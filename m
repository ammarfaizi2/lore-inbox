Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTLIX33 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 18:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263412AbTLIX33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 18:29:29 -0500
Received: from mail.kroah.org ([65.200.24.183]:25514 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263402AbTLIX31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 18:29:27 -0500
Date: Tue, 9 Dec 2003 15:28:29 -0800
From: Greg KH <greg@kroah.com>
To: Svetoslav Slavtchev <svetljo@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Badness in kobject_get at lib/kobject.c:439
Message-ID: <20031209232829.GB1747@kroah.com>
References: <31715.1071010976@www51.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31715.1071010976@www51.gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 12:02:56AM +0100, Svetoslav Slavtchev wrote:
> Call Trace:
>  [<c019a1f4>] kobject_get+0x30/0x3d
>  [<c01dd8d3>] class_get+0x1a/0x2c
>  [<c01ddb67>] class_device_add+0x41/0x110
>  [<c01cc4ec>] misc_add_class_device+0x63/0xc6
>  [<c01cc6d8>] misc_register+0xeb/0x120
>  [<c0361fd8>] apm_init+0x2ec/0x324

Hm, here's the problem.  Can you disable APM and see if the oops goes
away?  I bet apm_init() is being called before misc_init() is.

If you don't want to disable APM (and you should not have to) can you
apply the patch below to misc.c and let me know if it fixes your problem
or not?

thanks,

greg k-h

--- a/drivers/char/misc.c	Mon Oct  6 10:47:30 2003
+++ b/drivers/char/misc.c	Tue Dec  9 15:28:10 2003
@@ -407,4 +407,4 @@
 	}
 	return 0;
 }
-module_init(misc_init);
+subsys_initcall(misc_init);
