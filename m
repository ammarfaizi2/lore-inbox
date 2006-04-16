Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWDPIz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWDPIz6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 04:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWDPIz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 04:55:58 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:34570 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750934AbWDPIz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 04:55:58 -0400
Date: Sun, 16 Apr 2006 10:55:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] modpost: relax driver data name
Message-ID: <20060416085543.GA5943@mars.ravnborg.org>
References: <20060415111712.311372aa.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060415111712.311372aa.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2006 at 11:17:12AM -0700, Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> modpost:  Relax driver data name from *_driver to *driver.
> This fixes the 26 section mismatch warnings in drivers/ide/pci.

For an allmodconfig build with CONFIG_HOTPLUG=n this killed
118 warnings out of 245 warnings in total.
Applied.

To turn off CONFIG_HOTPLUG I simply changed the Kconfig files like
this:

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index f0eff3d..1e25fc2 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -20,7 +20,6 @@ config PREVENT_FIRMWARE_BUILD
 
 config FW_LOADER
 	tristate "Userspace firmware loading support"
-	select HOTPLUG
 	---help---
 	  This option is provided for the case where no in-kernel-tree modules
 	  require userspace firmware loading support, but a module built outside

Then it became trivial to turn off CONFIG_HOTPLUG.

	Sam
