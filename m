Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310446AbSCBQBt>; Sat, 2 Mar 2002 11:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310416AbSCBQBk>; Sat, 2 Mar 2002 11:01:40 -0500
Received: from acolyte.thorsen.se ([193.14.93.247]:42502 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S310397AbSCBQBS>;
	Sat, 2 Mar 2002 11:01:18 -0500
From: Christer Weinigel <wingel@acolyte.hack.org>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0202281244330.2117-100000@freak.distro.conectiva>
	(message from Marcelo Tosatti on Thu, 28 Feb 2002 12:45:44 -0300
	(BRT))
Subject: Re: [PATCH] NatSemi SCx200 Support
In-Reply-To: <Pine.LNX.4.21.0202281244330.2117-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="++----------20020302165603-041624518----------++"
Content-Transfer-Encoding: 7bit
X-Mailer: Emacs 20.5.1 with etach 1.1.6
Message-Id: <20020302160110.11DE1F5B@acolyte.hack.org>
Date: Sat,  2 Mar 2002 17:01:10 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--++----------20020302165603-041624518----------++
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> Your patch does not apply cleanly to my tree, probably due to some already
> applied patches.
> 
> Please regenerate your patch against -pre2 as soon as its released.

This is an updated patch for SCx200 support.  This patch is against
linux-2.4.19-pre2 and adds support for some SCx200 specific features
such as the GPIO pins, the watchdog and flash mapping via the DOCCS
pin.  Compared to the earlier patch, I've cleaned up a few more
things, and have also added a driver for the ACCESS.bus found in the
SCx200 CPUs.

BTW, what format do you preferr the patches in?  Should I place them
inline in the body of the mail or as an attachment as here?

   /Christer

-- 
"Just how much can I get away with and still go to heaven?"
--++----------20020302165603-041624518----------++
Content-Type: application/octet-stream; name="scx200.diff"
Content-Transfer-Encoding: 7bit

diff -urN linux-2.4.19-pre2/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.19-pre2/Documentation/Configure.help	Sat Mar  2 14:46:10 2002
+++ linux/Documentation/Configure.help	Sat Mar  2 15:24:59 2002
@@ -24451,6 +24451,74 @@
   information:  http://www.candelatech.com/~greear/vlan.html  If unsure,
   you can safely say 'N'.
 
+National Geode SCx200 support
+CONFIG_ARCH_SCx200
+  This provides basic support for the features of a National
+  Semiconductor SCx200 processor.
+
+  If you don't know what to do here, say N.
+
+  This support is also available as a module.  You probably don't want
+  to do this unless you are a developer modifying this driver.  If
+  compiled as a module, it will be called scx200.o.
+
+Nano Computer support
+CONFIG_ARCH_SCx200_NANO
+  The Nano Computer is a SC2200 based computer from Nano Computer
+  Systems AB, URL: <http://www.nano-system.com>.  Say Y here to create
+  a kernel that will have support for the Nano Computer.
+
+  WARNING!  Do NOT run a kernel compiled for the Nano Computer on any
+  other SC2200 platform; doing so could potentially do bad things to
+  your computer, such as fry your TFT screen.
+
+  This support is also available as a module.  You probably don't want
+  to do this unless you are a developer modifying this driver.  If
+  compiled as a module, it will be called scx200_nano.o.
+
+NatSemi SCx200 Watchdog
+CONFIG_SCx200_WATCHDOG
+  Enable the built-in watchdog timer support on SCx200 processors.
+
+  If compiled as a module, it will be called scx200_watchdog.o.
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
+  also be specified with a module parameter, if you want to do that,
+  leave the value as -1.
+
+GPIO pin used for SDA
+CONFIG_SCx200_I2C_SDA
+  Enter the GPIO pin number used for the SSA signal.  This value can
+  also be specified with a module parameter, if you want to do that,
+  leave the value as -1.
+
+NatSemi SCx200 ACCESS.bus
+CONFIG_SCx200_AB
+  Enable the use of the ACCESS.bus controllers of a SCx200 processor.
+
+  If you don't know what to do here, say N.
+
+  If compiled as a module, it will be called scx200_ab.o.
+
+Flash device mapped with DOCCS on NatSemi SCx200
+CONFIG_MTD_SCx200_DOCFLASH
+  Enable support for an CFI flash mapped using the DOCCS signal on a
+  SCx200 processor.  
+
+  If you don't know what to do here, say N.
+
+  If compiled as a module, it will be called scx200_docflash.o.
+
 #
 # A couple of things I keep forgetting:
 #   capitalize: AppleTalk, Ethernet, DOS, DMA, FAT, FTP, Internet,
diff -urN linux-2.4.19-pre2/MAINTAINERS linux/MAINTAINERS
--- linux-2.4.19-pre2/MAINTAINERS	Sat Mar  2 14:46:12 2002
+++ linux/MAINTAINERS	Sat Mar  2 15:24:59 2002
@@ -1375,6 +1375,12 @@
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 
+SCx200 CPU SUPPORT
+P:	Christer Weinigel
+M:	wingel@nano-system.com
+W:	http://www.nano-system.com
+S:	Supported
+
 SGI VISUAL WORKSTATION 320 AND 540
 P:	Bent Hagemark
 M:	bh@sgi.com
diff -urN linux-2.4.19-pre2/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.4.19-pre2/arch/i386/config.in	Sat Mar  2 14:46:13 2002
+++ linux/arch/i386/config.in	Sat Mar  2 15:25:09 2002
@@ -238,6 +238,9 @@
    fi
 fi
 
+tristate 'National Geode SCx200 support' CONFIG_ARCH_SCx200
+dep_tristate '    Nano Computer support' CONFIG_ARCH_SCx200_NANO $CONFIG_ARCH_SCx200
+
 source drivers/pci/Config.in
 
 bool 'EISA support' CONFIG_EISA
diff -urN linux-2.4.19-pre2/arch/i386/kernel/Makefile linux/arch/i386/kernel/Makefile
--- linux-2.4.19-pre2/arch/i386/kernel/Makefile	Fri Nov  9 23:21:21 2001
+++ linux/arch/i386/kernel/Makefile	Sat Mar  2 15:25:09 2002
@@ -41,4 +41,8 @@
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o acpitable.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
 
+export-objs += scx200.o
+obj-$(CONFIG_ARCH_SCx200)	+= scx200.o
+obj-$(CONFIG_ARCH_SCx200_NANO)	+= scx200_nano.o
+
 include $(TOPDIR)/Rules.make
diff -urN linux-2.4.19-pre2/arch/i386/kernel/scx200.c linux/arch/i386/kernel/scx200.c
--- linux-2.4.19-pre2/arch/i386/kernel/scx200.c	Thu Jan  1 01:00:00 1970
+++ linux/arch/i386/kernel/scx200.c	Sat Mar  2 15:25:10 2002
@@ -0,0 +1,241 @@
+/* linux/arch/i386/kernel/scx200.c 
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   National Semiconductor SCx200 support
+
+   Probe for a SCx200 CPU and locate the Configuration Block.
+   Provide a more user friendly interface to the GPIO pins.
+*/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <linux/scx200.h>
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("National Semiconductor Geode SCx200 support");
+MODULE_LICENSE("GPL");
+
+extern int scx200_nano_init(void);
+
+#define CONFIG_BLOCK_SIZE 0x40
+#define GX_BASE_SIZE (64*1024)
+
+static char name[] = "scx200";
+
+struct pci_dev *scx200_f0_pdev;
+struct pci_dev *scx200_f5_pdev;
+unsigned scx200_config_block;
+void *gx1_control;
+
+EXPORT_SYMBOL(scx200_f0_pdev);
+EXPORT_SYMBOL(scx200_f5_pdev);
+EXPORT_SYMBOL(scx200_config_block);
+EXPORT_SYMBOL(gx1_control);
+
+static int __init scx200_probe_config_block(unsigned cb_base)
+{
+	unsigned cb_data;
+
+	/* Check for the presence of the Configuration block.  */
+	cb_data = inw(cb_base + 0x3e);
+	return (cb_data == cb_base);
+}
+
+int __init scx200_init(void)
+{
+	int r;
+	int bank;
+	long flags;
+	u8 gcr;
+	unsigned gx_base;
+	unsigned cb_base;
+	const char *cb_text;
+
+	printk(KERN_DEBUG "%s\n", __PRETTY_FUNCTION__);
+
+	if ((scx200_f0_pdev = pci_find_device(PCI_VENDOR_ID_NS, 
+					      PCI_DEVICE_ID_NS_SCx200_BRIDGE,
+					      NULL)) == NULL)
+		return -ENODEV;
+
+	if ((scx200_f5_pdev = pci_find_device(PCI_VENDOR_ID_NS, 
+					      PCI_DEVICE_ID_NS_SCx200_XBUS,
+					      NULL)) == NULL)
+		return -ENODEV;
+
+	r = pci_request_regions(scx200_f0_pdev, name);
+	if (r) {
+		printk(KERN_WARNING "%s: unable to allocate the F0 I/O region\n", name);
+		return r;
+	}
+
+	/* First check if the configuration BIOS has stored the
+	   Configuration Block address in the scratch pad register */
+	pci_read_config_dword(scx200_f5_pdev, 0x64, &cb_base);
+	if (cb_base && scx200_probe_config_block(cb_base)) {
+		cb_text = "BIOS";
+		goto have_cb;
+	} 
+
+	/* The BIOS hasn't set up the scratch pad register, so first
+	   try the default address specified in the SCx200 errata */
+	cb_base = 0x9000;
+	if (scx200_probe_config_block(cb_base)) {
+		cb_text = "default";
+		goto have_cb;
+	}
+
+	/* Didn't work either, do it the hard way by scanning the I/O
+	   space for it */
+	printk(KERN_DEBUG "%s: Scanning for Configuration Block\n", name);
+	for (cb_base = 0x400; cb_base < 0x10000; cb_base += 64)	{
+		if (scx200_probe_config_block(cb_base)) {
+			cb_text = "scanned";
+			goto have_cb;
+		}
+	}
+	
+	printk(KERN_WARNING "%s: Unable to find Configuration Block\n", name);
+	cb_base = 0;
+	pci_release_regions(scx200_f0_pdev);
+	return -ENODEV;
+
+ have_cb:
+	printk(KERN_INFO "%s: Configuration Block at 0x%04x (%s)\n", 
+	       name, cb_base, cb_text);
+	scx200_config_block = cb_base;
+
+	if (!request_region(scx200_config_block, CONFIG_BLOCK_SIZE, name)) {
+		printk(KERN_WARNING "%s: unable to allocate the Configuration Block I/O region\n", name);
+		pci_release_regions(scx200_f0_pdev);
+		return -EBUSY;
+	}
+
+	save_flags(flags);
+	cli();
+	outb(0xb8, 0x22);	/* Read GCR */
+	gcr = inb(0x23);
+	restore_flags(flags);
+	gx_base = (gcr & 3) << 30;
+	if (gx_base) {
+		printk(KERN_INFO "%s: GX_BASE is 0x%08x\n", name, gx_base);
+		gx1_control = ioremap(gx_base, GX_BASE_SIZE);
+		if (!gx1_control)
+			printk(KERN_WARNING "%s: unable to allocate the GX_BASE I/O region\n", name);
+	}
+	else
+		printk(KERN_INFO "%s: GX_BASE is disabled\n",name);
+
+	if (gx_base) {
+		printk(KERN_DEBUG "MC_MEM_CNTRL1: 0x%08x\n", readl(gx1_control + 0x8400));
+		printk(KERN_DEBUG "MC_MEM_CNTRL2: 0x%08x\n", readl(gx1_control + 0x8404));
+		printk(KERN_DEBUG "MC_MEM_BANK_CNFG: 0x%08x\n", readl(gx1_control + 0x8408));
+		printk(KERN_DEBUG "MC_SYNC_TIM1:  0x%08x\n", readl(gx1_control + 0x840c));
+	}
+
+	scx200_gpio_base = pci_resource_start(scx200_f0_pdev, 0);
+	printk(KERN_INFO "%s: GPIOs at 0x%x\n", name, scx200_gpio_base);
+
+	/* read the current values driven on the GPIO signals */
+	for (bank = 0; bank < 2; ++bank)
+		scx200_gpio_shadow[bank] = inl(scx200_gpio_base + 0x10 * bank);
+
+#ifdef CONFIG_ARCH_SCx200_NANO
+	scx200_nano_init();
+#endif
+
+	return 0;
+}
+
+#ifdef MODULE
+void __exit scx200_cleanup(void)
+{
+	printk(KERN_DEBUG "%s\n", __PRETTY_FUNCTION__);
+
+	if (gx1_control)
+		iounmap(gx1_control);
+	release_region(scx200_config_block, CONFIG_BLOCK_SIZE);
+	pci_release_regions(scx200_f0_pdev);
+}
+
+module_init(scx200_init);
+module_exit(scx200_cleanup);
+#endif MODULE
+
+/* GPIO stuff */
+
+unsigned scx200_gpio_base;
+u32 scx200_gpio_shadow[2];
+
+spinlock_t scx200_gpio_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t scx200_gpio_config_lock = SPIN_LOCK_UNLOCKED;
+
+/* this should be spinlock protected I suppose */
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
+EXPORT_SYMBOL(scx200_gpio_base);
+EXPORT_SYMBOL(scx200_gpio_shadow);
+EXPORT_SYMBOL(scx200_gpio_lock);
+EXPORT_SYMBOL(scx200_gpio_configure);
+EXPORT_SYMBOL(scx200_gpio_dump);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../../.. SUBDIRS=arch/i386/kernel bzImage"
+        c-basic-offset: 8
+    End:
+*/
diff -urN linux-2.4.19-pre2/arch/i386/kernel/scx200_nano.c linux/arch/i386/kernel/scx200_nano.c
--- linux-2.4.19-pre2/arch/i386/kernel/scx200_nano.c	Thu Jan  1 01:00:00 1970
+++ linux/arch/i386/kernel/scx200_nano.c	Sat Mar  2 15:25:10 2002
@@ -0,0 +1,197 @@
+/* linux/arch/i386/kernel/scx200_nano.c 
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   Do any hardware specific setup for the SC2200 based Nano Computer.
+
+   WARNING!  Do NOT run a kernel compiled for the Nano Computer on any
+   other SC2200 platform; doing so could potentially do bad things to
+   your computer, such as fry your TFT screen. */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/scx200.h>
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("Nano Computer support");
+MODULE_LICENSE("GPL");
+
+static char name[] = "scx200_nano";
+
+/* Where should the flash be mapped? */
+#define DOC_WINDOW_ADDR (0xc0000000)
+#define DOC_WINDOW_SIZE (16 * 1024 * 1024)
+#define DOC_BUSWIDTH 1
+
+static void __init nano_fixup_irq(void)
+{
+	struct pci_dev *dev;
+	int i;
+	u16 int_map;
+	int intb, intc;
+
+	if (scx200_f0_pdev == NULL) {
+		printk(KERN_ERR "scx200_i2c: Not a SCx200 CPU\n");
+		return;
+	}
+
+	pci_read_config_word(scx200_f0_pdev, 0x5c, &int_map);
+	intb = (int_map >> 4) & 15;
+	intc = (int_map >> 8) & 15;
+
+	for (i = 0; i < 4; i++) {
+		u8 pin;
+		int irq;
+
+		dev = pci_find_slot(0, PCI_DEVFN(0x11, i));
+		if (!dev)
+			break;
+
+		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+		if (!pin) {
+			continue;
+		}
+		switch (pin) {
+		case 1:
+		case 3:
+			irq = intc;
+			break;
+		case 2:
+		case 4:
+			irq = intb;
+			break;
+		default:
+			irq = dev->irq;
+		}
+
+		if (irq != dev->irq) {
+			printk(KERN_INFO "%s: IRQ fixup for %02x:%02x.%d, was %d, new %d\n", name, 0, 0x11, i, dev->irq, irq);
+			dev->irq = irq;
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+		}
+	}
+}
+
+int __init scx200_nano_init(void)
+{
+	u32 pmr, mcr;
+	u32 doccs_base, doccs_ctrl;
+
+	printk(KERN_DEBUG "%s\n", __PRETTY_FUNCTION__);
+
+	if (scx200_f0_pdev == NULL) {
+		printk(KERN_ERR "%s: Not a SCx200 CPU\n", name);
+		return -ENODEV;
+	}
+
+	pmr = inl(scx200_config_block + SCx200_PMR);
+	mcr = inl(scx200_config_block + SCx200_MCR);
+
+	printk(KERN_DEBUG "%s: PMR = 0x%08x\n", name, pmr);
+	printk(KERN_DEBUG "%s: MCR = 0x%08x\n", name, mcr);
+
+	pci_read_config_dword(scx200_f0_pdev, 0x78, &doccs_base);
+	pci_read_config_dword(scx200_f0_pdev, 0x7c, &doccs_ctrl);
+
+	printk(KERN_DEBUG "%s: PCI DOCCS Base = 0x%08x\n", name, doccs_base);
+	printk(KERN_DEBUG "%s: PCI DOCCS Ctrl = 0x%08x\n", name, doccs_ctrl);
+	
+	printk(KERN_INFO "%s: GPIO01/#IOCS1,GPIO20/#DOCCS on H2,H3\n", name);
+	pmr &= ~(1<<23);
+
+	printk(KERN_INFO "%s: Configuring GPIOs\n", name);
+	pmr &= ~(1<<13);	/* GPIO01 not #IOCS1 */
+	pmr &= ~((1<<14) | (1<<22)); /* GPIO32-GPIO39 not LPC */
+
+#if 0
+	pmr &= ~(1<<19);	/* GPIO12-GPIO13 not ACCESS.bus 2 */
+#else
+	pmr |= 1<<19;		/* AB2, not GPIO12,GPIO13 */
+#endif
+
+	/* Pin header GPIOs */
+	scx200_gpio_configure(36, 0, 0); /* GPIO36 = HGPIO1 */
+	scx200_gpio_configure(35, 0, 0); /* GPIO35 = HGPIO2 */
+	scx200_gpio_configure(1, 0, 0); /* GPIO1 = HGPIO3 */
+	scx200_gpio_configure(17, 0, 0); /* GPIO17 = HGPIO4 */
+
+	/* Unused GPIOs */
+	scx200_gpio_configure(37, 0, 0); /* GPIO37 = HGPIO8 not connected */
+	scx200_gpio_configure(39, 0, 0); /* GPIO39/SERIRQ not connected */
+
+	/* LED GPIOs */
+	scx200_gpio_configure(32, 7, 7);
+	scx200_gpio_configure(33, 7, 7);
+	scx200_gpio_configure(34, 7, 7);
+
+	/* EEPROM U6WP GPIO */
+	scx200_gpio_configure(38, 7, 7);
+
+	printk(KERN_INFO "%s: #DOCCS not GPIO20, ZWS\n", name);
+	pmr |= (1<<7);	/* #DOCCS not GPIO20 */
+	mcr |= (1<<10);	/* Zero Wait States */
+
+	printk(KERN_DEBUG "%s: DOC 0x%x-0x%x, width %d\n",
+	       name, DOC_WINDOW_ADDR, DOC_WINDOW_ADDR+DOC_WINDOW_SIZE, 
+	       DOC_BUSWIDTH);
+	scx200_gpio_configure(20, 7, 7); /* DOCCS GPIOs (not needed?) */
+	doccs_base = DOC_WINDOW_ADDR;
+	doccs_ctrl = ((DOC_WINDOW_SIZE-1) >> 13);
+	doccs_ctrl |= 0x07000000;
+	if (DOC_BUSWIDTH == 1)
+		pmr &= ~(1<<6);
+	else if (DOC_BUSWIDTH == 2)
+		pmr |= (1<<6);
+	else
+		printk(KERN_WARNING "%s: invalid DOC bus with %d\n", 
+		       name, DOC_BUSWIDTH);
+
+	/* INTC */
+	pmr |= 1<<4;		/* #INTC not GPIO19 */
+	pmr &= ~(1<<9);	/* #INTC not IOCHRDY */
+	
+	printk(KERN_DEBUG "%s: PCI DOCCS Base = 0x%08x\n", name, doccs_base);
+	printk(KERN_DEBUG "%s: PCI DOCCS Ctrl = 0x%08x\n", name, doccs_ctrl);
+	
+	pci_write_config_dword(scx200_f0_pdev, 0x78, doccs_base);
+	pci_write_config_dword(scx200_f0_pdev, 0x7c, doccs_ctrl);
+
+	printk(KERN_DEBUG "%s: PMR = 0x%08x\n", name, pmr);
+	printk(KERN_DEBUG "%s: MCR = 0x%08x\n", name, mcr);
+
+	outl(pmr, scx200_config_block + SCx200_PMR);
+	outl(mcr, scx200_config_block + SCx200_MCR);
+
+	printk(KERN_DEBUG "%s: Removing EEPROM write protect\n", name);
+	scx200_gpio_set_low(38);
+
+	/* turn off two top leds */
+	scx200_gpio_set_low(32);
+	scx200_gpio_set_low(33);
+	scx200_gpio_set_high(34);
+
+	nano_fixup_irq();
+
+	return 0;
+}
+
+#ifdef MODULE
+void __exit scx200_nano_cleanup(void)
+{
+	printk(KERN_INFO "%s\n", __PRETTY_FUNCTION__);
+}
+
+module_init(scx200_nano_init);
+module_exit(scx200_nano_cleanup);
+#endif
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../../.. SUBDIRS=arch/i386/kernel bzImage"
+        c-basic-offset: 8
+    End:
+*/
Binary files linux-2.4.19-pre2/core and linux/core differ
diff -urN linux-2.4.19-pre2/drivers/char/Config.in linux/drivers/char/Config.in
--- linux-2.4.19-pre2/drivers/char/Config.in	Sat Mar  2 14:46:36 2002
+++ linux/drivers/char/Config.in	Sat Mar  2 15:26:02 2002
@@ -196,6 +196,7 @@
    tristate '  IB700 SBC Watchdog Timer' CONFIG_IB700_WDT
    tristate '  Intel i810 TCO timer / Watchdog' CONFIG_I810_TCO
    tristate '  Mixcom Watchdog' CONFIG_MIXCOMWD 
+   dep_tristate '  NatSemi SCx200 Watchdog' CONFIG_SCx200_WATCHDOG $CONFIG_ARCH_SCx200
    tristate '  SBC-60XX Watchdog Timer' CONFIG_60XX_WDT
    tristate '  W83877F (EMACS) Watchdog Timer' CONFIG_W83877F_WDT
    tristate '  ZF MachZ Watchdog' CONFIG_MACHZ_WDT
diff -urN linux-2.4.19-pre2/drivers/char/Makefile linux/drivers/char/Makefile
--- linux-2.4.19-pre2/drivers/char/Makefile	Sat Mar  2 14:46:36 2002
+++ linux/drivers/char/Makefile	Sat Mar  2 15:26:02 2002
@@ -247,6 +247,7 @@
 obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_INDYDOG) += indydog.o
