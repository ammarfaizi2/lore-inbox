Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVILP5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVILP5k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVILP5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:57:39 -0400
Received: from hoboe2bl1.telenet-ops.be ([195.130.137.73]:55176 "EHLO
	hoboe2bl1.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1750757AbVILP5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:57:38 -0400
Date: Mon, 12 Sep 2005 17:57:08 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andrey Panin <pazke@donpac.ru>,
       Arnaud Patard <arnaud.patard@rtp-net.org>,
       David Hardeman <david@2gen.com>, "Ian E. Morgan" <imorgan@webcon.ca>,
       James Chapman <jchapman@katalix.com>, Jiri Slaby <xslaby@fi.muni.cz>,
       Jose Miguel Goncalves <jose.goncalves@inov.pt>,
       Naveen Gupta <ngupta@google.com>
Subject: [WATCHDOG] linux-2.6-watchdog patches (5 new drivers + some small changes)
Message-ID: <20050912155707.GB19487@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please do a

	git pull rsync://rsync.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 drivers/char/watchdog/Kconfig       |   93 ++++--
 drivers/char/watchdog/Makefile      |    7 
 drivers/char/watchdog/i6300esb.c    |  527 ++++++++++++++++++++++++++++++++++
 drivers/char/watchdog/ibmasr.c      |  405 ++++++++++++++++++++++++++
 drivers/char/watchdog/mv64x60_wdt.c |  252 ++++++++++++++++
 drivers/char/watchdog/pcwd_pci.c    |   42 +-
 drivers/char/watchdog/s3c2410_wdt.c |    2 
 drivers/char/watchdog/sbc8360.c     |  414 +++++++++++++++++++++++++++
 drivers/char/watchdog/w83977f_wdt.c |  543 ++++++++++++++++++++++++++++++++++++
 include/asm-ppc/mv64x60.h           |    8 
 10 files changed, 2251 insertions(+), 42 deletions(-)

with these Changes:

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Mon Sep 12 00:21:19 2005 +0200

    [WATCHDOG] pcwd_pci-include+WDIOC_SETOPTIONS-patch
    
    Clean-up includes
    Check results for start + stop in the WDIOC_SETOPTIONS ioctl call
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sun Sep 11 23:58:22 2005 +0200

    [WATCHDOG] sbc8360+w83977f_wdt-consolidate_CONFIG_WATCHDOG_NOWAYOUT_handling
    
    Attached patch removes #ifdef CONFIG_WATCHDOG_NOWAYOUT mess and
    replaces it with common define in linux/watchdog.h.
    
    Signed-Off-By: Wim Van Sebroeck <wim@iguana.be>

Author: Jose Miguel Goncalves <jose.goncalves@inov.pt>
Date:   Tue Sep 6 17:05:30 2005 -0700

    [WATCHDOG] w83977f-watchdog-driver.patch
    
    In a project for my company I've needed to use the watchdog device in a
    PCM-5335 SBC from AAEON.  The watchdog timer is from a Winbond's SuperIO
    chip, the W83977F.
    
    I've made this driver based on two others already on the kernel tree,
    the w83877f_wdt and the wdt977.
    
    Signed-off-by: Jose Goncalves <jose.goncalves@inov.pt>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Ian E. Morgan <imorgan@webcon.ca>
Date:   Thu Sep 1 22:49:17 2005 +0200

    [WATCHDOG] New SBC8360 watchdog driver (revised)
    
    New SBC8360 watchdog driver patch
    
    From: Ian E. Morgan <imorgan@webcon.ca>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Fri Aug 19 23:31:41 2005 +0200

    [WATCHDOG] driver-for-ibm-automatic-server-restart-watchdog-fix2.patch
    
    The device/watchdog has a fixed timeout/heartbeat.
    So we don't support the WDIOC_SETTIMEOUT ioctl call
    and we also may not set the WDIOF_SETTIMEOUT flag.
    
    Cc: Andrey Panin <pazke@donpac.ru>
    Cc: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Andrew Morton <akpm@osdl.org>
Date:   Fri Aug 19 23:21:01 2005 +0200

    [WATCHDOG] driver-for-ibm-automatic-server-restart-watchdog-fix
    
    Add fixed timeout comments
    
    Cc: Andrey Panin <pazke@donpac.ru>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Andrey Panin <pazke@donpac.ru>
Date:   Fri Aug 19 23:15:11 2005 +0200

    [WATCHDOG] driver-for-ibm-automatic-server-restart-watchdog.patch
    
    This patch adds driver for IBM Automatic Server Restart watchdog hardware
    found in some IBM eServer xSeries machines.  This driver is based on the ugly
    driver provided by IBM.  Driver was tested on IBM eServer 226.
    
    Signed-off-by: Andrey Panin <pazke@donpac.ru>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: David Hardeman <david@2gen.com>
Date:   Thu Sep 1 22:34:53 2005 +0200

    [WATCHDOG] i6300.h-removal-patch
    
    the attached patch moves the content of drivers/char/watchdog/i6300.h
    into drivers/char/watchdog/i6300.c, since it is the only file using the
    defines there is no real reason to have a separate header.
    
    Also cleaned up the comments a bit and added myself to the copyright
    holders.
    
    Signed-off-by: David Hardeman <david@2gen.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Jiri Slaby <xslaby@fi.muni.cz>
Date:   Mon Aug 22 09:05:03 2005 +0200

    [WATCHDOG] i6300esb.c-2-bugs-little-cleanup.patch
    
    In i6300esb.c watchdog card driver were 2 bugs (misused pc_match_device and
    pci_dev_put wasn't called in one error case) and one little cleanup was
    done (long line was converted to a shorter one with using built-in macro).
    
    Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Naveen Gupta <ngupta@google.com>
Date:   Sun Aug 21 13:02:41 2005 +0200

    [WATCHDOG] i6300esb.c-pci_dev_put+nowayout-patch
    
    One pci_dev_put was misused (there was one case without putting
    the device).
    Changed nowayout according to other drivers.
    
    Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
    Signed-off-by: Naveen Gupta <ngupta@google.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Naveen Gupta <ngupta@google.com>
Date:   Wed Aug 17 09:11:46 2005 +0200

    [WATCHDOG] i6300esb-set_correct_reload_register_bit
    
    This patch writes into bit 8 of the reload register to perform the
    correct 'Reload Sequence' instead of writing into bit 4 of Watchdog for
    Intel 6300ESB chipset.
    
    Signed-off-by: Naveen Gupta <ngupta@google.com>
    Signed-off-by: David Hardeman <david@2gen.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Naveen Gupta <ngupta@google.com>
Date:   Wed Aug 17 09:10:10 2005 +0200

    [WATCHDOG] i6300esb.c-WDT_ENABLE-bug
    
    This patch sets the WDT_ENABLE bit of the Lock Register to enable the
    watchdog and WDT_LOCK bit only if nowayout is set. The old code always
    sets the WDT_LOCK bit of watchdog timer for Intel 6300ESB chipset. So, we
    end up locking the watchdog instead of enabling it.
    
    Signed-off-by: Naveen Gupta <ngupta@google.com>
    Signed-off-by: David Hardeman <david@2gen.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Jiri Slaby <xslaby@fi.muni.cz>
Date:   Wed Aug 17 09:09:13 2005 +0200

    [WATCHDOG] removes pci_find_device from i6300esb.c
    
    This patch changes pci_find_device to pci_get_device
    (encapsulated in for_each_pci_dev) in i6300esb watchdog
    card with appropriate adding pci_dev_put.
    
    Generated in 2.6.13-rc5-mm1 kernel version.
    
    Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: David Hardeman <david@2gen.com>
Date:   Wed Aug 17 09:07:44 2005 +0200

    [WATCHDOG] i6300esb.patch
    
    I wrote earlier to the list[1] asking for a driver for the watchdog
    included in the 6300ESB chipset.  I got a 2.4 driver via private email
    from Ross Biro which I've changed into what I hope resembles a 2.6
    driver (which was done by looking a lot at the watchdog drivers
    already in the 2.6 tree).
    
    I've attached the result, and I'm hoping to get some feedback on the
    coding as a first step.  I can't actually test it on the hardware
    right now as I won't have physical access until April. So my own tests
    have been limited to "compiles-without-warnings" and
    "can-be-insmodded-in-other-machine-without-oops".
    
    [1] http://marc.theaimsgroup.com/?l=linux-kernel&m=110711079825794&w=2
    [2] http://marc.theaimsgroup.com/?l=linux-kernel&m=110711973917746&w=2
    
    Signed-off-by: David Hardeman <david@2gen.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: James Chapman <jchapman@katalix.com>
Date:   Wed Aug 17 09:01:33 2005 +0200

    [WATCHDOG] mv64x60_wdt.patch
    
    Add mv64x60 (Marvell Discovery) watchdog support.
    
    Signed-off-by: James Chapman <jchapman@katalix.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sat Sep 10 20:53:57 2005 +0200

    [WATCHDOG] Kconfig+Makefile-clean2
    
    Clean the Kconfig+Makefile according to a sorted list
    of the drivers of each architecture (and sub-architecture).
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Date:   Thu Sep 8 07:42:02 2005 +0200

    [WATCHDOG] s3c2410_wdt.c-state_warning.patch
    
    I've noticed that the patch from Ben Dooks (commit
    af4bb822bc65efb087cd36b83789f22161a6515b on your git tree) is
    introducing a warning. It's using 'u32 state' instead of 'pm_message_t
    state'. I've attached a one liner to fix it.
    
    Signed-Off-By: Arnaud Patard <arnaud.patard@rtp-net.org>
    Signed-off-by: Ben Dooks <ben-linux@fluff.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>


The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig
+++ b/drivers/char/watchdog/Kconfig
@@ -84,6 +84,17 @@ config 977_WATCHDOG
 
 	  Not sure? It's safe to say N.
 
+config IXP2000_WATCHDOG
+	tristate "IXP2000 Watchdog"
+	depends on WATCHDOG && ARCH_IXP2000
+	help
+	  Say Y here if to include support for the watchdog timer
+	  in the Intel IXP2000(2400, 2800, 2850) network processors.
+	  This driver can be built as a module by choosing M. The module
+	  will be called ixp2000_wdt.
+
+	  Say N if you are unsure.
+
 config IXP4XX_WATCHDOG
 	tristate "IXP4xx Watchdog"
 	depends on WATCHDOG && ARCH_IXP4XX
@@ -100,17 +111,6 @@ config IXP4XX_WATCHDOG
 
 	  Say N if you are unsure.
 
-config IXP2000_WATCHDOG
-	tristate "IXP2000 Watchdog"
-	depends on WATCHDOG && ARCH_IXP2000
-	help
-	  Say Y here if to include support for the watchdog timer
-	  in the Intel IXP2000(2400, 2800, 2850) network processors.
-	  This driver can be built as a module by choosing M. The module
-	  will be called ixp2000_wdt.
-
-	  Say N if you are unsure.
-
 config S3C2410_WATCHDOG
 	tristate "S3C2410 Watchdog"
 	depends on WATCHDOG && ARCH_S3C2410
@@ -224,6 +224,16 @@ config IB700_WDT
 
 	  Most people will say N.
 
+config IBMASR
+        tristate "IBM Automatic Server Restart"
+        depends on WATCHDOG && X86
+        help
+	  This is the driver for the IBM Automatic Server Restart watchdog
+	  timer builtin into some eServer xSeries machines.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ibmasr.
+
 config WAFER_WDT
 	tristate "ICP Wafer 5823 Single Board Computer Watchdog"
 	depends on WATCHDOG && X86
@@ -234,6 +244,16 @@ config WAFER_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called wafer5823wdt.
 
+config I6300ESB_WDT
+	tristate "Intel 6300ESB Timer/Watchdog"
+	depends on WATCHDOG && X86 && PCI
+	---help---
+	  Hardware driver for the watchdog timer built into the Intel
+	  6300ESB controller hub.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called i6300esb.
+
 config I8XX_TCO
 	tristate "Intel i8xx TCO Timer/Watchdog"
 	depends on WATCHDOG && (X86 || IA64) && PCI
@@ -289,6 +309,19 @@ config 60XX_WDT
 	  You can compile this driver directly into the kernel, or use
 	  it as a module.  The module will be called sbc60xxwdt.
 
+config SBC8360_WDT
+	tristate "SBC8360 Watchdog Timer"
+	depends on WATCHDOG && X86
+	---help---
+
+	  This is the driver for the hardware watchdog on the SBC8360 Single
+	  Board Computer produced by Axiomtek Co., Ltd. (www.axiomtek.com).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sbc8360.ko.
+
+	  Most people will say N.
+
 config CPU5_WDT
 	tristate "SMA CPU5 Watchdog"
 	depends on WATCHDOG && X86
@@ -327,6 +360,19 @@ config W83877F_WDT
 
 	  Most people will say N.
 
+config W83977F_WDT
+	tristate "W83977F (PCM-5335) Watchdog Timer"
+	depends on WATCHDOG && X86
+	---help---
+	  This is the driver for the hardware watchdog on the W83977F I/O chip
+	  as used in AAEON's PCM-5335 SBC (and likely others).  This
+	  watchdog simply watches your kernel to make sure it doesn't freeze,
+	  and if it does, it reboots your computer after a certain amount of
+	  time.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called w83977f_wdt.
+
 config MACHZ_WDT
 	tristate "ZF MachZ Watchdog"
 	depends on WATCHDOG && X86
@@ -346,6 +392,10 @@ config 8xx_WDT
 	tristate "MPC8xx Watchdog Timer"
 	depends on WATCHDOG && 8xx
 
+config MV64X60_WDT
+	tristate "MV64X60 (Marvell Discovery) Watchdog Timer"
+	depends on WATCHDOG && MV64X60
+
 config BOOKE_WDT
 	tristate "PowerPC Book-E Watchdog Timer"
 	depends on WATCHDOG && (BOOKE || 4xx)
@@ -353,6 +403,17 @@ config BOOKE_WDT
 	  Please see Documentation/watchdog/watchdog-api.txt for
 	  more information.
 
+# PPC64 Architecture
+
+config WATCHDOG_RTAS
+	tristate "RTAS watchdog"
+	depends on WATCHDOG && PPC_RTAS
+	help
+	  This driver adds watchdog support for the RTAS watchdog.
+
+          To compile this driver as a module, choose M here. The module
+	  will be called wdrtas.
+
 # MIPS Architecture
 
 config INDYDOG
@@ -421,16 +482,6 @@ config WATCHDOG_RIO
 	  machines.  The watchdog timeout period is normally one minute but
 	  can be changed with a boot-time parameter.
 
-# ppc64 RTAS watchdog
-config WATCHDOG_RTAS
-	tristate "RTAS watchdog"
-	depends on WATCHDOG && PPC_RTAS
-	help
-	  This driver adds watchdog support for the RTAS watchdog.
-
-          To compile this driver as a module, choose M here. The module
-	  will be called wdrtas.
-
 #
 # ISA-based Watchdog Cards
 #
diff --git a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile
+++ b/drivers/char/watchdog/Makefile
@@ -38,22 +38,27 @@ obj-$(CONFIG_ALIM7101_WDT) += alim7101_w
 obj-$(CONFIG_SC520_WDT) += sc520_wdt.o
 obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
 obj-$(CONFIG_IB700_WDT) += ib700wdt.o
+obj-$(CONFIG_IBMASR) += ibmasr.o
 obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
+obj-$(CONFIG_I6300ESB_WDT) += i6300esb.o
 obj-$(CONFIG_I8XX_TCO) += i8xx_tco.o
 obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
 obj-$(CONFIG_SCx200_WDT) += scx200_wdt.o
 obj-$(CONFIG_60XX_WDT) += sbc60xxwdt.o
+obj-$(CONFIG_SBC8360_WDT) += sbc8360.o
 obj-$(CONFIG_CPU5_WDT) += cpu5wdt.o
 obj-$(CONFIG_W83627HF_WDT) += w83627hf_wdt.o
 obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
+obj-$(CONFIG_W83977F_WDT) += w83977f_wdt.o
 obj-$(CONFIG_MACHZ_WDT) += machzwd.o
 
 # PowerPC Architecture
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
+obj-$(CONFIG_MV64X60_WDT) += mv64x60_wdt.o
+obj-$(CONFIG_BOOKE_WDT) += booke_wdt.o
 
 # PPC64 Architecture
 obj-$(CONFIG_WATCHDOG_RTAS) += wdrtas.o
-obj-$(CONFIG_BOOKE_WDT) += booke_wdt.o
 
 # MIPS Architecture
 obj-$(CONFIG_INDYDOG) += indydog.o
diff --git a/drivers/char/watchdog/i6300esb.c b/drivers/char/watchdog/i6300esb.c
new file mode 100644
--- /dev/null
+++ b/drivers/char/watchdog/i6300esb.c
@@ -0,0 +1,527 @@
+/*
+ *	i6300esb:	Watchdog timer driver for Intel 6300ESB chipset
+ *
+ *	(c) Copyright 2004 Google Inc.
+ *	(c) Copyright 2005 David Härdeman <david@2gen.com>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *      based on i810-tco.c which is in turn based on softdog.c
+ *
+ * 	The timer is implemented in the following I/O controller hubs:
+ * 	(See the intel documentation on http://developer.intel.com.)
+ * 	6300ESB chip : document number 300641-003
+ *
+ *  2004YYZZ Ross Biro
+ *	Initial version 0.01
+ *  2004YYZZ Ross Biro
+ *  	Version 0.02
+ *  20050210 David Härdeman <david@2gen.com>
+ *      Ported driver to kernel 2.6
+ */
+
+/*
+ *      Includes, defines, variables, module parameters, ...
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/ioport.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+/* Module and version information */
+#define ESB_VERSION "0.03"
+#define ESB_MODULE_NAME "i6300ESB timer"
+#define ESB_DRIVER_NAME ESB_MODULE_NAME ", v" ESB_VERSION
+#define PFX ESB_MODULE_NAME ": "
+
+/* PCI configuration registers */
+#define ESB_CONFIG_REG  0x60            /* Config register                   */
+#define ESB_LOCK_REG    0x68            /* WDT lock register                 */
+
+/* Memory mapped registers */
+#define ESB_TIMER1_REG  BASEADDR + 0x00 /* Timer1 value after each reset     */
+#define ESB_TIMER2_REG  BASEADDR + 0x04 /* Timer2 value after each reset     */
+#define ESB_GINTSR_REG  BASEADDR + 0x08 /* General Interrupt Status Register */
+#define ESB_RELOAD_REG  BASEADDR + 0x0c /* Reload register                   */
+
+/* Lock register bits */
+#define ESB_WDT_FUNC    ( 0x01 << 2 )   /* Watchdog functionality            */
+#define ESB_WDT_ENABLE  ( 0x01 << 1 )   /* Enable WDT                        */
+#define ESB_WDT_LOCK    ( 0x01 << 0 )   /* Lock (nowayout)                   */
+
+/* Config register bits */
+#define ESB_WDT_REBOOT  ( 0x01 << 5 )   /* Enable reboot on timeout          */
+#define ESB_WDT_FREQ    ( 0x01 << 2 )   /* Decrement frequency               */
+#define ESB_WDT_INTTYPE ( 0x11 << 0 )   /* Interrupt type on timer1 timeout  */
+
+/* Reload register bits */
+#define ESB_WDT_RELOAD ( 0x01 << 8 )    /* prevent timeout                   */
+
+/* Magic constants */
+#define ESB_UNLOCK1     0x80            /* Step 1 to unlock reset registers  */
+#define ESB_UNLOCK2     0x86            /* Step 2 to unlock reset registers  */
+
+/* internal variables */
+static void __iomem *BASEADDR;
+static spinlock_t esb_lock; /* Guards the hardware */
+static unsigned long timer_alive;
+static struct pci_dev *esb_pci;
+static unsigned short triggered; /* The status of the watchdog upon boot */
+static char esb_expect_close;
+
+/* module parameters */
+#define WATCHDOG_HEARTBEAT 30   /* 30 sec default heartbeat (1<heartbeat<2*1023) */
+static int heartbeat = WATCHDOG_HEARTBEAT;  /* in seconds */
+module_param(heartbeat, int, 0);
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (1<heartbeat<2046, default=" __MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
+/*
+ * Some i6300ESB specific functions
+ */
+
+/*
+ * Prepare for reloading the timer by unlocking the proper registers.
+ * This is performed by first writing 0x80 followed by 0x86 to the
+ * reload register. After this the appropriate registers can be written
+ * to once before they need to be unlocked again.
+ */
+static inline void esb_unlock_registers(void) {
+        writeb(ESB_UNLOCK1, ESB_RELOAD_REG);
+        writeb(ESB_UNLOCK2, ESB_RELOAD_REG);
+}
+
+static void esb_timer_start(void)
+{
+	u8 val;
+
+	/* Enable or Enable + Lock? */
+	val = 0x02 | (nowayout ? 0x01 : 0x00);
+
+        pci_write_config_byte(esb_pci, ESB_LOCK_REG, val);
+}
+
+static int esb_timer_stop(void)
+{
+	u8 val;
+
+	spin_lock(&esb_lock);
+	/* First, reset timers as suggested by the docs */
+	esb_unlock_registers();
+	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
+	/* Then disable the WDT */
+	pci_write_config_byte(esb_pci, ESB_LOCK_REG, 0x0);
+	pci_read_config_byte(esb_pci, ESB_LOCK_REG, &val);
+	spin_unlock(&esb_lock);
+
+	/* Returns 0 if the timer was disabled, non-zero otherwise */
+	return (val & 0x01);
+}
+
+static void esb_timer_keepalive(void)
+{
+	spin_lock(&esb_lock);
+	esb_unlock_registers();
+	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
+        /* FIXME: Do we need to flush anything here? */
+	spin_unlock(&esb_lock);
+}
+
+static int esb_timer_set_heartbeat(int time)
+{
+	u32 val;
+
+	if (time < 0x1 || time > (2 * 0x03ff))
+		return -EINVAL;
+
+	spin_lock(&esb_lock);
+
+	/* We shift by 9, so if we are passed a value of 1 sec,
+	 * val will be 1 << 9 = 512, then write that to two
+	 * timers => 2 * 512 = 1024 (which is decremented at 1KHz)
+	 */
+	val = time << 9;
+
+	/* Write timer 1 */
+	esb_unlock_registers();
+	writel(val, ESB_TIMER1_REG);
+
+	/* Write timer 2 */
+	esb_unlock_registers();
+        writel(val, ESB_TIMER2_REG);
+
+        /* Reload */
+	esb_unlock_registers();
+	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
+
+	/* FIXME: Do we need to flush everything out? */
+
+	/* Done */
+	heartbeat = time;
+	spin_unlock(&esb_lock);
+	return 0;
+}
+
+static int esb_timer_read (void)
+{
+       	u32 count;
+
+	/* This isn't documented, and doesn't take into
+         * acount which stage is running, but it looks
+         * like a 20 bit count down, so we might as well report it.
+         */
+        pci_read_config_dword(esb_pci, 0x64, &count);
+        return (int)count;
+}
+
+/*
+ * 	/dev/watchdog handling
+ */
+
+static int esb_open (struct inode *inode, struct file *file)
+{
+        /* /dev/watchdog can only be opened once */
+        if (test_and_set_bit(0, &timer_alive))
+                return -EBUSY;
+
+        /* Reload and activate timer */
+        esb_timer_keepalive ();
+        esb_timer_start ();
+
+	return nonseekable_open(inode, file);
+}
+
+static int esb_release (struct inode *inode, struct file *file)
+{
+        /* Shut off the timer. */
+        if (esb_expect_close == 42) {
+                esb_timer_stop ();
+        } else {
+                printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
+                esb_timer_keepalive ();
+        }
+        clear_bit(0, &timer_alive);
+        esb_expect_close = 0;
+        return 0;
+}
+
+static ssize_t esb_write (struct file *file, const char __user *data,
+			  size_t len, loff_t * ppos)
+{
+	/* See if we got the magic character 'V' and reload the timer */
+        if (len) {
+		if (!nowayout) {
+			size_t i;
+
+			/* note: just in case someone wrote the magic character
+			 * five months ago... */
+			esb_expect_close = 0;
+
+			/* scan to see whether or not we got the magic character */
+			for (i = 0; i != len; i++) {
+				char c;
+				if(get_user(c, data+i))
+					return -EFAULT;
+				if (c == 'V')
+					esb_expect_close = 42;
+			}
+		}
+
+		/* someone wrote to us, we should reload the timer */
+		esb_timer_keepalive ();
+	}
+	return len;
+}
+
+static int esb_ioctl (struct inode *inode, struct file *file,
+		      unsigned int cmd, unsigned long arg)
+{
+	int new_options, retval = -EINVAL;
+	int new_heartbeat;
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
+	static struct watchdog_info ident = {
+		.options =              WDIOF_SETTIMEOUT |
+					WDIOF_KEEPALIVEPING |
+					WDIOF_MAGICCLOSE,
+		.firmware_version =     0,
+		.identity =             ESB_MODULE_NAME,
+	};
+
+	switch (cmd) {
+		case WDIOC_GETSUPPORT:
+			return copy_to_user(argp, &ident,
+					    sizeof (ident)) ? -EFAULT : 0;
+
+		case WDIOC_GETSTATUS:
+			return put_user (esb_timer_read(), p);
+
+		case WDIOC_GETBOOTSTATUS:
+			return put_user (triggered, p);
+
+                case WDIOC_KEEPALIVE:
+                        esb_timer_keepalive ();
+                        return 0;
+
+                case WDIOC_SETOPTIONS:
+                {
+                        if (get_user (new_options, p))
+                                return -EFAULT;
+
+                        if (new_options & WDIOS_DISABLECARD) {
+                                esb_timer_stop ();
+                                retval = 0;
+                        }
+
+                        if (new_options & WDIOS_ENABLECARD) {
+                                esb_timer_keepalive ();
+                                esb_timer_start ();
+                                retval = 0;
+                        }
+
+                        return retval;
+                }
+
+                case WDIOC_SETTIMEOUT:
+                {
+                        if (get_user(new_heartbeat, p))
+                                return -EFAULT;
+
+                        if (esb_timer_set_heartbeat(new_heartbeat))
+                            return -EINVAL;
+
+                        esb_timer_keepalive ();
+                        /* Fall */
+                }
+
+                case WDIOC_GETTIMEOUT:
+                        return put_user(heartbeat, p);
+
+                default:
+                        return -ENOIOCTLCMD;
+        }
+}
+
+/*
+ *      Notify system
+ */
+
+static int esb_notify_sys (struct notifier_block *this, unsigned long code, void *unused)
+{
+        if (code==SYS_DOWN || code==SYS_HALT) {
+                /* Turn the WDT off */
+                esb_timer_stop ();
+        }
+
+        return NOTIFY_DONE;
+}
+
+/*
+ *      Kernel Interfaces
+ */
+
+static struct file_operations esb_fops = {
+        .owner =        THIS_MODULE,
+        .llseek =       no_llseek,
+        .write =        esb_write,
+        .ioctl =        esb_ioctl,
+        .open =         esb_open,
+        .release =      esb_release,
+};
+
+static struct miscdevice esb_miscdev = {
+        .minor =        WATCHDOG_MINOR,
+        .name =         "watchdog",
+        .fops =         &esb_fops,
+};
+
+static struct notifier_block esb_notifier = {
+        .notifier_call =        esb_notify_sys,
+};
+
+/*
+ * Data for PCI driver interface
+ *
+ * This data only exists for exporting the supported
+ * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
+ * register a pci_driver, because someone else might one day
+ * want to register another driver on the same PCI id.
+ */
+static struct pci_device_id esb_pci_tbl[] = {
+        { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_9), },
+        { 0, },                 /* End of list */
+};
+MODULE_DEVICE_TABLE (pci, esb_pci_tbl);
+
+/*
+ *      Init & exit routines
+ */
+
+static unsigned char __init esb_getdevice (void)
+{
+	u8 val1;
+	unsigned short val2;
+
+        struct pci_dev *dev = NULL;
+        /*
+         *      Find the PCI device
+         */
+
+        for_each_pci_dev(dev) {
+                if (pci_match_id(esb_pci_tbl, dev)) {
+                        esb_pci = dev;
+                        break;
+                }
+	}
+
+        if (esb_pci) {
+        	if (pci_enable_device(esb_pci)) {
+			printk (KERN_ERR PFX "failed to enable device\n");
+			goto err_devput;
+		}
+
+		if (pci_request_region(esb_pci, 0, ESB_MODULE_NAME)) {
+			printk (KERN_ERR PFX "failed to request region\n");
+			goto err_disable;
+		}
+
+		BASEADDR = ioremap(pci_resource_start(esb_pci, 0),
+				   pci_resource_len(esb_pci, 0));
+		if (BASEADDR == NULL) {
+                	/* Something's wrong here, BASEADDR has to be set */
+			printk (KERN_ERR PFX "failed to get BASEADDR\n");
+                        goto err_release;
+                }
+
+		/*
+		 * The watchdog has two timers, it can be setup so that the
+		 * expiry of timer1 results in an interrupt and the expiry of
+		 * timer2 results in a reboot. We set it to not generate
+		 * any interrupts as there is not much we can do with it
+		 * right now.
+		 *
+		 * We also enable reboots and set the timer frequency to
+		 * the PCI clock divided by 2^15 (approx 1KHz).
+		 */
+		pci_write_config_word(esb_pci, ESB_CONFIG_REG, 0x0003);
+
+		/* Check that the WDT isn't already locked */
+		pci_read_config_byte(esb_pci, ESB_LOCK_REG, &val1);
+		if (val1 & ESB_WDT_LOCK)
+			printk (KERN_WARNING PFX "nowayout already set\n");
+
+		/* Set the timer to watchdog mode and disable it for now */
+		pci_write_config_byte(esb_pci, ESB_LOCK_REG, 0x00);
+
+		/* Check if the watchdog was previously triggered */
+		esb_unlock_registers();
+		val2 = readw(ESB_RELOAD_REG);
+		triggered = (val2 & (0x01 << 9) >> 9);
+
+		/* Reset trigger flag and timers */
+		esb_unlock_registers();
+		writew((0x11 << 8), ESB_RELOAD_REG);
+
+		/* Done */
+		return 1;
+
+err_release:
+		pci_release_region(esb_pci, 0);
+err_disable:
+		pci_disable_device(esb_pci);
+err_devput:
+		pci_dev_put(esb_pci);
+	}
+	return 0;
+}
+
+static int __init watchdog_init (void)
+{
+        int ret;
+
+        spin_lock_init(&esb_lock);
+
+        /* Check whether or not the hardware watchdog is there */
+        if (!esb_getdevice () || esb_pci == NULL)
+                return -ENODEV;
+
+        /* Check that the heartbeat value is within it's range ; if not reset to the default */
+        if (esb_timer_set_heartbeat (heartbeat)) {
+                esb_timer_set_heartbeat (WATCHDOG_HEARTBEAT);
+                printk(KERN_INFO PFX "heartbeat value must be 1<heartbeat<2046, using %d\n",
+		       heartbeat);
+        }
+
+        ret = register_reboot_notifier(&esb_notifier);
+        if (ret != 0) {
+                printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
+                        ret);
+                goto err_unmap;
+        }
+
+        ret = misc_register(&esb_miscdev);
+        if (ret != 0) {
+                printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+                        WATCHDOG_MINOR, ret);
+                goto err_notifier;
+        }
+
+        esb_timer_stop ();
+
+        printk (KERN_INFO PFX "initialized (0x%p). heartbeat=%d sec (nowayout=%d)\n",
+                BASEADDR, heartbeat, nowayout);
+
+        return 0;
+
+err_notifier:
+        unregister_reboot_notifier(&esb_notifier);
+err_unmap:
+	iounmap(BASEADDR);
+/* err_release: */
+	pci_release_region(esb_pci, 0);
+/* err_disable: */
+	pci_disable_device(esb_pci);
+/* err_devput: */
+	pci_dev_put(esb_pci);
+        return ret;
+}
+
+static void __exit watchdog_cleanup (void)
+{
+	/* Stop the timer before we leave */
+	if (!nowayout)
+		esb_timer_stop ();
+
+	/* Deregister */
+	misc_deregister(&esb_miscdev);
+        unregister_reboot_notifier(&esb_notifier);
+	iounmap(BASEADDR);
+	pci_release_region(esb_pci, 0);
+	pci_disable_device(esb_pci);
+	pci_dev_put(esb_pci);
+}
+
+module_init(watchdog_init);
+module_exit(watchdog_cleanup);
+
+MODULE_AUTHOR("Ross Biro and David Härdeman");
+MODULE_DESCRIPTION("Watchdog driver for Intel 6300ESB chipsets");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff --git a/drivers/char/watchdog/ibmasr.c b/drivers/char/watchdog/ibmasr.c
new file mode 100644
--- /dev/null
+++ b/drivers/char/watchdog/ibmasr.c
@@ -0,0 +1,405 @@
+/*
+ * IBM Automatic Server Restart driver.
+ *
+ * Copyright (c) 2005 Andrey Panin <pazke@donpac.ru>
+ *
+ * Based on driver written by Pete Reynolds.
+ * Copyright (c) IBM Corporation, 1998-2004.
+ *
+ * This software may be used and distributed according to the terms
+ * of the GNU Public License, incorporated herein by reference.
+ */
+
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/timer.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/dmi.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+
+enum {
+	ASMTYPE_UNKNOWN,
+	ASMTYPE_TOPAZ,
+	ASMTYPE_JASPER,
+	ASMTYPE_PEARL,
+	ASMTYPE_JUNIPER,
+	ASMTYPE_SPRUCE,
+};
+
+#define PFX "ibmasr: "
+
+#define TOPAZ_ASR_REG_OFFSET	4
+#define TOPAZ_ASR_TOGGLE	0x40
+#define TOPAZ_ASR_DISABLE	0x80
+
+/* PEARL ASR S/W REGISTER SUPERIO PORT ADDRESSES */
+#define PEARL_BASE	0xe04
+#define PEARL_WRITE	0xe06
+#define PEARL_READ	0xe07
+
+#define PEARL_ASR_DISABLE_MASK	0x80	/* bit 7: disable = 1, enable = 0 */
+#define PEARL_ASR_TOGGLE_MASK	0x40	/* bit 6: 0, then 1, then 0 */
+
+/* JASPER OFFSET FROM SIO BASE ADDR TO ASR S/W REGISTERS. */
+#define JASPER_ASR_REG_OFFSET	0x38
+
+#define JASPER_ASR_DISABLE_MASK	0x01	/* bit 0: disable = 1, enable = 0 */
+#define JASPER_ASR_TOGGLE_MASK	0x02	/* bit 1: 0, then 1, then 0 */
+
+#define JUNIPER_BASE_ADDRESS	0x54b	/* Base address of Juniper ASR */
+#define JUNIPER_ASR_DISABLE_MASK 0x01	/* bit 0: disable = 1 enable = 0 */
+#define JUNIPER_ASR_TOGGLE_MASK	0x02	/* bit 1: 0, then 1, then 0 */
+
+#define SPRUCE_BASE_ADDRESS	0x118e	/* Base address of Spruce ASR */
+#define SPRUCE_ASR_DISABLE_MASK	0x01	/* bit 1: disable = 1 enable = 0 */
+#define SPRUCE_ASR_TOGGLE_MASK	0x02	/* bit 0: 0, then 1, then 0 */
+
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+
+static unsigned long asr_is_open;
+static char asr_expect_close;
+
+static unsigned int asr_type, asr_base, asr_length;
+static unsigned int asr_read_addr, asr_write_addr;
+static unsigned char asr_toggle_mask, asr_disable_mask;
+
+static void asr_toggle(void)
+{
+	unsigned char reg = inb(asr_read_addr);
+
+	outb(reg & ~asr_toggle_mask, asr_write_addr);
+	reg = inb(asr_read_addr);
+
+	outb(reg | asr_toggle_mask, asr_write_addr);
+	reg = inb(asr_read_addr);
+
+	outb(reg & ~asr_toggle_mask, asr_write_addr);
+	reg = inb(asr_read_addr);
+}
+
+static void asr_enable(void)
+{
+	unsigned char reg;
+
+	if (asr_type == ASMTYPE_TOPAZ) {
+		/* asr_write_addr == asr_read_addr */
+		reg = inb(asr_read_addr);
+		outb(reg & ~(TOPAZ_ASR_TOGGLE | TOPAZ_ASR_DISABLE),
+		     asr_read_addr);
+	} else {
+		/*
+		 * First make sure the hardware timer is reset by toggling
+		 * ASR hardware timer line.
+		 */
+		asr_toggle();
+
+		reg = inb(asr_read_addr);
+		outb(reg & ~asr_disable_mask, asr_write_addr);
+	}
+	reg = inb(asr_read_addr);
+}
+
+static void asr_disable(void)
+{
+	unsigned char reg = inb(asr_read_addr);
+
+	if (asr_type == ASMTYPE_TOPAZ)
+		/* asr_write_addr == asr_read_addr */
+		outb(reg | TOPAZ_ASR_TOGGLE | TOPAZ_ASR_DISABLE,
+		     asr_read_addr);
+	else {
+		outb(reg | asr_toggle_mask, asr_write_addr);
+		reg = inb(asr_read_addr);
+
+		outb(reg | asr_disable_mask, asr_write_addr);
+	}
+	reg = inb(asr_read_addr);
+}
+
+static int __init asr_get_base_address(void)
+{
+	unsigned char low, high;
+	const char *type = "";
+
+	asr_length = 1;
+
+	switch (asr_type) {
+	case ASMTYPE_TOPAZ:
+		/* SELECT SuperIO CHIP FOR QUERYING (WRITE 0x07 TO BOTH 0x2E and 0x2F) */
+		outb(0x07, 0x2e);
+		outb(0x07, 0x2f);
+
+		/* SELECT AND READ THE HIGH-NIBBLE OF THE GPIO BASE ADDRESS */
+		outb(0x60, 0x2e);
+		high = inb(0x2f);
+
+		/* SELECT AND READ THE LOW-NIBBLE OF THE GPIO BASE ADDRESS */
+		outb(0x61, 0x2e);
+		low = inb(0x2f);
+
+		asr_base = (high << 16) | low;
+		asr_read_addr = asr_write_addr =
+			asr_base + TOPAZ_ASR_REG_OFFSET;
+		asr_length = 5;
+
+		break;
+
+	case ASMTYPE_JASPER:
+		type = "Jaspers ";
+
+		/* FIXME: need to use pci_config_lock here, but it's not exported */
+
+/*		spin_lock_irqsave(&pci_config_lock, flags);*/
+
+		/* Select the SuperIO chip in the PCI I/O port register */
+		outl(0x8000f858, 0xcf8);
+
+		/*
+		 * Read the base address for the SuperIO chip.
+		 * Only the lower 16 bits are valid, but the address is word
+		 * aligned so the last bit must be masked off.
+		 */
+		asr_base = inl(0xcfc) & 0xfffe;
+
+/*		spin_unlock_irqrestore(&pci_config_lock, flags);*/
+
+		asr_read_addr = asr_write_addr =
+			asr_base + JASPER_ASR_REG_OFFSET;
+		asr_toggle_mask = JASPER_ASR_TOGGLE_MASK;
+		asr_disable_mask = JASPER_ASR_DISABLE_MASK;
+		asr_length = JASPER_ASR_REG_OFFSET + 1;
+
+		break;
+
+	case ASMTYPE_PEARL:
+		type = "Pearls ";
+		asr_base = PEARL_BASE;
+		asr_read_addr = PEARL_READ;
+		asr_write_addr = PEARL_WRITE;
+		asr_toggle_mask = PEARL_ASR_TOGGLE_MASK;
+		asr_disable_mask = PEARL_ASR_DISABLE_MASK;
+		asr_length = 4;
+		break;
+
+	case ASMTYPE_JUNIPER:
+		type = "Junipers ";
+		asr_base = JUNIPER_BASE_ADDRESS;
+		asr_read_addr = asr_write_addr = asr_base;
+		asr_toggle_mask = JUNIPER_ASR_TOGGLE_MASK;
+		asr_disable_mask = JUNIPER_ASR_DISABLE_MASK;
+		break;
+
+	case ASMTYPE_SPRUCE:
+		type = "Spruce's ";
+		asr_base = SPRUCE_BASE_ADDRESS;
+		asr_read_addr = asr_write_addr = asr_base;
+		asr_toggle_mask = SPRUCE_ASR_TOGGLE_MASK;
+		asr_disable_mask = SPRUCE_ASR_DISABLE_MASK;
+		break;
+	}
+
+	if (!request_region(asr_base, asr_length, "ibmasr")) {
+		printk(KERN_ERR PFX "address %#x already in use\n",
+			asr_base);
+		return -EBUSY;
+	}
+
+	printk(KERN_INFO PFX "found %sASR @ addr %#x\n", type, asr_base);
+
+	return 0;
+}
+
+
+static ssize_t asr_write(struct file *file, const char __user *buf,
+			 size_t count, loff_t *ppos)
+{
+	if (count) {
+		if (!nowayout) {
+			size_t i;
+
+			/* In case it was set long ago */
+			asr_expect_close = 0;
+
+			for (i = 0; i != count; i++) {
+				char c;
+				if (get_user(c, buf + i))
+					return -EFAULT;
+				if (c == 'V')
+					asr_expect_close = 42;
+			}
+		}
+		asr_toggle();
+	}
+	return count;
+}
+
+static int asr_ioctl(struct inode *inode, struct file *file,
+		     unsigned int cmd, unsigned long arg)
+{
+	static const struct watchdog_info ident = {
+		.options =	WDIOF_KEEPALIVEPING | 
+				WDIOF_MAGICCLOSE,
+		.identity =	"IBM ASR"
+	};
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
+	int heartbeat;
+
+	switch (cmd) {
+		case WDIOC_GETSUPPORT:
+			return copy_to_user(argp, &ident, sizeof(ident)) ?
+				-EFAULT : 0;
+
+		case WDIOC_GETSTATUS:
+		case WDIOC_GETBOOTSTATUS:
+			return put_user(0, p);
+
+		case WDIOC_KEEPALIVE:
+			asr_toggle();
+			return 0;
+
+		/*
+		 * The hardware has a fixed timeout value, so no WDIOC_SETTIMEOUT
+		 * and WDIOC_GETTIMEOUT always returns 256.
+		 */
+		case WDIOC_GETTIMEOUT:
+			heartbeat = 256;
+			return put_user(heartbeat, p);
+
+		case WDIOC_SETOPTIONS: {
+			int new_options, retval = -EINVAL;
+
+			if (get_user(new_options, p))
+				return -EFAULT;
+
+			if (new_options & WDIOS_DISABLECARD) {
+				asr_disable();
+				retval = 0;
+			}
+
+			if (new_options & WDIOS_ENABLECARD) {
+				asr_enable();
+				asr_toggle();
+				retval = 0;
+			}
+
+			return retval;
+		}
+	}
+
+	return -ENOIOCTLCMD;
+}
+
+static int asr_open(struct inode *inode, struct file *file)
+{
+	if(test_and_set_bit(0, &asr_is_open))
+		return -EBUSY;
+
+	asr_toggle();
+	asr_enable();
+
+	return nonseekable_open(inode, file);
+}
+
+static int asr_release(struct inode *inode, struct file *file)
+{
+	if (asr_expect_close == 42)
+		asr_disable();
+	else {
+		printk(KERN_CRIT PFX "unexpected close, not stopping watchdog!\n");
+		asr_toggle();
+	}
+	clear_bit(0, &asr_is_open);
+	asr_expect_close = 0;
+	return 0;
+}
+
+static struct file_operations asr_fops = {
+	.owner =	THIS_MODULE,
+	.llseek	=	no_llseek,
+	.write =	asr_write,
+	.ioctl =	asr_ioctl,
+	.open =		asr_open,
+	.release =	asr_release,
+};
+
+static struct miscdevice asr_miscdev = {
+	.minor =	WATCHDOG_MINOR,
+	.name =		"watchdog",
+	.fops =		&asr_fops,
+};
+
+
+struct ibmasr_id {
+	const char *desc;
+	int type;
+};
+
+static struct ibmasr_id __initdata ibmasr_id_table[] = {
+	{ "IBM Automatic Server Restart - eserver xSeries 220", ASMTYPE_TOPAZ },
+	{ "IBM Automatic Server Restart - Machine Type 8673", ASMTYPE_PEARL },
+	{ "IBM Automatic Server Restart - Machine Type 8480", ASMTYPE_JASPER },
+	{ "IBM Automatic Server Restart - Machine Type 8482", ASMTYPE_JUNIPER },
+	{ "IBM Automatic Server Restart - Machine Type 8648", ASMTYPE_SPRUCE },
+	{ NULL }
+};
+
+static int __init ibmasr_init(void)
+{
+	struct ibmasr_id *id;
+	int rc;
+
+	for (id = ibmasr_id_table; id->desc; id++) {
+		if (dmi_find_device(DMI_DEV_TYPE_OTHER, id->desc, NULL)) {
+			asr_type = id->type;
+			break;
+		}
+	}
+
+	if (!asr_type)
+		return -ENODEV;
+
+	rc = misc_register(&asr_miscdev);
+	if (rc < 0) {
+		printk(KERN_ERR PFX "failed to register misc device\n");
+		return rc;
+	}
+
+	rc = asr_get_base_address();
+	if (rc) {
+		misc_deregister(&asr_miscdev);
+		return rc;
+	}
+
+	return 0;
+}
+
+static void __exit ibmasr_exit(void)
+{
+	if (!nowayout)
+		asr_disable();
+
+	misc_deregister(&asr_miscdev);
+
+	release_region(asr_base, asr_length);
+}
+
+module_init(ibmasr_init);
+module_exit(ibmasr_exit);
+
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
+MODULE_DESCRIPTION("IBM Automatic Server Restart driver");
+MODULE_AUTHOR("Andrey Panin");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff --git a/drivers/char/watchdog/mv64x60_wdt.c b/drivers/char/watchdog/mv64x60_wdt.c
new file mode 100644
--- /dev/null
+++ b/drivers/char/watchdog/mv64x60_wdt.c
@@ -0,0 +1,252 @@
+/*
+ * mv64x60_wdt.c - MV64X60 (Marvell Discovery) watchdog userspace interface
+ *
+ * Author: James Chapman <jchapman@katalix.com>
+ *
+ * Platform-specific setup code should configure the dog to generate
+ * interrupt or reset as required.  This code only enables/disables
+ * and services the watchdog.
+ *
+ * Derived from mpc8xx_wdt.c, with the following copyright.
+ * 
+ * 2002 (c) Florian Schirmer <jolt@tuxbox.org> This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/watchdog.h>
+#include <asm/mv64x60.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+/* MV64x60 WDC (config) register access definitions */
+#define MV64x60_WDC_CTL1_MASK	(3 << 24)
+#define MV64x60_WDC_CTL1(val)	((val & 3) << 24)
+#define MV64x60_WDC_CTL2_MASK	(3 << 26)
+#define MV64x60_WDC_CTL2(val)	((val & 3) << 26)
+
+/* Flags bits */
+#define MV64x60_WDOG_FLAG_OPENED	0
+#define MV64x60_WDOG_FLAG_ENABLED	1
+
+static unsigned long wdt_flags;
+static int wdt_status;
+static void __iomem *mv64x60_regs;
+static int mv64x60_wdt_timeout;
+
+static void mv64x60_wdt_reg_write(u32 val)
+{
+	/* Allow write only to CTL1 / CTL2 fields, retaining values in
+	 * other fields.
+	 */
+	u32 data = readl(mv64x60_regs + MV64x60_WDT_WDC);
+	data &= ~(MV64x60_WDC_CTL1_MASK | MV64x60_WDC_CTL2_MASK);
+	data |= val;
+	writel(data, mv64x60_regs + MV64x60_WDT_WDC);
+}
+
+static void mv64x60_wdt_service(void)
+{
+	/* Write 01 followed by 10 to CTL2 */
+	mv64x60_wdt_reg_write(MV64x60_WDC_CTL2(0x01));
+	mv64x60_wdt_reg_write(MV64x60_WDC_CTL2(0x02));
+}
+
+static void mv64x60_wdt_handler_disable(void)
+{
+	if (test_and_clear_bit(MV64x60_WDOG_FLAG_ENABLED, &wdt_flags)) {
+		/* Write 01 followed by 10 to CTL1 */
+		mv64x60_wdt_reg_write(MV64x60_WDC_CTL1(0x01));
+		mv64x60_wdt_reg_write(MV64x60_WDC_CTL1(0x02));
+		printk(KERN_NOTICE "mv64x60_wdt: watchdog deactivated\n");
+	}
+}
+
+static void mv64x60_wdt_handler_enable(void)
+{
+	if (!test_and_set_bit(MV64x60_WDOG_FLAG_ENABLED, &wdt_flags)) {
+		/* Write 01 followed by 10 to CTL1 */
+		mv64x60_wdt_reg_write(MV64x60_WDC_CTL1(0x01));
+		mv64x60_wdt_reg_write(MV64x60_WDC_CTL1(0x02));
+		printk(KERN_NOTICE "mv64x60_wdt: watchdog activated\n");
+	}
+}
+
+static int mv64x60_wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(MV64x60_WDOG_FLAG_OPENED, &wdt_flags))
+		return -EBUSY;
+
+	mv64x60_wdt_service();
+	mv64x60_wdt_handler_enable();
+
+	return 0;
+}
+
+static int mv64x60_wdt_release(struct inode *inode, struct file *file)
+{
+	mv64x60_wdt_service();
+
+#if !defined(CONFIG_WATCHDOG_NOWAYOUT)
+	mv64x60_wdt_handler_disable();
+#endif
+
+	clear_bit(MV64x60_WDOG_FLAG_OPENED, &wdt_flags);
+
+	return 0;
+}
+
+static ssize_t mv64x60_wdt_write(struct file *file, const char *data,
+				 size_t len, loff_t * ppos)
+{
+	if (*ppos != file->f_pos)
+		return -ESPIPE;
+
+	if (len)
+		mv64x60_wdt_service();
+
+	return len;
+}
+
+static int mv64x60_wdt_ioctl(struct inode *inode, struct file *file,
+			     unsigned int cmd, unsigned long arg)
+{
+	int timeout;
+	static struct watchdog_info info = {
+		.options = WDIOF_KEEPALIVEPING,
+		.firmware_version = 0,
+		.identity = "MV64x60 watchdog",
+	};
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		if (copy_to_user((void *)arg, &info, sizeof(info)))
+			return -EFAULT;
+		break;
+
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		if (put_user(wdt_status, (int *)arg))
+			return -EFAULT;
+		wdt_status &= ~WDIOF_KEEPALIVEPING;
+		break;
+
+	case WDIOC_GETTEMP:
+		return -EOPNOTSUPP;
+
+	case WDIOC_SETOPTIONS:
+		return -EOPNOTSUPP;
+
+	case WDIOC_KEEPALIVE:
+		mv64x60_wdt_service();
+		wdt_status |= WDIOF_KEEPALIVEPING;
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		return -EOPNOTSUPP;
+
+	case WDIOC_GETTIMEOUT:
+		timeout = mv64x60_wdt_timeout * HZ;
+		if (put_user(timeout, (int *)arg))
+			return -EFAULT;
+		break;
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return 0;
+}
+
+static struct file_operations mv64x60_wdt_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.write = mv64x60_wdt_write,
+	.ioctl = mv64x60_wdt_ioctl,
+	.open = mv64x60_wdt_open,
+	.release = mv64x60_wdt_release,
+};
+
+static struct miscdevice mv64x60_wdt_miscdev = {
+	.minor = WATCHDOG_MINOR,
+	.name = "watchdog",
+	.fops = &mv64x60_wdt_fops,
+};
+
+static int __devinit mv64x60_wdt_probe(struct device *dev)
+{
+	struct platform_device *pd = to_platform_device(dev);
+	struct mv64x60_wdt_pdata *pdata = pd->dev.platform_data;
+	int bus_clk = 133;
+
+	mv64x60_wdt_timeout = 10;
+	if (pdata) {
+		mv64x60_wdt_timeout = pdata->timeout;
+		bus_clk = pdata->bus_clk;
+	}
+
+	mv64x60_regs = mv64x60_get_bridge_vbase();
+
+	writel((mv64x60_wdt_timeout * (bus_clk * 1000000)) >> 8,
+	       mv64x60_regs + MV64x60_WDT_WDC);
+
+	return misc_register(&mv64x60_wdt_miscdev);
+}
+
+static int __devexit mv64x60_wdt_remove(struct device *dev)
+{
+	misc_deregister(&mv64x60_wdt_miscdev);
+
+	mv64x60_wdt_service();
+	mv64x60_wdt_handler_disable();
+
+	return 0;
+}
+
+static struct device_driver mv64x60_wdt_driver = {
+	.name = MV64x60_WDT_NAME,
+	.bus = &platform_bus_type,
+	.probe = mv64x60_wdt_probe,
+	.remove = __devexit_p(mv64x60_wdt_remove),
+};
+
+static struct platform_device *mv64x60_wdt_dev;
+
+static int __init mv64x60_wdt_init(void)
+{
+	int ret;
+
+	printk(KERN_INFO "MV64x60 watchdog driver\n");
+
+	mv64x60_wdt_dev = platform_device_register_simple(MV64x60_WDT_NAME,
+							  -1, NULL, 0);
+	if (IS_ERR(mv64x60_wdt_dev)) {
+		ret = PTR_ERR(mv64x60_wdt_dev);
+		goto out;
+	}
+
+	ret = driver_register(&mv64x60_wdt_driver);
+      out:
+	return ret;
+}
+
+static void __exit mv64x60_wdt_exit(void)
+{
+	driver_unregister(&mv64x60_wdt_driver);
+	platform_device_unregister(mv64x60_wdt_dev);
+}
+
+module_init(mv64x60_wdt_init);
+module_exit(mv64x60_wdt_exit);
+
+MODULE_AUTHOR("James Chapman <jchapman@katalix.com>");
+MODULE_DESCRIPTION("MV64x60 watchdog driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff --git a/drivers/char/watchdog/pcwd_pci.c b/drivers/char/watchdog/pcwd_pci.c
--- a/drivers/char/watchdog/pcwd_pci.c
+++ b/drivers/char/watchdog/pcwd_pci.c
@@ -29,27 +29,29 @@
  *	Includes, defines, variables, module parameters, ...
  */
 
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/types.h>
-#include <linux/delay.h>
-#include <linux/miscdevice.h>
-#include <linux/watchdog.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
-#include <linux/init.h>
-#include <linux/fs.h>
-#include <linux/pci.h>
-#include <linux/ioport.h>
-#include <linux/spinlock.h>
+#include <linux/config.h>	/* For CONFIG_WATCHDOG_NOWAYOUT/... */
+#include <linux/module.h>	/* For module specific items */
+#include <linux/moduleparam.h>	/* For new moduleparam's */
+#include <linux/types.h>	/* For standard types (like size_t) */
+#include <linux/errno.h>	/* For the -ENODEV/... values */
+#include <linux/kernel.h>	/* For printk/panic/... */
+#include <linux/delay.h>	/* For mdelay function */
+#include <linux/miscdevice.h>	/* For MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR) */
+#include <linux/watchdog.h>	/* For the watchdog specific items */
+#include <linux/notifier.h>	/* For notifier support */
+#include <linux/reboot.h>	/* For reboot_notifier stuff */
+#include <linux/init.h>		/* For __init/__exit/... */
+#include <linux/fs.h>		/* For file operations */
+#include <linux/pci.h>		/* For pci functions */
+#include <linux/ioport.h>	/* For io-port access */
+#include <linux/spinlock.h>	/* For spin_lock/spin_unlock/... */
 
-#include <asm/uaccess.h>
-#include <asm/io.h>
+#include <asm/uaccess.h>	/* For copy_to_user/put_user/... */
+#include <asm/io.h>		/* For inb/outb/... */
 
 /* Module and version information */
 #define WATCHDOG_VERSION "1.01"
-#define WATCHDOG_DATE "15 Mar 2005"
+#define WATCHDOG_DATE "02 Sep 2005"
 #define WATCHDOG_DRIVER_NAME "PCI-PC Watchdog"
 #define WATCHDOG_NAME "pcwd_pci"
 #define PFX WATCHDOG_NAME ": "
@@ -335,12 +337,14 @@ static int pcipcwd_ioctl(struct inode *i
 				return -EFAULT;
 
 			if (new_options & WDIOS_DISABLECARD) {
-				pcipcwd_stop();
+				if (pcipcwd_stop())
+					return -EIO;
 				retval = 0;
 			}
 
 			if (new_options & WDIOS_ENABLECARD) {
-				pcipcwd_start();
+				if (pcipcwd_start())
+					return -EIO;
 				retval = 0;
 			}
 
diff --git a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
--- a/drivers/char/watchdog/s3c2410_wdt.c
+++ b/drivers/char/watchdog/s3c2410_wdt.c
@@ -464,7 +464,7 @@ static void s3c2410wdt_shutdown(struct d
 static unsigned long wtcon_save;
 static unsigned long wtdat_save;
 
-static int s3c2410wdt_suspend(struct device *dev, u32 state, u32 level)
+static int s3c2410wdt_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level == SUSPEND_POWER_DOWN) {
 		/* Save watchdog state, and turn it off. */
diff --git a/drivers/char/watchdog/sbc8360.c b/drivers/char/watchdog/sbc8360.c
new file mode 100644
--- /dev/null
+++ b/drivers/char/watchdog/sbc8360.c
@@ -0,0 +1,414 @@
+/*
+ *	SBC8360 Watchdog driver
+ *
+ *	(c) Copyright 2005 Webcon, Inc.
+ *
+ *	Based on ib700wdt.c, which is based on advantechwdt.c which is based
+ *      on acquirewdt.c which is based on wdt.c.
+ *
+ *	(c) Copyright 2001 Charles Howes <chowes@vsol.net>
+ *
+ *      Based on advantechwdt.c which is based on acquirewdt.c which
+ *       is based on wdt.c.
+ *
+ *	(c) Copyright 2000-2001 Marek Michalkiewicz <marekm@linux.org.pl>
+ *
+ *	Based on acquirewdt.c which is based on wdt.c.
+ *	Original copyright messages:
+ *
+ *	(c) Copyright 1996 Alan Cox <alan@redhat.com>, All Rights Reserved.
+ *				http://www.redhat.com
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
+ *	warranty for any of this software. This material is provided
+ *	"AS-IS" and at no charge.
+ *
+ *	(c) Copyright 1995    Alan Cox <alan@redhat.com>
+ *
+ *      14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
+ *           Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
+ *           Added timeout module option to override default
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/notifier.h>
+#include <linux/fs.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/moduleparam.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+static unsigned long sbc8360_is_open;
+static spinlock_t sbc8360_lock;
+static char expect_close;
+
+#define PFX "sbc8360: "
+
+/*
+ *
+ * Watchdog Timer Configuration
+ *
+ * The function of the watchdog timer is to reset the system automatically
+ * and is defined at I/O port 0120H and 0121H.  To enable the watchdog timer
+ * and allow the system to reset, write appropriate values from the table
+ * below to I/O port 0120H and 0121H.  To disable the timer, write a zero
+ * value to I/O port 0121H for the system to stop the watchdog function.
+ *
+ * The following describes how the timer should be programmed (according to
+ * the vendor documentation)
+ *
+ * Enabling Watchdog:
+ * MOV AX,000AH (enable, phase I)
+ * MOV DX,0120H
+ * OUT DX,AX
+ * MOV AX,000BH (enable, phase II)
+ * MOV DX,0120H
+ * OUT DX,AX
+ * MOV AX,000nH (set multiplier n, from 1-4)
+ * MOV DX,0120H
+ * OUT DX,AX
+ * MOV AX,000mH (set base timer m, from 0-F)
+ * MOV DX,0121H
+ * OUT DX,AX
+ *
+ * Reset timer:
+ * MOV AX,000mH (same as set base timer, above)
+ * MOV DX,0121H
+ * OUT DX,AX
+ *
+ * Disabling Watchdog:
+ * MOV AX,0000H (a zero value)
+ * MOV DX,0120H
+ * OUT DX,AX
+ *
+ * Watchdog timeout configuration values:
+ *		N
+ *	M |	1	2	3	4
+ *	--|----------------------------------
+ *	0 |	0.5s	5s	50s	100s
+ *	1 |	1s	10s	100s	200s
+ *	2 |	1.5s	15s	150s	300s
+ *	3 |	2s	20s	200s	400s
+ *	4 |	2.5s	25s	250s	500s
+ *	5 |	3s	30s	300s	600s
+ *	6 |	3.5s	35s	350s	700s
+ *	7 |	4s	40s	400s	800s
+ *	8 |	4.5s	45s	450s	900s
+ *	9 |	5s	50s	500s	1000s
+ *	A |	5.5s	55s	550s	1100s
+ *	B |	6s	60s	600s	1200s
+ *	C |	6.5s	65s	650s	1300s
+ *	D |	7s	70s	700s	1400s
+ *	E |	7.5s	75s	750s	1500s
+ *	F |	8s	80s 	800s 	1600s
+ *
+ * Another way to say the same things is:
+ *  For N=1, Timeout = (M+1) * 0.5s
+ *  For N=2, Timeout = (M+1) * 5s
+ *  For N=3, Timeout = (M+1) * 50s
+ *  For N=4, Timeout = (M+1) * 100s
+ *
+ */
+
+static int wd_times[64][2] = {
+	{0, 1},			/* 0  = 0.5s */
+	{1, 1},			/* 1  = 1s   */
+	{2, 1},			/* 2  = 1.5s */
+	{3, 1},			/* 3  = 2s   */
+	{4, 1},			/* 4  = 2.5s */
+	{5, 1},			/* 5  = 3s   */
+	{6, 1},			/* 6  = 3.5s */
+	{7, 1},			/* 7  = 4s   */
+	{8, 1},			/* 8  = 4.5s */
+	{9, 1},			/* 9  = 5s   */
+	{0xA, 1},		/* 10 = 5.5s */
+	{0xB, 1},		/* 11 = 6s   */
+	{0xC, 1},		/* 12 = 6.5s */
+	{0xD, 1},		/* 13 = 7s   */
+	{0xE, 1},		/* 14 = 7.5s */
+	{0xF, 1},		/* 15 = 8s   */
+	{0, 2},			/* 16 = 5s  */
+	{1, 2},			/* 17 = 10s */
+	{2, 2},			/* 18 = 15s */
+	{3, 2},			/* 19 = 20s */
+	{4, 2},			/* 20 = 25s */
+	{5, 2},			/* 21 = 30s */
+	{6, 2},			/* 22 = 35s */
+	{7, 2},			/* 23 = 40s */
+	{8, 2},			/* 24 = 45s */
+	{9, 2},			/* 25 = 50s */
+	{0xA, 2},		/* 26 = 55s */
+	{0xB, 2},		/* 27 = 60s */
+	{0xC, 2},		/* 28 = 65s */
+	{0xD, 2},		/* 29 = 70s */
+	{0xE, 2},		/* 30 = 75s */
+	{0xF, 2},		/* 31 = 80s */
+	{0, 3},			/* 32 = 50s  */
+	{1, 3},			/* 33 = 100s */
+	{2, 3},			/* 34 = 150s */
+	{3, 3},			/* 35 = 200s */
+	{4, 3},			/* 36 = 250s */
+	{5, 3},			/* 37 = 300s */
+	{6, 3},			/* 38 = 350s */
+	{7, 3},			/* 39 = 400s */
+	{8, 3},			/* 40 = 450s */
+	{9, 3},			/* 41 = 500s */
+	{0xA, 3},		/* 42 = 550s */
+	{0xB, 3},		/* 43 = 600s */
+	{0xC, 3},		/* 44 = 650s */
+	{0xD, 3},		/* 45 = 700s */
+	{0xE, 3},		/* 46 = 750s */
+	{0xF, 3},		/* 47 = 800s */
+	{0, 4},			/* 48 = 100s */
+	{1, 4},			/* 49 = 200s */
+	{2, 4},			/* 50 = 300s */
+	{3, 4},			/* 51 = 400s */
+	{4, 4},			/* 52 = 500s */
+	{5, 4},			/* 53 = 600s */
+	{6, 4},			/* 54 = 700s */
+	{7, 4},			/* 55 = 800s */
+	{8, 4},			/* 56 = 900s */
+	{9, 4},			/* 57 = 1000s */
+	{0xA, 4},		/* 58 = 1100s */
+	{0xB, 4},		/* 59 = 1200s */
+	{0xC, 4},		/* 60 = 1300s */
+	{0xD, 4},		/* 61 = 1400s */
+	{0xE, 4},		/* 62 = 1500s */
+	{0xF, 4}		/* 63 = 1600s */
+};
+
+#define SBC8360_ENABLE 0x120
+#define SBC8360_BASETIME 0x121
+
+static int timeout = 27;
+static int wd_margin = 0xB;
+static int wd_multiplier = 2;
+static int nowayout = WATCHDOG_NOWAYOUT;
+
+module_param(timeout, int, 27);
+MODULE_PARM_DESC(timeout, "Index into timeout table (0-63) (default=27 (60s))");
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout,
+		 "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
+/*
+ *	Kernel methods.
+ */
+
+/* Activate and pre-configure watchdog */
+static void sbc8360_activate(void)
+{
+	/* Enable the watchdog */
+	outb(0x0A, SBC8360_ENABLE);
+	msleep_interruptible(100);
+	outb(0x0B, SBC8360_ENABLE);
+	msleep_interruptible(100);
+	/* Set timeout multiplier */
+	outb(wd_multiplier, SBC8360_ENABLE);
+	msleep_interruptible(100);
+	/* Nothing happens until first sbc8360_ping() */
+}
+
+/* Kernel pings watchdog */
+static void sbc8360_ping(void)
+{
+	/* Write the base timer register */
+	outb(wd_margin, SBC8360_BASETIME);
+}
+
+/* Userspace pings kernel driver, or requests clean close */
+static ssize_t sbc8360_write(struct file *file, const char __user * buf,
+			     size_t count, loff_t * ppos)
+{
+	if (count) {
+		if (!nowayout) {
+			size_t i;
+
+			/* In case it was set long ago */
+			expect_close = 0;
+
+			for (i = 0; i != count; i++) {
+				char c;
+				if (get_user(c, buf + i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 42;
+			}
+		}
+		sbc8360_ping();
+	}
+	return count;
+}
+
+static int sbc8360_open(struct inode *inode, struct file *file)
+{
+	spin_lock(&sbc8360_lock);
+	if (test_and_set_bit(0, &sbc8360_is_open)) {
+		spin_unlock(&sbc8360_lock);
+		return -EBUSY;
+	}
+	if (nowayout)
+		__module_get(THIS_MODULE);
+
+	/* Activate and ping once to start the countdown */
+	spin_unlock(&sbc8360_lock);
+	sbc8360_activate();
+	sbc8360_ping();
+	return nonseekable_open(inode, file);
+}
+
+static int sbc8360_close(struct inode *inode, struct file *file)
+{
+	spin_lock(&sbc8360_lock);
+	if (expect_close == 42)
+		outb(0, SBC8360_ENABLE);
+	else
+		printk(KERN_CRIT PFX
+		       "SBC8360 device closed unexpectedly.  SBC8360 will not stop!\n");
+
+	clear_bit(0, &sbc8360_is_open);
+	expect_close = 0;
+	spin_unlock(&sbc8360_lock);
+	return 0;
+}
+
+/*
+ *	Notifier for system down
+ */
+
+static int sbc8360_notify_sys(struct notifier_block *this, unsigned long code,
+			      void *unused)
+{
+	if (code == SYS_DOWN || code == SYS_HALT) {
+		/* Disable the SBC8360 Watchdog */
+		outb(0, SBC8360_ENABLE);
+	}
+	return NOTIFY_DONE;
+}
+
+/*
+ *	Kernel Interfaces
+ */
+
+static struct file_operations sbc8360_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.write = sbc8360_write,
+	.open = sbc8360_open,
+	.release = sbc8360_close,
+};
+
+static struct miscdevice sbc8360_miscdev = {
+	.minor = WATCHDOG_MINOR,
+	.name = "watchdog",
+	.fops = &sbc8360_fops,
+};
+
+/*
+ *	The SBC8360 needs to learn about soft shutdowns in order to
+ *	turn the timebomb registers off.
+ */
+
+static struct notifier_block sbc8360_notifier = {
+	.notifier_call = sbc8360_notify_sys,
+};
+
+static int __init sbc8360_init(void)
+{
+	int res;
+	unsigned long int mseconds = 60000;
+
+	spin_lock_init(&sbc8360_lock);
+	res = misc_register(&sbc8360_miscdev);
+	if (res) {
+		printk(KERN_ERR PFX "failed to register misc device\n");
+		goto out_nomisc;
+	}
+
+	if (!request_region(SBC8360_ENABLE, 1, "SBC8360")) {
+		printk(KERN_ERR PFX "ENABLE method I/O %X is not available.\n",
+		       SBC8360_ENABLE);
+		res = -EIO;
+		goto out_noenablereg;
+	}
+	if (!request_region(SBC8360_BASETIME, 1, "SBC8360")) {
+		printk(KERN_ERR PFX
+		       "BASETIME method I/O %X is not available.\n",
+		       SBC8360_BASETIME);
+		res = -EIO;
+		goto out_nobasetimereg;
+	}
+
+	res = register_reboot_notifier(&sbc8360_notifier);
+	if (res) {
+		printk(KERN_ERR PFX "Failed to register reboot notifier.\n");
+		goto out_noreboot;
+	}
+
+	if (timeout < 0 || timeout > 63) {
+		printk(KERN_ERR PFX "Invalid timeout index (must be 0-63).\n");
+		res = -EINVAL;
+		goto out_noreboot;
+	}
+
+	wd_margin = wd_times[timeout][0];
+	wd_multiplier = wd_times[timeout][1];
+
+	if (wd_multiplier == 1)
+		mseconds = (wd_margin + 1) * 500;
+	else if (wd_multiplier == 2)
+		mseconds = (wd_margin + 1) * 5000;
+	else if (wd_multiplier == 3)
+		mseconds = (wd_margin + 1) * 50000;
+	else if (wd_multiplier == 4)
+		mseconds = (wd_margin + 1) * 100000;
+
+	/* My kingdom for the ability to print "0.5 seconds" in the kernel! */
+	printk(KERN_INFO PFX "Timeout set at %ld ms.\n", mseconds);
+
+	return 0;
+
+      out_noreboot:
+	release_region(SBC8360_ENABLE, 1);
+	release_region(SBC8360_BASETIME, 1);
+      out_noenablereg:
+      out_nobasetimereg:
+	misc_deregister(&sbc8360_miscdev);
+      out_nomisc:
+	return res;
+}
+
+static void __exit sbc8360_exit(void)
+{
+	misc_deregister(&sbc8360_miscdev);
+	unregister_reboot_notifier(&sbc8360_notifier);
+	release_region(SBC8360_ENABLE, 1);
+	release_region(SBC8360_BASETIME, 1);
+}
+
+module_init(sbc8360_init);
+module_exit(sbc8360_exit);
+
+MODULE_AUTHOR("Ian E. Morgan <imorgan@webcon.ca>");
+MODULE_DESCRIPTION("SBC8360 watchdog driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+
+/* end of sbc8360.c */
diff --git a/drivers/char/watchdog/w83977f_wdt.c b/drivers/char/watchdog/w83977f_wdt.c
new file mode 100644
--- /dev/null
+++ b/drivers/char/watchdog/w83977f_wdt.c
@@ -0,0 +1,543 @@
+/*
+ *	W83977F Watchdog Timer Driver for Winbond W83977F I/O Chip
+ *
+ *	(c) Copyright 2005  Jose Goncalves <jose.goncalves@inov.pt>
+ *
+ *      Based on w83877f_wdt.c by Scott Jennings,
+ *           and wdt977.c by Woody Suwalski
+ *
+ *			-----------------------
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/watchdog.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/uaccess.h>
+
+#define WATCHDOG_VERSION  "1.00"
+#define WATCHDOG_NAME     "W83977F WDT"
+#define PFX WATCHDOG_NAME ": "
+#define DRIVER_VERSION    WATCHDOG_NAME " driver, v" WATCHDOG_VERSION "\n"
+
+#define IO_INDEX_PORT     0x3F0
+#define IO_DATA_PORT      (IO_INDEX_PORT+1)
+
+#define UNLOCK_DATA       0x87
+#define LOCK_DATA         0xAA
+#define DEVICE_REGISTER   0x07
+
+#define	DEFAULT_TIMEOUT   45		/* default timeout in seconds */
+
+static	int timeout = DEFAULT_TIMEOUT;
+static	int timeoutW;			/* timeout in watchdog counter units */
+static	unsigned long timer_alive;
+static	int testmode;
+static	char expect_close;
+static	spinlock_t spinlock;
+
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout,"Watchdog timeout in seconds (15..7635), default=" __MODULE_STRING(DEFAULT_TIMEOUT) ")");
+module_param(testmode, int, 0);
+MODULE_PARM_DESC(testmode,"Watchdog testmode (1 = no reboot), default=0");
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
+/*
+ * Start the watchdog
+ */
+
+static int wdt_start(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&spinlock, flags);
+
+	/* Unlock the SuperIO chip */
+	outb_p(UNLOCK_DATA,IO_INDEX_PORT);
+	outb_p(UNLOCK_DATA,IO_INDEX_PORT);
+
+	/*
+	 * Select device Aux2 (device=8) to set watchdog regs F2, F3 and F4.
+	 * F2 has the timeout in watchdog counter units.
+	 * F3 is set to enable watchdog LED blink at timeout.
+	 * F4 is used to just clear the TIMEOUT'ed state (bit 0).
+	 */
+	outb_p(DEVICE_REGISTER,IO_INDEX_PORT);
+	outb_p(0x08,IO_DATA_PORT);
+	outb_p(0xF2,IO_INDEX_PORT);
+	outb_p(timeoutW,IO_DATA_PORT);
+	outb_p(0xF3,IO_INDEX_PORT);
+	outb_p(0x08,IO_DATA_PORT);
+	outb_p(0xF4,IO_INDEX_PORT);
+	outb_p(0x00,IO_DATA_PORT);
+
+	/* Set device Aux2 active */
+	outb_p(0x30,IO_INDEX_PORT);
+	outb_p(0x01,IO_DATA_PORT);
+
+	/* 
+	 * Select device Aux1 (dev=7) to set GP16 as the watchdog output
+	 * (in reg E6) and GP13 as the watchdog LED output (in reg E3).
+	 * Map GP16 at pin 119.
+	 * In test mode watch the bit 0 on F4 to indicate "triggered" or
+	 * check watchdog LED on SBC.
+	 */
+	outb_p(DEVICE_REGISTER,IO_INDEX_PORT);
+	outb_p(0x07,IO_DATA_PORT);
+	if (!testmode)
+	{
+		unsigned pin_map;
+
+		outb_p(0xE6,IO_INDEX_PORT);
+		outb_p(0x0A,IO_DATA_PORT);
+		outb_p(0x2C,IO_INDEX_PORT);
+		pin_map = inb_p(IO_DATA_PORT);
+		pin_map |= 0x10;
+		pin_map &= ~(0x20);
+		outb_p(0x2C,IO_INDEX_PORT);
+		outb_p(pin_map,IO_DATA_PORT);
+	}
+	outb_p(0xE3,IO_INDEX_PORT);
+	outb_p(0x08,IO_DATA_PORT);
+
+	/* Set device Aux1 active */
+	outb_p(0x30,IO_INDEX_PORT);
+	outb_p(0x01,IO_DATA_PORT);
+
+	/* Lock the SuperIO chip */
+	outb_p(LOCK_DATA,IO_INDEX_PORT);
+
+	spin_unlock_irqrestore(&spinlock, flags);
+
+	printk(KERN_INFO PFX "activated.\n");
+
+	return 0;
+}
+
+/*
+ * Stop the watchdog
+ */
+
+static int wdt_stop(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&spinlock, flags);
+
+	/* Unlock the SuperIO chip */
+	outb_p(UNLOCK_DATA,IO_INDEX_PORT);
+	outb_p(UNLOCK_DATA,IO_INDEX_PORT);
+
+	/* 
+	 * Select device Aux2 (device=8) to set watchdog regs F2, F3 and F4.
+	 * F2 is reset to its default value (watchdog timer disabled).
+	 * F3 is reset to its default state.
+	 * F4 clears the TIMEOUT'ed state (bit 0) - back to default.
+	 */
+	outb_p(DEVICE_REGISTER,IO_INDEX_PORT);
+	outb_p(0x08,IO_DATA_PORT);
+	outb_p(0xF2,IO_INDEX_PORT);
+	outb_p(0xFF,IO_DATA_PORT);
+	outb_p(0xF3,IO_INDEX_PORT);
+	outb_p(0x00,IO_DATA_PORT);
+	outb_p(0xF4,IO_INDEX_PORT);
+	outb_p(0x00,IO_DATA_PORT);
+	outb_p(0xF2,IO_INDEX_PORT);
+	outb_p(0x00,IO_DATA_PORT);
+
+	/*
+	 * Select device Aux1 (dev=7) to set GP16 (in reg E6) and 
+	 * Gp13 (in reg E3) as inputs.
+	 */
+	outb_p(DEVICE_REGISTER,IO_INDEX_PORT);
+	outb_p(0x07,IO_DATA_PORT);
+	if (!testmode)
+	{
+		outb_p(0xE6,IO_INDEX_PORT);
+		outb_p(0x01,IO_DATA_PORT);
+	}
+	outb_p(0xE3,IO_INDEX_PORT);
+	outb_p(0x01,IO_DATA_PORT);
+
+	/* Lock the SuperIO chip */
+	outb_p(LOCK_DATA,IO_INDEX_PORT);
+
+	spin_unlock_irqrestore(&spinlock, flags);
+
+	printk(KERN_INFO PFX "shutdown.\n");
+
+	return 0;
+}
+
+/*
+ * Send a keepalive ping to the watchdog
+ * This is done by simply re-writing the timeout to reg. 0xF2
+ */
+
+static int wdt_keepalive(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&spinlock, flags);
+
+	/* Unlock the SuperIO chip */
+	outb_p(UNLOCK_DATA,IO_INDEX_PORT);
+	outb_p(UNLOCK_DATA,IO_INDEX_PORT);
+
+	/* Select device Aux2 (device=8) to kick watchdog reg F2 */
+	outb_p(DEVICE_REGISTER,IO_INDEX_PORT);
+	outb_p(0x08,IO_DATA_PORT);
+	outb_p(0xF2,IO_INDEX_PORT);
+	outb_p(timeoutW,IO_DATA_PORT);
+
+	/* Lock the SuperIO chip */
+	outb_p(LOCK_DATA,IO_INDEX_PORT);
+
+	spin_unlock_irqrestore(&spinlock, flags);
+
+	return 0;
+}
+
+/*
+ * Set the watchdog timeout value
+ */
+
+static int wdt_set_timeout(int t)
+{
+	int tmrval;
+
+	/*
+	 * Convert seconds to watchdog counter time units, rounding up.
+	 * On PCM-5335 watchdog units are 30 seconds/step with 15 sec startup 
+	 * value. This information is supplied in the PCM-5335 manual and was
+	 * checked by me on a real board. This is a bit strange because W83977f
+	 * datasheet says counter unit is in minutes!
+	 */
+	if (t < 15)
+		return -EINVAL;
+
+	tmrval = ((t + 15) + 29) / 30;
+
+	if (tmrval > 255)
+		return -EINVAL;
+
+	/*
+	 * timeout is the timeout in seconds, 
+	 * timeoutW is the timeout in watchdog counter units.
+	 */
+	timeoutW = tmrval;
+	timeout = (timeoutW * 30) - 15;
+	return 0;
+}
+
+/*
+ * Get the watchdog status
+ */
+
+static int wdt_get_status(int *status)
+{
+	int new_status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&spinlock, flags);
+
+	/* Unlock the SuperIO chip */
+	outb_p(UNLOCK_DATA,IO_INDEX_PORT);
+	outb_p(UNLOCK_DATA,IO_INDEX_PORT);
+
+	/* Select device Aux2 (device=8) to read watchdog reg F4 */
+	outb_p(DEVICE_REGISTER,IO_INDEX_PORT);
+	outb_p(0x08,IO_DATA_PORT);
+	outb_p(0xF4,IO_INDEX_PORT);
+	new_status = inb_p(IO_DATA_PORT);
+
+	/* Lock the SuperIO chip */
+	outb_p(LOCK_DATA,IO_INDEX_PORT);
+
+	spin_unlock_irqrestore(&spinlock, flags);
+
+	*status = 0;
+	if (new_status & 1)
+		*status |= WDIOF_CARDRESET;
+
+	return 0;
+}
+
+
+/*
+ *	/dev/watchdog handling
+ */
+
+static int wdt_open(struct inode *inode, struct file *file)
+{
+	/* If the watchdog is alive we don't need to start it again */
+	if( test_and_set_bit(0, &timer_alive) )
+		return -EBUSY;
+
+	if (nowayout)
+		__module_get(THIS_MODULE);
+
+	wdt_start();
+	return nonseekable_open(inode, file);
+}
+
+static int wdt_release(struct inode *inode, struct file *file)
+{
+	/*
+	 * Shut off the timer.
+	 * Lock it in if it's a module and we set nowayout
+	 */
+	if (expect_close == 42)
+	{
+		wdt_stop();
+		clear_bit(0, &timer_alive);
+	} else {
+		wdt_keepalive();
+		printk(KERN_CRIT PFX "unexpected close, not stopping watchdog!\n");
+	}
+	expect_close = 0;
+	return 0;
+}
+
+/*
+ *      wdt_write:
+ *      @file: file handle to the watchdog
+ *      @buf: buffer to write (unused as data does not matter here
+ *      @count: count of bytes
+ *      @ppos: pointer to the position to write. No seeks allowed
+ *
+ *      A write to a watchdog device is defined as a keepalive signal. Any
+ *      write of data will do, as we we don't define content meaning.
+ */
+
+static ssize_t wdt_write(struct file *file, const char __user *buf,
+			    size_t count, loff_t *ppos)
+{
+	/* See if we got the magic character 'V' and reload the timer */
+	if(count)
+	{
+		if (!nowayout)
+		{
+			size_t ofs;
+
+			/* note: just in case someone wrote the magic character long ago */
+			expect_close = 0;
+
+			/* scan to see whether or not we got the magic character */
+			for(ofs = 0; ofs != count; ofs++)
+			{
+				char c;
+				if (get_user(c, buf + ofs))
+					return -EFAULT;
+				if (c == 'V') {
+					expect_close = 42;
+				}
+			}
+		}
+
+		/* someone wrote to us, we should restart timer */
+		wdt_keepalive();
+	}
+	return count;
+}
+
+/*
+ *      wdt_ioctl:
+ *      @inode: inode of the device
+ *      @file: file handle to the device
+ *      @cmd: watchdog command
+ *      @arg: argument pointer
+ *
+ *      The watchdog API defines a common set of functions for all watchdogs
+ *      according to their available features.
+ */
+
+static struct watchdog_info ident = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
+	.firmware_version =	1,
+	.identity = WATCHDOG_NAME,
+};
+
+static int wdt_ioctl(struct inode *inode, struct file *file,
+	unsigned int cmd, unsigned long arg)
+{
+	int status;
+	int new_options, retval = -EINVAL;
+	int new_timeout;
+	union {
+		struct watchdog_info __user *ident;
+		int __user *i;
+	} uarg;
+
+	uarg.i = (int __user *)arg;
+
+	switch(cmd)
+	{
+	default:
+		return -ENOIOCTLCMD;
+
+	case WDIOC_GETSUPPORT:
+		return copy_to_user(uarg.ident, &ident, sizeof(ident)) ? -EFAULT : 0;
+
+	case WDIOC_GETSTATUS:
+		wdt_get_status(&status);
+		return put_user(status, uarg.i);
+
+	case WDIOC_GETBOOTSTATUS:
+		return put_user(0, uarg.i);
+
+	case WDIOC_KEEPALIVE:
+		wdt_keepalive();
+		return 0;
+
+	case WDIOC_SETOPTIONS:
+		if (get_user (new_options, uarg.i))
+			return -EFAULT;
+
+		if (new_options & WDIOS_DISABLECARD) {
+			wdt_stop();
+			retval = 0;
+		}
+
+		if (new_options & WDIOS_ENABLECARD) {
+			wdt_start();
+			retval = 0;
+		}
+
+		return retval;
+
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_timeout, uarg.i))
+			return -EFAULT;
+
+		if (wdt_set_timeout(new_timeout))
+		    return -EINVAL;
+
+		wdt_keepalive();
+		/* Fall */
+
+	case WDIOC_GETTIMEOUT:
+		return put_user(timeout, uarg.i);
+
+	}
+}
+
+static int wdt_notify_sys(struct notifier_block *this, unsigned long code,
+	void *unused)
+{
+	if (code==SYS_DOWN || code==SYS_HALT)
+		wdt_stop();
+	return NOTIFY_DONE;
+}
+
+static struct file_operations wdt_fops=
+{
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= wdt_write,
+	.ioctl		= wdt_ioctl,
+	.open		= wdt_open,
+	.release	= wdt_release,
+};
+
+static struct miscdevice wdt_miscdev=
+{
+	.minor		= WATCHDOG_MINOR,
+	.name		= "watchdog",
+	.fops		= &wdt_fops,
+};
+
+static struct notifier_block wdt_notifier = {
+	.notifier_call = wdt_notify_sys,
+};
+
+static int __init w83977f_wdt_init(void)
+{
+	int rc;
+
+        printk(KERN_INFO PFX DRIVER_VERSION);
+
+	spin_lock_init(&spinlock);
+
+	/*
+	 * Check that the timeout value is within it's range ; 
+	 * if not reset to the default
+	 */
+	if (wdt_set_timeout(timeout)) {
+		wdt_set_timeout(DEFAULT_TIMEOUT);
+		printk(KERN_INFO PFX "timeout value must be 15<=timeout<=7635, using %d\n",
+			DEFAULT_TIMEOUT);
+	}
+
+	if (!request_region(IO_INDEX_PORT, 2, WATCHDOG_NAME))
+	{
+		printk(KERN_ERR PFX "I/O address 0x%04x already in use\n",
+			IO_INDEX_PORT);
+		rc = -EIO;
+		goto err_out;
+	}
+
+	rc = misc_register(&wdt_miscdev);
+	if (rc)
+	{
+		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			wdt_miscdev.minor, rc);
+		goto err_out_region;
+	}
+
+	rc = register_reboot_notifier(&wdt_notifier);
+	if (rc)
+	{
+		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
+			rc);
+		goto err_out_miscdev;
+	}
+
+	printk(KERN_INFO PFX "initialized. timeout=%d sec (nowayout=%d testmode=%d)\n",
+		timeout, nowayout, testmode);
+
+	return 0;
+
+err_out_miscdev:
+	misc_deregister(&wdt_miscdev);
+err_out_region:
+	release_region(IO_INDEX_PORT,2);
+err_out:
+	return rc;
+}
+
+static void __exit w83977f_wdt_exit(void)
+{
+	wdt_stop();
+	misc_deregister(&wdt_miscdev);
+	unregister_reboot_notifier(&wdt_notifier);
+	release_region(IO_INDEX_PORT,2);
+}
+
+module_init(w83977f_wdt_init);
+module_exit(w83977f_wdt_exit);
+
+MODULE_AUTHOR("Jose Goncalves <jose.goncalves@inov.pt>");
+MODULE_DESCRIPTION("Driver for watchdog timer in W83977F I/O chip");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff --git a/include/asm-ppc/mv64x60.h b/include/asm-ppc/mv64x60.h
--- a/include/asm-ppc/mv64x60.h
+++ b/include/asm-ppc/mv64x60.h
@@ -119,6 +119,14 @@ extern spinlock_t mv64x60_lock;
 
 #define	MV64x60_64BIT_WIN_COUNT			24
 
+/* Watchdog Platform Device, Driver Data */
+#define	MV64x60_WDT_NAME			"wdt"
+
+struct mv64x60_wdt_pdata {
+	int	timeout;	/* watchdog expiry in seconds, default 10 */
+	int	bus_clk;	/* bus clock in MHz, default 133 */
+};
+
 /*
  * Define a structure that's used to pass in config information to the
  * core routines.
