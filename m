Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965403AbWJBV23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965403AbWJBV23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965401AbWJBV23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:28:29 -0400
Received: from outmx022.isp.belgacom.be ([195.238.4.203]:52375 "EHLO
	outmx022.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S965400AbWJBV2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:28:25 -0400
Date: Mon, 2 Oct 2006 23:27:53 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>, Samuel Tardieu <sam@rfc1149.net>,
       Ben Dooks <ben-linux@fluff.org>, Vitaly Wool <vitalywool@gmail.com>,
       Jiri Slaby <jirislaby@gmail.com>, Alan Cox <alan@redhat.com>
Subject: [WATCHDOG] v2.6.19 watchdog patches
Message-ID: <20061002212753.GA9556@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

If no-one objects, can you please pull from 'master' branch of
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 arch/arm/mach-pnx4008/clock.c        |   11 +
 drivers/char/watchdog/Kconfig        |   11 +
 drivers/char/watchdog/Makefile       |    1 
 drivers/char/watchdog/acquirewdt.c   |    2 
 drivers/char/watchdog/advantechwdt.c |    2 
 drivers/char/watchdog/alim1535_wdt.c |   12 -
 drivers/char/watchdog/alim7101_wdt.c |   17 +
 drivers/char/watchdog/at91_wdt.c     |    2 
 drivers/char/watchdog/booke_wdt.c    |    2 
 drivers/char/watchdog/cpu5wdt.c      |    2 
 drivers/char/watchdog/ep93xx_wdt.c   |    2 
 drivers/char/watchdog/eurotechwdt.c  |    2 
 drivers/char/watchdog/i6300esb.c     |    2 
 drivers/char/watchdog/i8xx_tco.c     |   35 +--
 drivers/char/watchdog/ib700wdt.c     |    2 
 drivers/char/watchdog/ibmasr.c       |    2 
 drivers/char/watchdog/indydog.c      |    2 
 drivers/char/watchdog/ixp2000_wdt.c  |    2 
 drivers/char/watchdog/ixp4xx_wdt.c   |    2 
 drivers/char/watchdog/machzwd.c      |    5 
 drivers/char/watchdog/mixcomwd.c     |    2 
 drivers/char/watchdog/mpc83xx_wdt.c  |    2 
 drivers/char/watchdog/mpc8xx_wdt.c   |    2 
 drivers/char/watchdog/mpcore_wdt.c   |    4 
 drivers/char/watchdog/mv64x60_wdt.c  |    2 
 drivers/char/watchdog/pcwd.c         |    2 
 drivers/char/watchdog/pcwd_pci.c     |    2 
 drivers/char/watchdog/pcwd_usb.c     |    2 
 drivers/char/watchdog/pnx4008_wdt.c  |  362 +++++++++++++++++++++++++++++++++++
 drivers/char/watchdog/s3c2410_wdt.c  |   12 -
 drivers/char/watchdog/sa1100_wdt.c   |    2 
 drivers/char/watchdog/sbc60xxwdt.c   |    2 
 drivers/char/watchdog/sbc_epx_c3.c   |    2 
 drivers/char/watchdog/sc1200wdt.c    |    2 
 drivers/char/watchdog/sc520_wdt.c    |    2 
 drivers/char/watchdog/scx200_wdt.c   |    2 
 drivers/char/watchdog/shwdt.c        |    2 
 drivers/char/watchdog/softdog.c      |    2 
 drivers/char/watchdog/w83627hf_wdt.c |    2 
 drivers/char/watchdog/w83877f_wdt.c  |    2 
 drivers/char/watchdog/w83977f_wdt.c  |    2 
 drivers/char/watchdog/wafer5823wdt.c |    2 
 drivers/char/watchdog/wdrtas.c       |    2 
 drivers/char/watchdog/wdt.c          |    2 
 drivers/char/watchdog/wdt285.c       |    2 
 drivers/char/watchdog/wdt977.c       |    2 
 drivers/char/watchdog/wdt_pci.c      |    2 
 include/asm-arm/arch-pnx4008/clock.h |    1 
 48 files changed, 472 insertions(+), 73 deletions(-)

with these Changes:

Author: Dave Jones <davej@redhat.com>
Date:   Tue Aug 1 20:06:43 2006 +0200

    [WATCHDOG] improve machzwd detection
    
    On a machine with no machzwd, loading the module prints out..
    
    machzwd: MachZ ZF-Logic Watchdog driver initializing.
    0xffff
    machzwd: Watchdog using action = RESET
    
    - the 0xffff printk is unnecessary
    - 0xffff seems to be 'hardware not present'
    - fix CodingStyle. (This driver could use some more work here)
    
    Signed-off-by: Dave Jones <davej@redhat.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Sat Sep 9 17:34:31 2006 +0200

    [WATCHDOG] use ENOTTY instead of ENOIOCTLCMD in ioctl()
    
    Return ENOTTY instead of ENOIOCTLCMD in user-visible ioctl() results
    
    The watchdog drivers used to return ENOIOCTLCMD for bad ioctl() commands.
    ENOIOCTLCMD should not be visible by the user, so use ENOTTY instead.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Acked-by: Alan Cox <alan@redhat.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Ben Dooks <ben-linux@fluff.org>
Date:   Wed Sep 6 12:24:35 2006 +0100

    [WATCHDOG] s3c24XX nowayout
    
    If the driver is not configured for `no way out`,
    then the open method should not automatically allow
    the setting of allow_close to CLOSE_STATE_ALLOW.
    
    The setting of allow_close nullifies the use of
    the magic close via the write path. It means that
    in the default state, the watchdog will shut-down
    even if the magic close has not been issued.
    
    Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Author: Vitaly Wool <vitalywool@gmail.com>
Date:   Mon Sep 11 14:42:39 2006 +0400

    [WATCHDOG] pnx4008: add cpu_relax()
    
    Added cpu_relax as suggested by Alan Cox.
    
    Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sun Sep 10 12:48:15 2006 +0200

    [WATCHDOG] pnx4008_wdt.c - spinlock fixes.
    
    Add io spinlocks to prevent possible race
    conditions between start and stop operations
    that are issued from different child processes
    where the master process opened /dev/watchdog.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sun Jul 30 20:06:07 2006 +0200

    [WATCHDOG] pnx4008_wdt.c - remove patch
    
    Change remove code so that we first detach
    the driver from userspace, then clean up the
    clock and then clean up the memory we allocated.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Mon Jul 3 09:03:47 2006 +0200

    [WATCHDOG] pnx4008_wdt.c - nowayout patch
    
    Change nowayout to: WATCHDOG_NOWAYOUT as defined
    in include/linux/watchdog.h .
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Vitaly Wool <vitalywool@gmail.com>
Date:   Mon Jun 26 19:31:49 2006 +0400

    [WATCHDOG] pnx4008: add watchdog support
    
    Add watchdog support for Philips PNX4008 ARM board inlined.
    
    Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Jiri Slaby <jirislaby@gmail.com>
Date:   Wed Jul 19 02:18:23 2006 +0159

    [WATCHDOG] i8xx_tco remove pci_find_device.
    
    Use refcounting for pci device obtaining.
    Use PCI_DEVICE macro.
    
    Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Cc: Andrew Morton <akpm@osdl.org>

Author: Jiri Slaby <jirislaby@gmail.com>
Date:   Tue Jul 18 18:29:00 2006 +0159

    [WATCHDOG] alim remove pci_find_device
    
    Convert pci_find_device to pci_get_device + pci_dev_put
    in alim watchdog cards' drivers (refcounting).
    
    Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/arch/arm/mach-pnx4008/clock.c b/arch/arm/mach-pnx4008/clock.c
index f582ed2..daa8d3d 100644
--- a/arch/arm/mach-pnx4008/clock.c
+++ b/arch/arm/mach-pnx4008/clock.c
@@ -735,6 +735,16 @@ static struct clk uart6_ck = {
 	.enable_reg = UARTCLKCTRL_REG,
 };
 
+static struct clk wdt_ck = {
+	.name = "wdt_ck",
+	.parent = &per_ck,
+	.flags = NEEDS_INITIALIZATION,
+	.round_rate = &on_off_round_rate,
+	.set_rate = &on_off_set_rate,
+	.enable_shift = 0,
+	.enable_reg = TIMCLKCTRL_REG,
+};
+
 /* These clocks are visible outside this module
  * and can be initialized
  */
@@ -765,6 +775,7 @@ static struct clk *onchip_clks[] = {
 	&uart4_ck,
 	&uart5_ck,
 	&uart6_ck,
+	&wdt_ck,
 };
 
 static int local_clk_enable(struct clk *clk)
diff --git a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
index 77ab7e0..06f3fa2 100644
--- a/drivers/char/watchdog/Kconfig
+++ b/drivers/char/watchdog/Kconfig
@@ -172,6 +172,17 @@ config OMAP_WATCHDOG
 	  Support for TI OMAP1610/OMAP1710/OMAP2420 watchdog.  Say 'Y' here to
 	  enable the OMAP1610/OMAP1710 watchdog timer.
 
+config PNX4008_WATCHDOG
+	tristate "PNX4008 Watchdog"
+	depends on WATCHDOG && ARCH_PNX4008
+	help
+	  Say Y here if to include support for the watchdog timer
+	  in the PNX4008 processor.
+	  This driver can be built as a module by choosing M. The module
+	  will be called pnx4008_wdt.
+
+	  Say N if you are unsure.
+
 # X86 (i386 + ia64 + x86_64) Architecture
 
 config ACQUIRE_WDT
diff --git a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
index 5099f8b..6ffca7c 100644
--- a/drivers/char/watchdog/Makefile
+++ b/drivers/char/watchdog/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_S3C2410_WATCHDOG) += s3c241
 obj-$(CONFIG_SA1100_WATCHDOG) += sa1100_wdt.o
 obj-$(CONFIG_MPCORE_WATCHDOG) += mpcore_wdt.o
 obj-$(CONFIG_EP93XX_WATCHDOG) += ep93xx_wdt.o
