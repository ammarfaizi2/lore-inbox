Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVCOVtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVCOVtD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 16:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVCOVtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 16:49:03 -0500
Received: from asia.telenet-ops.be ([195.130.132.59]:44673 "EHLO
	asia.telenet-ops.be") by vger.kernel.org with ESMTP id S261880AbVCOVqo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 16:46:44 -0500
Date: Tue, 15 Mar 2005 22:46:34 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] linux-2.6-watchdog-mm patches
Message-ID: <20050315214634.GC4909@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog-mm

This will update the following files:

 drivers/char/watchdog/Kconfig       |   14 
 drivers/char/watchdog/Makefile      |   86 +++---
 drivers/char/watchdog/i6300esb.c    |  508 ++++++++++++++++++++++++++++++++++++
 drivers/char/watchdog/i6300esb.h    |   62 ++++
 drivers/char/watchdog/i8xx_tco.c    |    1 
 drivers/char/watchdog/ixp2000_wdt.c |    2 
 drivers/char/watchdog/ixp4xx_wdt.c  |    2 
 drivers/char/watchdog/mv64x60_wdt.c |  252 +++++++++++++++++
 drivers/char/watchdog/pcwd_pci.c    |    6 
 drivers/char/watchdog/pcwd_usb.c    |    6 
 drivers/char/watchdog/s3c2410_wdt.c |   95 ++++--
 drivers/char/watchdog/sa1100_wdt.c  |    2 
 drivers/char/watchdog/scx200_wdt.c  |    2 
 include/asm-ppc/mv64x60.h           |    8 
 14 files changed, 969 insertions(+), 77 deletions(-)

through these ChangeSets:

<wim@iguana.be> (05/03/15 1.2187)
   [WATCHDOG] pcwd_usb: usb_control_msg-timeout-patch
   
   set timeout in usb_control_msg to USB_COMMAND_TIMEOUT instead of a
   full second.

<ben-linux@fluff.org> (05/03/15 1.2188)
   [WATCHDOG] s3c2410-divide-patch
   
   The s3c2410 watchdog driver has an incorrect /2
   in the timer calculation, fix this problem
   
   Signed-off-by: Ben Dooks <ben-linux@fluff.org>

<wim@iguana.be> (05/03/15 1.2189)
   [WATCHDOG] pcwd_pci-register-driver-patch
   
   convert from pci_module_init to pci_register_driver
   
   Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
   Signed-off-by: Domen Puncer <domen@coderock.org>
   Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

<davej@redhat.com> (05/03/15 1.2190)
   [WATCHDOG] Makefile-patch
   
   The comment at the top of the Makefile suggests that the current
   ordering is incorrect.
   
   Signed-off-by: Dave Jones <davej@redhat.com>
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

<wim@iguana.be> (05/03/15 1.2191)
   [WATCHDOG] correct sysfs name for watchdog devices
   
   While looking for possible candidates for our udev.rules package,
   I found a few odd ->name properties. /dev/watchdog has minor 130
   according to devices.txt. Since all watchdog drivers use the
   misc_register() call, they will end up in /sys/class/misc/$foo.
   udev may create the /dev/watchdog node if the driver is loaded.
   I dont have such a device, so I cant test it.
   The drivers below provide names with spaces and even with / in it.
   Not a big deal, but apps may expect /dev/watchdog.
   
   Signed-off-by: Olaf Hering <olh@suse.de>
   Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

<jchapman@katalix.com> (05/03/15 1.2192)
   [WATCHDOG] mv64x60_wdt.patch
   
   Add mv64x60 (Marvell Discovery) watchdog support.
   
   Signed-off-by: James Chapman <jchapman@katalix.com>

<david@2gen.com> (05/03/15 1.2193)
   [WATCHDOG] i6300esb.patch
   
   From: David Hardeman <david@2gen.com>
   
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
   
   Signed-off-by: Andrew Morton <akpm@osdl.org>

<david@2gen.com> (05/03/15 1.2194)
   From: David Hardeman <david@2gen.com>
   
   Add support for the intel 6300ESB chipset.

