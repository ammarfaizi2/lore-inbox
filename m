Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbTJINaC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 09:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTJINaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 09:30:01 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:4480 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262168AbTJIN37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 09:29:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16261.25288.125075.508225@gargle.gargle.HOWL>
Date: Thu, 9 Oct 2003 15:29:44 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, arun.sharma@intel.com, torvalds@osdl.org
Subject: 2.6.0-test7 BLK_DEV_FD dependence on ISA breakage
In-Reply-To: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As found in ChangeLog-2.6.0-test7:
><akpm@osdl.org>
>	[PATCH] Disable floppy and the related ioctl32s on some platforms
>	
>	From: Arun Sharma <arun.sharma@intel.com>
>	
>	Based on some earlier discussion:
>	
>	http://marc.theaimsgroup.com/?t=106015010700002&r=1&w=2
>	
>	here's a new patch that attempts to disable BLK_DEV_FD on platforms which
>	don't support it.

This patch

--- a/drivers/block/Kconfig	Wed Oct  8 12:24:56 2003
+++ b/drivers/block/Kconfig	Wed Oct  8 12:24:56 2003
@@ -6,7 +6,7 @@
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
-	depends on !X86_PC9800 && !ARCH_S390
+	depends on ISA || M68 || SPARC64
 	---help---
 	  If you want to use the floppy disk drive(s) of your PC under Linux,
 	  say Y. Information about this driver, especially important for IBM

is broken. The help text and de facto definition of CONFIG_ISA only
refers to devices in ISA _slots_. Since the FDC is not such a device,
this patch reinterprets CONFIG_ISA to mean any device which is
accessed via in/out to the low I/O port range.

Well in that case I guess !CONFIG_ISA should also disable keyboards,
serial ports, dma controllers, timers, etc.

IA64 folks may not want to be asked about BLK_DEV_FD, but this patch
now forces me to set CONFIG_ISA in my ISA-slot-free machines, which
also adds a lot of new config options I don't want.

/Mikael