+obj-$(CONFIG_PNX4008_WATCHDOG) += pnx4008_wdt.o
 
 # X86 (i386 + ia64 + x86_64) Architecture
 obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
diff --git a/drivers/char/watchdog/acquirewdt.c b/drivers/char/watchdog/acquirewdt.c
index c77fe3c..154d67e 100644
--- a/drivers/char/watchdog/acquirewdt.c
+++ b/drivers/char/watchdog/acquirewdt.c
@@ -183,7 +183,7 @@ static int acq_ioctl(struct inode *inode
 	}
 
 	default:
-	  return -ENOIOCTLCMD;
+	  return -ENOTTY;
 	}
 }
 
diff --git a/drivers/char/watchdog/advantechwdt.c b/drivers/char/watchdog/advantechwdt.c
index 8069be4..9d73276 100644
--- a/drivers/char/watchdog/advantechwdt.c
+++ b/drivers/char/watchdog/advantechwdt.c
@@ -176,7 +176,7 @@ advwdt_ioctl(struct inode *inode, struct
 	}
 
 	default:
-	  return -ENOIOCTLCMD;
+	  return -ENOTTY;
 	}
 	return 0;
 }
diff --git a/drivers/char/watchdog/alim1535_wdt.c b/drivers/char/watchdog/alim1535_wdt.c
index c5c94e4..01b0d13 100644
--- a/drivers/char/watchdog/alim1535_wdt.c
+++ b/drivers/char/watchdog/alim1535_wdt.c
@@ -236,7 +236,7 @@ static int ali_ioctl(struct inode *inode
 			return put_user(timeout, p);
 
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 }
 
@@ -330,17 +330,20 @@ static int __init ali_find_watchdog(void
 	u32 wdog;
 
 	/* Check for a 1535 series bridge */
-	pdev = pci_find_device(PCI_VENDOR_ID_AL, 0x1535, NULL);
+	pdev = pci_get_device(PCI_VENDOR_ID_AL, 0x1535, NULL);
 	if(pdev == NULL)
 		return -ENODEV;
+	pci_dev_put(pdev);
 
 	/* Check for the a 7101 PMU */
-	pdev = pci_find_device(PCI_VENDOR_ID_AL, 0x7101, NULL);
+	pdev = pci_get_device(PCI_VENDOR_ID_AL, 0x7101, NULL);
 	if(pdev == NULL)
 		return -ENODEV;
 
-	if(pci_enable_device(pdev))
+	if(pci_enable_device(pdev)) {
+		pci_dev_put(pdev);
 		return -EIO;
+	}
 
 	ali_pci = pdev;
 
@@ -447,6 +450,7 @@ static void __exit watchdog_exit(void)
 	/* Deregister */
 	unregister_reboot_notifier(&ali_notifier);
 	misc_deregister(&ali_miscdev);
+	pci_dev_put(ali_pci);
 }
 
 module_init(watchdog_init);