<ben-linux@fluff.org> (05/03/15 1.2195)
   [WATCHDOG] s3c2410 watchdog power management
   
   Patch from Dimitry Andric <dimitry.andric@tomtom.com>, updated
   by Ben Dooks <ben-linux@fluff.org>. Patch is against 2.6.11-mm2
   
   Add power management support to the s3c2410 watchdog, so that
   it is shut-down over suspend, and re-initialised on resume.
   
   Also add Dimitry to the list of authors.
   
   Signed-off-by: Dimitry Andric <dimitry.andric@tomtom.com>
   Signed-off-by: Ben Dooks <ben-linux@fluff.org>

<ben-linux@fluff.org> (05/03/15 1.2196)
   [WATCHDOG] s3c2410 watchdog - replace reboot notifier
   
   Patch from Dimitry Andric <dimitry.andric@tomtom.com>
   
   Change to using platfrom driver's .shutdown method instead
   of an reboot notifier
   
   Signed-off-by: Dimitry Andric <dimitry.andric@tomtom.com>
   Signed-off-by: Ben Dooks <ben-linux@fluff.org>

<wim@iguana.be> (05/03/15 1.2197)
   [WATCHDOG] Makefile-probe_order-patch
   
   Re-arrange Makefile according to what we want to probe first.


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog-mm

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/pcwd_usb.c b/drivers/char/watchdog/pcwd_usb.c
--- a/drivers/char/watchdog/pcwd_usb.c	2005-03-15 22:44:05 +01:00
+++ b/drivers/char/watchdog/pcwd_usb.c	2005-03-15 22:44:05 +01:00
@@ -56,8 +56,8 @@
 
 
 /* Module and Version Information */
-#define DRIVER_VERSION "1.00"
-#define DRIVER_DATE "12 Jun 2004"
+#define DRIVER_VERSION "1.01"
+#define DRIVER_DATE "15 Mar 2005"
 #define DRIVER_AUTHOR "Wim Van Sebroeck <wim@iguana.be>"
 #define DRIVER_DESC "Berkshire USB-PC Watchdog driver"
 #define DRIVER_LICENSE "GPL"
@@ -227,7 +227,7 @@
 	if (usb_control_msg(usb_pcwd->udev, usb_sndctrlpipe(usb_pcwd->udev, 0),
 			HID_REQ_SET_REPORT, HID_DT_REPORT,
 			0x0200, usb_pcwd->interface_number, buf, sizeof(buf),
-			1000) != sizeof(buf)) {
+			USB_COMMAND_TIMEOUT) != sizeof(buf)) {
 		dbg("usb_pcwd_send_command: error in usb_control_msg for cmd 0x%x 0x%x 0x%x\n", cmd, *msb, *lsb);
 	}
 	/* wait till the usb card processed the command,
diff -Nru a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
--- a/drivers/char/watchdog/s3c2410_wdt.c	2005-03-15 22:44:08 +01:00
+++ b/drivers/char/watchdog/s3c2410_wdt.c	2005-03-15 22:44:08 +01:00
@@ -27,6 +27,8 @@
  *				Fixed tmr_count / wdt_count confusion
  *				Added configurable debug
  *
+ *	11-Jan-2004	BJD	Fixed divide-by-2 in timeout code
+ *
  *	10-Mar-2005	LCVR	Changed S3C2410_VA to S3C24XX_VA
 */
 
@@ -165,11 +167,7 @@
 	if (timeout < 1)
 		return -EINVAL;
 
