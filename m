Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUCPB37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbUCPB32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:29:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:30895 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262905AbUCPACi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:38 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <1079391394595@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:34 -0800
Message-Id: <10793913941866@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.74.10, 2004/03/15 10:27:26-08:00, greg@kroah.com

[PATCH] I2C: fix up CONFIG_I2C_DEBUG_BUS logic to be simpler on the .c files.


 drivers/i2c/busses/Makefile            |    4 ++++
 drivers/i2c/busses/i2c-ali1535.c       |    4 ----
 drivers/i2c/busses/i2c-ali15x3.c       |    4 ----
 drivers/i2c/busses/i2c-amd756.c        |    4 ----
 drivers/i2c/busses/i2c-amd8111.c       |    4 ----
 drivers/i2c/busses/i2c-elektor.c       |    4 ----
 drivers/i2c/busses/i2c-elv.c           |    4 ----
 drivers/i2c/busses/i2c-frodo.c         |    4 ----
 drivers/i2c/busses/i2c-i801.c          |    4 ----
 drivers/i2c/busses/i2c-i810.c          |    4 ----
 drivers/i2c/busses/i2c-ibm_iic.c       |    4 ----
 drivers/i2c/busses/i2c-iop3xx.c        |    4 ----
 drivers/i2c/busses/i2c-isa.c           |    4 ----
 drivers/i2c/busses/i2c-ite.c           |    4 ----
 drivers/i2c/busses/i2c-ixp42x.c        |    4 ----
 drivers/i2c/busses/i2c-keywest.c       |    4 ----
 drivers/i2c/busses/i2c-nforce2.c       |    4 ----
 drivers/i2c/busses/i2c-parport-light.c |    4 ----
 drivers/i2c/busses/i2c-parport.c       |    4 ----
 drivers/i2c/busses/i2c-philips-par.c   |    4 ----
 drivers/i2c/busses/i2c-piix4.c         |    4 ----
 drivers/i2c/busses/i2c-prosavage.c     |    4 ----
 drivers/i2c/busses/i2c-rpx.c           |    4 ----
 drivers/i2c/busses/i2c-savage4.c       |    4 ----
 drivers/i2c/busses/i2c-sis5595.c       |    4 ----
 drivers/i2c/busses/i2c-sis630.c        |    4 ----
 drivers/i2c/busses/i2c-sis96x.c        |    4 ----
 drivers/i2c/busses/i2c-velleman.c      |    4 ----
 drivers/i2c/busses/i2c-via.c           |    4 ----
 drivers/i2c/busses/i2c-viapro.c        |    4 ----
 drivers/i2c/busses/i2c-voodoo3.c       |    4 ----
 drivers/i2c/busses/scx200_acb.c        |    4 ----
 drivers/i2c/busses/scx200_i2c.c        |    4 ----
 33 files changed, 4 insertions(+), 128 deletions(-)


diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/Makefile	Mon Mar 15 14:34:28 2004
@@ -34,3 +34,7 @@
 obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
+
+ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-ali1535.c	Mon Mar 15 14:34:28 2004
@@ -54,10 +54,6 @@
 /* Note: we assume there can only be one ALI1535, with one SMBus interface */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Mon Mar 15 14:34:28 2004
@@ -61,10 +61,6 @@
 /* Note: we assume there can only be one ALI15X3, with one SMBus interface */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-amd756.c	Mon Mar 15 14:34:28 2004
@@ -38,10 +38,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-amd8111.c	Mon Mar 15 14:34:28 2004
@@ -9,10 +9,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- a/drivers/i2c/busses/i2c-elektor.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-elektor.c	Mon Mar 15 14:34:28 2004
@@ -26,10 +26,6 @@
    for Alpha Processor Inc. UP-2000(+) boards */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
diff -Nru a/drivers/i2c/busses/i2c-elv.c b/drivers/i2c/busses/i2c-elv.c
--- a/drivers/i2c/busses/i2c-elv.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-elv.c	Mon Mar 15 14:34:28 2004
@@ -22,10 +22,6 @@
    Frodo Looijaard <frodol@dds.nl> */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
diff -Nru a/drivers/i2c/busses/i2c-frodo.c b/drivers/i2c/busses/i2c-frodo.c
--- a/drivers/i2c/busses/i2c-frodo.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-frodo.c	Mon Mar 15 14:34:28 2004
@@ -13,10 +13,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-i801.c	Mon Mar 15 14:34:28 2004
@@ -39,10 +39,6 @@
 /* Note: we assume there can only be one I801, with one SMBus interface */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/busses/i2c-i810.c b/drivers/i2c/busses/i2c-i810.c