diff --git a/drivers/char/watchdog/alim7101_wdt.c b/drivers/char/watchdog/alim7101_wdt.c
index ffd7684..5948863 100644
--- a/drivers/char/watchdog/alim7101_wdt.c
+++ b/drivers/char/watchdog/alim7101_wdt.c
@@ -277,7 +277,7 @@ static int fop_ioctl(struct inode *inode
 		case WDIOC_GETTIMEOUT:
 			return put_user(timeout, p);
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 }
 
@@ -333,6 +333,7 @@ static void __exit alim7101_wdt_unload(v
 	/* Deregister */
 	misc_deregister(&wdt_miscdev);
 	unregister_reboot_notifier(&wdt_notifier);
+	pci_dev_put(alim7101_pmu);
 }
 
 static int __init alim7101_wdt_init(void)
@@ -342,7 +343,8 @@ static int __init alim7101_wdt_init(void
 	char tmp;
 
 	printk(KERN_INFO PFX "Steve Hill <steve@navaho.co.uk>.\n");
-	alim7101_pmu = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,NULL);
+	alim7101_pmu = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,
+		NULL);
 	if (!alim7101_pmu) {
 		printk(KERN_INFO PFX "ALi M7101 PMU not present - WDT not set\n");
 		return -EBUSY;
@@ -351,21 +353,23 @@ static int __init alim7101_wdt_init(void
 	/* Set the WDT in the PMU to 1 second */
 	pci_write_config_byte(alim7101_pmu, ALI_7101_WDT, 0x02);
 
-	ali1543_south = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
+	ali1543_south = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
+		NULL);
 	if (!ali1543_south) {
 		printk(KERN_INFO PFX "ALi 1543 South-Bridge not present - WDT not set\n");
-		return -EBUSY;
+		goto err_out;
 	}
 	pci_read_config_byte(ali1543_south, 0x5e, &tmp);
+	pci_dev_put(ali1543_south);
 	if ((tmp & 0x1e) == 0x00) {
 		if (!use_gpio) {
 			printk(KERN_INFO PFX "Detected old alim7101 revision 'a1d'.  If this is a cobalt board, set the 'use_gpio' module parameter.\n");
-			return -EBUSY;
+			goto err_out;
 		} 
 		nowayout = 1;
 	} else if ((tmp & 0x1e) != 0x12 && (tmp & 0x1e) != 0x00) {
 		printk(KERN_INFO PFX "ALi 1543 South-Bridge does not have the correct revision number (???1001?) - WDT not set\n");
-		return -EBUSY;
+		goto err_out;
 	}
 
 	if(timeout < 1 || timeout > 3600) /* arbitrary upper limit */
@@ -404,6 +408,7 @@ static int __init alim7101_wdt_init(void
 err_out_miscdev:
 	misc_deregister(&wdt_miscdev);
 err_out:
+	pci_dev_put(alim7101_pmu);
 	return rc;
 }
 
diff --git a/drivers/char/watchdog/at91_wdt.c b/drivers/char/watchdog/at91_wdt.c
index cc26671..4e7a114 100644
--- a/drivers/char/watchdog/at91_wdt.c
+++ b/drivers/char/watchdog/at91_wdt.c
@@ -168,7 +168,7 @@ static int at91_wdt_ioctl(struct inode *
 			return 0;
 
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 }
 
diff --git a/drivers/char/watchdog/booke_wdt.c b/drivers/char/watchdog/booke_wdt.c
index e3cefc5..4889022 100644
--- a/drivers/char/watchdog/booke_wdt.c
+++ b/drivers/char/watchdog/booke_wdt.c
@@ -125,7 +125,7 @@ static int booke_wdt_ioctl (struct inode
 			return -EINVAL;
 		return 0;
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 
 	return 0;
diff --git a/drivers/char/watchdog/cpu5wdt.c b/drivers/char/watchdog/cpu5wdt.c
index 04c7e49..00bdabb 100644
--- a/drivers/char/watchdog/cpu5wdt.c
+++ b/drivers/char/watchdog/cpu5wdt.c
@@ -183,7 +183,7 @@ static int cpu5wdt_ioctl(struct inode *i
 			}
 			break;
 		default:
-    			return -ENOIOCTLCMD;
+    			return -ENOTTY;
 	}
 	return 0;
 }
diff --git a/drivers/char/watchdog/ep93xx_wdt.c b/drivers/char/watchdog/ep93xx_wdt.c
index 77c8a95..01cf123 100644
--- a/drivers/char/watchdog/ep93xx_wdt.c
+++ b/drivers/char/watchdog/ep93xx_wdt.c
@@ -144,7 +144,7 @@ static int
 ep93xx_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 		 unsigned long arg)
 {
-	int ret = -ENOIOCTLCMD;
+	int ret = -ENOTTY;
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
diff --git a/drivers/char/watchdog/eurotechwdt.c b/drivers/char/watchdog/eurotechwdt.c
index 62dbccb..4f42697 100644
--- a/drivers/char/watchdog/eurotechwdt.c
+++ b/drivers/char/watchdog/eurotechwdt.c
@@ -240,7 +240,7 @@ static int eurwdt_ioctl(struct inode *in
 
 	switch(cmd) {
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 
 	case WDIOC_GETSUPPORT:
 		return copy_to_user(argp, &ident, sizeof(ident)) ? -EFAULT : 0;
diff --git a/drivers/char/watchdog/i6300esb.c b/drivers/char/watchdog/i6300esb.c
index 870539e..fb64df4 100644
--- a/drivers/char/watchdog/i6300esb.c
+++ b/drivers/char/watchdog/i6300esb.c
@@ -315,7 +315,7 @@ static int esb_ioctl (struct inode *inod
                         return put_user(heartbeat, p);
 
                 default:
-                        return -ENOIOCTLCMD;
+                        return -ENOTTY;
         }
 }
 
diff --git a/drivers/char/watchdog/i8xx_tco.c b/drivers/char/watchdog/i8xx_tco.c
index 8385dd3..e0627d7 100644
--- a/drivers/char/watchdog/i8xx_tco.c
+++ b/drivers/char/watchdog/i8xx_tco.c
@@ -356,7 +356,7 @@ static int i8xx_tco_ioctl (struct inode 
 		}
 
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 }
 
@@ -406,18 +406,18 @@ static struct notifier_block i8xx_tco_no
  * want to register another driver on the same PCI id.
  */
 static struct pci_device_id i8xx_tco_pci_tbl[] = {
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_1,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0, },			/* End of list */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_1) },
+	{ },			/* End of list */
 };
 MODULE_DEVICE_TABLE (pci, i8xx_tco_pci_tbl);
 