-	/* I think someone must have missed a divide-by-2 in the 2410,
-	 * as a divisor of 128 gives half the calculated delay...
-	 */
-
-	freq /= 128/2;
+	freq /= 128;
 	count = timeout * freq;
 
 	DBG("%s: count=%d, timeout=%d, freq=%d\n",
diff -Nru a/drivers/char/watchdog/pcwd_pci.c b/drivers/char/watchdog/pcwd_pci.c
--- a/drivers/char/watchdog/pcwd_pci.c	2005-03-15 22:44:11 +01:00
+++ b/drivers/char/watchdog/pcwd_pci.c	2005-03-15 22:44:11 +01:00
@@ -48,8 +48,8 @@
 #include <asm/io.h>
 
 /* Module and version information */
-#define WATCHDOG_VERSION "1.00"
-#define WATCHDOG_DATE "12 Jun 2004"
+#define WATCHDOG_VERSION "1.01"
+#define WATCHDOG_DATE "15 Mar 2005"
 #define WATCHDOG_DRIVER_NAME "PCI-PC Watchdog"
 #define WATCHDOG_NAME "pcwd_pci"
 #define PFX WATCHDOG_NAME ": "
@@ -659,7 +659,7 @@
 {
 	spin_lock_init (&pcipcwd_private.io_lock);
 
-	return pci_module_init(&pcipcwd_driver);
+	return pci_register_driver(&pcipcwd_driver);
 }
 
 static void __exit pcipcwd_cleanup_module(void)
diff -Nru a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	2005-03-15 22:44:14 +01:00
+++ b/drivers/char/watchdog/Makefile	2005-03-15 22:44:14 +01:00
@@ -2,11 +2,6 @@
 # Makefile for the WatchDog device drivers.
 #
 
-# Only one watchdog can succeed. We probe the hardware watchdog
-# drivers first, then the softdog driver.  This means if your hardware
-# watchdog dies or is 'borrowed' for some reason the software watchdog
-# still gives you some cover.
-
 obj-$(CONFIG_PCWATCHDOG) += pcwd.o
 obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
 obj-$(CONFIG_ADVANTECH_WDT) += advantechwdt.o
@@ -24,7 +19,6 @@
 obj-$(CONFIG_S3C2410_WATCHDOG) += s3c2410_wdt.o
 obj-$(CONFIG_SA1100_WATCHDOG) += sa1100_wdt.o
 obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
-obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
 obj-$(CONFIG_W83627HF_WDT) += w83627hf_wdt.o
 obj-$(CONFIG_SC520_WDT) += sc520_wdt.o
@@ -39,3 +33,10 @@
 obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
 obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
+
+# Only one watchdog can succeed. We probe the hardware watchdog
+# drivers first, then the softdog driver.  This means if your hardware
+# watchdog dies or is 'borrowed' for some reason the software watchdog
+# still gives you some cover.
+
+obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
diff -Nru a/drivers/char/watchdog/ixp2000_wdt.c b/drivers/char/watchdog/ixp2000_wdt.c
--- a/drivers/char/watchdog/ixp2000_wdt.c	2005-03-15 22:44:17 +01:00
+++ b/drivers/char/watchdog/ixp2000_wdt.c	2005-03-15 22:44:17 +01:00
@@ -186,7 +186,7 @@
 static struct miscdevice ixp2000_wdt_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "IXP2000 Watchdog",
+	.name		= "watchdog",
 	.fops		= &ixp2000_wdt_fops,
 };
 
diff -Nru a/drivers/char/watchdog/ixp4xx_wdt.c b/drivers/char/watchdog/ixp4xx_wdt.c
--- a/drivers/char/watchdog/ixp4xx_wdt.c	2005-03-15 22:44:17 +01:00
+++ b/drivers/char/watchdog/ixp4xx_wdt.c	2005-03-15 22:44:17 +01:00
@@ -180,7 +180,7 @@
 static struct miscdevice ixp4xx_wdt_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "IXP4xx Watchdog",
+	.name		= "watchdog",
 	.fops		= &ixp4xx_wdt_fops,
 };
 
diff -Nru a/drivers/char/watchdog/sa1100_wdt.c b/drivers/char/watchdog/sa1100_wdt.c
--- a/drivers/char/watchdog/sa1100_wdt.c	2005-03-15 22:44:17 +01:00
+++ b/drivers/char/watchdog/sa1100_wdt.c	2005-03-15 22:44:17 +01:00
@@ -176,7 +176,7 @@
 static struct miscdevice sa1100dog_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "SA1100/PXA2xx watchdog",
+	.name		= "watchdog",
 	.fops		= &sa1100dog_fops,
 };
 
diff -Nru a/drivers/char/watchdog/scx200_wdt.c b/drivers/char/watchdog/scx200_wdt.c
--- a/drivers/char/watchdog/scx200_wdt.c	2005-03-15 22:44:17 +01:00
+++ b/drivers/char/watchdog/scx200_wdt.c	2005-03-15 22:44:17 +01:00
@@ -210,7 +210,7 @@
 
 static struct miscdevice scx200_wdt_miscdev = {
 	.minor = WATCHDOG_MINOR,
-	.name  = NAME,
+	.name  = "watchdog",
 	.fops  = &scx200_wdt_fops,
 };
 
