Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263688AbSJHUZo>; Tue, 8 Oct 2002 16:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263685AbSJHUZL>; Tue, 8 Oct 2002 16:25:11 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:6668 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id <S263638AbSJHUWT>;
	Tue, 8 Oct 2002 16:22:19 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Updated SCx200 patches for 2.4
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 08 Oct 2002 22:27:52 +0200
Message-ID: <87ptukvfp3.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

My SCx200 patches just turned up in Linux-2.5.41, so I would like to
submit them for 2.4 too so that 2.4 and 2.5 are synced. 

The patch adds support for the National Semiconductor SCx200 processor
family to Linux 2.4.  The patch consists of the following drivers:

arch/i386/kernel/scx200.c -- give kernel access to the GPIO pins

drivers/chars/scx200_gpio.c -- give userspace access to the GPIO pins
drivers/chars/scx200_wdt.c -- watchdog timer driver

drivers/i2c/scx200_i2c.c -- use any two GPIO pins as an I2C bus
drivers/i2c/scx200_acb.c -- driver for the Access.BUS hardware

drivers/mtd/maps/scx200_docflash.c -- driver for a CFI flash connected
                                      to the DOCCS pin

If they look ok to you, please apply.

  /Christer


--=-=-=
Content-Disposition: attachment; filename=scx200-2.4.diff

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.724   -> 1.725  
#	drivers/mtd/maps/Makefile	1.5     -> 1.6    
#	drivers/i2c/Makefile	1.3     -> 1.4    
#	         MAINTAINERS	1.82    -> 1.83   
#	         init/main.c	1.26    -> 1.28   
#	arch/i386/kernel/Makefile	1.4     -> 1.6    
#	drivers/char/Config.in	1.36    -> 1.38   
#	 arch/i386/config.in	1.35    -> 1.37   
#	drivers/char/Makefile	1.23    -> 1.25   
#	include/linux/pci_ids.h	1.44.1.1 -> 1.46   
#	drivers/mtd/maps/Config.in	1.6     -> 1.7    
#	Documentation/Configure.help	1.136.1.2 -> 1.138  
#	drivers/i2c/Config.in	1.4     -> 1.6    
#	               (new)	        -> 1.2     include/linux/scx200.h
#	               (new)	        -> 1.1     drivers/char/scx200_gpio.c
#	               (new)	        -> 1.2     drivers/char/scx200_wdt.c
#	               (new)	        -> 1.1     drivers/i2c/scx200_i2c.c
#	               (new)	        -> 1.2     include/linux/scx200_gpio.h
#	               (new)	        -> 1.1     drivers/mtd/maps/scx200_docflash.c
#	               (new)	        -> 1.1     drivers/i2c/scx200_acb.c
#	               (new)	        -> 1.2     arch/i386/kernel/scx200.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/08	wingel@weinigel.se	1.725
# Merge weinigel.se:/export/bk/linux-2.4
# into weinigel.se:/export/bk/scx200-2.4
# --------------------------------------------
#
diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Tue Oct  8 22:22:45 2002
+++ b/Documentation/Configure.help	Tue Oct  8 22:22:45 2002
@@ -26197,6 +26197,58 @@
 
   If unsure, say N.
 
+NatSemi SCx200 support
+CONFIG_SCx200
+  This provides basic support for the National Semiconductor SCx200
+  processor.  Right now this is just a driver for the GPIO pins.
+
+  If you don't know what to do here, say N.
+
+  This support is also available as a module.  If compiled as a
+  module, it will be called scx200.o.
+
+NatSemi SCx200 Watchdog
+CONFIG_SCx200_WDT
+  Enable the built-in watchdog timer support on the National 
+  Semiconductor SCx200 processors.
+
+  If compiled as a module, it will be called scx200_watchdog.o.
+
+Flash device mapped with DOCCS on NatSemi SCx200
+CONFIG_MTD_SCx200_DOCFLASH
+  Enable support for a flash chip mapped using the DOCCS signal on a
+  National Semiconductor SCx200 processor.
+
+  If you don't know what to do here, say N.
+
+  If compiled as a module, it will be called scx200_docflash.o.
+
+NatSemi SCx200 I2C using GPIO pins
+CONFIG_SCx200_I2C
+  Enable the use of two GPIO pins of a SCx200 processor as an I2C bus.
+
+  If you don't know what to do here, say N.
+
+  If compiled as a module, it will be called scx200_i2c.o.
+
+GPIO pin used for SCL
+CONFIG_SCx200_I2C_SCL
+  Enter the GPIO pin number used for the SCL signal.  This value can
+  also be specified with a module parameter.
+
+GPIO pin used for SDA
+CONFIG_SCx200_I2C_SDA
+  Enter the GPIO pin number used for the SSA signal.  This value can
+  also be specified with a module parameter.
+
+NatSemi SCx200 ACCESS.bus
+CONFIG_SCx200_ACB
+  Enable the use of the ACCESS.bus controllers of a SCx200 processor.
+
+  If you don't know what to do here, say N.
+
+  If compiled as a module, it will be called scx200_acb.o.
+
 #
 # A couple of things I keep forgetting:
 #   capitalize: AppleTalk, Ethernet, DOS, DMA, FAT, FTP, Internet,
diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Tue Oct  8 22:22:45 2002
+++ b/MAINTAINERS	Tue Oct  8 22:22:45 2002
@@ -1430,6 +1430,12 @@
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 
+SCx200 CPU SUPPORT
+P:	Christer Weinigel
+M:	christer@weinigel.se
+W:	http://www.weinigel.se
+S:	Supported
+
 SGI VISUAL WORKSTATION 320 AND 540
 P:	Bent Hagemark
 M:	bh@sgi.com
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Tue Oct  8 22:22:45 2002
+++ b/arch/i386/config.in	Tue Oct  8 22:22:45 2002
@@ -263,6 +263,8 @@
    bool 'ISA bus support' CONFIG_ISA
 fi
 
+tristate 'NatSemi SCx200 support' CONFIG_SCx200
+
 source drivers/pci/Config.in
 
 bool 'EISA support' CONFIG_EISA
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Tue Oct  8 22:22:45 2002
+++ b/arch/i386/kernel/Makefile	Tue Oct  8 22:22:45 2002
@@ -41,4 +41,7 @@
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o acpitable.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
 
+export-objs += scx200.o
+obj-$(CONFIG_SCx200)		+= scx200.o
+
 include $(TOPDIR)/Rules.make