@@ -434,12 +434,11 @@ static unsigned char __init i8xx_tco_get
 	 *      Find the PCI device
 	 */
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev)
 		if (pci_match_id(i8xx_tco_pci_tbl, dev)) {
 			i8xx_tco_pci = dev;
 			break;
 		}
-	}
 
 	if (i8xx_tco_pci) {
 		/*
@@ -454,6 +453,7 @@ static unsigned char __init i8xx_tco_get
 		/* Something's wrong here, ACPIBASE has to be set */
 		if (badr == 0x0001 || badr == 0x0000) {
 			printk (KERN_ERR PFX "failed to get TCOBASE address\n");
+			pci_dev_put(i8xx_tco_pci);
 			return 0;
 		}
 
@@ -465,6 +465,7 @@ static unsigned char __init i8xx_tco_get
 			pci_read_config_byte (i8xx_tco_pci, 0xd4, &val1);
 			if (val1 & 0x02) {
 				printk (KERN_ERR PFX "failed to reset NO_REBOOT flag, reboot disabled by hardware\n");
+				pci_dev_put(i8xx_tco_pci);
 				return 0;	/* Cannot reset NO_REBOOT bit */
 			}
 		}
@@ -476,6 +477,7 @@ static unsigned char __init i8xx_tco_get
 		if (!request_region (SMI_EN + 1, 1, "i8xx TCO")) {
 			printk (KERN_ERR PFX "I/O address 0x%04x already in use\n",
 				SMI_EN + 1);
+			pci_dev_put(i8xx_tco_pci);
 			return 0;
 		}
 		val1 = inb (SMI_EN + 1);
@@ -542,6 +544,7 @@ unreg_notifier:
 unreg_region:
 	release_region (TCOBASE, 0x10);
 out:
+	pci_dev_put(i8xx_tco_pci);
 	return ret;
 }
 
@@ -555,6 +558,8 @@ static void __exit watchdog_cleanup (voi
 	misc_deregister (&i8xx_tco_miscdev);
 	unregister_reboot_notifier(&i8xx_tco_notifier);
 	release_region (TCOBASE, 0x10);
+
+	pci_dev_put(i8xx_tco_pci);
 }
 
 module_init(watchdog_init);
diff --git a/drivers/char/watchdog/ib700wdt.c b/drivers/char/watchdog/ib700wdt.c
index fd95f73..c1ed209 100644
--- a/drivers/char/watchdog/ib700wdt.c
+++ b/drivers/char/watchdog/ib700wdt.c
@@ -199,7 +199,7 @@ ibwdt_ioctl(struct inode *inode, struct 
 	  break;
 
 	default:
-	  return -ENOIOCTLCMD;
+	  return -ENOTTY;
 	}
 	return 0;
 }
diff --git a/drivers/char/watchdog/ibmasr.c b/drivers/char/watchdog/ibmasr.c
index 26ceee7..dd6760f 100644
--- a/drivers/char/watchdog/ibmasr.c
+++ b/drivers/char/watchdog/ibmasr.c
@@ -295,7 +295,7 @@ static int asr_ioctl(struct inode *inode
 		}
 	}
 
-	return -ENOIOCTLCMD;
+	return -ENOTTY;
 }
 
 static int asr_open(struct inode *inode, struct file *file)