diff -Nru a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig	2005-03-15 22:44:20 +01:00
+++ b/drivers/char/watchdog/Kconfig	2005-03-15 22:44:20 +01:00
@@ -346,6 +346,10 @@
 	tristate "MPC8xx Watchdog Timer"
 	depends on WATCHDOG && 8xx
 
+config MV64X60_WDT
+	tristate "MV64X60 (Marvell Discovery) Watchdog Timer"
+	depends on WATCHDOG && MV64X60
+
 # MIPS Architecture
 
 config INDYDOG
diff -Nru a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	2005-03-15 22:44:20 +01:00
+++ b/drivers/char/watchdog/Makefile	2005-03-15 22:44:20 +01:00
@@ -33,6 +33,7 @@
 obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
 obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
+obj-$(CONFIG_MV64X60_WDT) += mv64x60_wdt.o
 
 # Only one watchdog can succeed. We probe the hardware watchdog
 # drivers first, then the softdog driver.  This means if your hardware
diff -Nru a/drivers/char/watchdog/mv64x60_wdt.c b/drivers/char/watchdog/mv64x60_wdt.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/char/watchdog/mv64x60_wdt.c	2005-03-15 22:44:20 +01:00
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
diff -Nru a/include/asm-ppc/mv64x60.h b/include/asm-ppc/mv64x60.h
--- a/include/asm-ppc/mv64x60.h	2005-03-15 22:44:20 +01:00
+++ b/include/asm-ppc/mv64x60.h	2005-03-15 22:44:20 +01:00
@@ -119,6 +119,14 @@
 
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
diff -Nru a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig	2005-03-15 22:44:23 +01:00
+++ b/drivers/char/watchdog/Kconfig	2005-03-15 22:44:23 +01:00
@@ -252,6 +252,16 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called i8xx_tco.
 
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
 config SC1200_WDT
 	tristate "National Semiconductor PC87307/PC97307 (ala SC1200) Watchdog"
 	depends on WATCHDOG && X86
diff -Nru a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	2005-03-15 22:44:23 +01:00
+++ b/drivers/char/watchdog/Makefile	2005-03-15 22:44:23 +01:00
@@ -14,6 +14,7 @@
 obj-$(CONFIG_21285_WATCHDOG) += wdt285.o
 obj-$(CONFIG_977_WATCHDOG) += wdt977.o
 obj-$(CONFIG_I8XX_TCO) += i8xx_tco.o
+obj-$(CONFIG_I6300ESB_WDT) += i6300esb.o
 obj-$(CONFIG_MACHZ_WDT) += machzwd.o
 obj-$(CONFIG_SH_WDT) += shwdt.o
 obj-$(CONFIG_S3C2410_WATCHDOG) += s3c2410_wdt.o