diff -Nru a/arch/i386/kernel/scx200.c b/arch/i386/kernel/scx200.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/scx200.c	Tue Oct  8 22:22:45 2002
@@ -0,0 +1,128 @@
+/* linux/arch/i386/kernel/scx200.c 
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   National Semiconductor SCx200 support. */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <linux/scx200.h>
+#include <linux/scx200.h>
+
+#define NAME "scx200"
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("NatSemi SCx200 Driver");
+MODULE_LICENSE("GPL");
+
+unsigned scx200_gpio_base = 0;
+long scx200_gpio_shadow[2];
+
+spinlock_t scx200_gpio_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t scx200_gpio_config_lock = SPIN_LOCK_UNLOCKED;
+
+u32 scx200_gpio_configure(int index, u32 mask, u32 bits)
+{
+	u32 config, new_config;
+	unsigned long flags;
+
+	spin_lock_irqsave(&scx200_gpio_config_lock, flags);
+
+	outl(index, scx200_gpio_base + 0x20);
+	config = inl(scx200_gpio_base + 0x24);
+
+	new_config = (config & mask) | bits;
+	outl(new_config, scx200_gpio_base + 0x24);
+
+	spin_unlock_irqrestore(&scx200_gpio_config_lock, flags);
+
+	return config;
+}
+
+void scx200_gpio_dump(unsigned index)
+{
+	u32 config = scx200_gpio_configure(index, ~0, 0);
+	printk(KERN_DEBUG "GPIO%02u: 0x%08lx", index, (unsigned long)config);
+	
+	if (config & 1) 
+		printk(" OE"); /* output enabled */
+	else
+		printk(" TS"); /* tristate */
+	if (config & 2) 
+		printk(" PP"); /* push pull */
+	else
+		printk(" OD"); /* open drain */
+	if (config & 4) 
+		printk(" PUE"); /* pull up enabled */
+	else
+		printk(" PUD"); /* pull up disabled */
+	if (config & 8) 
+		printk(" LOCKED"); /* locked */
+	if (config & 16) 
+		printk(" LEVEL"); /* level input */
+	else
+		printk(" EDGE"); /* edge input */
+	if (config & 32) 
+		printk(" HI"); /* trigger on rising edge */
+	else
+		printk(" LO"); /* trigger on falling edge */
+	if (config & 64) 
+		printk(" DEBOUNCE"); /* debounce */
+	printk("\n");
+}
+
+int __init scx200_init(void)
+{
+	struct pci_dev *bridge;
+	int bank;
+	unsigned base;
+
+	printk(KERN_INFO NAME ": NatSemi SCx200 Driver\n");
+
+	if ((bridge = pci_find_device(PCI_VENDOR_ID_NS, 
+				      PCI_DEVICE_ID_NS_SCx200_BRIDGE,
+				      NULL)) == NULL)
+		return -ENODEV;
+
+	base = pci_resource_start(bridge, 0);
+	printk(KERN_INFO NAME ": GPIO base 0x%x\n", base);
+
+	if (request_region(base, SCx200_GPIO_SIZE, "NatSemi SCx200 GPIO") == 0) {
+		printk(KERN_ERR NAME ": can't allocate I/O for GPIOs\n");
+		return -EBUSY;
+	}
+
+	scx200_gpio_base = base;
+
+	/* read the current values driven on the GPIO signals */
+	for (bank = 0; bank < 2; ++bank)
+		scx200_gpio_shadow[bank] = inl(scx200_gpio_base + 0x10 * bank);
+
+	return 0;
+}
+
+void __exit scx200_cleanup(void)
+{
+	release_region(scx200_gpio_base, SCx200_GPIO_SIZE);
+}
+
+module_init(scx200_init);
+module_exit(scx200_cleanup);
+
+EXPORT_SYMBOL(scx200_gpio_base);
+EXPORT_SYMBOL(scx200_gpio_shadow);
+EXPORT_SYMBOL(scx200_gpio_lock);
+EXPORT_SYMBOL(scx200_gpio_configure);
+EXPORT_SYMBOL(scx200_gpio_dump);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../../.. SUBDIRS=arch/i386/kernel modules"
+        c-basic-offset: 8
+    End:
+*/
diff -Nru a/drivers/char/Config.in b/drivers/char/Config.in
--- a/drivers/char/Config.in	Tue Oct  8 22:22:45 2002
+++ b/drivers/char/Config.in	Tue Oct  8 22:22:45 2002
@@ -212,6 +212,7 @@
    tristate '  Mixcom Watchdog' CONFIG_MIXCOMWD 
    tristate '  SBC-60XX Watchdog Timer' CONFIG_60XX_WDT
    dep_tristate '  SC1200 Watchdog Timer (EXPERIMENTAL)' CONFIG_SC1200_WDT $CONFIG_EXPERIMENTAL
+   tristate '  NatSemi SCx200 Watchdog' CONFIG_SCx200_WDT
    tristate '  Software Watchdog' CONFIG_SOFT_WATCHDOG
    tristate '  W83877F (EMACS) Watchdog Timer' CONFIG_W83877F_WDT
    tristate '  WDT Watchdog timer' CONFIG_WDT
@@ -235,6 +236,7 @@
    fi
    tristate 'NetWinder flash support' CONFIG_NWFLASH
 fi
+dep_tristate 'NatSemi SCx200 GPIO Support' CONFIG_SCx200_GPIO $CONFIG_SCx200
 
 if [ "$CONFIG_X86" = "y" -o "$CONFIG_X86_64" = "y" ]; then
    dep_tristate 'AMD 768 Random Number Generator support' CONFIG_AMD_RNG $CONFIG_PCI
diff -Nru a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile	Tue Oct  8 22:22:45 2002
+++ b/drivers/char/Makefile	Tue Oct  8 22:22:45 2002
@@ -252,6 +252,7 @@
 obj-$(CONFIG_DZ) += dz.o
 obj-$(CONFIG_NWBUTTON) += nwbutton.o
 obj-$(CONFIG_NWFLASH) += nwflash.o
+obj-$(CONFIG_SCx200_GPIO) += scx200_gpio.o
 
 # Only one watchdog can succeed. We probe the hardware watchdog
 # drivers first, then the softdog driver.  This means if your hardware
@@ -278,6 +279,7 @@
 #obj-$(CONFIG_ALIM1535_WDT) += alim1535d_wdt.o
 obj-$(CONFIG_INDYDOG) += indydog.o
 obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
+obj-$(CONFIG_SCx200_WDT) += scx200_wdt.o
 obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_AMD7XX_TCO) += amd7xx_tco.o
