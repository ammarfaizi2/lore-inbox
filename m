Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267872AbUHWWhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267872AbUHWWhq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUHWUBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:01:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:40387 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266615AbUHWSgJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:09 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286090598@kroah.com>
Date: Mon, 23 Aug 2004 11:34:50 -0700
Message-Id: <10932860903579@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.59.3, 2004/08/05 13:11:29-07:00, greg@kroah.com

I2C: convert all drivers from MODULE_PARM to module_param


 drivers/i2c/algos/i2c-algo-bit.c       |    4 ++--
 drivers/i2c/algos/i2c-algo-ite.c       |   14 ++++----------
 drivers/i2c/algos/i2c-algo-pcf.c       |    6 ++----
 drivers/i2c/busses/i2c-ali15x3.c       |    4 ++--
 drivers/i2c/busses/i2c-elektor.c       |   10 +++++-----
 drivers/i2c/busses/i2c-i801.c          |    4 ++--
 drivers/i2c/busses/i2c-ibm_iic.c       |    8 ++++----
 drivers/i2c/busses/i2c-ite.c           |   16 ++++++++--------
 drivers/i2c/busses/i2c-keywest.c       |    4 ++--
 drivers/i2c/busses/i2c-parport-light.c |    4 ++--
 drivers/i2c/busses/i2c-parport.h       |    2 +-
 drivers/i2c/busses/i2c-sis5595.c       |    4 ++--
 drivers/i2c/busses/i2c-sis630.c        |   14 +++++++-------
 drivers/i2c/busses/i2c-viapro.c        |    6 +++---
 drivers/i2c/busses/scx200_acb.c        |    3 ++-
 drivers/i2c/busses/scx200_i2c.c        |    4 ++--
 drivers/i2c/chips/adm1021.c            |    2 +-
 drivers/i2c/chips/ds1621.c             |    2 +-
 drivers/i2c/chips/eeprom.c             |    2 +-
 drivers/i2c/chips/it87.c               |    4 ++--
 drivers/i2c/chips/pcf8591.c            |    2 +-
 drivers/i2c/chips/rtc8564.c            |    4 ++--
 drivers/i2c/chips/via686a.c            |    4 ++--
 drivers/i2c/chips/w83627hf.c           |   10 +++++-----
 drivers/i2c/chips/w83781d.c            |    2 +-
 include/linux/i2c.h                    |    4 +++-
 26 files changed, 69 insertions(+), 74 deletions(-)


diff -Nru a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
--- a/drivers/i2c/algos/i2c-algo-bit.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/algos/i2c-algo-bit.c	2004-08-23 11:05:32 -07:00
@@ -565,8 +565,8 @@
 MODULE_DESCRIPTION("I2C-Bus bit-banging algorithm");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(bit_test, "i");