diff -Nru a/drivers/char/watchdog/i6300esb.c b/drivers/char/watchdog/i6300esb.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/char/watchdog/i6300esb.c	2005-03-15 22:44:23 +01:00
@@ -0,0 +1,508 @@
+/*
+ *	i6300esb 0.03:	Watchdog timer driver for Intel 6300ESB chipset
+ *
+ *	(c) Copyright 2004 Google Inc.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *      based on i810-tco.c which is
+ *
+ *	(c) Copyright 2000	kernel concepts <nils@kernelconcepts.de>
+ *				developed for
+ *                              Jentro AG, Haar/Munich (Germany)
+ *
+ * 	which is in turn based on softdog.c by Alan Cox <alan@redhat.com>
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
+#include "i6300esb.h"
+
+/* Module and version information */
+#define ESB_VERSION "0.03"
+#define ESB_MODULE_NAME "i6300ESB timer"
+#define ESB_DRIVER_NAME ESB_MODULE_NAME ", v" ESB_VERSION
+#define PFX ESB_MODULE_NAME ": "
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
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
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
+	val = 0x02 | nowayout ? 0x01 : 0x00;
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
+	writew(0x10, ESB_RELOAD_REG);
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
+	writew(0x10, ESB_RELOAD_REG);
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
+	writew(0x10, ESB_RELOAD_REG);
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
+        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_9, PCI_ANY_ID, PCI_ANY_ID, },
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
+        while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+                if (pci_match_device(esb_pci_tbl, dev)) {
+                        esb_pci = dev;
+                        break;
+                }
+        }
+
+        if (esb_pci) {
+        	if (pci_enable_device(esb_pci)) {
+			printk (KERN_ERR PFX "failed to enable device\n");
+			goto out;
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
+	}
+out:
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
+/* out: */
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
+}
+
+module_init(watchdog_init);
+module_exit(watchdog_cleanup);
+
+MODULE_AUTHOR("Ross Biro and David Härdeman");
+MODULE_DESCRIPTION("Watchdog driver for Intel 6300ESB chipsets");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff -Nru a/drivers/char/watchdog/i6300esb.h b/drivers/char/watchdog/i6300esb.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/char/watchdog/i6300esb.h	2005-03-15 22:44:23 +01:00
@@ -0,0 +1,62 @@
+/*
+ *	i8xx_tco:	TCO timer driver for i8xx chipsets
+ *
+ *	(c) Copyright 2000 kernel concepts <nils@kernelconcepts.de>, All Rights Reserved.
+ *				http://www.kernelconcepts.de
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	Neither kernel concepts nor Nils Faerber admit liability nor provide
+ *	warranty for any of this software. This material is provided
+ *	"AS-IS" and at no charge.
+ *
+ *	(c) Copyright 2000	kernel concepts <nils@kernelconcepts.de>
+ *				developed for
+ *                              Jentro AG, Haar/Munich (Germany)
+ *
+ *	TCO timer driver for i8xx chipsets
+ *	based on softdog.c by Alan Cox <alan@redhat.com>
+ *
+ *	For history and the complete list of supported I/O Controller Hub's
+ *	see i8xx_tco.c
+ */
+
+
+/*
+ * Some address definitions for the TCO
+ */
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
+
+/*
+ * Some register bits
+ */
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
+
+/*
+ * Some magic constants
+ */
+#define ESB_UNLOCK1     0x80            /* Step 1 to unlock reset registers  */
+#define ESB_UNLOCK2     0x86            /* Step 2 to unlock reset registers  */
diff -Nru a/drivers/char/watchdog/i8xx_tco.c b/drivers/char/watchdog/i8xx_tco.c
--- a/drivers/char/watchdog/i8xx_tco.c	2005-03-15 22:44:26 +01:00
+++ b/drivers/char/watchdog/i8xx_tco.c	2005-03-15 22:44:26 +01:00
@@ -382,6 +382,7 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_1,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_1,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },			/* End of list */
 };
 MODULE_DEVICE_TABLE (pci, i8xx_tco_pci_tbl);
diff -Nru a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
--- a/drivers/char/watchdog/s3c2410_wdt.c	2005-03-15 22:44:29 +01:00
+++ b/drivers/char/watchdog/s3c2410_wdt.c	2005-03-15 22:44:29 +01:00
@@ -27,7 +27,9 @@
  *				Fixed tmr_count / wdt_count confusion
  *				Added configurable debug
  *
- *	11-Jan-2004	BJD	Fixed divide-by-2 in timeout code
+ *	11-Jan-2005	BJD	Fixed divide-by-2 in timeout code
+ *
+ *	25-Jan-2005	DA	Added suspend/resume support
  *
  *	10-Mar-2005	LCVR	Changed S3C2410_VA to S3C24XX_VA
 */
@@ -484,15 +486,57 @@
 	return 0;
 }
 
+#ifdef CONFIG_PM
+
+static unsigned long wtcon_save;
+static unsigned long wtdat_save;
+
+static int s3c2410wdt_suspend(struct device *dev, u32 state, u32 level)
+{
+	if (level == SUSPEND_POWER_DOWN) {
+		/* Save watchdog state, and turn it off. */
+		wtcon_save = readl(wdt_base + S3C2410_WTCON);
+		wtdat_save = readl(wdt_base + S3C2410_WTDAT);
+
+		/* Note that WTCNT doesn't need to be saved. */
+		s3c2410wdt_stop();
+	}
+
+	return 0;
+}
+
+static int s3c2410wdt_resume(struct device *dev, u32 level)
+{
+	if (level == RESUME_POWER_ON) {
+		/* Restore watchdog state. */
+
+		writel(wtdat_save, wdt_base + S3C2410_WTDAT);
+		writel(wtdat_save, wdt_base + S3C2410_WTCNT); /* Reset count */
+		writel(wtcon_save, wdt_base + S3C2410_WTCON);
+
+		printk(KERN_INFO PFX "watchdog %sabled\n",
+		       (wtcon_save & S3C2410_WTCON_ENABLE) ? "en" : "dis");
+	}
+
+	return 0;
+}
+
+#else
+#define s3c2410wdt_suspend NULL
+#define s3c2410wdt_resume  NULL
+#endif /* CONFIG_PM */
+
+
 static struct device_driver s3c2410wdt_driver = {
 	.name		= "s3c2410-wdt",
 	.bus		= &platform_bus_type,
 	.probe		= s3c2410wdt_probe,
 	.remove		= s3c2410wdt_remove,
+	.suspend	= s3c2410wdt_suspend,
+	.resume		= s3c2410wdt_resume,
 };
 
 