diff -Nru a/drivers/char/scx200_gpio.c b/drivers/char/scx200_gpio.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/scx200_gpio.c	Tue Oct  8 22:22:45 2002
@@ -0,0 +1,154 @@
+/* linux/drivers/char/scx200_gpio.c 
+
+   National Semiconductor SCx200 GPIO driver.  Allows a user space
+   process to play with the GPIO pins.
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com> */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#include <linux/scx200_gpio.h>
+
+#define NAME "scx200_gpio"
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("NatSemi SCx200 GPIO Pin Driver");
+MODULE_LICENSE("GPL");
+
+static int major = 0;		/* default to dynamic major */
+MODULE_PARM(major, "i");
+MODULE_PARM_DESC(major, "Major device number");
+
+static ssize_t scx200_gpio_write(struct file *file, const char *data, 
+				 size_t len, loff_t *ppos)
+{
+	unsigned m = minor(file->f_dentry->d_inode->i_rdev);
+	size_t i;
+
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	for (i = 0; i < len; ++i) {
+		char c;
+		if (get_user(c, data+i))
+			return -EFAULT;
+		switch (c)
+		{
+		case '0': 
+			scx200_gpio_set(m, 0); 
+			break;
+		case '1': 
+			scx200_gpio_set(m, 1); 
+			break;
+		case 'O':
+			printk(KERN_INFO NAME ": GPIO%d output enabled\n", m);
+			scx200_gpio_configure(m, ~1, 1);
+			break;
+		case 'o':
+			printk(KERN_INFO NAME ": GPIO%d output disabled\n", m);
+			scx200_gpio_configure(m, ~1, 0);
+			break;
+		case 'T':
+			printk(KERN_INFO NAME ": GPIO%d output is push pull\n", m);
+			scx200_gpio_configure(m, ~2, 2);
+			break;
+		case 't':
+			printk(KERN_INFO NAME ": GPIO%d output is open drain\n", m);
+			scx200_gpio_configure(m, ~2, 0);
+			break;
+		case 'P':
+			printk(KERN_INFO NAME ": GPIO%d pull up enabled\n", m);
+			scx200_gpio_configure(m, ~4, 4);
+			break;
+		case 'p':
+			printk(KERN_INFO NAME ": GPIO%d pull up disabled\n", m);
+			scx200_gpio_configure(m, ~4, 0);
+			break;
+		}
+	}
+
+	return len;
+}
+
+static ssize_t scx200_gpio_read(struct file *file, char *buf,
+				size_t len, loff_t *ppos)
+{
+	unsigned m = minor(file->f_dentry->d_inode->i_rdev);
+	int value;
+
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	value = scx200_gpio_get(m);
+	if (put_user(value ? '1' : '0', buf))
+		return -EFAULT;
+	
+	return 1;
+}
+
+static int scx200_gpio_open(struct inode *inode, struct file *file)
+{
+	unsigned m = minor(inode->i_rdev);
+	if (m > 63)
+		return -EINVAL;
+	return 0;
+}
+
+static int scx200_gpio_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+
+static struct file_operations scx200_gpio_fops = {
+	.owner   = THIS_MODULE,
+	.write   = scx200_gpio_write,
+	.read    = scx200_gpio_read,
+	.open    = scx200_gpio_open,
+	.release = scx200_gpio_release,
+};
+
+static int __init scx200_gpio_init(void)
+{
+	int r;
+
+	printk(KERN_DEBUG NAME ": NatSemi SCx200 GPIO Driver\n");
+
+	if (!scx200_gpio_present()) {
+		printk(KERN_ERR NAME ": no SCx200 gpio pins available\n");
+		return -ENODEV;
+	}
+
+	r = register_chrdev(major, NAME, &scx200_gpio_fops);
+	if (r < 0) {
+		printk(KERN_ERR NAME ": unable to register character device\n");
+		return r;
+	}
+	if (!major) {
+		major = r;
+		printk(KERN_DEBUG NAME ": got dynamic major %d\n", major);
+	}
+
+	return 0;
+}
+
+static void __exit scx200_gpio_cleanup(void)
+{
+	unregister_chrdev(major, NAME);
+}
+
+module_init(scx200_gpio_init);
+module_exit(scx200_gpio_cleanup);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../.. SUBDIRS=drivers/char modules"
+        c-basic-offset: 8
+    End:
+*/
diff -Nru a/drivers/char/scx200_wdt.c b/drivers/char/scx200_wdt.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/scx200_wdt.c	Tue Oct  8 22:22:45 2002
@@ -0,0 +1,277 @@
+/* linux/drivers/char/scx200_wdt.c 
+
+   National Semiconductor SCx200 Watchdog support
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   Som code taken from:
+   National Semiconductor PC87307/PC97307 (ala SC1200) WDT driver
+   (c) Copyright 2002 Zwane Mwaikambo <zwane@commfireservices.com>
+
+   This program is free software; you can redistribute it and/or
+   modify it under the terms of the GNU General Public License as
+   published by the Free Software Foundation; either version 2 of the
+   License, or (at your option) any later version.
+
+   The author(s) of this software shall not be held liable for damages
+   of any nature resulting due to the use of this software. This
+   software is provided AS-IS with no warranties. */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#include <linux/scx200.h>
+
+#define NAME "scx200_wdt"
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("NatSemi SCx200 Watchdog Driver");
+MODULE_LICENSE("GPL");
+
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+#define CONFIG_WATCHDOG_NOWAYOUT 0
+#endif
+
+static int margin = 60;		/* in seconds */
+MODULE_PARM(margin, "i");
+MODULE_PARM_DESC(margin, "Watchdog margin in seconds");
+
+static int nowayout = CONFIG_WATCHDOG_NOWAYOUT;
+MODULE_PARM(nowayout, "i");
+MODULE_PARM_DESC(nowayout, "Disable watchdog shutdown on close");
+
+static u16 wdto_restart;
+static struct semaphore open_semaphore;
+static unsigned expect_close;
+
+/* Bits of the WDCNFG register */
+#define W_ENABLE 0x00fa		/* Enable watchdog */
+#define W_DISABLE 0x0000	/* Disable watchdog */
+
+/* The scaling factor for the timer, this depends on the value of W_ENABLE */
+#define W_SCALE (32768/1024)
+
+static void scx200_wdt_ping(void)
+{
+	outw(wdto_restart, SCx200_CB_BASE + SCx200_WDT_WDTO);
+}
+
+static void scx200_wdt_update_margin(void)
+{
+	printk(KERN_INFO NAME ": timer margin %d seconds\n", margin);
+	wdto_restart = margin * W_SCALE;
+}
+
+static void scx200_wdt_enable(void)
+{
+	printk(KERN_DEBUG NAME ": enabling watchdog timer, wdto_restart = %d\n", 
+	       wdto_restart);
+
+	outw(0, SCx200_CB_BASE + SCx200_WDT_WDTO);
+	outb(SCx200_WDT_WDSTS_WDOVF, SCx200_CB_BASE + SCx200_WDT_WDSTS);
+	outw(W_ENABLE, SCx200_CB_BASE + SCx200_WDT_WDCNFG);
+
+	scx200_wdt_ping();
+}
+
+static void scx200_wdt_disable(void)
+{
+	printk(KERN_DEBUG NAME ": disabling watchdog timer\n");
+		
+	outw(0, SCx200_CB_BASE + SCx200_WDT_WDTO);
+	outb(SCx200_WDT_WDSTS_WDOVF, SCx200_CB_BASE + SCx200_WDT_WDSTS);
+	outw(W_DISABLE, SCx200_CB_BASE + SCx200_WDT_WDCNFG);
+}
+
+static int scx200_wdt_open(struct inode *inode, struct file *file)
+{
+        /* only allow one at a time */
+        if (down_trylock(&open_semaphore))
+                return -EBUSY;
+	scx200_wdt_enable();
+	expect_close = 0;
+
+	return 0;
+}
+
+static int scx200_wdt_release(struct inode *inode, struct file *file)
+{
+	if (!expect_close) {
+		printk(KERN_WARNING NAME ": watchdog device closed unexpectedly, will not disable the watchdog timer\n");
+	} else if (!nowayout) {
+		scx200_wdt_disable();
+	}
+        up(&open_semaphore);
+
+	return 0;
+}
+
+static int scx200_wdt_notify_sys(struct notifier_block *this, 
+				      unsigned long code, void *unused)
+{
+        if (code == SYS_HALT || code == SYS_POWER_OFF)
+		if (!nowayout)
+			scx200_wdt_disable();
+
+        return NOTIFY_DONE;
+}
+
+static struct notifier_block scx200_wdt_notifier =
+{
+        notifier_call: scx200_wdt_notify_sys
+};
+
+static ssize_t scx200_wdt_write(struct file *file, const char *data, 
+				     size_t len, loff_t *ppos)
+{
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	/* check for a magic close character */
+	if (len) 
+	{
+		size_t i;
+
+		scx200_wdt_ping();
+
+		expect_close = 0;
+		for (i = 0; i < len; ++i) {
+			char c;
+			if (get_user(c, data+i))
+				return -EFAULT;
+			if (c == 'V')
+				expect_close = 1;
+		}
+
+		return len;
+	}
+
+	return 0;
+}
+
+static int scx200_wdt_ioctl(struct inode *inode, struct file *file,
+	unsigned int cmd, unsigned long arg)
+{
+	static struct watchdog_info ident = {
+		.identity = "NatSemi SCx200 Watchdog",
+		.firmware_version = 1, 
+		.options = (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING),
+	};
+	int new_margin;
+	
+	switch (cmd) {
+	default:
+		return -ENOTTY;
+	case WDIOC_GETSUPPORT:
+		if(copy_to_user((struct watchdog_info *)arg, &ident, 
+				sizeof(ident)))
+			return -EFAULT;
+		return 0;
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		if (put_user(0, (int *)arg))
+			return -EFAULT;
+		return 0;
+	case WDIOC_KEEPALIVE:
+		scx200_wdt_ping();
+		return 0;
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_margin, (int *)arg))
+			return -EFAULT;
+		if (new_margin < 1)
+			return -EINVAL;
+		margin = new_margin;
+		scx200_wdt_update_margin();
+		scx200_wdt_ping();
+	case WDIOC_GETTIMEOUT:
+		if (put_user(margin, (int *)arg))
+			return -EFAULT;
+		return 0;
+	}
+}
+
+static struct file_operations scx200_wdt_fops = {
+	.owner	 = THIS_MODULE,
+	.write   = scx200_wdt_write,
+	.ioctl   = scx200_wdt_ioctl,
+	.open    = scx200_wdt_open,
+	.release = scx200_wdt_release,
+};
+
+static struct miscdevice scx200_wdt_miscdev = {
+	.minor = WATCHDOG_MINOR,
+	.name  = NAME,
+	.fops  = &scx200_wdt_fops,
+};
+
+static int __init scx200_wdt_init(void)
+{
+	int r;
+
+	printk(KERN_DEBUG NAME ": NatSemi SCx200 Watchdog Driver\n");
+
+	/* First check that this really is a NatSemi SCx200 CPU */
+	if ((pci_find_device(PCI_VENDOR_ID_NS, 
+			     PCI_DEVICE_ID_NS_SCx200_BRIDGE,
+			     NULL)) == NULL)
+		return -ENODEV;
+
+	/* More sanity checks, verify that the configuration block is there */
+	if (!scx200_cb_probe(SCx200_CB_BASE)) {
+		printk(KERN_WARNING NAME ": no configuration block found\n");
+		return -ENODEV;
+	}
+
+	if (!request_region(SCx200_CB_BASE + SCx200_WDT_OFFSET, 
+			    SCx200_WDT_SIZE, 
+			    "NatSemi SCx200 Watchdog")) {
+		printk(KERN_WARNING NAME ": watchdog I/O region busy\n");
+		return -EBUSY;
+	}
+
+	scx200_wdt_update_margin();
+	scx200_wdt_disable();
+
+	sema_init(&open_semaphore, 1);
+
+	r = misc_register(&scx200_wdt_miscdev);
+	if (r)
+		return r;
+
+	r = register_reboot_notifier(&scx200_wdt_notifier);
+        if (r) {
+                printk(KERN_ERR NAME ": unable to register reboot notifier");
+		misc_deregister(&scx200_wdt_miscdev);
+                return r;
+        }
+
+	return 0;
+}
+
+static void __exit scx200_wdt_cleanup(void)
+{
+        unregister_reboot_notifier(&scx200_wdt_notifier);
+	misc_deregister(&scx200_wdt_miscdev);
+	release_region(SCx200_CB_BASE + SCx200_WDT_OFFSET,
+		       SCx200_WDT_SIZE);
+}
+
+module_init(scx200_wdt_init);
+module_exit(scx200_wdt_cleanup);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../.. SUBDIRS=drivers/char modules"
+        c-basic-offset: 8
+    End:
+*/
diff -Nru a/drivers/i2c/Config.in b/drivers/i2c/Config.in
--- a/drivers/i2c/Config.in	Tue Oct  8 22:22:45 2002
+++ b/drivers/i2c/Config.in	Tue Oct  8 22:22:45 2002
@@ -13,6 +13,12 @@
       dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_PHILIPSPAR $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
       dep_tristate '  ELV adapter' CONFIG_I2C_ELV $CONFIG_I2C_ALGOBIT
       dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_VELLEMAN $CONFIG_I2C_ALGOBIT