+obj-$(CONFIG_SCx200_WATCHDOG) += scx200_watchdog.o
 
 subdir-$(CONFIG_MWAVE) += mwave
 ifeq ($(CONFIG_MWAVE),y)
diff -urN linux-2.4.19-pre2/drivers/char/scx200_watchdog.c linux/drivers/char/scx200_watchdog.c
--- linux-2.4.19-pre2/drivers/char/scx200_watchdog.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/char/scx200_watchdog.c	Sat Mar  2 15:26:09 2002
@@ -0,0 +1,263 @@
+/* linux/drivers/char/scx200_watchdog.c 
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
+#include <asm/uaccess.h>
+
+#include <linux/scx200.h>
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("NatSemi SCx200 Watchdog");
+MODULE_LICENSE("GPL");
+
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+#define CONFIG_WATCHDOG_NOWAYOUT 0
+#endif
+
+static const char name[] = "scx200_watchdog";
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
+#define WDTO 0x00		/* Time-Out Register */
+#define WDCNFG 0x02		/* Configuration Register */
+#define    W_ENABLE 0x00fa	/* Enable watchdog */
+#define    W_DISABLE 0x0000	/* Disable watchdog */
+#define WDSTS 0x04		/* Status Register */
+#define    WDOVF (1<<0)		/* Overflow */
+
+#define W_SCALE (32768/1024)	/* This depends on the value of W_ENABLE */
+
+static void scx200_watchdog_ping(void)
+{
+	outw(wdto_restart, scx200_config_block + WDTO);
+}
+
+static void scx200_watchdog_update_margin(void)
+{
+	printk(KERN_INFO "%s: timer margin %d seconds\n", name, margin);
+	wdto_restart = margin * W_SCALE;
+}
+
+static void scx200_watchdog_enable(void)
+{
+	printk(KERN_DEBUG "%s: enabling watchdog timer, wdto_restart = %d\n", 
+	       name, wdto_restart);
+
+	outw(0, scx200_config_block + WDTO);
+	outb(WDOVF, scx200_config_block + WDSTS);
+	outw(W_ENABLE, scx200_config_block + WDCNFG);
+
+	scx200_watchdog_ping();
+}
+
+static void scx200_watchdog_disable(void)
+{
+	printk(KERN_DEBUG "%s: disabling watchdog timer\n", name);
+		
+	outw(0, scx200_config_block + WDTO);
+	outb(WDOVF, scx200_config_block + WDSTS);
+	outw(W_DISABLE, scx200_config_block + WDCNFG);
+}
+
+static int scx200_watchdog_open(struct inode *inode, struct file *file)
+{
+        /* only allow one at a time */
+        if (down_trylock(&open_semaphore))
+                return -EBUSY;
+	scx200_watchdog_enable();
+	expect_close = 0;
+
+	return 0;
+}
+
+static int scx200_watchdog_release(struct inode *inode, struct file *file)
+{
+	if (!expect_close) {
+		printk(KERN_WARNING "%s: watchdog device closed unexpectedly, "
+		       "will not disable the watchdog timer\n", name);
+	} else if (!nowayout) {
+		scx200_watchdog_disable();
+	}
+        up(&open_semaphore);
+
+	return 0;
+}
+
+static int scx200_watchdog_notify_sys(struct notifier_block *this, 
+				      unsigned long code, void *unused)
+{
+        if (code == SYS_HALT || code == SYS_POWER_OFF)
+		if (!nowayout)
+			scx200_watchdog_disable();
+
+        return NOTIFY_DONE;
+}
+
+static struct notifier_block scx200_watchdog_notifier =
+{
+        notifier_call: scx200_watchdog_notify_sys
+};
+
+static ssize_t scx200_watchdog_write(struct file *file, const char *data, 
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
+		scx200_watchdog_ping();
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
+static int scx200_watchdog_ioctl(struct inode *inode, struct file *file,
+	unsigned int cmd, unsigned long arg)
+{
+	static struct watchdog_info ident = {
+		identity : "SCx200 Watchdog",
+		firmware_version : 1, 
+		options : (
+#ifdef WDIOF_SETTIMEOUT
+			WDIOF_SETTIMEOUT | 
+#endif
+			WDIOF_KEEPALIVEPING),
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
+		return put_user(0, (int *)arg);
+	case WDIOC_KEEPALIVE:
+		scx200_watchdog_ping();
+		return 0;
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_margin, (int *)arg))
+			return -EFAULT;
+		if (new_margin < 1)
+			return -EINVAL;
+		margin = new_margin;
+		scx200_watchdog_update_margin();
+		scx200_watchdog_ping();
+#ifdef WDIOC_GETTIMEOUT
+	case WDIOC_GETTIMEOUT:
+#endif
+		return put_user(margin, (int *)arg);
+	}
+}
+
+static struct file_operations scx200_watchdog_fops = {
+	owner: THIS_MODULE,
+	write: scx200_watchdog_write,
+	ioctl: scx200_watchdog_ioctl,
+	open: scx200_watchdog_open,
+	release: scx200_watchdog_release,
+};
+
+static struct miscdevice scx200_watchdog_miscdev = {
+	minor: WATCHDOG_MINOR,
+	name: name,
+	fops: &scx200_watchdog_fops,
+};
+
+static int __init scx200_watchdog_init(void)
+{
+	int r;
+
+	if (scx200_f0_pdev == NULL) {
+		printk(KERN_ERR "%s: Not a SCx200 CPU\n", name);
+		return -ENODEV;
+	}
+
+	scx200_watchdog_update_margin();
+	scx200_watchdog_disable();
+
+	sema_init(&open_semaphore, 1);
+
+	r = misc_register(&scx200_watchdog_miscdev);
+	if (r)
+		return r;
+
+	r = register_reboot_notifier(&scx200_watchdog_notifier);
+        if (r) {
+                printk(KERN_ERR "%s: unable to register reboot notifier", 
+		       name);
+		misc_deregister(&scx200_watchdog_miscdev);
+                return r;
+        }
+
+	return 0;
+}
+
+static void __exit scx200_watchdog_cleanup(void)
+{
+        unregister_reboot_notifier(&scx200_watchdog_notifier);
+	misc_deregister(&scx200_watchdog_miscdev);
+}
+
+module_init(scx200_watchdog_init);
+module_exit(scx200_watchdog_cleanup);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../.. SUBDIRS=drivers/char modules"
+        c-basic-offset: 8
+    End:
+*/
diff -urN linux-2.4.19-pre2/drivers/i2c/Config.in linux/drivers/i2c/Config.in
--- linux-2.4.19-pre2/drivers/i2c/Config.in	Mon Feb 25 20:37:57 2002
+++ linux/drivers/i2c/Config.in	Sat Mar  2 15:26:17 2002
@@ -13,6 +13,12 @@
       dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_PHILIPSPAR $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
       dep_tristate '  ELV adapter' CONFIG_I2C_ELV $CONFIG_I2C_ALGOBIT
       dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_VELLEMAN $CONFIG_I2C_ALGOBIT