-
 static char banner[] __initdata = KERN_INFO "S3C2410 Watchdog Timer, (c) 2004 Simtec Electronics\n";
 
 static int __init watchdog_init(void)
@@ -510,7 +554,8 @@
 module_init(watchdog_init);
 module_exit(watchdog_exit);
 
-MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>, "
+	      "Dimitry Andric <dimitry.andric@tomtom.com>");
 MODULE_DESCRIPTION("S3C2410 Watchdog Device Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff -Nru a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
--- a/drivers/char/watchdog/s3c2410_wdt.c	2005-03-15 22:44:31 +01:00
+++ b/drivers/char/watchdog/s3c2410_wdt.c	2005-03-15 22:44:31 +01:00
@@ -30,6 +30,7 @@
  *	11-Jan-2005	BJD	Fixed divide-by-2 in timeout code
  *
  *	25-Jan-2005	DA	Added suspend/resume support
+ *				Replaced reboot notifier with .shutdown method
  *
  *	10-Mar-2005	LCVR	Changed S3C2410_VA to S3C24XX_VA
 */
@@ -42,8 +43,6 @@
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/fs.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
@@ -324,20 +323,6 @@
 	}
 }
 
-/*
- *	Notifier for system down
- */
-
-static int s3c2410wdt_notify_sys(struct notifier_block *this, unsigned long code,
-			      void *unused)
-{
-	if(code==SYS_DOWN || code==SYS_HALT) {
-		/* Turn the WDT off */
-		s3c2410wdt_stop();
-	}
-	return NOTIFY_DONE;
-}
-
 /* kernel interface */
 
 static struct file_operations s3c2410wdt_fops = {
@@ -355,10 +340,6 @@
 	.fops		= &s3c2410wdt_fops,
 };
 
-static struct notifier_block s3c2410wdt_notifier = {
-	.notifier_call	= s3c2410wdt_notify_sys,
-};
-
 /* interrupt handler code */
 
 static irqreturn_t s3c2410wdt_irq(int irqno, void *param,
@@ -439,18 +420,10 @@
 		}
 	}
 
-	ret = register_reboot_notifier(&s3c2410wdt_notifier);
-	if (ret) {
-		printk (KERN_ERR PFX "cannot register reboot notifier (%d)\n",
-			ret);
-		return ret;
-	}
-
 	ret = misc_register(&s3c2410wdt_miscdev);
 	if (ret) {
 		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (%d)\n",
 			WATCHDOG_MINOR, ret);
-		unregister_reboot_notifier(&s3c2410wdt_notifier);
 		return ret;
 	}
 
@@ -486,6 +459,11 @@
 	return 0;
 }
 
+static void s3c2410wdt_shutdown(struct device *dev)
+{
+	s3c2410wdt_stop();	
+}
+
 #ifdef CONFIG_PM
 
 static unsigned long wtcon_save;
@@ -532,6 +510,7 @@
 	.bus		= &platform_bus_type,
 	.probe		= s3c2410wdt_probe,
 	.remove		= s3c2410wdt_remove,
+	.shutdown	= s3c2410wdt_shutdown,
 	.suspend	= s3c2410wdt_suspend,
 	.resume		= s3c2410wdt_resume,
 };
@@ -548,7 +527,6 @@
 static void __exit watchdog_exit(void)
 {
 	driver_unregister(&s3c2410wdt_driver);
-	unregister_reboot_notifier(&s3c2410wdt_notifier);
 }
 
 module_init(watchdog_init);
diff -Nru a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	2005-03-15 22:44:34 +01:00
+++ b/drivers/char/watchdog/Makefile	2005-03-15 22:44:34 +01:00
@@ -2,43 +2,66 @@
 # Makefile for the WatchDog device drivers.
 #
 
