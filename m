Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTKVPPW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 10:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTKVPPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 10:15:22 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:47876 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262324AbTKVPPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 10:15:12 -0500
Date: Sat, 22 Nov 2003 16:15:10 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Cc: LM Sensors <sensors@Stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Subject: [PATCH 2.4] Trivial changes to I2C stuff
Message-Id: <20031122161510.7d5b4d20.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, hi list,

Below is a simple patch that does some trivial changes to a few i2c
drivers in 2.4.23-rc3. The changes are only white space and comment
changes, and line reordering. There are also two simple changes to
i2c-id.h to keep it in line with the one in Linux 2.6.0-test9.

Nothing dangerous here, as you'll see (and nothing very important
either, I admit), but I plan to submit a patch that updates the whole
i2c subsystem for Linux 2.4.24, and would like these changes done before
so that the diffs look better. I already made the required changes to
our CVS repository to ensure that all changes made to the kernel tree
since the last sync (i2c 2.6.1 in Linux 2.4.13) had been correctly back
ported. (Actually, this is how I found the little differences that the
patch below fixes.)

Please apply,
thanks.

diff -ru linux-2.4.23-rc3/drivers/i2c/i2c-core.c linux-2.4.23-rc3-k1/drivers/i2c/i2c-core.c
--- linux-2.4.23-rc3/drivers/i2c/i2c-core.c	Mon Aug 25 13:44:41 2003
+++ linux-2.4.23-rc3-k1/drivers/i2c/i2c-core.c	Sat Nov 22 09:14:37 2003
@@ -1427,9 +1427,10 @@
 #ifdef MODULE
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
+MODULE_LICENSE("GPL");
+
 MODULE_PARM(i2c_debug, "i");
 MODULE_PARM_DESC(i2c_debug,"debug level");
-MODULE_LICENSE("GPL");
 
 int init_module(void) 
 {
diff -ru linux-2.4.23-rc3/drivers/i2c/i2c-dev.c linux-2.4.23-rc3-k1/drivers/i2c/i2c-dev.c
--- linux-2.4.23-rc3/drivers/i2c/i2c-dev.c	Mon Aug 25 13:44:41 2003
+++ linux-2.4.23-rc3-k1/drivers/i2c/i2c-dev.c	Sat Nov 22 10:07:25 2003
@@ -159,9 +159,9 @@
 
 	struct i2c_client *client = (struct i2c_client *)file->private_data;
 
-	if(count > 8192)
+	if (count > 8192)
 		count = 8192;
-		
+
 	/* copy user space data to kernel space. */
 	tmp = kmalloc(count,GFP_KERNEL);
 	if (tmp==NULL)
@@ -190,9 +190,9 @@
 	struct inode *inode = file->f_dentry->d_inode;
 #endif /* DEBUG */
 
-	if(count > 8192)
+	if (count > 8192)
 		count = 8192;
-		
+
 	/* copy user space data to kernel space. */
 	tmp = kmalloc(count,GFP_KERNEL);
 	if (tmp==NULL)
diff -ru linux-2.4.23-rc3/drivers/i2c/i2c-elv.c linux-2.4.23-rc3-k1/drivers/i2c/i2c-elv.c
--- linux-2.4.23-rc3/drivers/i2c/i2c-elv.c	Thu Oct 11 17:05:47 2001
+++ linux-2.4.23-rc3-k1/drivers/i2c/i2c-elv.c	Sat Nov 22 09:15:25 2003
@@ -202,7 +202,6 @@
 MODULE_DESCRIPTION("I2C-Bus adapter routines for ELV parallel port adapter");
 MODULE_LICENSE("GPL");
 
-
 MODULE_PARM(base, "i");
 
 int init_module(void)
diff -ru linux-2.4.23-rc3/drivers/media/video/saa7110.c linux-2.4.23-rc3-k1/drivers/media/video/saa7110.c
--- linux-2.4.23-rc3/drivers/media/video/saa7110.c	Sat Nov 22 09:09:37 2003
+++ linux-2.4.23-rc3-k1/drivers/media/video/saa7110.c	Sat Nov 22 09:20:40 2003
@@ -404,7 +404,7 @@
 {
 	"saa7110",			/* name */
 
-	I2C_DRIVERID_VIDEODECODER,	/* in i2c.h */
+	I2C_DRIVERID_VIDEODECODER,	/* in i2c-old.h */
 	I2C_SAA7110, I2C_SAA7110+1,	/* Addr range */
 
 	saa7110_attach,
diff -ru linux-2.4.23-rc3/include/linux/i2c-id.h linux-2.4.23-rc3-k1/include/linux/i2c-id.h
--- linux-2.4.23-rc3/include/linux/i2c-id.h	Sat Nov 22 09:09:41 2003
+++ linux-2.4.23-rc3-k1/include/linux/i2c-id.h	Sat Nov 22 15:23:13 2003
@@ -90,7 +90,7 @@
 #define I2C_DRIVERID_DRP3510	43     /* ADR decoder (Astra Radio)	*/
 #define I2C_DRIVERID_SP5055	44     /* Satellite tuner		*/
 #define I2C_DRIVERID_STV0030	45     /* Multipurpose switch		*/
-#define I2C_DRIVERID_ADV717X   48     /* video encoder                 */
+#define I2C_DRIVERID_ADV7175	48     /* ADV 7175/7176 video encoder	*/
 
 #define I2C_DRIVERID_EXP0	0xF0	/* experimental use id's	*/
 #define I2C_DRIVERID_EXP1	0xF1
@@ -199,7 +199,7 @@
 #define I2C_HW_SMBUS_AMD756	0x05
 #define I2C_HW_SMBUS_SIS5595	0x06
 #define I2C_HW_SMBUS_ALI1535	0x07
-#define I2C_HW_SMBUS_W9968CF	0x08
+#define I2C_HW_SMBUS_W9968CF	0x0d
 
 /* --- ISA pseudo-adapter						*/
 #define I2C_HW_ISA 0x00


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