--- a/drivers/i2c/busses/i2c-i810.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-i810.c	Mon Mar 15 14:34:28 2004
@@ -35,10 +35,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	Mon Mar 15 14:34:28 2004
@@ -29,10 +29,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
diff -Nru a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
--- a/drivers/i2c/busses/i2c-iop3xx.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-iop3xx.c	Mon Mar 15 14:34:28 2004
@@ -32,10 +32,6 @@
   ---------------------------------------------------------------------------*/
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff -Nru a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
--- a/drivers/i2c/busses/i2c-isa.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-isa.c	Mon Mar 15 14:34:28 2004
@@ -25,10 +25,6 @@
    of this. */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/busses/i2c-ite.c b/drivers/i2c/busses/i2c-ite.c
--- a/drivers/i2c/busses/i2c-ite.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-ite.c	Mon Mar 15 14:34:28 2004
@@ -34,10 +34,6 @@
    Frodo Looijaard <frodol@dds.nl> */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
diff -Nru a/drivers/i2c/busses/i2c-ixp42x.c b/drivers/i2c/busses/i2c-ixp42x.c
--- a/drivers/i2c/busses/i2c-ixp42x.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-ixp42x.c	Mon Mar 15 14:34:28 2004
@@ -27,10 +27,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/device.h>
diff -Nru a/drivers/i2c/busses/i2c-keywest.c b/drivers/i2c/busses/i2c-keywest.c
--- a/drivers/i2c/busses/i2c-keywest.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-keywest.c	Mon Mar 15 14:34:28 2004
@@ -47,10 +47,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-nforce2.c	Mon Mar 15 14:34:28 2004
@@ -33,10 +33,6 @@
 /* Note: we assume there can only be one nForce2, with two SMBus interfaces */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/i2c-parport-light.c
--- a/drivers/i2c/busses/i2c-parport-light.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-parport-light.c	Mon Mar 15 14:34:28 2004
@@ -25,10 +25,6 @@
  * ------------------------------------------------------------------------ */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -Nru a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
--- a/drivers/i2c/busses/i2c-parport.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-parport.c	Mon Mar 15 14:34:28 2004
@@ -25,10 +25,6 @@
  * ------------------------------------------------------------------------ */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -Nru a/drivers/i2c/busses/i2c-philips-par.c b/drivers/i2c/busses/i2c-philips-par.c
--- a/drivers/i2c/busses/i2c-philips-par.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-philips-par.c	Mon Mar 15 14:34:28 2004
@@ -22,10 +22,6 @@
    Frodo Looijaard <frodol@dds.nl> */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-piix4.c	Mon Mar 15 14:34:28 2004
@@ -29,10 +29,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/config.h>
diff -Nru a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
--- a/drivers/i2c/busses/i2c-prosavage.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-prosavage.c	Mon Mar 15 14:34:28 2004
@@ -55,10 +55,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
diff -Nru a/drivers/i2c/busses/i2c-rpx.c b/drivers/i2c/busses/i2c-rpx.c
--- a/drivers/i2c/busses/i2c-rpx.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-rpx.c	Mon Mar 15 14:34:28 2004
@@ -12,10 +12,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -Nru a/drivers/i2c/busses/i2c-savage4.c b/drivers/i2c/busses/i2c-savage4.c
--- a/drivers/i2c/busses/i2c-savage4.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-savage4.c	Mon Mar 15 14:34:28 2004
@@ -30,10 +30,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-sis5595.c	Mon Mar 15 14:34:28 2004
@@ -56,10 +56,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff -Nru a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
--- a/drivers/i2c/busses/i2c-sis630.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-sis630.c	Mon Mar 15 14:34:28 2004
@@ -49,10 +49,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff -Nru a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
--- a/drivers/i2c/busses/i2c-sis96x.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-sis96x.c	Mon Mar 15 14:34:28 2004
@@ -33,10 +33,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/busses/i2c-velleman.c b/drivers/i2c/busses/i2c-velleman.c
--- a/drivers/i2c/busses/i2c-velleman.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-velleman.c	Mon Mar 15 14:34:28 2004
@@ -19,10 +19,6 @@
 /* ------------------------------------------------------------------------- */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
diff -Nru a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
--- a/drivers/i2c/busses/i2c-via.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-via.c	Mon Mar 15 14:34:28 2004
@@ -22,10 +22,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-viapro.c	Mon Mar 15 14:34:28 2004
@@ -34,10 +34,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/busses/i2c-voodoo3.c b/drivers/i2c/busses/i2c-voodoo3.c
--- a/drivers/i2c/busses/i2c-voodoo3.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/i2c-voodoo3.c	Mon Mar 15 14:34:28 2004
@@ -28,10 +28,6 @@
     the BT869 and possibly other I2C devices. */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -Nru a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
--- a/drivers/i2c/busses/scx200_acb.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/scx200_acb.c	Mon Mar 15 14:34:28 2004
@@ -25,10 +25,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
diff -Nru a/drivers/i2c/busses/scx200_i2c.c b/drivers/i2c/busses/scx200_i2c.c
--- a/drivers/i2c/busses/scx200_i2c.c	Mon Mar 15 14:34:28 2004
+++ b/drivers/i2c/busses/scx200_i2c.c	Mon Mar 15 14:34:28 2004
@@ -22,10 +22,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>

