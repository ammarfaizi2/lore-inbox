Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVFGDRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVFGDRn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 23:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVFGDRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 23:17:43 -0400
Received: from holomorphy.com ([66.93.40.71]:52458 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261776AbVFGDRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 23:17:30 -0400
Date: Mon, 6 Jun 2005 20:13:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jan Dittmer <jdittmer@ppp0.net>, spyro@f2s.com, zippel@linux-m68k.org,
       starvik@axis.com, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net, dev-etrax@axis.com,
       sparclinux@vger.kernel.org
Subject: Re: select of non-existing I2C* symbols
Message-ID: <20050607031355.GB2621@holomorphy.com>
References: <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <20050506235842.A23651@flint.arm.linux.org.uk> <427C9DBD.1030905@ppp0.net> <20050507122622.C11839@flint.arm.linux.org.uk> <427CC082.4000603@ppp0.net> <20050507144135.GL3590@stusta.de> <20050511143010.GF9304@holomorphy.com> <20050511225057.GK6884@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050511225057.GK6884@stusta.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 07:30:10AM -0700, William Lee Irwin III wrote:
>> You're telling me I have to futz with the i2c Kconfig just to cope with
>> it not existing?

On Thu, May 12, 2005 at 12:50:57AM +0200, Adrian Bunk wrote:
> What happens if a user selects one of the options that do themself 
> select one or more of the I2C* options?
> This might be solved differently (e.g. via some kind of 
> ARCH_SUPPORTS_I2C), but it should be solved.

I've got a patch to convert arch/sparc/Kconfig to sourcing drivers/Kconfig.
I've checked that defconfig comes out largely the same (the difference
seems to be order and comments) but haven't really checked thoroughly.

Maybe if others (e.g. sparc32 users) could look and complain if
something goes wrong that would help.

vs. 2.6.12-rc5-mm2


-- wli

Index: mm2-2.6.12-rc5/arch/sparc/Kconfig
===================================================================
--- mm2-2.6.12-rc5.orig/arch/sparc/Kconfig	2005-06-06 13:45:32.000000000 -0700
+++ mm2-2.6.12-rc5/arch/sparc/Kconfig	2005-06-06 16:08:36.859702935 -0700
@@ -264,7 +264,11 @@
 	  want to run SunOS binaries on an Ultra you must also say Y to
 	  "Kernel support for 32-bit a.out binaries" above.
 
-source "drivers/parport/Kconfig"
+source "mm/Kconfig"
+
+endmenu
+
+source "drivers/Kconfig"
 
 config PRINTER
 	tristate "Parallel printer support"
@@ -291,41 +295,10 @@
 	  If you have more than 8 printers, you need to increase the LP_NO
 	  macro in lp.c and the PARPORT_MAX macro in parport.h.
 
-source "mm/Kconfig"
-
-endmenu
-
-source "drivers/base/Kconfig"
-
-source "drivers/video/Kconfig"
-
-source "drivers/mtd/Kconfig"
-
-source "drivers/serial/Kconfig"
-
 if !SUN4
 source "drivers/sbus/char/Kconfig"
 endif
 
-source "drivers/block/Kconfig"
-
-# Don't frighten a common SBus user
-if PCI
-
-source "drivers/ide/Kconfig"
-
-endif
-
-source "drivers/isdn/Kconfig"
-
-source "drivers/scsi/Kconfig"
-
-source "drivers/fc4/Kconfig"
-
-source "drivers/md/Kconfig"
-
-source "net/Kconfig"
-
 # This one must be before the filesystem configs. -DaveM
 
 menu "Unix98 PTY support"
@@ -374,18 +347,8 @@
 
 endmenu
 
-source "drivers/input/Kconfig"
-
 source "fs/Kconfig"
 
-source "sound/Kconfig"
-
-source "drivers/usb/Kconfig"
-
-source "drivers/infiniband/Kconfig"
-
-source "drivers/char/watchdog/Kconfig"
-
 source "arch/sparc/Kconfig.debug"
 
 source "security/Kconfig"
