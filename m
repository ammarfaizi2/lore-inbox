Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbVKBLzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbVKBLzo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 06:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbVKBLzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 06:55:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:32591 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932586AbVKBLzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 06:55:44 -0500
Date: Wed, 2 Nov 2005 12:55:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with the default IOSCHED
Message-ID: <20051102115542.GN26049@suse.de>
References: <1130891282.5048.50.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130891282.5048.50.camel@blade>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02 2005, Marcel Holtmann wrote:
> Hi guys,
> 
> by accident I selected the anticipatory IO scheduler as default in my
> kernel config, but only the CFQ was built in. The anticipatory and
> deadline were only available as modules. This caused an oops at boot.
> After selecting CFQ as default schedule and a recompile and reboot
> everything was fine again.

Hmm yes, that looks like a bug introduced with the io scheduler
selection reorg. There's really no support in place for requesting this
module out of initrd, I'd rather just make your selection illegal. Does
this work for you?

diff --git a/drivers/block/Kconfig.iosched b/drivers/block/Kconfig.iosched
index 5b90d2f..f3b7753 100644
--- a/drivers/block/Kconfig.iosched
+++ b/drivers/block/Kconfig.iosched
@@ -46,13 +46,13 @@ choice
 	  block devices.
 
 	config DEFAULT_AS
-		bool "Anticipatory" if IOSCHED_AS
+		bool "Anticipatory" if IOSCHED_AS=y
 
 	config DEFAULT_DEADLINE
-		bool "Deadline" if IOSCHED_DEADLINE
+		bool "Deadline" if IOSCHED_DEADLINE=y
 
 	config DEFAULT_CFQ
-		bool "CFQ" if IOSCHED_CFQ
+		bool "CFQ" if IOSCHED_CFQ=y
 
 	config DEFAULT_NOOP
 		bool "No-op"

-- 
Jens Axboe