+      dep_tristate '  NatSemi SCx200 I2C using GPIO pins' CONFIG_SCx200_I2C $CONFIG_SCx200 $CONFIG_I2C_ALGOBIT
+      if [ "$CONFIG_SCx200_I2C" != "n" ]; then
+         int  '    GPIO pin used for SCL' CONFIG_SCx200_I2C_SCL 12
+         int  '    GPIO pin used for SDA' CONFIG_SCx200_I2C_SDA 13
+      fi
+      dep_tristate '  NatSemi SCx200 ACCESS.bus' CONFIG_SCx200_ACB $CONFIG_I2C
    fi
 
    dep_tristate 'I2C PCF 8584 interfaces' CONFIG_I2C_ALGOPCF $CONFIG_I2C
diff -Nru a/drivers/i2c/Makefile b/drivers/i2c/Makefile
--- a/drivers/i2c/Makefile	Tue Oct  8 22:22:45 2002
+++ b/drivers/i2c/Makefile	Tue Oct  8 22:22:45 2002
@@ -18,6 +18,8 @@
 obj-$(CONFIG_ITE_I2C_ALGO)	+= i2c-algo-ite.o
 obj-$(CONFIG_ITE_I2C_ADAP)	+= i2c-adap-ite.o
 obj-$(CONFIG_I2C_PROC)		+= i2c-proc.o
+obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
+obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
 
 # This is needed for automatic patch generation: sensors code starts here