diff --git a/drivers/char/watchdog/indydog.c b/drivers/char/watchdog/indydog.c
index dacc1c2..0bc2393 100644
--- a/drivers/char/watchdog/indydog.c
+++ b/drivers/char/watchdog/indydog.c
@@ -112,7 +112,7 @@ static int indydog_ioctl(struct inode *i
 
 	switch (cmd) {
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			if (copy_to_user((struct watchdog_info *)arg,
 					 &ident, sizeof(ident)))
diff --git a/drivers/char/watchdog/ixp2000_wdt.c b/drivers/char/watchdog/ixp2000_wdt.c
index 6929088..c91d9a6 100644
--- a/drivers/char/watchdog/ixp2000_wdt.c
+++ b/drivers/char/watchdog/ixp2000_wdt.c
@@ -107,7 +107,7 @@ static int
 ixp2000_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 			unsigned long arg)
 {
-	int ret = -ENOIOCTLCMD;
+	int ret = -ENOTTY;
 	int time;
 
 	switch (cmd) {
diff --git a/drivers/char/watchdog/ixp4xx_wdt.c b/drivers/char/watchdog/ixp4xx_wdt.c
index 9db5cf2..db477f7 100644
--- a/drivers/char/watchdog/ixp4xx_wdt.c
+++ b/drivers/char/watchdog/ixp4xx_wdt.c
@@ -102,7 +102,7 @@ static int
 ixp4xx_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 			unsigned long arg)
 {
-	int ret = -ENOIOCTLCMD;
+	int ret = -ENOTTY;
 	int time;
 
 	switch (cmd) {
diff --git a/drivers/char/watchdog/machzwd.c b/drivers/char/watchdog/machzwd.c
index 23734e0..276577d 100644
--- a/drivers/char/watchdog/machzwd.c
+++ b/drivers/char/watchdog/machzwd.c
@@ -329,7 +329,7 @@ static int zf_ioctl(struct inode *inode,
 			break;
 
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 
 	return 0;
@@ -426,8 +426,7 @@ static int __init zf_init(void)
 	printk(KERN_INFO PFX ": MachZ ZF-Logic Watchdog driver initializing.\n");
 
 	ret = zf_get_ZFL_version();
-	printk("%#x\n", ret);
-	if((!ret) || (ret != 0xffff)){
+	if ((!ret) || (ret == 0xffff)) {
 		printk(KERN_WARNING PFX ": no ZF-Logic found\n");
 		return -ENODEV;
 	}
diff --git a/drivers/char/watchdog/mixcomwd.c b/drivers/char/watchdog/mixcomwd.c
index ae94332..c2dac0a 100644
--- a/drivers/char/watchdog/mixcomwd.c
+++ b/drivers/char/watchdog/mixcomwd.c
@@ -185,7 +185,7 @@ static int mixcomwd_ioctl(struct inode *
 			mixcomwd_ping();
 			break;
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 	return 0;
 }
diff --git a/drivers/char/watchdog/mpc83xx_wdt.c b/drivers/char/watchdog/mpc83xx_wdt.c
index a480903..18ca752 100644
--- a/drivers/char/watchdog/mpc83xx_wdt.c
+++ b/drivers/char/watchdog/mpc83xx_wdt.c
@@ -125,7 +125,7 @@ static int mpc83xx_wdt_ioctl(struct inod
 	case WDIOC_GETTIMEOUT:
 		return put_user(timeout_sec, p);
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 }
 
diff --git a/drivers/char/watchdog/mpc8xx_wdt.c b/drivers/char/watchdog/mpc8xx_wdt.c
index 35dd9e6..8aaed10 100644
--- a/drivers/char/watchdog/mpc8xx_wdt.c
+++ b/drivers/char/watchdog/mpc8xx_wdt.c
@@ -126,7 +126,7 @@ static int mpc8xx_wdt_ioctl(struct inode
 		break;
 
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 
 	return 0;
diff --git a/drivers/char/watchdog/mpcore_wdt.c b/drivers/char/watchdog/mpcore_wdt.c
index 54b3c56..02d336a 100644
--- a/drivers/char/watchdog/mpcore_wdt.c
+++ b/drivers/char/watchdog/mpcore_wdt.c
@@ -221,7 +221,7 @@ static int mpcore_wdt_ioctl(struct inode
 	} uarg;
 
 	if (_IOC_DIR(cmd) && _IOC_SIZE(cmd) > sizeof(uarg))
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 
 	if (_IOC_DIR(cmd) & _IOC_WRITE) {
 		ret = copy_from_user(&uarg, (void __user *)arg, _IOC_SIZE(cmd));
@@ -271,7 +271,7 @@ static int mpcore_wdt_ioctl(struct inode
 		break;
 
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 
 	if (ret == 0 && _IOC_DIR(cmd) & _IOC_READ) {
diff --git a/drivers/char/watchdog/mv64x60_wdt.c b/drivers/char/watchdog/mv64x60_wdt.c
index 5c8fab3..b887cdb 100644
--- a/drivers/char/watchdog/mv64x60_wdt.c
+++ b/drivers/char/watchdog/mv64x60_wdt.c
@@ -160,7 +160,7 @@ static int mv64x60_wdt_ioctl(struct inod
 		break;
 
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 
 	return 0;
diff --git a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
index cd7d1b6..6f8515d 100644
--- a/drivers/char/watchdog/pcwd.c
+++ b/drivers/char/watchdog/pcwd.c
@@ -572,7 +572,7 @@ static int pcwd_ioctl(struct inode *inod
 
 	switch(cmd) {
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 
 	case WDIOC_GETSUPPORT:
 		if(copy_to_user(argp, &ident, sizeof(ident)))
diff --git a/drivers/char/watchdog/pcwd_pci.c b/drivers/char/watchdog/pcwd_pci.c
index c7cfd6d..2de6e49 100644
--- a/drivers/char/watchdog/pcwd_pci.c
+++ b/drivers/char/watchdog/pcwd_pci.c
@@ -541,7 +541,7 @@ static int pcipcwd_ioctl(struct inode *i
 		}
 
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 }
 
diff --git a/drivers/char/watchdog/pcwd_usb.c b/drivers/char/watchdog/pcwd_usb.c
index b7ae73d..77662cb 100644
--- a/drivers/char/watchdog/pcwd_usb.c
+++ b/drivers/char/watchdog/pcwd_usb.c
@@ -445,7 +445,7 @@ static int usb_pcwd_ioctl(struct inode *
 		}
 
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 }
 
diff --git a/drivers/char/watchdog/pnx4008_wdt.c b/drivers/char/watchdog/pnx4008_wdt.c
new file mode 100644
index 0000000..e7f0450
--- /dev/null
+++ b/drivers/char/watchdog/pnx4008_wdt.c
@@ -0,0 +1,362 @@
+/*
+ * drivers/char/watchdog/pnx4008_wdt.c
+ *
+ * Watchdog driver for PNX4008 board
+ *
+ * Authors: Dmitry Chigirev <source@mvista.com>,
+ * 	    Vitaly Wool <vitalywool@gmail.com>
+ * Based on sa1100 driver,
+ * Copyright (C) 2000 Oleg Drokin <green@crimea.edu>
+ *
+ * 2005-2006 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/init.h>
+#include <linux/bitops.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/spinlock.h>
+
+#include <asm/hardware.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#define MODULE_NAME "PNX4008-WDT: "
+
+/* WatchDog Timer - Chapter 23 Page 207 */
+
+#define DEFAULT_HEARTBEAT 19
+#define MAX_HEARTBEAT     60
+
+/* Watchdog timer register set definition */
+#define WDTIM_INT(p)     ((p) + 0x0)
+#define WDTIM_CTRL(p)    ((p) + 0x4)
+#define WDTIM_COUNTER(p) ((p) + 0x8)
+#define WDTIM_MCTRL(p)   ((p) + 0xC)
+#define WDTIM_MATCH0(p)  ((p) + 0x10)
+#define WDTIM_EMR(p)     ((p) + 0x14)
+#define WDTIM_PULSE(p)   ((p) + 0x18)
+#define WDTIM_RES(p)     ((p) + 0x1C)
+
+/* WDTIM_INT bit definitions */
+#define MATCH_INT      1
+
+/* WDTIM_CTRL bit definitions */
+#define COUNT_ENAB     1
+#define RESET_COUNT    (1<<1)
+#define DEBUG_EN       (1<<2)
+
+/* WDTIM_MCTRL bit definitions */
+#define MR0_INT        1
+#undef  RESET_COUNT0
+#define RESET_COUNT0   (1<<2)
+#define STOP_COUNT0    (1<<2)
+#define M_RES1         (1<<3)
+#define M_RES2         (1<<4)
+#define RESFRC1        (1<<5)
+#define RESFRC2        (1<<6)
+
+/* WDTIM_EMR bit definitions */
+#define EXT_MATCH0      1
+#define MATCH_OUTPUT_HIGH (2<<4)	/*a MATCH_CTRL setting */
+
+/* WDTIM_RES bit definitions */
+#define WDOG_RESET      1	/* read only */
+
+#define WDOG_COUNTER_RATE 13000000	/*the counter clock is 13 MHz fixed */
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+static int heartbeat = DEFAULT_HEARTBEAT;
+
+static spinlock_t io_lock;
+static unsigned long wdt_status;
+#define WDT_IN_USE        0
+#define WDT_OK_TO_CLOSE   1
+#define WDT_REGION_INITED 2
+#define WDT_DEVICE_INITED 3
+
+static unsigned long boot_status;
+
+static struct resource	*wdt_mem;
+static void __iomem	*wdt_base;
+struct clk		*wdt_clk;
+
+static void wdt_enable(void)
+{
+	spin_lock(&io_lock);
+
+	if (wdt_clk)
+		clk_set_rate(wdt_clk, 1);
+
+	/* stop counter, initiate counter reset */
+	__raw_writel(RESET_COUNT, WDTIM_CTRL(wdt_base));
+	/*wait for reset to complete. 100% guarantee event */
+	while (__raw_readl(WDTIM_COUNTER(wdt_base)))
+		cpu_relax();
+	/* internal and external reset, stop after that */
+	__raw_writel(M_RES2 | STOP_COUNT0 | RESET_COUNT0,
+		WDTIM_MCTRL(wdt_base));
+	/* configure match output */
+	__raw_writel(MATCH_OUTPUT_HIGH, WDTIM_EMR(wdt_base));
+	/* clear interrupt, just in case */
+	__raw_writel(MATCH_INT, WDTIM_INT(wdt_base));
+	/* the longest pulse period 65541/(13*10^6) seconds ~ 5 ms. */
+	__raw_writel(0xFFFF, WDTIM_PULSE(wdt_base));
+	__raw_writel(heartbeat * WDOG_COUNTER_RATE, WDTIM_MATCH0(wdt_base));
+	/*enable counter, stop when debugger active */
+	__raw_writel(COUNT_ENAB | DEBUG_EN, WDTIM_CTRL(wdt_base));
+
+	spin_unlock(&io_lock);
+}
+
+static void wdt_disable(void)
+{
+	spin_lock(&io_lock);
+
+	__raw_writel(0, WDTIM_CTRL(wdt_base));	/*stop counter */
+	if (wdt_clk)
+		clk_set_rate(wdt_clk, 0);
+
+	spin_unlock(&io_lock);
+}
+
+static int pnx4008_wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(WDT_IN_USE, &wdt_status))
+		return -EBUSY;
+
+	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
+
+	wdt_enable();
+
+	return nonseekable_open(inode, file);
+}
+
+static ssize_t
+pnx4008_wdt_write(struct file *file, const char *data, size_t len,
+		  loff_t * ppos)
+{
+	/*  Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	if (len) {
+		if (!nowayout) {
+			size_t i;
+
+			clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
+
+			for (i = 0; i != len; i++) {
+				char c;
+
+				if (get_user(c, data + i))
+					return -EFAULT;
+				if (c == 'V')
+					set_bit(WDT_OK_TO_CLOSE, &wdt_status);
+			}
+		}
+		wdt_enable();
+	}
+
+	return len;
+}
+
+static struct watchdog_info ident = {
+	.options = WDIOF_CARDRESET | WDIOF_MAGICCLOSE |
+	    WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = "PNX4008 Watchdog",
+};
+
+static int
+pnx4008_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		  unsigned long arg)
+{
+	int ret = -ENOIOCTLCMD;
+	int time;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		ret = copy_to_user((struct watchdog_info *)arg, &ident,
+				   sizeof(ident)) ? -EFAULT : 0;
+		break;
+
+	case WDIOC_GETSTATUS:
+		ret = put_user(0, (int *)arg);
+		break;
+
+	case WDIOC_GETBOOTSTATUS:
+		ret = put_user(boot_status, (int *)arg);
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		ret = get_user(time, (int *)arg);
+		if (ret)
+			break;
+
+		if (time <= 0 || time > MAX_HEARTBEAT) {
+			ret = -EINVAL;
+			break;
+		}
+
+		heartbeat = time;
+		wdt_enable();
+		/* Fall through */
+
+	case WDIOC_GETTIMEOUT:
+		ret = put_user(heartbeat, (int *)arg);
+		break;
+
+	case WDIOC_KEEPALIVE:
+		wdt_enable();
+		ret = 0;
+		break;
+	}
+	return ret;
+}
+
+static int pnx4008_wdt_release(struct inode *inode, struct file *file)
+{
+	if (!test_bit(WDT_OK_TO_CLOSE, &wdt_status))
+		printk(KERN_WARNING "WATCHDOG: Device closed unexpectdly\n");
+
+	wdt_disable();
+	clear_bit(WDT_IN_USE, &wdt_status);
+	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
+
+	return 0;
+}
+
+static struct file_operations pnx4008_wdt_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.write = pnx4008_wdt_write,
+	.ioctl = pnx4008_wdt_ioctl,
+	.open = pnx4008_wdt_open,
+	.release = pnx4008_wdt_release,
+};
+
+static struct miscdevice pnx4008_wdt_miscdev = {
+	.minor = WATCHDOG_MINOR,
+	.name = "watchdog",
+	.fops = &pnx4008_wdt_fops,
+};
+
+static int pnx4008_wdt_probe(struct platform_device *pdev)
+{
+	int ret = 0, size;
+	struct resource *res;
+
+	spin_lock_init(&io_lock);
+
+	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
+		heartbeat = DEFAULT_HEARTBEAT;
+
+	printk(KERN_INFO MODULE_NAME
+		"PNX4008 Watchdog Timer: heartbeat %d sec\n", heartbeat);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		printk(KERN_INFO MODULE_NAME
+			"failed to get memory region resouce\n");
+		return -ENOENT;
+	}
+
+	size = res->end - res->start + 1;
+	wdt_mem = request_mem_region(res->start, size, pdev->name);
+
+	if (wdt_mem == NULL) {
+		printk(KERN_INFO MODULE_NAME "failed to get memory region\n");
+		return -ENOENT;
+	}
+	wdt_base = (void __iomem *)IO_ADDRESS(res->start);
+
+	wdt_clk = clk_get(&pdev->dev, "wdt_ck");
+	if (!wdt_clk) {
+		release_resource(wdt_mem);
+		kfree(wdt_mem);
+		goto out;
+	} else
+		clk_set_rate(wdt_clk, 1);
+
+	ret = misc_register(&pnx4008_wdt_miscdev);
+	if (ret < 0) {
+		printk(KERN_ERR MODULE_NAME "cannot register misc device\n");
+		release_resource(wdt_mem);
+		kfree(wdt_mem);
+		clk_set_rate(wdt_clk, 0);
+	} else {
+		boot_status = (__raw_readl(WDTIM_RES(wdt_base)) & WDOG_RESET) ?
+		    WDIOF_CARDRESET : 0;
+		wdt_disable();		/*disable for now */
+		set_bit(WDT_DEVICE_INITED, &wdt_status);
+	}
+
+out:
+	return ret;
+}
+
+static int pnx4008_wdt_remove(struct platform_device *pdev)
+{
+	misc_deregister(&pnx4008_wdt_miscdev);
+	if (wdt_clk) {
+		clk_set_rate(wdt_clk, 0);
+		clk_put(wdt_clk);
+		wdt_clk = NULL;
+	}
+	if (wdt_mem) {
+		release_resource(wdt_mem);
+		kfree(wdt_mem);
+		wdt_mem = NULL;
+	}
+	return 0;
+}
+
+static struct platform_driver platform_wdt_driver = {
+	.driver = {
+		.name = "watchdog",
+	},
+	.probe = pnx4008_wdt_probe,
+	.remove = pnx4008_wdt_remove,
+};
+
+static int __init pnx4008_wdt_init(void)
+{
+	return platform_driver_register(&platform_wdt_driver);
+}
+
+static void __exit pnx4008_wdt_exit(void)
+{
+	return platform_driver_unregister(&platform_wdt_driver);
+}
+
+module_init(pnx4008_wdt_init);
+module_exit(pnx4008_wdt_exit);
+
+MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
+MODULE_DESCRIPTION("PNX4008 Watchdog Driver");
+
+module_param(heartbeat, int, 0);
+MODULE_PARM_DESC(heartbeat,
+		 "Watchdog heartbeat period in seconds from 1 to "
+		 __MODULE_STRING(MAX_HEARTBEAT) ", default "
+		 __MODULE_STRING(DEFAULT_HEARTBEAT));
+
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout,
+		 "Set to 1 to keep watchdog running after device release");
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff --git a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
index be978e8..b36a04a 100644
--- a/drivers/char/watchdog/s3c2410_wdt.c
+++ b/drivers/char/watchdog/s3c2410_wdt.c
@@ -62,7 +62,7 @@ #define PFX "s3c2410-wdt: "
 #define CONFIG_S3C2410_WATCHDOG_ATBOOT		(0)
 #define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME	(15)
 
-static int nowayout = WATCHDOG_NOWAYOUT;
+static int nowayout	= WATCHDOG_NOWAYOUT;
 static int tmr_margin	= CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME;
 static int tmr_atboot	= CONFIG_S3C2410_WATCHDOG_ATBOOT;
 static int soft_noboot	= 0;
@@ -213,11 +213,10 @@ static int s3c2410wdt_open(struct inode 
 	if(down_trylock(&open_lock))
 		return -EBUSY;
 
-	if (nowayout) {
+	if (nowayout)
 		__module_get(THIS_MODULE);
-	} else {
-		allow_close = CLOSE_STATE_ALLOW;
-	}
+
+	allow_close = CLOSE_STATE_NOT;
 
 	/* start the timer */
 	s3c2410wdt_start();
@@ -230,6 +229,7 @@ static int s3c2410wdt_release(struct ino
 	 *	Shut off the timer.
 	 * 	Lock it in if it's a module and we set nowayout
 	 */
+
 	if (allow_close == CLOSE_STATE_ALLOW) {
 		s3c2410wdt_stop();
 	} else {
@@ -288,7 +288,7 @@ static int s3c2410wdt_ioctl(struct inode
 
 	switch (cmd) {
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 
 		case WDIOC_GETSUPPORT:
 			return copy_to_user(argp, &s3c2410_wdt_ident,
diff --git a/drivers/char/watchdog/sa1100_wdt.c b/drivers/char/watchdog/sa1100_wdt.c
index 1fc16d9..33c1137 100644
--- a/drivers/char/watchdog/sa1100_wdt.c
+++ b/drivers/char/watchdog/sa1100_wdt.c
@@ -90,7 +90,7 @@ static struct watchdog_info ident = {
 static int sa1100dog_ioctl(struct inode *inode, struct file *file,
 	unsigned int cmd, unsigned long arg)
 {
-	int ret = -ENOIOCTLCMD;
+	int ret = -ENOTTY;
 	int time;
 	void __user *argp = (void __user *)arg;
 	int __user *p = argp;
diff --git a/drivers/char/watchdog/sbc60xxwdt.c b/drivers/char/watchdog/sbc60xxwdt.c
index 4663c2f..c7b2045 100644
--- a/drivers/char/watchdog/sbc60xxwdt.c
+++ b/drivers/char/watchdog/sbc60xxwdt.c
@@ -235,7 +235,7 @@ static int fop_ioctl(struct inode *inode
 	switch(cmd)
 	{
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user(argp, &ident, sizeof(ident))?-EFAULT:0;
 		case WDIOC_GETSTATUS:
diff --git a/drivers/char/watchdog/sbc_epx_c3.c b/drivers/char/watchdog/sbc_epx_c3.c
index bfc475d..8882b42 100644
--- a/drivers/char/watchdog/sbc_epx_c3.c
+++ b/drivers/char/watchdog/sbc_epx_c3.c
@@ -141,7 +141,7 @@ static int epx_c3_ioctl(struct inode *in
 
 		return retval;
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 }
 
diff --git a/drivers/char/watchdog/sc1200wdt.c b/drivers/char/watchdog/sc1200wdt.c
index 7c3cf29..d8d0f28 100644
--- a/drivers/char/watchdog/sc1200wdt.c
+++ b/drivers/char/watchdog/sc1200wdt.c
@@ -180,7 +180,7 @@ static int sc1200wdt_ioctl(struct inode 
 
 	switch (cmd) {
 		default:
-			return -ENOIOCTLCMD;	/* Keep Pavel Machek amused ;) */
+			return -ENOTTY;
 
 		case WDIOC_GETSUPPORT:
 			if (copy_to_user(argp, &ident, sizeof ident))
diff --git a/drivers/char/watchdog/sc520_wdt.c b/drivers/char/watchdog/sc520_wdt.c
index 2c7c9db..caec37b 100644
--- a/drivers/char/watchdog/sc520_wdt.c
+++ b/drivers/char/watchdog/sc520_wdt.c
@@ -290,7 +290,7 @@ static int fop_ioctl(struct inode *inode
 	switch(cmd)
 	{
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user(argp, &ident, sizeof(ident))?-EFAULT:0;
 		case WDIOC_GETSTATUS:
diff --git a/drivers/char/watchdog/scx200_wdt.c b/drivers/char/watchdog/scx200_wdt.c
index c561299..fc0e034 100644
--- a/drivers/char/watchdog/scx200_wdt.c
+++ b/drivers/char/watchdog/scx200_wdt.c
@@ -166,7 +166,7 @@ static int scx200_wdt_ioctl(struct inode
 
 	switch (cmd) {
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	case WDIOC_GETSUPPORT:
 		if(copy_to_user(argp, &ident, sizeof(ident)))
 			return -EFAULT;
diff --git a/drivers/char/watchdog/shwdt.c b/drivers/char/watchdog/shwdt.c
index e5b8c64..dc40362 100644
--- a/drivers/char/watchdog/shwdt.c
+++ b/drivers/char/watchdog/shwdt.c
@@ -360,7 +360,7 @@ static int sh_wdt_ioctl(struct inode *in
 
 			return retval;
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 
 	return 0;
diff --git a/drivers/char/watchdog/softdog.c b/drivers/char/watchdog/softdog.c
index ef8da51..4067e1f 100644
--- a/drivers/char/watchdog/softdog.c
+++ b/drivers/char/watchdog/softdog.c
@@ -203,7 +203,7 @@ static int softdog_ioctl(struct inode *i
 	};
 	switch (cmd) {
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user(argp, &ident,
 				sizeof(ident)) ? -EFAULT : 0;
diff --git a/drivers/char/watchdog/w83627hf_wdt.c b/drivers/char/watchdog/w83627hf_wdt.c
index 13f16d4..b4adc52 100644
--- a/drivers/char/watchdog/w83627hf_wdt.c
+++ b/drivers/char/watchdog/w83627hf_wdt.c
@@ -223,7 +223,7 @@ wdt_ioctl(struct inode *inode, struct fi
 	}
 
 	default:
-	  return -ENOIOCTLCMD;
+	  return -ENOTTY;
 	}
 	return 0;
 }
diff --git a/drivers/char/watchdog/w83877f_wdt.c b/drivers/char/watchdog/w83877f_wdt.c
index ccf6c09..b0e5f84 100644
--- a/drivers/char/watchdog/w83877f_wdt.c
+++ b/drivers/char/watchdog/w83877f_wdt.c
@@ -252,7 +252,7 @@ static int fop_ioctl(struct inode *inode
 	switch(cmd)
 	{
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user(argp, &ident, sizeof(ident))?-EFAULT:0;
 		case WDIOC_GETSTATUS:
diff --git a/drivers/char/watchdog/w83977f_wdt.c b/drivers/char/watchdog/w83977f_wdt.c
index 98f4e17..2c8d5d8 100644
--- a/drivers/char/watchdog/w83977f_wdt.c
+++ b/drivers/char/watchdog/w83977f_wdt.c
@@ -393,7 +393,7 @@ static int wdt_ioctl(struct inode *inode
 	switch(cmd)
 	{
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 
 	case WDIOC_GETSUPPORT:
 		return copy_to_user(uarg.ident, &ident, sizeof(ident)) ? -EFAULT : 0;
diff --git a/drivers/char/watchdog/wafer5823wdt.c b/drivers/char/watchdog/wafer5823wdt.c
index 2bb6a9d..163e028 100644
--- a/drivers/char/watchdog/wafer5823wdt.c
+++ b/drivers/char/watchdog/wafer5823wdt.c
@@ -174,7 +174,7 @@ static int wafwdt_ioctl(struct inode *in
 	}
 
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 	return 0;
 }
diff --git a/drivers/char/watchdog/wdrtas.c b/drivers/char/watchdog/wdrtas.c
index 5c38cdf..1d64e27 100644
--- a/drivers/char/watchdog/wdrtas.c
+++ b/drivers/char/watchdog/wdrtas.c
@@ -385,7 +385,7 @@ wdrtas_ioctl(struct inode *inode, struct
 		return put_user(wdrtas_interval, argp);
 
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 }
 
diff --git a/drivers/char/watchdog/wdt.c b/drivers/char/watchdog/wdt.c
index 70be81e..13f23f4 100644
--- a/drivers/char/watchdog/wdt.c
+++ b/drivers/char/watchdog/wdt.c
@@ -341,7 +341,7 @@ #endif /* CONFIG_WDT_501 */
 	switch(cmd)
 	{
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user(argp, &ident, sizeof(ident))?-EFAULT:0;
 
diff --git a/drivers/char/watchdog/wdt285.c b/drivers/char/watchdog/wdt285.c
index 6555fb8..89a249e 100644
--- a/drivers/char/watchdog/wdt285.c
+++ b/drivers/char/watchdog/wdt285.c
@@ -137,7 +137,7 @@ watchdog_ioctl(struct inode *inode, stru
 	       unsigned long arg)
 {
 	unsigned int new_margin;
-	int ret = -ENOIOCTLCMD;
+	int ret = -ENOTTY;
 
 	switch(cmd) {
 	case WDIOC_GETSUPPORT:
diff --git a/drivers/char/watchdog/wdt977.c b/drivers/char/watchdog/wdt977.c
index a0935bc..6253041 100644
--- a/drivers/char/watchdog/wdt977.c
+++ b/drivers/char/watchdog/wdt977.c
@@ -361,7 +361,7 @@ static int wdt977_ioctl(struct inode *in
 	switch(cmd)
 	{
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 
 	case WDIOC_GETSUPPORT:
 		return copy_to_user(uarg.ident, &ident,
diff --git a/drivers/char/watchdog/wdt_pci.c b/drivers/char/watchdog/wdt_pci.c
index 5918ca2..74d8cf8 100644
--- a/drivers/char/watchdog/wdt_pci.c
+++ b/drivers/char/watchdog/wdt_pci.c
@@ -386,7 +386,7 @@ #endif /* CONFIG_WDT_501_PCI */
 	switch(cmd)
 	{
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user(argp, &ident, sizeof(ident))?-EFAULT:0;
 
diff --git a/include/asm-arm/arch-pnx4008/clock.h b/include/asm-arm/arch-pnx4008/clock.h
index 91ae003..ce155e1 100644
--- a/include/asm-arm/arch-pnx4008/clock.h
+++ b/include/asm-arm/arch-pnx4008/clock.h
@@ -32,6 +32,7 @@ #define I2CCLKCTRL_REG		(PWRMAN_VA_BASE 
 #define KEYCLKCTRL_REG		(PWRMAN_VA_BASE + 0xb0)
 #define TSCLKCTRL_REG		(PWRMAN_VA_BASE + 0xb4)
 #define PWMCLKCTRL_REG		(PWRMAN_VA_BASE + 0xb8)
+#define TIMCLKCTRL_REG		(PWRMAN_VA_BASE + 0xbc)
 #define SPICTRL_REG		(PWRMAN_VA_BASE + 0xc4)
 #define FLASHCLKCTRL_REG	(PWRMAN_VA_BASE + 0xc8)
 #define UART3CLK_REG		(PWRMAN_VA_BASE + 0xd0)