+      dep_tristate '  NatSemi SCx200 I2C using GPIO pins' CONFIG_SCx200_I2C $CONFIG_ARCH_SCx200 $CONFIG_I2C_ALGOBIT
+      if [ "$CONFIG_I2C_SCx200" != "n" ]; then
+         int  '    GPIO pin used for SCL' CONFIG_SCx200_I2C_SCL -1
+         int  '    GPIO pin used for SDA' CONFIG_SCx200_I2C_SDA -1
+      fi
+      dep_tristate '  NatSemi SCx200 ACCESS.bus' CONFIG_SCx200_AB $CONFIG_ARCH_SCx200
    fi
 
    dep_tristate 'I2C PCF 8584 interfaces' CONFIG_I2C_ALGOPCF $CONFIG_I2C
diff -urN linux-2.4.19-pre2/drivers/i2c/Makefile linux/drivers/i2c/Makefile
--- linux-2.4.19-pre2/drivers/i2c/Makefile	Mon Feb 25 20:37:57 2002
+++ linux/drivers/i2c/Makefile	Sat Mar  2 15:26:17 2002
@@ -18,6 +18,8 @@
 obj-$(CONFIG_ITE_I2C_ALGO)	+= i2c-algo-ite.o
 obj-$(CONFIG_ITE_I2C_ADAP)	+= i2c-adap-ite.o
 obj-$(CONFIG_I2C_PROC)		+= i2c-proc.o
+obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
+obj-$(CONFIG_SCx200_AB)		+= scx200_ab.o
 obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
 
 # This is needed for automatic patch generation: sensors code starts here
diff -urN linux-2.4.19-pre2/drivers/i2c/scx200_ab.c linux/drivers/i2c/scx200_ab.c
--- linux-2.4.19-pre2/drivers/i2c/scx200_ab.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/i2c/scx200_ab.c	Sat Mar  2 15:26:17 2002
@@ -0,0 +1,583 @@
+/*  linux/drivers/i2c/scx200_ab.c 
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
+
+#include <linux/scx200.h>
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("NatSemi SCx200 ACCESS.buss");
+MODULE_LICENSE("GPL");
+
+#define MAX_DEVICES 4
+static int base[MAX_DEVICES] = { 0x840 };
+MODULE_PARM(base, "1-4i");
+MODULE_PARM_DESC(base, "Base addresses for the ACCESS.bus controllers");
+
+static const char name[] = "scx200_ab";
+
+#define DEBUG 0
+
+#if DEBUG
+#define DBG(x...) printk(KERN_DEBUG x)
+#else
+#define DBG(x...)
+#endif
+
+#define POLLED_MODE 1
+#define POLL_TIMEOUT (HZ)
+
+enum scx200_ab_state {
+	state_idle,
+	state_address,
+	state_command,
+	state_repeat_start,
+	state_quick,
+	state_read,
+	state_write,
+};
+
+static const char *scx200_ab_state_name[] = {
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
+struct scx200_ab_iface
+{
+	struct scx200_ab_iface *next;
+	struct i2c_adapter adapter;
+	unsigned base;
+	struct semaphore sem;
+
+	/* State machine data */
+	enum scx200_ab_state state;
+	int result;
+	u8 address_byte;
+	u8 command;
+	u8 *ptr;
+	char needs_reset;
+	unsigned len;
+};
+
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
+static void scx200_ab_machine(struct scx200_ab_iface *iface, u8 status)
+{
+	const char *errmsg;
+
+	DBG("%s: state %s, status = 0x%02x\n", iface->adapter.name, 
+	    scx200_ab_state_name[iface->state], status);
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
+		printk(KERN_WARNING "%s: interrupt in idle state\n", 
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
+	DBG("%s: negative acknowledge in state %s\n", 
+	    iface->adapter.name, scx200_ab_state_name[iface->state]);
+
+	iface->state = state_idle;
+	iface->result = -ENXIO;
+
+	outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
+	outb(ACBST_STASTR | ACBST_NEGACK, ACBST);
+	return;
+
+ error:
+	printk(KERN_ERR "%s: %s in state %s\n", iface->adapter.name, 
+	       errmsg, scx200_ab_state_name[iface->state]);
+
+	iface->state = state_idle;
+	iface->result = -EIO;
+	iface->needs_reset = 1;
+}
+
+static void scx200_ab_timeout(struct scx200_ab_iface *iface) 
+{
+	printk(KERN_ERR "%s: timeout in state %s\n", iface->adapter.name, 
+	       scx200_ab_state_name[iface->state]);
+
+	iface->state = state_idle;
+	iface->result = -EIO;
+	iface->needs_reset = 1;
+}
+
+#ifdef POLLED_MODE
+static void scx200_ab_poll(struct scx200_ab_iface *iface)
+{
+	u8 status = 0;
+	unsigned long timeout;
+
+	timeout = jiffies + POLL_TIMEOUT;
+	while (time_before(jiffies, timeout)) {
+		status = inb(ACBST);
+		if ((status & (ACBST_SDAST|ACBST_BER|ACBST_NEGACK)) != 0) {
+			scx200_ab_machine(iface, status);
+			return;
+		}
+		current->policy |= SCHED_YIELD;
+		schedule();
+	}
+
+	scx200_ab_timeout(iface);
+}
+#endif /* POLLED_MODE */
+
+static void scx200_ab_reset(struct scx200_ab_iface *iface)
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
+static s32 scx200_ab_smbus_xfer(struct i2c_adapter *adapter,
+				u16 address, unsigned short flags,	
+				char rw, u8 command, int size, 
+				union i2c_smbus_data *data)
+{
+	struct scx200_ab_iface *iface = adapter->data;
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
+	DBG("%s: size=%d, address=0x%x, command=0x%x, len=%d, read=%d\n",
+	    adapter->name, size, address, command, len, rw == I2C_SMBUS_READ);
+
+	if (!len && rw == I2C_SMBUS_READ) {
+		printk(KERN_WARNING "%s: zero length read\n", 
+		       adapter->name);
+		return -EINVAL;
+	}
+
+	if (len && !buffer) {
+		printk(KERN_WARNING "%s: nonzero length but no buffer\n", 
+		       adapter->name);
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
+		scx200_ab_poll(iface);
+#else /* POLLED_MODE */
+#error Not implemented
+#endif /* POLLED_MODE */	
+
+	if (iface->needs_reset)
+		scx200_ab_reset(iface);
+
+	rc = iface->result;
+
+	up(&iface->sem);
+
+	if (rc == 0 && size == I2C_SMBUS_WORD_DATA && rw == I2C_SMBUS_READ)
+	    	data->word = le16_to_cpu(cur_word);
+
+#if DEBUG
+	printk(KERN_DEBUG "%s: transfer done, result: %d", adapter->name, rc);
+	if (buffer) {
+		int i;
+		printk(" data:");
+		for (i = 0; i < len; ++i)
+			printk(" %02x", buffer[i]);
+		printk("\n");
+	}
+#endif
+	DBG("\n");
+
+	return rc;
+}
+
+static u32 scx200_ab_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	       I2C_FUNC_SMBUS_BLOCK_DATA;
+}
+
+static int scx200_ab_reg(struct i2c_client *client)
+{
+	return 0;
+}
+
+static int scx200_ab_unreg(struct i2c_client *client)
+{
+	return 0;
+}
+
+static void scx200_ab_inc_use(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+static void scx200_ab_dec_use(struct i2c_adapter *adapter)
+{
+	MOD_DEC_USE_COUNT;
+}
+
+/* For now, we only handle combined mode (smbus) */
+static struct i2c_algorithm scx200_ab_algorithm = {
+	name:		"SCx200 ACCESS.bus",
+	id:		I2C_ALGO_SMBUS,
+	smbus_xfer:	scx200_ab_smbus_xfer,
+	functionality:	scx200_ab_func,
+};
+
+struct scx200_ab_iface *scx200_ab_list;
+
+int scx200_ab_probe(struct scx200_ab_iface *iface)
+{
+	u8 val;
+
+	/* Disable the ACCESS.bus device and Configure the SCL
+           frequency: 16 clock cycles */
+	outb(0x70, ACBCTL2);
+
+	if (inb(ACBCTL2) != 0x70) {
+		DBG("%s: ACBCTL2 readback failed\n", iface->adapter.name);
+		return -ENXIO;
+	}
+
+	outb(inb(ACBCTL1) | ACBCTL1_NMINTE, ACBCTL1);
+
+	val = inb(ACBCTL1);
+	if (val) {
+		DBG("%s: disabled, but ACBCTL1=0x%02x\n", 
+		    iface->adapter.name, val);
+		return -ENXIO;
+	}
+
+	outb(inb(ACBCTL2) | ACBCTL2_ENABLE, ACBCTL2);
+
+	outb(inb(ACBCTL1) | ACBCTL1_NMINTE, ACBCTL1);
+
+	val = inb(ACBCTL1);
+	if ((val & ACBCTL1_NMINTE) != ACBCTL1_NMINTE) {
+		DBG("%s: enabled, but NMINTE won't be set, ACBCTL1=0x%02x\n", 
+		    iface->adapter.name, val);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+void scx200_ab_destroy(struct scx200_ab_iface *iface)
+{
+	if (iface) {
+		if (iface->base)
+			release_region(iface->base, 8);
+		kfree(iface);
+	}
+}
+
+int scx200_ab_create(int base, int index)
+{
+	struct scx200_ab_iface *iface;
+	struct i2c_adapter *adapter;
+	int rc = 0;
+
+	iface = kmalloc(sizeof(*iface), GFP_KERNEL);
+	if (!iface) {
+		printk(KERN_ERR "%s: can't allocate memory\n", name);
+		rc = -ENOMEM;
+		goto errout;
+	}
+
+	memset(iface, 0, sizeof(*iface));
+	adapter = &iface->adapter;
+	adapter->data = iface;
+	sprintf(adapter->name, "SCx200_ACB%d", index);
+	adapter->id = I2C_ALGO_SMBUS;
+	adapter->algo = &scx200_ab_algorithm;
+	adapter->inc_use = scx200_ab_inc_use;
+	adapter->dec_use = scx200_ab_dec_use;
+	adapter->client_register = scx200_ab_reg;
+	adapter->client_unregister = scx200_ab_unreg;
+
+	printk(KERN_INFO "%s: initializing\n", adapter->name);
+
+	init_MUTEX(&iface->sem);
+
+	if (request_region(base, 8, adapter->name) == 0) {
+		printk(KERN_ERR "%s: can't allocate io 0x%x-0x%x\n", 
+		       adapter->name, base, base + 8-1);
+		rc = -EBUSY;
+		goto errout;
+	}
+	iface->base = base;
+
+	rc = scx200_ab_probe(iface);
+	if (rc) {
+		printk(KERN_WARNING "%s: probe failed\n", adapter->name);
+		goto errout;
+	}
+
+	scx200_ab_reset(iface);
+
+	if (i2c_add_adapter(adapter) < 0) {
+		printk(KERN_ERR "%s: failed to register %s\n", 
+		       adapter->name, adapter->name);
+		rc = -ENODEV;
+		goto errout;
+	}
+
+	lock_kernel();
+	iface->next = scx200_ab_list;
+	scx200_ab_list = iface;
+	unlock_kernel();
+
+	return 0;
+
+ errout:
+	scx200_ab_destroy(iface);
+	return rc;
+}
+
+int scx200_ab_init(void)
+{
+	int i;
+	int rc;
+
+	if (pci_find_device(PCI_VENDOR_ID_NS,
+			    PCI_DEVICE_ID_NS_SCx200_BRIDGE,
+			    NULL) == NULL) {
+		printk(KERN_ERR "%s: Not a SCx200 CPU\n", name);
+		return -ENODEV;
+	}
+
+	rc = -ENXIO;
+	for (i = 0; i < MAX_DEVICES; ++i) {
+		if (base[i] > 0)
+			rc = scx200_ab_create(base[i], i);
+	}
+	if (scx200_ab_list)
+		return 0;
+	return rc;
+}
+
+void scx200_ab_cleanup(void)
+{
+	struct scx200_ab_iface *iface;
+	lock_kernel();
+	while ((iface = scx200_ab_list) != NULL) {
+		scx200_ab_list = iface->next;
+		unlock_kernel();
+
+		i2c_del_adapter(&iface->adapter);
+		scx200_ab_destroy(iface);
+
+		lock_kernel();
+	}
+	unlock_kernel();
+}
+
+module_init(scx200_ab_init);
+module_exit(scx200_ab_cleanup);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../.. SUBDIRS=drivers/i2c modules"
+        c-basic-offset: 8
+    End:
+*/
+
diff -urN linux-2.4.19-pre2/drivers/i2c/scx200_i2c.c linux/drivers/i2c/scx200_i2c.c
--- linux-2.4.19-pre2/drivers/i2c/scx200_i2c.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/i2c/scx200_i2c.c	Sat Mar  2 15:26:17 2002
@@ -0,0 +1,153 @@
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
+
+#include <linux/scx200.h>
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("NatSemi SCx200 I2C using GPIO pins");
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
+static const char name[] = "scx200_i2c";
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
+	name:		"SCx200 GPIO I2C",
+	id:		I2C_HW_B_VELLE,
+	algo_data:	&scx200_i2c_data,
+	inc_use:	scx200_i2c_inc_use,
+	dec_use:	scx200_i2c_dec_use,
+	client_register: scx200_i2c_reg,
+	client_unregister: scx200_i2c_unreg,
+};
+
+int scx200_i2c_init(void)
+{
+	if (scx200_f0_pdev == NULL) {
+		printk(KERN_ERR "%s: Not a SCx200 CPU\n", name);
+		return -ENODEV;
+	}
+
+	printk(KERN_INFO "%s: SCL=GPIO%02u, SDA=GPIO%02u\n", 
+	       name, scl, sda);
+
+	if (scl == -1 || sda == -1 || scl == sda) {
+		printk(KERN_ERR "%s: scl and sda must be specified\n", name);
+		return -EINVAL;
+	}
+
+	/* Configure GPIOs as open collector outputs */
+	scx200_gpio_configure(scl, ~2, 5);
+	scx200_gpio_configure(sda, ~2, 5);
+
+	if (i2c_bit_add_bus(&scx200_i2c_ops) < 0) {
+		printk(KERN_ERR "%s: Adapter %s registration failed\n", 
+		       name, scx200_i2c_ops.name);
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
diff -urN linux-2.4.19-pre2/drivers/mtd/maps/Config.in linux/drivers/mtd/maps/Config.in
--- linux-2.4.19-pre2/drivers/mtd/maps/Config.in	Sat Mar  2 14:46:44 2002
+++ linux/drivers/mtd/maps/Config.in	Sat Mar  2 15:26:25 2002
@@ -27,6 +27,7 @@
    dep_tristate '  JEDEC Flash device mapped on Octagon 5066 SBC' CONFIG_MTD_OCTAGON $CONFIG_MTD_JEDEC
    dep_tristate '  JEDEC Flash device mapped on Tempustech VMAX SBC301' CONFIG_MTD_VMAX $CONFIG_MTD_JEDEC
    dep_tristate '  BIOS flash chip on Intel L440GX boards' CONFIG_MTD_L440GX $CONFIG_I386 $CONFIG_MTD_JEDEC
+   dep_tristate '  Flash device mapped with DOCCS on NatSemi SCx200' CONFIG_MTD_SCx200_DOCFLASH $CONFIG_ARCH_SCx200 $CONFIG_MTD_CFI $CONFIG_MTD_PARTITIONS
 fi
 
 if [ "$CONFIG_PPC" = "y" ]; then
diff -urN linux-2.4.19-pre2/drivers/mtd/maps/Makefile linux/drivers/mtd/maps/Makefile
--- linux-2.4.19-pre2/drivers/mtd/maps/Makefile	Sat Mar  2 14:46:44 2002
+++ linux/drivers/mtd/maps/Makefile	Sat Mar  2 15:26:25 2002
@@ -31,5 +31,6 @@
 obj-$(CONFIG_MTD_SOLUTIONENGINE)+= solutionengine.o
 obj-$(CONFIG_MTD_PB1000)        += pb1xxx-flash.o
 obj-$(CONFIG_MTD_PB1500)        += pb1xxx-flash.o
+obj-$(CONFIG_MTD_SCx200_DOCFLASH)+= scx200_docflash.o
 
 include $(TOPDIR)/Rules.make
diff -urN linux-2.4.19-pre2/drivers/mtd/maps/scx200_docflash.c linux/drivers/mtd/maps/scx200_docflash.c
--- linux-2.4.19-pre2/drivers/mtd/maps/scx200_docflash.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/mtd/maps/scx200_docflash.c	Sat Mar  2 15:26:25 2002
@@ -0,0 +1,177 @@
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
+MODULE_AUTHOR("Christer Weinigel <wingel@hack.org>");
+MODULE_DESCRIPTION("NatSemi SCx200 DOCCS Flash");
+MODULE_LICENSE("GPL");
+
+static int partition = 1;
+
+static const char name[] = "scx200_docflash";
+
+static struct mtd_info *mymtd;
+
+/* partition_info gives details on the logical partitions that the split the 
+ * single flash device into. If the size if zero we use up to the end of the
+ * device. */
+static struct mtd_partition partition_info[] = {
+	{ 
+		name: "scx200 Boot kernel", 
+		offset: 0, 
+		size: 	0xc0000
+	},
+	{ 
+		name: "scx200 Low BIOS", 
+		offset: 0xc0000, 
+		size: 	0x40000
+	},
+	{ 
+		name: "scx200 File system", 
+		offset: 0x100000, 
+		size: 	~0	/* calculate from flash size */
+	},
+	{ 
+		name: "scx200 High BIOS", 
+		offset: ~0, 	/* calculate from flash size */
+		size: 0x80000
+	},
+};
+#define NUM_PARTITIONS (sizeof(partition_info)/sizeof(partition_info[0]))
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
+	name: "scx200 DOCCS flash",
+	read8: scx200_docflash_read8,
+	read16: scx200_docflash_read16,
+	copy_from: scx200_docflash_copy_from,
+	write8: scx200_docflash_write8,
+	write16: scx200_docflash_write16,
+	copy_to: scx200_docflash_copy_to
+};
+
+int __init init_scx200_docflash(void)
+{
+	unsigned doccs_base;
+	unsigned doccs_ctrl;
+	unsigned pmr;
+
+	if (scx200_f0_pdev == NULL) {
+		printk(KERN_ERR "%s: Not a SCx200 CPU\n", name);
+		return -ENODEV;
+	}
+
+	/* read the current configuration for the DOCCS from the
+           SCx200 and use this to set up our flash mapping.  It might
+           be a better idea to ask the Linux kernel for a memory
+           region where the flash can be mapped instead of relying on
+           the BIOS to do it correctly */
+	pci_read_config_dword(scx200_f0_pdev, 0x78, &doccs_base);
+	pci_read_config_dword(scx200_f0_pdev, 0x7c, &doccs_ctrl);
+	pmr = inl(scx200_config_block + SCx200_PMR);
+
+	scx200_docflash_map.size = ((doccs_ctrl & 0x1fff) << 13) + (1<<13);
+
+	if (pmr & (1<<6))	/* is the flash 16 or 8 bits wide */
+		scx200_docflash_map.buswidth = 2;
+	else
+		scx200_docflash_map.buswidth = 1;
+
+       	printk(KERN_INFO "%s: DOCCS mapped at 0x%x, size 0x%lx, width %d\n", 
+	       name, doccs_base, 
+	       scx200_docflash_map.size, scx200_docflash_map.buswidth);
+
+	scx200_docflash_map.map_priv_1 = (unsigned long)ioremap(doccs_base, scx200_docflash_map.size);
+	if (!scx200_docflash_map.map_priv_1) {
+		printk(KERN_ERR "%s: failed to ioremap the flash\n", name);
+		return -EIO;
+	}
+
+	mymtd = do_map_probe("cfi_probe", &scx200_docflash_map);
+	if (!mymtd) {
+		printk(KERN_ERR "%s: unable to detect flash\n", name);
+		iounmap((void *)scx200_docflash_map.map_priv_1);
+		return -ENXIO;
+	}
+
+	mymtd->module = THIS_MODULE;
+
+	if (partition) {
+		partition_info[3].offset = mymtd->size-partition_info[3].size;
+		partition_info[2].size = partition_info[3].offset-partition_info[2].offset;
+		add_mtd_partitions(mymtd, partition_info, NUM_PARTITIONS);
+	} else {
+		add_mtd_device(mymtd);
+	}
+	return 0;
+}
+
+static void __exit cleanup_scx200_docflash(void)
+{
+	if (mymtd) {
+		if (partition)
+			del_mtd_partitions(mymtd);
+		del_mtd_device(mymtd);
+		map_destroy(mymtd);
+	}
+	if (scx200_docflash_map.map_priv_1) {
+		iounmap((void *)scx200_docflash_map.map_priv_1);
+		scx200_docflash_map.map_priv_1 = 0;
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
diff -urN linux-2.4.19-pre2/include/linux/pci_ids.h linux/include/linux/pci_ids.h
--- linux-2.4.19-pre2/include/linux/pci_ids.h	Sat Mar  2 14:47:39 2002
+++ linux/include/linux/pci_ids.h	Sat Mar  2 15:27:42 2002
@@ -287,6 +287,12 @@
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
diff -urN linux-2.4.19-pre2/include/linux/scx200.h linux/include/linux/scx200.h
--- linux-2.4.19-pre2/include/linux/scx200.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/scx200.h	Sat Mar  2 15:27:42 2002
@@ -0,0 +1,110 @@
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+
+/* Configuation block */
+#define SCx200_PMR	0x30
+#define SCx200_MCR	0x34	/* Miscellaneous Configuration Register */
+
+/* scx200_main.c */
+
+extern struct pci_dev *scx200_f0_pdev;
+extern struct pci_dev *scx200_f5_pdev;
+extern unsigned scx200_config_block;
+
+/* GPIO */
+
+u32 scx200_gpio_configure(int index, u32 set, u32 clear);
+void scx200_gpio_dump(unsigned index);
+
+extern unsigned scx200_gpio_base;
+extern spinlock_t scx200_gpio_lock;
+extern u32 scx200_gpio_shadow[2];
+extern u32 *dummy;
+
+/* Definitions to make sure I do the same thing in all functions */
+#define __SCx200_GPIO_BANK unsigned bank = index>>5
+#define __SCx200_GPIO_IOADDR unsigned short ioaddr = scx200_gpio_base+0x10*bank
+#define __SCx200_GPIO_SHADOW u32 *shadow = scx200_gpio_shadow+bank
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
+        compile-command: "cd ../../.. && ./build.sh fast "
+        c-basic-offset: 8
+    End:
+*/
diff -urN linux-2.4.19-pre2/init/main.c linux/init/main.c
--- linux-2.4.19-pre2/init/main.c	Sat Mar  2 14:47:39 2002
+++ linux/init/main.c	Sat Mar  2 15:27:44 2002
@@ -94,6 +94,7 @@
 extern void sysctl_init(void);
 extern void signals_init(void);
 extern int init_pcmcia_ds(void);
+extern int scx200_init(void);
 
 extern void free_initmem(void);
 
@@ -514,6 +515,9 @@
 #endif
 #ifdef CONFIG_TC
 	tc_init();
+#endif
+#ifdef CONFIG_ARCH_SCx200
+	scx200_init();
 #endif
 
 	/* Networking initialization needs a process context */ 
--++----------20020302165603-041624518----------++--