diff -Nru a/drivers/i2c/scx200_acb.c b/drivers/i2c/scx200_acb.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/scx200_acb.c	Tue Oct  8 22:22:45 2002
@@ -0,0 +1,579 @@
+/*  linux/drivers/i2c/scx200_acb.c 
+
+    Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+    National Semiconductor SCx200 ACCESS.bus support
+    
+    Based on i2c-keywest.c which is:
+        Copyright (c) 2001 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+        Copyright (c) 2000 Philip Edelbrock <phil@stimpy.netroedge.com>
+    
+    This program is free software; you can redistribute it and/or
+    modify it under the terms of the GNU General Public License as
+    published by the Free Software Foundation; either version 2 of the
+    License, or (at your option) any later version.
+   
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+    General Public License for more details.
+   
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+*/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/smp_lock.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+
+#include <linux/scx200.h>
+
+#define NAME "scx200_acb"
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("NatSemi SCx200 ACCESS.bus Driver");
+MODULE_LICENSE("GPL");
+
+#define MAX_DEVICES 4
+static int base[MAX_DEVICES] = { 0x840 };
+MODULE_PARM(base, "1-4i");
+MODULE_PARM_DESC(base, "Base addresses for the ACCESS.bus controllers");
+
+#define DEBUG 0
+
+#if DEBUG
+#define DBG(x...) printk(KERN_DEBUG NAME ": " x)
+#else
+#define DBG(x...)
+#endif
+
+/* The hardware supports interrupt driven mode too, but I haven't
+   implemented that. */
+#define POLLED_MODE 1
+#define POLL_TIMEOUT (HZ)
+
+enum scx200_acb_state {
+	state_idle,
+	state_address,
+	state_command,
+	state_repeat_start,
+	state_quick,
+	state_read,
+	state_write,
+};
+
+static const char *scx200_acb_state_name[] = {
+	"idle",
+	"address",
+	"command",
+	"repeat_start",
+	"quick",
+	"read",
+	"write",
+};
+
+/* Physical interface */
+struct scx200_acb_iface
+{
+	struct scx200_acb_iface *next;
+	struct i2c_adapter adapter;
+	unsigned base;
+	struct semaphore sem;
+
+	/* State machine data */
+	enum scx200_acb_state state;
+	int result;
+	u8 address_byte;
+	u8 command;
+	u8 *ptr;
+	char needs_reset;
+	unsigned len;
+};
+
+/* Register Definitions */
+#define ACBSDA		(iface->base + 0)
+#define ACBST		(iface->base + 1)
+#define    ACBST_SDAST		0x40 /* SDA Status */
+#define    ACBST_BER		0x20 
+#define    ACBST_NEGACK		0x10 /* Negative Acknowledge */
+#define    ACBST_STASTR		0x08 /* Stall After Start */
+#define    ACBST_MASTER		0x02
+#define ACBCST		(iface->base + 2)
+#define    ACBCST_BB		0x02
+#define ACBCTL1		(iface->base + 3)
+#define    ACBCTL1_STASTRE	0x80
+#define    ACBCTL1_NMINTE	0x40
+#define	   ACBCTL1_ACK		0x10
+#define	   ACBCTL1_STOP		0x02
+#define	   ACBCTL1_START	0x01
+#define ACBADDR		(iface->base + 4)
+#define ACBCTL2		(iface->base + 5)
+#define    ACBCTL2_ENABLE	0x01
+
+/************************************************************************/
+
+static void scx200_acb_machine(struct scx200_acb_iface *iface, u8 status)
+{
+	const char *errmsg;
+
+	DBG("state %s, status = 0x%02x\n", 
+	    scx200_acb_state_name[iface->state], status);
+
+	if (status & ACBST_BER) {
+		errmsg = "bus error";
+		goto error;
+	}
+	if (!(status & ACBST_MASTER)) {
+		errmsg = "not master";
+		goto error;
+	}
+	if (status & ACBST_NEGACK)
+		goto negack;
+
+	switch (iface->state) {
+	case state_idle:
+		printk(KERN_WARNING NAME ": %s, interrupt in idle state\n", 
+		       iface->adapter.name);
+		break;
+
+	case state_address:
+		/* Do a pointer write first */
+		outb(iface->address_byte & ~1, ACBSDA);
+
+		iface->state = state_command;
+		break;
+
+	case state_command:
+		outb(iface->command, ACBSDA);
+
+		if (iface->address_byte & 1)
+			iface->state = state_repeat_start;
+		else
+			iface->state = state_write;
+		break;
+
+	case state_repeat_start:
+		outb(inb(ACBCTL1) | ACBCTL1_START, ACBCTL1);
+		/* fallthrough */
+		
+	case state_quick:
+		if (iface->address_byte & 1) {
+			if (iface->len == 1) 
+				outb(inb(ACBCTL1) | ACBCTL1_ACK, ACBCTL1);
+			else
+				outb(inb(ACBCTL1) & ~ACBCTL1_ACK, ACBCTL1);
+			outb(iface->address_byte, ACBSDA);
+
+			iface->state = state_read;
+		} else {
+			outb(iface->address_byte, ACBSDA);
+
+			iface->state = state_write;
+		}
+		break;
+
+	case state_read:
+		/* Set ACK if receiving the last byte */
+		if (iface->len == 1)
+			outb(inb(ACBCTL1) | ACBCTL1_ACK, ACBCTL1);
+		else
+			outb(inb(ACBCTL1) & ~ACBCTL1_ACK, ACBCTL1);
+
+		*iface->ptr++ = inb(ACBSDA);
+		--iface->len;
+
+		if (iface->len == 0) {
+			iface->result = 0;
+			iface->state = state_idle;
+			outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
+		}
+
+		break;
+
+	case state_write:
+		if (iface->len == 0) {
+			iface->result = 0;
+			iface->state = state_idle;
+			outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
+			break;
+		}
+		
+		outb(*iface->ptr++, ACBSDA);
+		--iface->len;
+		
+		break;
+	}
+
+	return;
+
+ negack:
+	DBG("negative acknowledge in state %s\n", 
+	    scx200_acb_state_name[iface->state]);
+
+	iface->state = state_idle;
+	iface->result = -ENXIO;
+
+	outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
+	outb(ACBST_STASTR | ACBST_NEGACK, ACBST);
+	return;
+
+ error:
+	printk(KERN_ERR NAME ": %s, %s in state %s\n", iface->adapter.name, 
+	       errmsg, scx200_acb_state_name[iface->state]);
+
+	iface->state = state_idle;
+	iface->result = -EIO;
+	iface->needs_reset = 1;
+}
+
+static void scx200_acb_timeout(struct scx200_acb_iface *iface) 
+{
+	printk(KERN_ERR NAME ": %s, timeout in state %s\n", 
+	       iface->adapter.name, scx200_acb_state_name[iface->state]);
+
+	iface->state = state_idle;
+	iface->result = -EIO;
+	iface->needs_reset = 1;
+}
+
+#ifdef POLLED_MODE
+static void scx200_acb_poll(struct scx200_acb_iface *iface)
+{
+	u8 status = 0;
+	unsigned long timeout;
+
+	timeout = jiffies + POLL_TIMEOUT;
+	while (time_before(jiffies, timeout)) {
+		status = inb(ACBST);
+		if ((status & (ACBST_SDAST|ACBST_BER|ACBST_NEGACK)) != 0) {
+			scx200_acb_machine(iface, status);
+			return;
+		}
+		current->policy |= SCHED_YIELD;
+		schedule();
+	}
+
+	scx200_acb_timeout(iface);
+}
+#endif /* POLLED_MODE */
+
+static void scx200_acb_reset(struct scx200_acb_iface *iface)
+{
+	/* Disable the ACCESS.bus device and Configure the SCL
+           frequency: 16 clock cycles */
+	outb(0x70, ACBCTL2);
+	/* Polling mode */
+	outb(0, ACBCTL1);
+	/* Disable slave address */
+	outb(0, ACBADDR);
+	/* Enable the ACCESS.bus device */
+	outb(inb(ACBCTL2) | ACBCTL2_ENABLE, ACBCTL2);
+	/* Free STALL after START */
+	outb(inb(ACBCTL1) & ~(ACBCTL1_STASTRE | ACBCTL1_NMINTE), ACBCTL1);
+	/* Send a STOP */
+	outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
+	/* Clear BER, NEGACK and STASTR bits */
+	outb(ACBST_BER | ACBST_NEGACK | ACBST_STASTR, ACBST);
+	/* Clear BB bit */
+	outb(inb(ACBCST) | ACBCST_BB, ACBCST);
+}
+
+static s32 scx200_acb_smbus_xfer(struct i2c_adapter *adapter,
+				u16 address, unsigned short flags,	
+				char rw, u8 command, int size, 
+				union i2c_smbus_data *data)
+{
+	struct scx200_acb_iface *iface = adapter->data;
+	int len;
+	u8 *buffer;
+	u16 cur_word;
+	int rc;
+
+	switch (size) {
+	case I2C_SMBUS_QUICK:
+	    	len = 0;
+	    	buffer = NULL;
+	    	break;
+	case I2C_SMBUS_BYTE:
+		if (rw == I2C_SMBUS_READ) {
+			len = 1;
+			buffer = &data->byte;
+		} else {
+			len = 1;
+			buffer = &command;
+		}
+	    	break;
+	case I2C_SMBUS_BYTE_DATA:
+	    	len = 1;
+	    	buffer = &data->byte;
+	    	break;
+	case I2C_SMBUS_WORD_DATA:
+		len = 2;
+	    	cur_word = cpu_to_le16(data->word);
+	    	buffer = (u8 *)&cur_word;
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+	    	len = data->block[0];
+	    	buffer = &data->block[1];
+		break;
+	default:
+	    	return -EINVAL;
+	}
+
+	DBG("size=%d, address=0x%x, command=0x%x, len=%d, read=%d\n",
+	    size, address, command, len, rw == I2C_SMBUS_READ);
+
+	if (!len && rw == I2C_SMBUS_READ) {
+		printk(KERN_WARNING NAME ": %s, zero length read\n", 
+		       adapter->name);
+		return -EINVAL;
+	}
+
+	if (len && !buffer) {
+		printk(KERN_WARNING NAME ": %s, nonzero length but no buffer\n", adapter->name);
+		return -EFAULT;
+	}
+
+	down(&iface->sem);
+
+	iface->address_byte = address<<1;
+	if (rw == I2C_SMBUS_READ)
+		iface->address_byte |= 1;
+	iface->command = command;
+	iface->ptr = buffer;
+	iface->len = len;
+	iface->result = -EINVAL;
+	iface->needs_reset = 0;
+
+	outb(inb(ACBCTL1) | ACBCTL1_START, ACBCTL1);
+
+	if (size == I2C_SMBUS_QUICK || size == I2C_SMBUS_BYTE)
+		iface->state = state_quick;
+	else
+		iface->state = state_address;
+
+#ifdef POLLED_MODE
+	while (iface->state != state_idle)
+		scx200_acb_poll(iface);
+#else /* POLLED_MODE */
+#error Interrupt driven mode not implemented
+#endif /* POLLED_MODE */	
+
+	if (iface->needs_reset)
+		scx200_acb_reset(iface);
+
+	rc = iface->result;
+
+	up(&iface->sem);
+
+	if (rc == 0 && size == I2C_SMBUS_WORD_DATA && rw == I2C_SMBUS_READ)
+	    	data->word = le16_to_cpu(cur_word);
+
+#if DEBUG
+	printk(KERN_DEBUG NAME ": transfer done, result: %d", rc);
+	if (buffer) {
+		int i;
+		printk(" data:");
+		for (i = 0; i < len; ++i)
+			printk(" %02x", buffer[i]);
+	}
+	printk("\n");
+#endif
+
+	return rc;
+}
+
+static u32 scx200_acb_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	       I2C_FUNC_SMBUS_BLOCK_DATA;
+}
+
+static int scx200_acb_reg(struct i2c_client *client)
+{
+	return 0;
+}
+
+static int scx200_acb_unreg(struct i2c_client *client)
+{
+	return 0;
+}
+
+static void scx200_acb_inc_use(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+static void scx200_acb_dec_use(struct i2c_adapter *adapter)
+{
+	MOD_DEC_USE_COUNT;
+}
+
+/* For now, we only handle combined mode (smbus) */
+static struct i2c_algorithm scx200_acb_algorithm = {
+	name:		"NatSemi SCx200 ACCESS.bus",
+	id:		I2C_ALGO_SMBUS,
+	smbus_xfer:	scx200_acb_smbus_xfer,
+	functionality:	scx200_acb_func,
+};
+
+struct scx200_acb_iface *scx200_acb_list;
+
+int scx200_acb_probe(struct scx200_acb_iface *iface)
+{
+	u8 val;
+
+	/* Disable the ACCESS.bus device and Configure the SCL
+           frequency: 16 clock cycles */
+	outb(0x70, ACBCTL2);
+
+	if (inb(ACBCTL2) != 0x70) {
+		DBG("ACBCTL2 readback failed\n");
+		return -ENXIO;
+	}
+
+	outb(inb(ACBCTL1) | ACBCTL1_NMINTE, ACBCTL1);
+
+	val = inb(ACBCTL1);
+	if (val) {
+		DBG("disabled, but ACBCTL1=0x%02x\n", val);
+		return -ENXIO;
+	}
+
+	outb(inb(ACBCTL2) | ACBCTL2_ENABLE, ACBCTL2);
+
+	outb(inb(ACBCTL1) | ACBCTL1_NMINTE, ACBCTL1);
+
+	val = inb(ACBCTL1);
+	if ((val & ACBCTL1_NMINTE) != ACBCTL1_NMINTE) {
+		DBG("enabled, but NMINTE won't be set, ACBCTL1=0x%02x\n", val);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int  __init scx200_acb_create(int base, int index)
+{
+	struct scx200_acb_iface *iface;
+	struct i2c_adapter *adapter;
+	int rc = 0;
+	char description[64];
+
+	iface = kmalloc(sizeof(*iface), GFP_KERNEL);
+	if (!iface) {
+		printk(KERN_ERR NAME ": can't allocate memory\n");
+		rc = -ENOMEM;
+		goto errout;
+	}
+
+	memset(iface, 0, sizeof(*iface));
+	adapter = &iface->adapter;
+	adapter->data = iface;
+	sprintf(adapter->name, "SCx200 ACB%d", index);
+	adapter->id = I2C_ALGO_SMBUS;
+	adapter->algo = &scx200_acb_algorithm;
+	adapter->inc_use = scx200_acb_inc_use;
+	adapter->dec_use = scx200_acb_dec_use;
+	adapter->client_register = scx200_acb_reg;
+	adapter->client_unregister = scx200_acb_unreg;
+
+	init_MUTEX(&iface->sem);
+
+	sprintf(description, "NatSemi SCx200 ACCESS.bus [%s]", adapter->name);
+	if (request_region(base, 8, description) == 0) {
+		printk(KERN_ERR NAME ": %s, can't allocate io 0x%x-0x%x\n", 
+		       adapter->name, base, base + 8-1);
+		rc = -EBUSY;
+		goto errout;
+	}
+	iface->base = base;
+
+	rc = scx200_acb_probe(iface);
+	if (rc) {
+		printk(KERN_WARNING NAME ": %s, probe failed\n", adapter->name);
+		goto errout;
+	}
+
+	scx200_acb_reset(iface);
+
+	if (i2c_add_adapter(adapter) < 0) {
+		printk(KERN_ERR NAME ": %s, failed to register\n", adapter->name);
+		rc = -ENODEV;
+		goto errout;
+	}
+
+	lock_kernel();
+	iface->next = scx200_acb_list;
+	scx200_acb_list = iface;
+	unlock_kernel();
+
+	return 0;
+
+ errout:
+	if (iface) {
+		if (iface->base)
+			release_region(iface->base, 8);
+		kfree(iface);
+	}
+	return rc;
+}
+
+static int __init scx200_acb_init(void)
+{
+	int i;
+	int rc;
+
+	printk(KERN_DEBUG NAME ": NatSemi SCx200 ACCESS.bus Driver\n");
+
+	/* Verify that this really is a SCx200 processor */
+	if (pci_find_device(PCI_VENDOR_ID_NS,
+			    PCI_DEVICE_ID_NS_SCx200_BRIDGE,
+			    NULL) == NULL)
+		return -ENODEV;
+
+	rc = -ENXIO;
+	for (i = 0; i < MAX_DEVICES; ++i) {
+		if (base[i] > 0)
+			rc = scx200_acb_create(base[i], i);
+	}
+	if (scx200_acb_list)
+		return 0;
+	return rc;
+}
+
+static void __exit scx200_acb_cleanup(void)
+{
+	struct scx200_acb_iface *iface;
+	lock_kernel();
+	while ((iface = scx200_acb_list) != NULL) {
+		scx200_acb_list = iface->next;
+		unlock_kernel();
+
+		i2c_del_adapter(&iface->adapter);
+		release_region(iface->base, 8);
+		kfree(iface);
+		lock_kernel();
+	}
+	unlock_kernel();
+}
+
+module_init(scx200_acb_init);
+module_exit(scx200_acb_cleanup);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../.. SUBDIRS=drivers/i2c modules"
+        c-basic-offset: 8
+    End:
+*/
+
diff -Nru a/drivers/i2c/scx200_i2c.c b/drivers/i2c/scx200_i2c.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/scx200_i2c.c	Tue Oct  8 22:22:45 2002
@@ -0,0 +1,156 @@
+/* linux/drivers/i2c/scx200_i2c.c 
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   National Semiconductor SCx200 I2C bus on GPIO pins
+
+   Based on i2c-velleman.c Copyright (C) 1995-96, 2000 Simon G. Vogl
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+   
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+   
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     
+*/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <asm/io.h>
+
+#include <linux/scx200_gpio.h>
+
+#define NAME "scx200_i2c"
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("NatSemi SCx200 I2C Driver");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(scl, "i");
+MODULE_PARM_DESC(scl, "GPIO line for SCL");
+MODULE_PARM(sda, "i");
+MODULE_PARM_DESC(sda, "GPIO line for SDA");
+
+static int scl = CONFIG_SCx200_I2C_SCL;
+static int sda = CONFIG_SCx200_I2C_SDA;
+
+static void scx200_i2c_setscl(void *data, int state)
+{
+	scx200_gpio_set(scl, state);
+}
+
+static void scx200_i2c_setsda(void *data, int state)
+{
+	scx200_gpio_set(sda, state);
+} 
+
+static int scx200_i2c_getscl(void *data)
+{
+	return scx200_gpio_get(scl);
+}
+
+static int scx200_i2c_getsda(void *data)
+{
+	return scx200_gpio_get(sda);
+}
+
+static int scx200_i2c_reg(struct i2c_client *client)
+{
+	return 0;
+}
+
+static int scx200_i2c_unreg(struct i2c_client *client)
+{
+	return 0;
+}
+
+static void scx200_i2c_inc_use(struct i2c_adapter *adap)
+{
+	MOD_INC_USE_COUNT;
+}
+
+static void scx200_i2c_dec_use(struct i2c_adapter *adap)
+{
+	MOD_DEC_USE_COUNT;
+}
+
+/* ------------------------------------------------------------------------
+ * Encapsulate the above functions in the correct operations structure.
+ * This is only done when more than one hardware adapter is supported.
+ */
+
+static struct i2c_algo_bit_data scx200_i2c_data = {
+	NULL,
+	scx200_i2c_setsda,
+	scx200_i2c_setscl,
+	scx200_i2c_getsda,
+	scx200_i2c_getscl,
+	10, 10, 100,		/* waits, timeout */
+};
+
+static struct i2c_adapter scx200_i2c_ops = {
+	.name              = "NatSemi SCx200 I2C",
+	.id		   = I2C_HW_B_VELLE,
+	.algo_data	   = &scx200_i2c_data,
+	.inc_use	   = scx200_i2c_inc_use,
+	.dec_use	   = scx200_i2c_dec_use,
+	.client_register   = scx200_i2c_reg,
+	.client_unregister = scx200_i2c_unreg,
+};
+
+int scx200_i2c_init(void)
+{
+	printk(KERN_DEBUG NAME ": NatSemi SCx200 I2C Driver\n");
+
+	if (!scx200_gpio_present()) {
+		printk(KERN_ERR NAME ": no SCx200 gpio pins available\n");
+		return -ENODEV;
+	}
+
+	printk(KERN_DEBUG NAME ": SCL=GPIO%02u, SDA=GPIO%02u\n", 
+	       scl, sda);
+
+	if (scl == -1 || sda == -1 || scl == sda) {
+		printk(KERN_ERR NAME ": scl and sda must be specified\n");
+		return -EINVAL;
+	}
+
+	/* Configure GPIOs as open collector outputs */
+	scx200_gpio_configure(scl, ~2, 5);
+	scx200_gpio_configure(sda, ~2, 5);
+
+	if (i2c_bit_add_bus(&scx200_i2c_ops) < 0) {
+		printk(KERN_ERR NAME ": adapter %s registration failed\n", 
+		       scx200_i2c_ops.name);
+		return -ENODEV;
+	}
+	
+	return 0;
+}
+
+void scx200_i2c_cleanup(void)
+{
+	i2c_bit_del_bus(&scx200_i2c_ops);
+}
+
+module_init(scx200_i2c_init);
+module_exit(scx200_i2c_cleanup);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../.. SUBDIRS=drivers/i2c modules"
+        c-basic-offset: 8
+    End:
+*/
diff -Nru a/drivers/mtd/maps/Config.in b/drivers/mtd/maps/Config.in
--- a/drivers/mtd/maps/Config.in	Tue Oct  8 22:22:45 2002
+++ b/drivers/mtd/maps/Config.in	Tue Oct  8 22:22:45 2002
@@ -30,6 +30,7 @@
    dep_tristate '  JEDEC Flash device mapped on Mixcom piggyback card' CONFIG_MTD_MIXMEM $CONFIG_MTD_JEDEC
    dep_tristate '  JEDEC Flash device mapped on Octagon 5066 SBC' CONFIG_MTD_OCTAGON $CONFIG_MTD_JEDEC
    dep_tristate '  JEDEC Flash device mapped on Tempustech VMAX SBC301' CONFIG_MTD_VMAX $CONFIG_MTD_JEDEC
+   dep_tristate '  Flash device mapped with DOCCS on NatSemi SCx200' CONFIG_MTD_SCx200_DOCFLASH $CONFIG_MTD_CFI
    dep_tristate '  BIOS flash chip on Intel L440GX boards' CONFIG_MTD_L440GX $CONFIG_MTD_JEDECPROBE
    dep_tristate ' ROM connected to AMD766 southbridge' CONFIG_MTD_AMD766ROM $CONFIG_MTD_GEN_PROBE   
    dep_tristate ' ROM connected to Intel Hub Controller 2' CONFIG_MTD_ICH2ROM $CONFIG_MTD_JEDECPROBE
diff -Nru a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
--- a/drivers/mtd/maps/Makefile	Tue Oct  8 22:22:45 2002
+++ b/drivers/mtd/maps/Makefile	Tue Oct  8 22:22:45 2002
@@ -32,6 +32,7 @@
 obj-$(CONFIG_MTD_NETSC520)	+= netsc520.o
 obj-$(CONFIG_MTD_SUN_UFLASH)    += sun_uflash.o
 obj-$(CONFIG_MTD_VMAX)		+= vmax301.o
+obj-$(CONFIG_MTD_SCx200_DOCFLASH)+= scx200_docflash.o
 obj-$(CONFIG_MTD_DBOX2)		+= dbox2-flash.o
 obj-$(CONFIG_MTD_OCELOT)	+= ocelot.o
 obj-$(CONFIG_MTD_SOLUTIONENGINE)+= solutionengine.o
diff -Nru a/drivers/mtd/maps/scx200_docflash.c b/drivers/mtd/maps/scx200_docflash.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/mtd/maps/scx200_docflash.c	Tue Oct  8 22:22:45 2002
@@ -0,0 +1,268 @@
+/* linux/drivers/mtd/maps/scx200_docflash.c 
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   National Semiconductor SCx200 flash mapped with DOCCS
+*/
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <asm/io.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+
+#include <linux/pci.h>
+#include <linux/scx200.h>
+
+#define NAME "scx200_docflash"
+
+MODULE_AUTHOR("Christer Weinigel <wingel@hack.org>");
+MODULE_DESCRIPTION("NatSemi SCx200 DOCCS Flash Driver");
+MODULE_LICENSE("GPL");
+
+/* Set this to one if you want to partition the flash */
+#define PARTITION 1
+
+MODULE_PARM(probe, "i");
+MODULE_PARM_DESC(probe, "Probe for a BIOS mapping");
+MODULE_PARM(size, "i");
+MODULE_PARM_DESC(size, "Size of the flash mapping");
+MODULE_PARM(width, "i");
+MODULE_PARM_DESC(width, "Data width of the flash mapping (8/16)");
+MODULE_PARM(flashtype, "s");
+MODULE_PARM_DESC(flashtype, "Type of MTD probe to do");
+
+static int probe = 0;		/* Don't autoprobe */
+static unsigned size = 0x1000000; /* 16 MB the whole ISA address space */
+static unsigned width = 8;	/* Default to 8 bits wide */
+static char *flashtype = "cfi_probe";
+
+static struct resource docmem = {
+	.flags = IORESOURCE_MEM,
+	.name  = "NatSemi SCx200 DOCCS Flash",
+};
+
+static struct mtd_info *mymtd;
+
+#if PARTITION
+static struct mtd_partition partition_info[] = {
+	{ 
+		.name   = "DOCCS Boot kernel", 
+		.offset = 0, 
+		.size   = 0xc0000
+	},
+	{ 
+		.name   = "DOCCS Low BIOS", 
+		.offset = 0xc0000, 
+		.size   = 0x40000
+	},
+	{ 
+		.name   = "DOCCS File system", 
+		.offset = 0x100000, 
+		.size   = ~0	/* calculate from flash size */
+	},
+	{ 
+		.name   = "DOCCS High BIOS", 
+		.offset = ~0, 	/* calculate from flash size */
+		.size   = 0x80000
+	},
+};
+#define NUM_PARTITIONS (sizeof(partition_info)/sizeof(partition_info[0]))
+#endif
+
+static __u8 scx200_docflash_read8(struct map_info *map, unsigned long ofs)
+{
+	return __raw_readb(map->map_priv_1 + ofs);
+}
+
+static __u16 scx200_docflash_read16(struct map_info *map, unsigned long ofs)
+{
+	return __raw_readw(map->map_priv_1 + ofs);
+}
+
+static void scx200_docflash_copy_from(struct map_info *map, void *to, unsigned long from, ssize_t len)
+{
+	memcpy_fromio(to, map->map_priv_1 + from, len);
+}
+
+static void scx200_docflash_write8(struct map_info *map, __u8 d, unsigned long adr)
+{
+	__raw_writeb(d, map->map_priv_1 + adr);
+	mb();
+}
+
+static void scx200_docflash_write16(struct map_info *map, __u16 d, unsigned long adr)
+{
+	__raw_writew(d, map->map_priv_1 + adr);
+	mb();
+}
+
+static void scx200_docflash_copy_to(struct map_info *map, unsigned long to, const void *from, ssize_t len)
+{
+	memcpy_toio(map->map_priv_1 + to, from, len);
+}
+
+static struct map_info scx200_docflash_map = {
+	.name      = "NatSemi SCx200 DOCCS Flash",
+	.read8     = scx200_docflash_read8,
+	.read16    = scx200_docflash_read16,
+	.copy_from = scx200_docflash_copy_from,
+	.write8    = scx200_docflash_write8,
+	.write16   = scx200_docflash_write16,
+	.copy_to   = scx200_docflash_copy_to
+};
+
+int __init init_scx200_docflash(void)
+{
+	unsigned u;
+	unsigned base;
+	unsigned ctrl;
+	unsigned pmr;
+	struct pci_dev *bridge;
+
+	printk(KERN_DEBUG NAME ": NatSemi SCx200 DOCCS Flash Driver\n");
+
+	if ((bridge = pci_find_device(PCI_VENDOR_ID_NS, 
+				      PCI_DEVICE_ID_NS_SCx200_BRIDGE,
+				      NULL)) == NULL)
+		return -ENODEV;
+	
+	if (!scx200_cb_probe(SCx200_CB_BASE)) {
+		printk(KERN_WARNING NAME ": no configuration block found\n");
+		return -ENODEV;
+	}
+
+	if (probe) {
+		/* Try to use the present flash mapping if any */
+		pci_read_config_dword(bridge, SCx200_DOCCS_BASE, &base);
+		pci_read_config_dword(bridge, SCx200_DOCCS_CTRL, &ctrl);
+		pmr = inl(SCx200_CB_BASE + SCx200_PMR);
+
+		if (base == 0
+		    || (ctrl & 0x07000000) != 0x07000000
+		    || (ctrl & 0x0007ffff) == 0)
+			return -ENODEV;
+
+		size = ((ctrl&0x1fff)<<13) + (1<<13);
+
+		for (u = size; u > 1; u >>= 1)
+			;
+		if (u != 1)
+			return -ENODEV;
+
+		if (pmr & (1<<6))
+			width = 16;
+		else
+			width = 8;
+
+		docmem.start = base;
+		docmem.end = base + size;
+
+		if (request_resource(&iomem_resource, &docmem)) {
+			printk(KERN_ERR NAME ": unable to allocate memory for flash mapping\n");
+			return -ENOMEM;
+		}
+	} else {
+		for (u = size; u > 1; u >>= 1)
+			;
+		if (u != 1) {
+			printk(KERN_ERR NAME ": invalid size for flash mapping\n");
+			return -EINVAL;
+		}
+		
+		if (width != 8 && width != 16) {
+			printk(KERN_ERR NAME ": invalid bus width for flash mapping\n");
+			return -EINVAL;
+		}
+		
+		if (allocate_resource(&iomem_resource, &docmem, 
+				      size,
+				      0xc0000000, 0xffffffff, 
+				      size, NULL, NULL)) {
+			printk(KERN_ERR NAME ": unable to allocate memory for flash mapping\n");
+			return -ENOMEM;
+		}
+		
+		ctrl = 0x07000000 | ((size-1) >> 13);
+
+		printk(KERN_INFO "DOCCS BASE=0x%08lx, CTRL=0x%08lx\n", (long)docmem.start, (long)ctrl);
+		
+		pci_write_config_dword(bridge, SCx200_DOCCS_BASE, docmem.start);
+		pci_write_config_dword(bridge, SCx200_DOCCS_CTRL, ctrl);
+		pmr = inl(SCx200_CB_BASE + SCx200_PMR);
+		
+		if (width == 8) {
+			pmr &= ~(1<<6);
+		} else {
+			pmr |= (1<<6);
+		}
+		outl(pmr, SCx200_CB_BASE + SCx200_PMR);
+	}
+	
+       	printk(KERN_INFO NAME ": DOCCS mapped at 0x%lx-0x%lx, width %d\n", 
+	       docmem.start, docmem.end, width);
+
+	scx200_docflash_map.size = size;
+	if (width == 8)
+		scx200_docflash_map.buswidth = 1;
+	else
+		scx200_docflash_map.buswidth = 2;
+
+	scx200_docflash_map.map_priv_1 = (unsigned long)ioremap(docmem.start, scx200_docflash_map.size);
+	if (!scx200_docflash_map.map_priv_1) {
+		printk(KERN_ERR NAME ": failed to ioremap the flash\n");
+		release_resource(&docmem);
+		return -EIO;
+	}
+
+	mymtd = do_map_probe(flashtype, &scx200_docflash_map);
+	if (!mymtd) {
+		printk(KERN_ERR NAME ": unable to detect flash\n");
+		iounmap((void *)scx200_docflash_map.map_priv_1);
+		release_resource(&docmem);
+		return -ENXIO;
+	}
+
+	if (size < mymtd->size)
+		printk(KERN_WARNING NAME ": warning, flash mapping is smaller than flash size\n");
+
+	mymtd->module = THIS_MODULE;
+
+#if PARTITION
+	partition_info[3].offset = mymtd->size-partition_info[3].size;
+	partition_info[2].size = partition_info[3].offset-partition_info[2].offset;
+	add_mtd_partitions(mymtd, partition_info, NUM_PARTITIONS);
+#else
+	add_mtd_device(mymtd);
+#endif
+	return 0;
+}
+
+static void __exit cleanup_scx200_docflash(void)
+{
+	if (mymtd) {
+#if PARTITION
+		del_mtd_partitions(mymtd);
+#else
+		del_mtd_device(mymtd);
+#endif
+		map_destroy(mymtd);
+	}
+	if (scx200_docflash_map.map_priv_1) {
+		iounmap((void *)scx200_docflash_map.map_priv_1);
+		release_resource(&docmem);
+	}
+}
+
+module_init(init_scx200_docflash);
+module_exit(cleanup_scx200_docflash);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../../.. SUBDIRS=drivers/mtd/maps modules"
+        c-basic-offset: 8
+    End:
+*/
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Tue Oct  8 22:22:45 2002
+++ b/include/linux/pci_ids.h	Tue Oct  8 22:22:45 2002
@@ -288,6 +288,12 @@
 #define PCI_DEVICE_ID_NS_87560_USB	0x0012
 #define PCI_DEVICE_ID_NS_83815		0x0020
 #define PCI_DEVICE_ID_NS_83820		0x0022
+#define PCI_DEVICE_ID_NS_SCx200_BRIDGE	0x0500
+#define PCI_DEVICE_ID_NS_SCx200_SMI	0x0501
+#define PCI_DEVICE_ID_NS_SCx200_IDE	0x0502
+#define PCI_DEVICE_ID_NS_SCx200_AUDIO	0x0503
+#define PCI_DEVICE_ID_NS_SCx200_VIDEO	0x0504
+#define PCI_DEVICE_ID_NS_SCx200_XBUS	0x0505
 #define PCI_DEVICE_ID_NS_87410		0xd001
 
 #define PCI_VENDOR_ID_TSENG		0x100c
diff -Nru a/include/linux/scx200.h b/include/linux/scx200.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/scx200.h	Tue Oct  8 22:22:45 2002
@@ -0,0 +1,56 @@
+/* linux/include/linux/scx200.h
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   Defines for the National Semiconductor SCx200 Processors
+*/
+
+/* Interesting stuff for the National Semiconductor SCx200 CPU */
+
+/* F0 PCI Header/Bridge Configuration Registers */
+#define SCx200_DOCCS_BASE 0x78	/* DOCCS Base Address Register */
+#define SCx200_DOCCS_CTRL 0x7c	/* DOCCS Control Register */
+
+/* GPIO Register Block */
+#define SCx200_GPIO_SIZE 0x2c	/* Size of GPIO register block */
+
+/* General Configuration Block */
+#define SCx200_CB_BASE 0x9000	/* Base fixed at 0x9000 according to errata */
+
+/* Watchdog Timer */
+#define SCx200_WDT_OFFSET 0x00	/* offset within configuration block */
+#define SCx200_WDT_SIZE 0x05	/* size */
+
+#define SCx200_WDT_WDTO 0x00	/* Time-Out Register */
+#define SCx200_WDT_WDCNFG 0x02	/* Configuration Register */
+#define SCx200_WDT_WDSTS 0x04	/* Status Register */
+#define SCx200_WDT_WDSTS_WDOVF (1<<0) /* Overflow bit */
+
+/* High Resolution Timer */
+#define SCx200_TIMER_OFFSET 0x08
+#define SCx200_TIMER_SIZE 0x05
+
+/* Clock Generators */
+#define SCx200_CLOCKGEN_OFFSET 0x10
+#define SCx200_CLOCKGEN_SIZE 0x10
+
+/* Pin Multiplexing and Miscellaneous Configuration Registers */
+#define SCx200_MISC_OFFSET 0x30
+#define SCx200_MISC_SIZE 0x10
+
+#define SCx200_PMR 0x30		/* Pin Multiplexing Register */
+#define SCx200_MCR 0x34		/* Miscellaneous Configuration Register */
+#define SCx200_INTSEL 0x38	/* Interrupt Selection Register */
+#define SCx200_IID 0x3c		/* IA On a Chip Identification Number Reg */
+#define SCx200_REV 0x3d		/* Revision Register */
+#define SCx200_CBA 0x3e		/* Configuration Base Address Register */
+
+/* Verify that the configuration block really is there */
+#define scx200_cb_probe(base) (inw((base) + SCx200_CBA) == (base))
+
+/*
+    Local variables:
+        compile-command: "make -C ../.. bzImage modules"
+        c-basic-offset: 8
+    End:
+*/
diff -Nru a/include/linux/scx200_gpio.h b/include/linux/scx200_gpio.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/scx200_gpio.h	Tue Oct  8 22:22:45 2002
@@ -0,0 +1,98 @@
+#include <linux/spinlock.h>
+
+u32 scx200_gpio_configure(int index, u32 set, u32 clear);
+void scx200_gpio_dump(unsigned index);
+
+extern unsigned scx200_gpio_base;
+extern spinlock_t scx200_gpio_lock;
+extern long scx200_gpio_shadow[2];
+
+#define scx200_gpio_present() (scx200_gpio_base!=0)
+
+/* Definitions to make sure I do the same thing in all functions */
+#define __SCx200_GPIO_BANK unsigned bank = index>>5
+#define __SCx200_GPIO_IOADDR unsigned short ioaddr = scx200_gpio_base+0x10*bank
+#define __SCx200_GPIO_SHADOW long *shadow = scx200_gpio_shadow+bank
+#define __SCx200_GPIO_INDEX index &= 31
+
+#define __SCx200_GPIO_OUT __asm__ __volatile__("outsl":"=mS" (shadow):"d" (ioaddr), "0" (shadow))
+
+/* returns the value of the GPIO pin */
+
+static inline int scx200_gpio_get(int index) {
+	__SCx200_GPIO_BANK;
+	__SCx200_GPIO_IOADDR + 0x04;
+	__SCx200_GPIO_INDEX;
+		
+	return (inl(ioaddr) & (1<<index)) ? 1 : 0;
+}
+
+/* return the value driven on the GPIO signal (the value that will be
+   driven if the GPIO is configured as an output, it might not be the
+   state of the GPIO right now if the GPIO is configured as an input) */
+
+static inline int scx200_gpio_current(int index) {
+        __SCx200_GPIO_BANK;
+	__SCx200_GPIO_INDEX;
+		
+	return (scx200_gpio_shadow[bank] & (1<<index)) ? 1 : 0;
+}
+
+/* drive the GPIO signal high */
+
+static inline void scx200_gpio_set_high(int index) {
+	__SCx200_GPIO_BANK;
+	__SCx200_GPIO_IOADDR;
+	__SCx200_GPIO_SHADOW;
+	__SCx200_GPIO_INDEX;
+	set_bit(index, shadow);
+	__SCx200_GPIO_OUT;
+}
+
+/* drive the GPIO signal low */
+
+static inline void scx200_gpio_set_low(int index) {
+	__SCx200_GPIO_BANK;
+	__SCx200_GPIO_IOADDR;
+	__SCx200_GPIO_SHADOW;
+	__SCx200_GPIO_INDEX;
+	clear_bit(index, shadow);
+	__SCx200_GPIO_OUT;
+}
+
+/* drive the GPIO signal to state */
+
+static inline void scx200_gpio_set(int index, int state) {
+	__SCx200_GPIO_BANK;
+	__SCx200_GPIO_IOADDR;
+	__SCx200_GPIO_SHADOW;
+	__SCx200_GPIO_INDEX;
+	if (state)
+		set_bit(index, shadow);
+	else
+		clear_bit(index, shadow);
+	__SCx200_GPIO_OUT;
+}
+
+/* toggle the GPIO signal */
+static inline void scx200_gpio_change(int index) {
+	__SCx200_GPIO_BANK;
+	__SCx200_GPIO_IOADDR;
+	__SCx200_GPIO_SHADOW;
+	__SCx200_GPIO_INDEX;
+	change_bit(index, shadow);
+	__SCx200_GPIO_OUT;
+}
+
+#undef __SCx200_GPIO_BANK
+#undef __SCx200_GPIO_IOADDR
+#undef __SCx200_GPIO_SHADOW
+#undef __SCx200_GPIO_INDEX
+#undef __SCx200_GPIO_OUT
+
+/*
+    Local variables:
+        compile-command: "make -C ../.. bzImage modules"
+        c-basic-offset: 8
+    End:
+*/

--=-=-=


-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se

--=-=-=--