+# Only one watchdog can succeed. We probe the ISA/PCI/USB based
+# watchdog-cards first, then the architecture specific watchdog
+# drivers and then the architecture independant "softdog" driver.
+# This means that if your ISA/PCI/USB card isn't detected that
+# you can fall back to an architecture specific driver and if
+# that also fails then you can fall back to the software watchdog
+# to give you some cover.
+
+# ISA-based Watchdog Cards
 obj-$(CONFIG_PCWATCHDOG) += pcwd.o
-obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
-obj-$(CONFIG_ADVANTECH_WDT) += advantechwdt.o
-obj-$(CONFIG_IB700_WDT) += ib700wdt.o
 obj-$(CONFIG_MIXCOMWD) += mixcomwd.o
-obj-$(CONFIG_SCx200_WDT) += scx200_wdt.o
-obj-$(CONFIG_60XX_WDT) += sbc60xxwdt.o
 obj-$(CONFIG_WDT) += wdt.o
+
+# PCI-based Watchdog Cards
+obj-$(CONFIG_PCIPCWATCHDOG) += pcwd_pci.o
 obj-$(CONFIG_WDTPCI) += wdt_pci.o
+
+# USB-based Watchdog Cards
+obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
+
+# ARM Architecture
 obj-$(CONFIG_21285_WATCHDOG) += wdt285.o
 obj-$(CONFIG_977_WATCHDOG) += wdt977.o
-obj-$(CONFIG_I8XX_TCO) += i8xx_tco.o
-obj-$(CONFIG_I6300ESB_WDT) += i6300esb.o
-obj-$(CONFIG_MACHZ_WDT) += machzwd.o
-obj-$(CONFIG_SH_WDT) += shwdt.o
+obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
+obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
 obj-$(CONFIG_S3C2410_WATCHDOG) += s3c2410_wdt.o
 obj-$(CONFIG_SA1100_WATCHDOG) += sa1100_wdt.o
-obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
-obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
-obj-$(CONFIG_W83627HF_WDT) += w83627hf_wdt.o
-obj-$(CONFIG_SC520_WDT) += sc520_wdt.o
-obj-$(CONFIG_ALIM7101_WDT) += alim7101_wdt.o
+
+# X86 (i386 + ia64 + x86_64) Architecture
+obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
+obj-$(CONFIG_ADVANTECH_WDT) += advantechwdt.o
 obj-$(CONFIG_ALIM1535_WDT) += alim1535_wdt.o
-obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
+obj-$(CONFIG_ALIM7101_WDT) += alim7101_wdt.o
+obj-$(CONFIG_SC520_WDT) += sc520_wdt.o
+obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
+obj-$(CONFIG_IB700_WDT) += ib700wdt.o
 obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
+obj-$(CONFIG_I8XX_TCO) += i8xx_tco.o
+obj-$(CONFIG_I6300ESB_WDT) += i6300esb.o
+obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
+obj-$(CONFIG_SCx200_WDT) += scx200_wdt.o
+obj-$(CONFIG_60XX_WDT) += sbc60xxwdt.o
 obj-$(CONFIG_CPU5_WDT) += cpu5wdt.o
-obj-$(CONFIG_INDYDOG) += indydog.o
-obj-$(CONFIG_PCIPCWATCHDOG) += pcwd_pci.o
-obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
-obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
-obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
+obj-$(CONFIG_W83627HF_WDT) += w83627hf_wdt.o
+obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
+obj-$(CONFIG_MACHZ_WDT) += machzwd.o
+
+# PowerPC Architecture
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
 obj-$(CONFIG_MV64X60_WDT) += mv64x60_wdt.o
 
-# Only one watchdog can succeed. We probe the hardware watchdog
-# drivers first, then the softdog driver.  This means if your hardware
-# watchdog dies or is 'borrowed' for some reason the software watchdog
-# still gives you some cover.
+# MIPS Architecture
+obj-$(CONFIG_INDYDOG) += indydog.o
+
+# S390 Architecture
+
+# SUPERH Architecture
+obj-$(CONFIG_SH_WDT) += shwdt.o
+
+# SPARC64 Architecture
 
+# Architecture Independant
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