-MODULE_PARM(i2c_debug,"i");
+module_param(bit_test, bool, 0);
+module_param(i2c_debug, int, S_IRUGO | S_IWUSR);
 
 MODULE_PARM_DESC(bit_test, "Test the lines of the bus to see if it is stuck");
 MODULE_PARM_DESC(i2c_debug,
diff -Nru a/drivers/i2c/algos/i2c-algo-ite.c b/drivers/i2c/algos/i2c-algo-ite.c
--- a/drivers/i2c/algos/i2c-algo-ite.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/algos/i2c-algo-ite.c	2004-08-23 11:05:32 -07:00
@@ -52,21 +52,15 @@
 #define	PM_IBSR		IT8172_PCI_IO_BASE + IT_PM_DSR + 0x04 
 #define GPIO_CCR	IT8172_PCI_IO_BASE + IT_GPCCR
 
-/* ----- global defines ----------------------------------------------- */
-#define DEB(x) if (i2c_debug>=1) x
 #define DEB2(x) if (i2c_debug>=2) x
 #define DEB3(x) if (i2c_debug>=3) x /* print several statistical values*/
-#define DEBPROTO(x) if (i2c_debug>=9) x;
- 	/* debug the protocol by showing transferred bits */
 #define DEF_TIMEOUT 16
 
 
-/* ----- global variables ---------------------------------------------	*/
-
 /* module parameters:
  */
-static int i2c_debug=1;
-static int iic_test=0;	/* see if the line-setting functions work	*/
+static int i2c_debug;
+static int iic_test;	/* see if the line-setting functions work	*/
 
 /* --- setting states on the bus with the right timing: ---------------	*/
 
@@ -804,8 +798,8 @@
 MODULE_DESCRIPTION("ITE iic algorithm");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(iic_test, "i");
-MODULE_PARM(i2c_debug,"i");
+module_param(iic_test, bool, 0);
+module_param(i2c_debug, int, S_IRUGO | S_IWUSR);
 
 MODULE_PARM_DESC(iic_test, "Test if the I2C bus is available");
 MODULE_PARM_DESC(i2c_debug,
diff -Nru a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
--- a/drivers/i2c/algos/i2c-algo-pcf.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/algos/i2c-algo-pcf.c	2004-08-23 11:05:32 -07:00
@@ -38,8 +38,6 @@
 #include "i2c-algo-pcf.h"
 
 
-/* ----- global defines ----------------------------------------------- */
-#define DEB(x) if (i2c_debug>=1) x
 #define DEB2(x) if (i2c_debug>=2) x
 #define DEB3(x) if (i2c_debug>=3) x /* print several statistical values*/
 #define DEBPROTO(x) if (i2c_debug>=9) x;
@@ -48,7 +46,7 @@
 
 /* module parameters:
  */
-static int i2c_debug=0;
+static int i2c_debug;
 
 /* --- setting states on the bus with the right timing: ---------------	*/
 
@@ -466,6 +464,6 @@
 MODULE_DESCRIPTION("I2C-Bus PCF8584 algorithm");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(i2c_debug,"i");
+module_param(i2c_debug, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(i2c_debug,
         "debug level - 0 off; 1 normal; 2,3 more verbose; 9 pcf-protocol");
diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/busses/i2c-ali15x3.c	2004-08-23 11:05:32 -07:00
@@ -126,8 +126,8 @@
 
 /* If force_addr is set to anything different from 0, we forcibly enable
    the device at the given address. */
-static int force_addr = 0;
-MODULE_PARM(force_addr, "i");
+static u16 force_addr = 0;
+module_param(force_addr, ushort, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Initialize the base address of the i2c controller");
 
diff -Nru a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- a/drivers/i2c/busses/i2c-elektor.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/busses/i2c-elektor.c	2004-08-23 11:05:32 -07:00
@@ -269,11 +269,11 @@
 MODULE_DESCRIPTION("I2C-Bus adapter routines for PCF8584 ISA bus adapter");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(base, "i");
-MODULE_PARM(irq, "i");
-MODULE_PARM(clock, "i");
-MODULE_PARM(own, "i");
-MODULE_PARM(mmapped, "i");
+module_param(base, int, 0);
+module_param(irq, int, 0);
+module_param(clock, int, 0);
+module_param(own, int, 0);
+module_param(mmapped, int, 0);
 
 module_init(i2c_pcfisa_init);
 module_exit(i2c_pcfisa_exit);
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/busses/i2c-i801.c	2004-08-23 11:05:32 -07:00
@@ -98,8 +98,8 @@
 
 /* If force_addr is set to anything different from 0, we forcibly enable
    the I801 at the given address. VERY DANGEROUS! */
-static int force_addr = 0;
-MODULE_PARM(force_addr, "i");
+static u16 force_addr;
+module_param(force_addr, ushort, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Forcibly enable the I801 at the given address. "
 		 "EXTREMELY DANGEROUS!");
diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	2004-08-23 11:05:32 -07:00
@@ -50,12 +50,12 @@
 MODULE_DESCRIPTION("IBM IIC driver v" DRIVER_VERSION);
 MODULE_LICENSE("GPL");
 
-static int iic_force_poll = 0;
-MODULE_PARM(iic_force_poll, "i");
+static int iic_force_poll;
+module_param(iic_force_poll, bool, 0);
 MODULE_PARM_DESC(iic_force_poll, "Force polling mode");
 
-static int iic_force_fast = 0;
-MODULE_PARM(iic_force_fast, "i");
+static int iic_force_fast;
+module_param(iic_force_fast, bool, 0);
 MODULE_PARM_DESC(iic_fast_poll, "Force fast mode (400 kHz)");
 
 #define DBG_LEVEL 0
diff -Nru a/drivers/i2c/busses/i2c-ite.c b/drivers/i2c/busses/i2c-ite.c
--- a/drivers/i2c/busses/i2c-ite.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/busses/i2c-ite.c	2004-08-23 11:05:32 -07:00
@@ -54,10 +54,10 @@
 #define DEFAULT_CLOCK 0x1b0e	/* default 16MHz/(27+14) = 400KHz */
 #define DEFAULT_OWN   0x55
 
-static int base  = 0;
-static int irq   = 0;
-static int clock = 0;
-static int own   = 0;
+static int base;
+static int irq;
+static int clock;
+static int own;
 
 static struct iic_ite gpi;
 static wait_queue_head_t iic_wait;
@@ -246,10 +246,10 @@
 MODULE_DESCRIPTION("I2C-Bus adapter routines for ITE IIC bus adapter");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(base, "i");
-MODULE_PARM(irq, "i");
-MODULE_PARM(clock, "i");
-MODULE_PARM(own, "i");
+module_param(base, int, 0);
+module_param(irq, int, 0);
+module_param(clock, int, 0);
+module_param(own, int, 0);
 
 
 /* Called when module is loaded or when kernel is initialized.
diff -Nru a/drivers/i2c/busses/i2c-keywest.c b/drivers/i2c/busses/i2c-keywest.c
--- a/drivers/i2c/busses/i2c-keywest.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/busses/i2c-keywest.c	2004-08-23 11:05:32 -07:00
@@ -91,9 +91,9 @@
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
 MODULE_DESCRIPTION("I2C driver for Apple's Keywest");
 MODULE_LICENSE("GPL");
-MODULE_PARM(probe, "i");
+module_param(probe, bool, 0);
 
-static int probe = 0;
+static int probe;
 
 #ifdef POLLED_MODE
 /* Don't schedule, the g5 fan controller is too
diff -Nru a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/i2c-parport-light.c
--- a/drivers/i2c/busses/i2c-parport-light.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/busses/i2c-parport-light.c	2004-08-23 11:05:32 -07:00
@@ -36,8 +36,8 @@
 
 #define DEFAULT_BASE 0x378
 
-static int base;
-MODULE_PARM(base, "i");
+static u16 base;
+module_param(base, ushort, 0);
 MODULE_PARM_DESC(base, "Base I/O address");
 
 /* ----- Low-level parallel port access ----------------------------------- */
diff -Nru a/drivers/i2c/busses/i2c-parport.h b/drivers/i2c/busses/i2c-parport.h
--- a/drivers/i2c/busses/i2c-parport.h	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/busses/i2c-parport.h	2004-08-23 11:05:32 -07:00
@@ -83,7 +83,7 @@
 };
 
 static int type;
-MODULE_PARM(type, "i");
+module_param(type, int, 0);
 MODULE_PARM_DESC(type,
 	"Type of adapter:\n"
 	" 0 = Philips adapter\n"
diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/busses/i2c-sis5595.c	2004-08-23 11:05:32 -07:00
@@ -124,8 +124,8 @@
 
 /* If force_addr is set to anything different from 0, we forcibly enable
    the device at the given address. */
-static int force_addr = 0;
-MODULE_PARM(force_addr, "i");
+static u16 force_addr = 0;
+module_param(force_addr, ushort, 0);
 MODULE_PARM_DESC(force_addr, "Initialize the base address of the i2c controller");
 
 static unsigned short sis5595_base = 0;
diff -Nru a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
--- a/drivers/i2c/busses/i2c-sis630.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/busses/i2c-sis630.c	2004-08-23 11:05:32 -07:00
@@ -94,11 +94,11 @@
 #define SIS630_BLOCK_DATA	0x05
 
 /* insmod parameters */
-static int high_clock = 0;
-static int force = 0;
-MODULE_PARM(high_clock, "i");
+static int high_clock;
+static int force;
+module_param(high_clock, bool, 0);
 MODULE_PARM_DESC(high_clock, "Set Host Master Clock to 56KHz (default 14KHz).");
-MODULE_PARM(force, "i");
+module_param(force, bool, 0);
 MODULE_PARM_DESC(force, "Forcibly enable the SIS630. DANGEROUS!");
 
 /* acpi base address */
@@ -145,7 +145,7 @@
 	dev_dbg(&adap->dev, "saved clock 0x%02x\n", *oldclock);
 
 	/* disable timeout interrupt , set Host Master Clock to 56KHz if requested */
-	if (high_clock > 0)
+	if (high_clock)
 		sis630_write(SMB_CNT, 0x20);
 	else
 		sis630_write(SMB_CNT, (*oldclock & ~0x40));
@@ -210,7 +210,7 @@
 	 * restore old Host Master Clock if high_clock is set
 	 * and oldclock was not 56KHz
 	 */
-	if (high_clock > 0 && !(oldclock & 0x20))
+	if (high_clock && !(oldclock & 0x20))
 		sis630_write(SMB_CNT,(sis630_read(SMB_CNT) & ~0x20));
 
 	dev_dbg(&adap->dev, "SMB_CNT after clock restore 0x%02x\n", sis630_read(SMB_CNT));
@@ -401,7 +401,7 @@
 	if (dummy) {
 		pci_dev_put(dummy);
 	}
-        else if (force > 0) {
+        else if (force) {
 		dev_err(&sis630_dev->dev, "WARNING: Can't detect SIS630 compatible device, but "
 			"loading because of force option enabled\n");
  	}
diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/busses/i2c-viapro.c	2004-08-23 11:05:32 -07:00
@@ -92,13 +92,13 @@
 /* If force is set to anything different from 0, we forcibly enable the
    VT596. DANGEROUS! */
 static int force;
-MODULE_PARM(force, "i");
+module_param(force, bool, 0);
 MODULE_PARM_DESC(force, "Forcibly enable the SMBus. DANGEROUS!");
 
 /* If force_addr is set to anything different from 0, we forcibly enable
    the VT596 at the given address. VERY DANGEROUS! */
-static int force_addr;
-MODULE_PARM(force_addr, "i");
+static u16 force_addr;
+module_param(force_addr, ushort, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Forcibly enable the SMBus at the given address. "
 		 "EXTREMELY DANGEROUS!");
diff -Nru a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
--- a/drivers/i2c/busses/scx200_acb.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/busses/scx200_acb.c	2004-08-23 11:05:32 -07:00
@@ -45,7 +45,8 @@
 
 #define MAX_DEVICES 4
 static int base[MAX_DEVICES] = { 0x820, 0x840 };
-MODULE_PARM(base, "1-4i");
+static int num_base;
+module_param_array(base, int, num_base, 0);
 MODULE_PARM_DESC(base, "Base addresses for the ACCESS.bus controllers");
 
 #ifdef DEBUG
diff -Nru a/drivers/i2c/busses/scx200_i2c.c b/drivers/i2c/busses/scx200_i2c.c
--- a/drivers/i2c/busses/scx200_i2c.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/busses/scx200_i2c.c	2004-08-23 11:05:32 -07:00
@@ -38,9 +38,9 @@
 MODULE_DESCRIPTION("NatSemi SCx200 I2C Driver");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(scl, "i");
+module_param(scl, int, 0);
 MODULE_PARM_DESC(scl, "GPIO line for SCL");
-MODULE_PARM(sda, "i");
+module_param(sda, int, 0);
 MODULE_PARM_DESC(sda, "GPIO line for SDA");
 
 static int scl = CONFIG_SCx200_I2C_SCL;
diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/chips/adm1021.c	2004-08-23 11:05:32 -07:00
@@ -418,7 +418,7 @@
 MODULE_DESCRIPTION("adm1021 driver");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(read_only, "i");
+module_param(read_only, bool, 0);
 MODULE_PARM_DESC(read_only, "Don't set any values, read only mode");
 
 module_init(sensors_adm1021_init)
diff -Nru a/drivers/i2c/chips/ds1621.c b/drivers/i2c/chips/ds1621.c
--- a/drivers/i2c/chips/ds1621.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/chips/ds1621.c	2004-08-23 11:05:32 -07:00
@@ -37,7 +37,7 @@
 /* Insmod parameters */
 SENSORS_INSMOD_1(ds1621);
 static int polarity = -1;
-MODULE_PARM(polarity, "i");
+module_param(polarity, int, 0);
 MODULE_PARM_DESC(polarity, "Output's polarity: 0 = active high, 1 = active low");
 
 /* Many DS1621 constants specified below */
diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/chips/eeprom.c	2004-08-23 11:05:32 -07:00
@@ -45,7 +45,7 @@
 SENSORS_INSMOD_1(eeprom);
 
 static int checksum = 0;
-MODULE_PARM(checksum, "i");
+module_param(checksum, bool, 0);
 MODULE_PARM_DESC(checksum, "Only accept eeproms whose checksum is correct");
 
 
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/chips/it87.c	2004-08-23 11:05:32 -07:00
@@ -938,9 +938,9 @@
 
 MODULE_AUTHOR("Chris Gauthron <chrisg@0-in.com>");
 MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
-MODULE_PARM(update_vbat, "i");
+module_param(update_vbat, bool, 0);
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
-MODULE_PARM(reset, "i");
+module_param(reset, bool, 0);
 MODULE_PARM_DESC(reset, "Reset the chip's registers, default no");
 MODULE_LICENSE("GPL");
 
diff -Nru a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
--- a/drivers/i2c/chips/pcf8591.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/chips/pcf8591.c	2004-08-23 11:05:32 -07:00
@@ -36,7 +36,7 @@
 SENSORS_INSMOD_1(pcf8591);
 
 static int input_mode;
-MODULE_PARM(input_mode, "i");
+module_param(input_mode, int, 0);
 MODULE_PARM_DESC(input_mode,
 	"Analog input mode:\n"
 	" 0 = four single ended inputs\n"
diff -Nru a/drivers/i2c/chips/rtc8564.c b/drivers/i2c/chips/rtc8564.c
--- a/drivers/i2c/chips/rtc8564.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/chips/rtc8564.c	2004-08-23 11:05:32 -07:00
@@ -56,8 +56,8 @@
 #define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
 #define BIN_TO_BCD(val) ((((val)/10)<<4) + (val)%10)
 
-static int debug = 0;
-MODULE_PARM(debug, "i");
+static int debug;;
+module_param(debug, int, S_IRUGO | S_IWUSR);
 
 static struct i2c_driver rtc8564_driver;
 
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/chips/via686a.c	2004-08-23 11:05:32 -07:00
@@ -43,8 +43,8 @@
 
 /* If force_addr is set to anything different from 0, we forcibly enable
    the device at the given address. */
-static int force_addr = 0;
-MODULE_PARM(force_addr, "i");
+static unsigned short force_addr = 0;
+module_param(force_addr, ushort, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Initialize the base address of the sensors");
 
diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/chips/w83627hf.c	2004-08-23 11:05:32 -07:00
@@ -46,12 +46,12 @@
 #include <asm/io.h>
 #include "lm75.h"
 
-static int force_addr;
-MODULE_PARM(force_addr, "i");
+static u16 force_addr;
+module_param(force_addr, ushort, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Initialize the base address of the sensors");
-static int force_i2c = 0x1f;
-MODULE_PARM(force_i2c, "i");
+static u8 force_i2c = 0x1f;
+module_param(force_i2c, byte, 0);
 MODULE_PARM_DESC(force_i2c,
 		 "Initialize the i2c address of the sensors");
 
@@ -65,7 +65,7 @@
 SENSORS_INSMOD_4(w83627hf, w83627thf, w83697hf, w83637hf);
 
 static int init = 1;
-MODULE_PARM(init, "i");
+module_param(init, bool, 0);
 MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
 
 /* modified from kernel/include/traps.c */
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	2004-08-23 11:05:32 -07:00
+++ b/drivers/i2c/chips/w83781d.c	2004-08-23 11:05:32 -07:00
@@ -60,7 +60,7 @@
 		    "{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
 static int init = 1;
-MODULE_PARM(init, "i");
+module_param(init, bool, 0);
 MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
 
 /* Constants specified below */
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2004-08-23 11:05:32 -07:00
+++ b/include/linux/i2c.h	2004-08-23 11:05:32 -07:00
@@ -566,7 +566,9 @@
 
 #define I2C_CLIENT_MODULE_PARM(var,desc) \
   static unsigned short var[I2C_CLIENT_MAX_OPTS] = I2C_CLIENT_DEFAULTS; \
-  MODULE_PARM(var,I2C_CLIENT_MODPARM); \
+  static unsigned int var##_num; \
+  /*MODULE_PARM(var,I2C_CLIENT_MODPARM);*/ \
+  module_param_array(var, short, var##_num, 0); \
   MODULE_PARM_DESC(var,desc)
 
 /* This is the one you want to use in your own modules */

