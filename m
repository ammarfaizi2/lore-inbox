Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUKDHeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUKDHeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbUKDHdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:33:25 -0500
Received: from mail.convergence.de ([212.227.36.84]:36514 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S262101AbUKDHVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 02:21:25 -0500
Message-ID: <4189D841.60201@linuxtv.org>
Date: Thu, 04 Nov 2004 08:20:33 +0100
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][V4L] mxb driver and i2c helper cleanup
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030500000502020904070601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030500000502020904070601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

the attached patch cleans up my Video4Linux "MXB" driver and the i2c 
helper chipset drivers used by that cards.

I ran Lindent on the files and fixed some other coding style violations, 
which makes the patch rather big.

But besides the MODULE_PARM => module_param there have been no crucial 
changes.

Please apply.

Thanks
Michael.

--------------030500000502020904070601
Content-Type: text/plain;
 name="v4l_mxb_i2c_cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_mxb_i2c_cleanup.diff"

- [V4L] mxb: replace MODULE_PARM with module_param
- [V4L] saa7111: replace MODULE_PARM with module_param
- [V4L] tda9840: replace MODULE_PARM with module_param, re-indent code with Lindent, remove unnecessary header includes, code simplification
- [V4L] tea6415c: replace MODULE_PARM with module_param, re-indent code with Lindent, remove unnecessary header includes, code simplification
- [V4L] tea6420: replace MODULE_PARM with module_param, re-indent code with Lindent, remove unnecessary header includes, code simplification

Signed-off-by: Michael Hunold <hunold@linuxtv.org>


diff -ura b/drivers/media/video/mxb.c linux-2.6.10-rc1-bk9-debug/drivers/media/video/mxb.c
--- b/drivers/media/video/mxb.c	2004-11-04 08:11:05.000000000 +0100
+++ linux-2.6.10-rc1-bk9-debug/drivers/media/video/mxb.c	2004-11-01 14:48:54.000000000 +0100
@@ -1,5 +1,5 @@
 /*
-    mxb.c - v4l2 driver for the Multimedia eXtension Board
+    mxb - v4l2 driver for the Multimedia eXtension Board
     
     Copyright (C) 1998-2003 Michael Hunold <michael@mihu.de>
 
@@ -43,12 +43,12 @@
    in verden (lower saxony, germany) 4148 is a
    channel called "phoenix" */
 static int freq = 4148;
-MODULE_PARM(freq,"i");
+module_param(freq, int, 0644);
 MODULE_PARM_DESC(freq, "initial frequency the tuner will be tuned to while setup");
 
 static int debug = 0;
-MODULE_PARM(debug,"i");
-MODULE_PARM_DESC(debug, "debug verbosity");
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off device debugging (default:off).");
 
 #define MXB_INPUTS 4
 enum { TUNER, AUX1, AUX3, AUX3_YC };
diff -ura b/drivers/media/video/saa7111.c linux-2.6.10-rc1-bk9-debug/drivers/media/video/saa7111.c
--- b/drivers/media/video/saa7111.c	2004-11-04 08:11:06.000000000 +0100
+++ linux-2.6.10-rc1-bk9-debug/drivers/media/video/saa7111.c	2004-11-01 14:48:50.000000000 +0100
@@ -60,7 +60,7 @@
 #include <linux/video_decoder.h>
 
 static int debug = 0;
-MODULE_PARM(debug, "i");
+module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Debug level (0-1)");
 
 #define dprintk(num, format, args...) \
diff -ura b/drivers/media/video/tda9840.c linux-2.6.10-rc1-bk9-debug/drivers/media/video/tda9840.c
--- b/drivers/media/video/tda9840.c	2004-11-04 08:11:06.000000000 +0100
+++ linux-2.6.10-rc1-bk9-debug/drivers/media/video/tda9840.c	2004-11-01 14:45:48.000000000 +0100
@@ -1,5 +1,5 @@
  /*
-    tda9840.h - i2c-driver for the tda9840 by SGS Thomson   
+    tda9840 - i2c-driver for the tda9840 by SGS Thomson   
 
     Copyright (C) 1998-2003 Michael Hunold <michael@mihu.de>
 
@@ -8,7 +8,7 @@
 
     For detailed informations download the specifications directly
     from SGS Thomson at http://www.st.com
-    
+
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
@@ -22,21 +22,19 @@
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
+  */
 
-#include <linux/version.h>
 #include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/poll.h>
-#include <linux/slab.h>
+#include <linux/ioctl.h>
 #include <linux/i2c.h>
-#include <linux/init.h>
 
 #include "tda9840.h"
 
-static int debug = 0;	/* insmod parameter */
-MODULE_PARM(debug,"i");
-#define dprintk	if (debug) printk
+static int debug = 0;		/* insmod parameter */
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off device debugging (default:off).");
+#define dprintk(args...) \
+            do { if (debug) { printk("%s: %s()[%d]: ",__stringify(KBUILD_MODNAME), __FUNCTION__, __LINE__); printk(args); } } while (0)
 
 #define	SWITCH		0x00
 #define	LEVEL_ADJUST	0x02
@@ -44,168 +42,146 @@
 #define	TEST		0x04
 
 /* addresses to scan, found only at 0x42 (7-Bit) */
-static unsigned short normal_i2c[] = {I2C_TDA9840, I2C_CLIENT_END};
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
+static unsigned short normal_i2c[] = { I2C_TDA9840, I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 /* magic definition of all other variables and things */
 I2C_CLIENT_INSMOD;
 
+static struct i2c_driver driver;
+static struct i2c_client client_template;
+
 /* unique ID allocation */
 static int tda9840_id = 0;
 
-static struct i2c_driver driver;
-
-static int tda9840_command(struct i2c_client *client, unsigned int cmd, void* arg)
+static int command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
-	int result = 0;
+	int result;
+	int byte = *(int *)arg;
 
 	switch (cmd) {
-		case TDA9840_SWITCH:
-		{
-			int byte = *(int*)arg;
-
-			dprintk("tda9840.o: TDA9840_SWITCH: 0x%02x\n",byte);
-
-			if (    byte != TDA9840_SET_MONO
-			     && byte != TDA9840_SET_MUTE
-			     && byte != TDA9840_SET_STEREO
-			     && byte != TDA9840_SET_LANG1
-			     && byte != TDA9840_SET_LANG2
-			     && byte != TDA9840_SET_BOTH
-			     && byte != TDA9840_SET_BOTH_R
-			     && byte != TDA9840_SET_EXTERNAL ) {
-				return -EINVAL;
-			}
-			
-			if ( 0 != (result = i2c_smbus_write_byte_data(client, SWITCH, byte))) {
-		 		printk("tda9840.o: TDA9840_SWITCH error.\n");
- 				return -EFAULT;
-			}
-			
-			return 0;
-		}
+	case TDA9840_SWITCH:
 
-		case TDA9840_LEVEL_ADJUST:
-		{
-			int  byte = *(int*)arg;
-
-			dprintk("tda9840.o: TDA9840_LEVEL_ADJUST: %d\n",byte);
-
-			/* check for correct range */
-			if ( byte > 25 || byte < -20 )
-				return -EINVAL;
-			
-			/* calculate actual value to set, see specs, page 18 */
-			byte /= 5;
-			if ( 0 < byte )
-				byte += 0x8;
-			else
-				byte = -byte;
-
-			if ( 0 != (result = i2c_smbus_write_byte_data(client, LEVEL_ADJUST, byte))) {
-		 		printk("tda9840.o: TDA9840_LEVEL_ADJUST error.\n");
- 				return -EFAULT;
-			}
-			
-			return 0;
-		}
+		dprintk("TDA9840_SWITCH: 0x%02x\n", byte);
 
-		case TDA9840_STEREO_ADJUST:
-		{
-			int  byte = *(int*)arg;
-
-			dprintk("tda9840.o: TDA9840_STEREO_ADJUST: %d\n",byte);
-
-			/* check for correct range */
-			if ( byte > 25 || byte < -24 )
-				return -EINVAL;
-			
-			/* calculate actual value to set */
-			byte /= 5;
-			if ( 0 < byte )
-				byte += 0x20;
-			else
-				byte = -byte;
-
-			if ( 0 != (result = i2c_smbus_write_byte_data(client, STEREO_ADJUST, byte))) {
-		 		printk("tda9840.o: TDA9840_STEREO_ADJUST error.\n");
- 				return -EFAULT;
-			}
-			
-			return 0;
+		if (byte != TDA9840_SET_MONO
+		    && byte != TDA9840_SET_MUTE
+		    && byte != TDA9840_SET_STEREO
+		    && byte != TDA9840_SET_LANG1
+		    && byte != TDA9840_SET_LANG2
+		    && byte != TDA9840_SET_BOTH
+		    && byte != TDA9840_SET_BOTH_R
+		    && byte != TDA9840_SET_EXTERNAL) {
+			return -EINVAL;
 		}
 
-		case TDA9840_DETECT:
-		{
-			int byte = 0x0;
-
-			if ( -1 == (byte = i2c_smbus_read_byte_data(client, STEREO_ADJUST))) {
-		 		printk("tda9840.o: TDA9840_DETECT error while reading.\n");
-				return -EFAULT;
-			}			
-
-			if( 0 != (byte & 0x80)) {
-		 		dprintk("tda9840.o: TDA9840_DETECT, register contents invalid.\n");
-				return -EFAULT;
-			}
+		result = i2c_smbus_write_byte_data(client, SWITCH, byte);
+		if (result)
+			dprintk("i2c_smbus_write_byte() failed, ret:%d\n", result);
+		break;
+
+	case TDA9840_LEVEL_ADJUST:
+
+		dprintk("TDA9840_LEVEL_ADJUST: %d\n", byte);
+
+		/* check for correct range */
+		if (byte > 25 || byte < -20)
+			return -EINVAL;
+
+		/* calculate actual value to set, see specs, page 18 */
+		byte /= 5;
+		if (0 < byte)
+			byte += 0x8;
+		else
+			byte = -byte;
+
+		result = i2c_smbus_write_byte_data(client, LEVEL_ADJUST, byte);
+		if (result)
+			dprintk("i2c_smbus_write_byte() failed, ret:%d\n", result);
+		break;
+		
+	case TDA9840_STEREO_ADJUST:
 
-			dprintk("tda9840.o: TDA9840_DETECT, result: 0x%02x (original byte)\n",byte);
+		dprintk("TDA9840_STEREO_ADJUST: %d\n", byte);
 
-			return ((byte & 0x60) >> 5);				
+		/* check for correct range */
+		if (byte > 25 || byte < -24)
+			return -EINVAL;
+
+		/* calculate actual value to set */
+		byte /= 5;
+		if (0 < byte)
+			byte += 0x20;
+		else
+			byte = -byte;
+
+		result = i2c_smbus_write_byte_data(client, STEREO_ADJUST, byte);
+		if (result)
+			dprintk("i2c_smbus_write_byte() failed, ret:%d\n", result);
+		break;
+
+	case TDA9840_DETECT:
+
+		byte = i2c_smbus_read_byte_data(client, STEREO_ADJUST);
+		if (byte == -1) {
+			dprintk("i2c_smbus_read_byte_data() failed\n");
+			return -EIO;
 		}
 
-		case TDA9840_TEST:
-		{
-			int  byte = *(int*)arg;
-
-			dprintk("tda9840.o: TDA9840_TEST: 0x%02x\n",byte);
-
-			/* mask out irrelevant bits */
-			byte &= 0x3;
-
-			if ( 0 != (result = i2c_smbus_write_byte_data(client, TEST, byte))) {
-		 		printk("tda9840.o: TDA9840_TEST error.\n");
- 				return -EFAULT;
-			}
-		
-			return 0;
+		if (0 != (byte & 0x80)) {
+			dprintk("TDA9840_DETECT: register contents invalid\n");
+			return -EINVAL;
 		}
 
-		default:
-			return -ENOIOCTLCMD;
+		dprintk("TDA9840_DETECT: byte: 0x%02x\n", byte);
+		return ((byte & 0x60) >> 5);
+
+	case TDA9840_TEST:
+		dprintk("TDA9840_TEST: 0x%02x\n", byte);
+
+		/* mask out irrelevant bits */
+		byte &= 0x3;
+
+		result = i2c_smbus_write_byte_data(client, TEST, byte);
+		if (result)
+			dprintk("i2c_smbus_write_byte() failed, ret:%d\n", result);
+		break;
+	default:
+		return -ENOIOCTLCMD;
 	}
+	
+	if (result)
+		return -EIO;
 
 	return 0;
 }
 
-static int tda9840_detect(struct i2c_adapter *adapter, int address, int kind)
+static int detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	struct	i2c_client *client;
+	struct i2c_client *client;
 	int result = 0;
 
 	int byte = 0x0;
-			
+
 	/* let's see whether this adapter can support what we need */
-	if ( 0 == i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA|I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
+	if (0 == i2c_check_functionality(adapter,
+				    I2C_FUNC_SMBUS_READ_BYTE_DATA |
+				    I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
 		return 0;
 	}
 
 	/* allocate memory for client structure */
 	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
-        if (0 == client) {
-		printk("tda9840.o: not enough kernel memory.\n");
+	if (0 == client) {
+		printk("not enough kernel memory\n");
 		return -ENOMEM;
 	}
-	memset(client, 0, sizeof(struct i2c_client));
-	
+
 	/* fill client structure */
-	sprintf(client->name,"tda9840 (0x%02x)", address);
+	memcpy(client, &client_template, sizeof(struct i2c_client));
 	client->id = tda9840_id++;
-	client->flags = 0;
 	client->addr = address;
 	client->adapter = adapter;
-	client->driver = &driver;
-	i2c_set_clientdata(client, NULL);
 
 	/* tell the i2c layer a new client has arrived */
 	if (0 != (result = i2c_attach_client(client))) {
@@ -215,71 +191,64 @@
 
 	/* set initial values for level & stereo - adjustment, mode */
 	byte = 0;
-	if ( 0 != (result = tda9840_command(client, TDA9840_LEVEL_ADJUST, &byte))) {
- 		printk("tda9840.o: could not initialize ic #1. continuing anyway. (result:%d)\n",result);
-	}
-	
-	if ( 0 != (result = tda9840_command(client, TDA9840_STEREO_ADJUST, &byte))) {
- 		printk("tda9840.o: could not initialize ic #2. continuing anyway. (result:%d)\n",result);
-	}
-
+	result  = command(client, TDA9840_LEVEL_ADJUST, &byte);
+	result += command(client, TDA9840_STEREO_ADJUST, &byte);
 	byte = TDA9840_SET_MONO;
-	if ( 0 != (result = tda9840_command(client, TDA9840_SWITCH, &byte))) {
- 		printk("tda9840.o: could not initialize ic #3. continuing anyway. (result:%d)\n",result);
-	} 
-	
-	printk("tda9840.o: detected @ 0x%02x on adapter %s\n",2*address,&client->adapter->name[0]);
+	result = command(client, TDA9840_SWITCH, &byte);
+	if (result) {
+		dprintk("could not initialize tda9840\n");
+		return -ENODEV;
+	}
 
+	printk("tda9840: detected @ 0x%02x on adapter %s\n", address, &client->adapter->name[0]);
 	return 0;
 }
 
-static int tda9840_attach(struct i2c_adapter *adapter)
+static int attach(struct i2c_adapter *adapter)
 {
 	/* let's see whether this is a know adapter we can attach to */
-	if( adapter->id != I2C_ALGO_SAA7146 ) {
-		dprintk("tda9840.o: refusing to probe on unknown adapter [name='%s',id=0x%x]\n",adapter->name,adapter->id);
+	if (adapter->id != I2C_ALGO_SAA7146) {
+		dprintk("refusing to probe on unknown adapter [name='%s',id=0x%x]\n", adapter->name, adapter->id);
 		return -ENODEV;
 	}
 
-	return i2c_probe(adapter,&addr_data,&tda9840_detect);
+	return i2c_probe(adapter, &addr_data, &detect);
 }
 
-static int tda9840_detach(struct i2c_client *client)
+static int detach(struct i2c_client *client)
 {
-	int err = 0;
-
-	if ( 0 != (err = i2c_detach_client(client))) {
-		printk("tda9840.o: Client deregistration failed, client not detached.\n");
-		return err;
-	}
-	
+	int ret = i2c_detach_client(client);
 	kfree(client);
-
-	return 0;
+	return ret;
 }
 
 static struct i2c_driver driver = {
-	.owner		= THIS_MODULE,
-	.name		= "tda9840 driver",
-	.id		= I2C_DRIVERID_TDA9840,
-	.flags		= I2C_DF_NOTIFY,
-        .attach_adapter = tda9840_attach,
-        .detach_client	= tda9840_detach,
-        .command	= tda9840_command,
+	.owner	= THIS_MODULE,
+	.name	= "tda9840",
+	.id	= I2C_DRIVERID_TDA9840,
+	.flags	= I2C_DF_NOTIFY,
+	.attach_adapter	= attach,
+	.detach_client	= detach,
+	.command	= command,
+};
+
+static struct i2c_client client_template = {
+	I2C_DEVNAME("tda9840"),
+	.driver = &driver,
 };
 
-static int __init tda9840_init_module(void)
+static int __init this_module_init(void)
 {
-        return i2c_add_driver(&driver);
+	return i2c_add_driver(&driver);
 }
 
-static void __exit tda9840_cleanup_module(void)
+static void __exit this_module_exit(void)
 {
-        i2c_del_driver(&driver);
+	i2c_del_driver(&driver);
 }
 
-module_init(tda9840_init_module);
-module_exit(tda9840_cleanup_module);
+module_init(this_module_init);
+module_exit(this_module_exit);
 
 MODULE_AUTHOR("Michael Hunold <michael@mihu.de>");
 MODULE_DESCRIPTION("tda9840 driver");
diff -ura b/drivers/media/video/tea6415c.c linux-2.6.10-rc1-bk9-debug/drivers/media/video/tea6415c.c
--- b/drivers/media/video/tea6415c.c	2004-11-04 08:11:06.000000000 +0100
+++ linux-2.6.10-rc1-bk9-debug/drivers/media/video/tea6415c.c	2004-11-01 14:44:29.000000000 +0100
@@ -1,5 +1,5 @@
  /*
-    tea6415c.h - i2c-driver for the tea6415c by SGS Thomson   
+    tea6415c - i2c-driver for the tea6415c by SGS Thomson   
 
     Copyright (C) 1998-2003 Michael Hunold <michael@mihu.de>
 
@@ -7,10 +7,10 @@
     with 8 inputs and 6 outputs.
     It is cascadable, i.e. it can be found at the addresses
     0x86 and 0x06 on the i2c-bus.
-    
+
     For detailed informations download the specifications directly
     from SGS Thomson at http://www.st.com
-        
+
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License vs published by
     the Free Software Foundation; either version 2 of the License, or
@@ -24,61 +24,58 @@
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
     Foundation, Inc., 675 Mvss Ave, Cambridge, MA 02139, USA.
- */
+  */
 
-#include <linux/version.h>
 #include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/poll.h>
-#include <linux/slab.h>
+#include <linux/ioctl.h>
 #include <linux/i2c.h>
-#include <linux/init.h>
+
 #include "tea6415c.h"
 
-static int debug = 0;	/* insmod parameter */
-MODULE_PARM(debug,"i");
-#define dprintk	if (debug) printk
+static int debug = 0;		/* insmod parameter */
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off device debugging (default:off).");
+#define dprintk(args...) \
+            do { if (debug) { printk("%s: %s()[%d]: ",__stringify(KBUILD_MODNAME), __FUNCTION__, __LINE__); printk(args); } } while (0)
 
 #define TEA6415C_NUM_INPUTS	8
 #define TEA6415C_NUM_OUTPUTS	6
 
 /* addresses to scan, found only at 0x03 and/or 0x43 (7-bit) */
-static unsigned short normal_i2c[] = {I2C_TEA6415C_1, I2C_TEA6415C_2, I2C_CLIENT_END};
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
+static unsigned short normal_i2c[] = { I2C_TEA6415C_1, I2C_TEA6415C_2, I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 /* magic definition of all other variables and things */
 I2C_CLIENT_INSMOD;
 
 static struct i2c_driver driver;
+static struct i2c_client client_template;
 
 /* unique ID allocation */
 static int tea6415c_id = 0;
 
 /* this function is called by i2c_probe */
-static int tea6415c_detect(struct i2c_adapter *adapter, int address, int kind)
+static int detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	struct	i2c_client *client = NULL;
+	struct i2c_client *client = NULL;
 	int err = 0;
 
 	/* let's see whether this adapter can support what we need */
-	if ( 0 == i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WRITE_BYTE)) {
+	if (0 == i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WRITE_BYTE)) {
 		return 0;
 	}
 
 	/* allocate memory for client structure */
 	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
-        if (0 == client) {
+	if (0 == client) {
 		return -ENOMEM;
 	}
-	memset(client, 0, sizeof(struct i2c_client));
 
 	/* fill client structure */
-	sprintf(client->name,"tea6415c (0x%02x)", address);
+	memcpy(client, &client_template, sizeof(struct i2c_client));
 	client->id = tea6415c_id++;
-	client->flags = 0;
 	client->addr = address;
 	client->adapter = adapter;
-	client->driver = &driver;
 
 	/* tell the i2c layer a new client has arrived */
 	if (0 != (err = i2c_attach_client(client))) {
@@ -86,151 +83,145 @@
 		return err;
 	}
 
-	printk("tea6415c.o: detected @ 0x%02x on adapter %s\n",2*address,&client->adapter->name[0]);
+	printk("tea6415c: detected @ 0x%02x on adapter %s\n", address, &client->adapter->name[0]);
 
 	return 0;
 }
 
-static int tea6415c_attach(struct i2c_adapter *adapter)
+static int attach(struct i2c_adapter *adapter)
 {
 	/* let's see whether this is a know adapter we can attach to */
-	if( adapter->id != I2C_ALGO_SAA7146 ) {
-		dprintk("tea6415c.o: refusing to probe on unknown adapter [name='%s',id=0x%x]\n",adapter->name,adapter->id);
+	if (adapter->id != I2C_ALGO_SAA7146) {
+		dprintk("refusing to probe on unknown adapter [name='%s',id=0x%x]\n", adapter->name, adapter->id);
 		return -ENODEV;
 	}
 
-	return i2c_probe(adapter,&addr_data,&tea6415c_detect);
+	return i2c_probe(adapter, &addr_data, &detect);
 }
 
-static int tea6415c_detach(struct i2c_client *client)
+static int detach(struct i2c_client *client)
 {
-	int err = 0;
-
-	if ( 0 != (err = i2c_detach_client(client))) {
-		printk("tea6415c.o: Client deregistration failed, client not detached.\n");
-		return err;
-	}
-	
+	int ret = i2c_detach_client(client);
 	kfree(client);
-
-	return 0;
+	return ret;
 }
 
 /* makes a connection between the input-pin 'i' and the output-pin 'o'
    for the tea6415c-client 'client' */
-static int tea6415c_switch(struct i2c_client *client, int i, int o)
+static int switch_matrix(struct i2c_client *client, int i, int o)
 {
-	u8 	byte = 0;
+	u8 byte = 0;
+	int ret;
 	
-	dprintk("tea6415c.o: tea6415c_switch: adr:0x%02x, i:%d, o:%d\n", client->addr, i, o);
-		
+	dprintk("adr:0x%02x, i:%d, o:%d\n", client->addr, i, o);
+
 	/* check if the pins are valid */
-	if ( 0 == ((  1 == i ||  3 == i ||  5 == i ||  6 == i ||  8 == i || 10 == i || 20 == i || 11 == i ) &&
-		    (18 == o || 17 == o || 16 == o || 15 == o || 14 == o || 13 == o )))
+	if (0 == ((1 == i ||  3 == i ||  5 == i ||  6 == i ||  8 == i || 10 == i || 20 == i || 11 == i)
+	      && (18 == o || 17 == o || 16 == o || 15 == o || 14 == o || 13 == o)))
 		return -1;
 
 	/* to understand this, have a look at the tea6415c-specs (p.5) */
-	switch(o) {
-		case 18:
-			byte = 0x00;
-			break;
-		case 14:
-			byte = 0x20;
-			break;
-		case 16:
-			byte = 0x10;
-			break;
-		case 17:
-			byte = 0x08;
-			break;
-		case 15:
-			byte = 0x18;
-			break;
-		case 13:
-			byte = 0x28;
-			break;
+	switch (o) {
+	case 18:
+		byte = 0x00;
+		break;
+	case 14:
+		byte = 0x20;
+		break;
+	case 16:
+		byte = 0x10;
+		break;
+	case 17:
+		byte = 0x08;
+		break;
+	case 15:
+		byte = 0x18;
+		break;
+	case 13:
+		byte = 0x28;
+		break;
 	};
-		
-	switch(i) {
-		case 5:
-			byte |= 0x00;
-			break;
-		case 8:
-			byte |= 0x04;
-			break;
-		case 3:
-			byte |= 0x02;
-			break;
-		case 20:
-			byte |= 0x06;
-			break;
-		case 6:
-			byte |= 0x01;
-			break;
-		case 10:
-			byte |= 0x05;
-			break;
-		case 1:
-			byte |= 0x03;
-			break;
-		case 11:
-			byte |= 0x07;
-			break;
+
+	switch (i) {
+	case 5:
+		byte |= 0x00;
+		break;
+	case 8:
+		byte |= 0x04;
+		break;
+	case 3:
+		byte |= 0x02;
+		break;
+	case 20:
+		byte |= 0x06;
+		break;
+	case 6:
+		byte |= 0x01;
+		break;
+	case 10:
+		byte |= 0x05;
+		break;
+	case 1:
+		byte |= 0x03;
+		break;
+	case 11:
+		byte |= 0x07;
+		break;
 	};
 
-	if ( 0 != i2c_smbus_write_byte(client,byte)) {
-		dprintk("tea6415c.o: tea6415c_switch: could not write to tea6415c\n");
-		return -1;
+	ret = i2c_smbus_write_byte(client, byte);
+	if (ret) {
+		dprintk("i2c_smbus_write_byte() failed, ret:%d\n", ret);
+		return -EIO;
 	}
 
-	return 0;
+	return ret;
 }
 
-static int tea6415c_command(struct i2c_client *client, unsigned int cmd, void* arg)
+static int command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
-	struct tea6415c_multiplex *v = (struct tea6415c_multiplex*)arg;
+	struct tea6415c_multiplex *v = (struct tea6415c_multiplex *)arg;
 	int result = 0;
 
 	switch (cmd) {
-		case TEA6415C_SWITCH: {
-			result = tea6415c_switch(client,v->in,v->out);
-			break;
-		}
-		default: {
-			return -ENOIOCTLCMD;
-		}
+	case TEA6415C_SWITCH:
+		result = switch_matrix(client, v->in, v->out);
+		break;
+	default:
+		return -ENOIOCTLCMD;
 	}
 
-	if ( 0 != result )
-		return result;
-	
-	return 0;
+	return result;
 }
 
 static struct i2c_driver driver = {
-	.owner		= THIS_MODULE,
-	.name		= "tea6415c driver",
-	.id		= I2C_DRIVERID_TEA6415C,
-	.flags		= I2C_DF_NOTIFY,
-        .attach_adapter = tea6415c_attach,
-        .detach_client	= tea6415c_detach,
-        .command	= tea6415c_command,
+	.owner	= THIS_MODULE,
+	.name 	= "tea6415c",
+	.id 	= I2C_DRIVERID_TEA6415C,
+	.flags 	= I2C_DF_NOTIFY,
+	.attach_adapter	= attach,
+	.detach_client	= detach,
+	.command	= command,
+};
+
+static struct i2c_client client_template = {
+	I2C_DEVNAME("tea6415c"),
+	.driver = &driver,
 };
 
-static int __init tea6415c_init_module(void)
+static int __init this_module_init(void)
 {
 	return i2c_add_driver(&driver);
 }
 
-static void __exit tea6415c_cleanup_module(void)
+static void __exit this_module_exit(void)
 {
-        i2c_del_driver(&driver);
+	i2c_del_driver(&driver);
 }
 
-module_init(tea6415c_init_module);
-module_exit(tea6415c_cleanup_module);
+module_init(this_module_init);
+module_exit(this_module_exit);
 
 MODULE_AUTHOR("Michael Hunold <michael@mihu.de>");
 MODULE_DESCRIPTION("tea6415c driver");
 MODULE_LICENSE("GPL");
-
diff -ura b/drivers/media/video/tea6420.c linux-2.6.10-rc1-bk9-debug/drivers/media/video/tea6420.c
--- b/drivers/media/video/tea6420.c	2004-11-04 08:11:06.000000000 +0100
+++ linux-2.6.10-rc1-bk9-debug/drivers/media/video/tea6420.c	2004-11-01 14:46:06.000000000 +0100
@@ -1,5 +1,5 @@
  /*
-    tea6420.o - i2c-driver for the tea6420 by SGS Thomson
+    tea6420 - i2c-driver for the tea6420 by SGS Thomson
 
     Copyright (C) 1998-2003 Michael Hunold <michael@mihu.de>
 
@@ -7,10 +7,10 @@
     4 stereo outputs and gain control for each output.
     It is cascadable, i.e. it can be found at the adresses 0x98
     and 0x9a on the i2c-bus.
-    
+
     For detailed informations download the specifications directly
     from SGS Thomson at http://www.st.com
-    
+
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
@@ -24,30 +24,29 @@
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
+  */
 
-#include <linux/version.h>
 #include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/poll.h>
-#include <linux/slab.h>
+#include <linux/ioctl.h>
 #include <linux/i2c.h>
-#include <linux/init.h>
 
 #include "tea6420.h"
 
-static int debug = 0;	/* insmod parameter */
-MODULE_PARM(debug,"i");
-#define dprintk	if (debug) printk
+static int debug = 0;		/* insmod parameter */
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off device debugging (default:off).");
+#define dprintk(args...) \
+            do { if (debug) { printk("%s: %s()[%d]: ",__stringify(KBUILD_MODNAME), __FUNCTION__, __LINE__); printk(args); } } while (0)
 
 /* addresses to scan, found only at 0x4c and/or 0x4d (7-Bit) */
-static unsigned short normal_i2c[] = {I2C_TEA6420_1, I2C_TEA6420_2, I2C_CLIENT_END};
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
+static unsigned short normal_i2c[] = { I2C_TEA6420_1, I2C_TEA6420_2, I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 /* magic definition of all other variables and things */
 I2C_CLIENT_INSMOD;
 
 static struct i2c_driver driver;
+static struct i2c_client client_template;
 
 /* unique ID allocation */
 static int tea6420_id = 0;
@@ -56,39 +55,37 @@
    with gain 'g' for the tea6420-client 'client' (note: i = 6 means 'mute') */
 static int tea6420_switch(struct i2c_client *client, int i, int o, int g)
 {
-	u8 	byte = 0;
-	
-	int 	result = 0;
-	
-	dprintk("tea6420.o: tea6420_switch: adr:0x%02x, i:%d, o:%d, g:%d\n",client->addr,i,o,g);
+	u8 byte = 0;
+	int ret;
+
+	dprintk("adr:0x%02x, i:%d, o:%d, g:%d\n", client->addr, i, o, g);
 
 	/* check if the paramters are valid */
-	if ( i < 1 || i > 6 || o < 1 || o > 4 || g < 0 || g > 6 || g%2 != 0 )
+	if (i < 1 || i > 6 || o < 1 || o > 4 || g < 0 || g > 6 || g % 2 != 0)
 		return -1;
 
-	byte  = ((o-1)<<5);
-	byte |=  (i-1);
+	byte  = ((o - 1) << 5);
+	byte |= (i - 1);
 
 	/* to understand this, have a look at the tea6420-specs (p.5) */
-	switch(g) {
-		case 0:
-			byte |= (3<<3);
-			break;
-		case 2:
-			byte |= (2<<3);
-			break;
-		case 4:
-			byte |= (1<<3);
-			break;
-		case 6:
-			break;
-	}
-
-	/* fixme?: 1 != ... => 0 != */
-	if ( 0 != (result = i2c_smbus_write_byte(client,byte))) {
-		printk("tea6402:%d\n",result);
-		dprintk(KERN_ERR "tea6420.o: could not switch, result:%d\n",result);
-		return -EFAULT;
+	switch (g) {
+	case 0:
+		byte |= (3 << 3);
+		break;
+	case 2:
+		byte |= (2 << 3);
+		break;
+	case 4:
+		byte |= (1 << 3);
+		break;
+	case 6:
+		break;
+	}
+
+	ret = i2c_smbus_write_byte(client, byte);
+	if (ret) {
+		dprintk("i2c_smbus_write_byte() failed, ret:%d\n", ret);
+		return -EIO;
 	}
 	
 	return 0;
@@ -97,29 +94,26 @@
 /* this function is called by i2c_probe */
 static int tea6420_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	struct	i2c_client *client;
+	struct i2c_client *client;
 	int err = 0, i = 0;
 
 	/* let's see whether this adapter can support what we need */
-	if ( 0 == i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WRITE_BYTE)) {
+	if (0 == i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WRITE_BYTE)) {
 		return 0;
 	}
 
 	/* allocate memory for client structure */
 	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
-        if (0 == client) {
+	if (0 == client) {
 		return -ENOMEM;
 	}
-	memset(client, 0x0, sizeof(struct i2c_client));	
+	memset(client, 0x0, sizeof(struct i2c_client));
 
 	/* fill client structure */
-	sprintf(client->name,"tea6420 (0x%02x)", address);
+	memcpy(client, &client_template, sizeof(struct i2c_client));
 	client->id = tea6420_id++;
-	client->flags = 0;
 	client->addr = address;
 	client->adapter = adapter;
-	client->driver = &driver;
-	i2c_set_clientdata(client, NULL);
 
 	/* tell the i2c layer a new client has arrived */
 	if (0 != (err = i2c_attach_client(client))) {
@@ -129,86 +123,81 @@
 
 	/* set initial values: set "mute"-input to all outputs at gain 0 */
 	err = 0;
-	for(i = 1; i < 5; i++) {
+	for (i = 1; i < 5; i++) {
 		err += tea6420_switch(client, 6, i, 0);
 	}
-	if( 0 != err) {
-		printk("tea6420.o: could not initialize chipset. continuing anyway.\n");
+	if (err) {
+		dprintk("could not initialize tea6420\n");
+		kfree(client);
+		return -ENODEV;
 	}
-	
-	printk("tea6420.o: detected @ 0x%02x on adapter %s\n",2*address,&client->adapter->name[0]);
+
+	printk("tea6420: detected @ 0x%02x on adapter %s\n", address, &client->adapter->name[0]);
 
 	return 0;
 }
 
-static int tea6420_attach(struct i2c_adapter *adapter)
+static int attach(struct i2c_adapter *adapter)
 {
 	/* let's see whether this is a know adapter we can attach to */
-	if( adapter->id != I2C_ALGO_SAA7146 ) {
-		dprintk("tea6420.o: refusing to probe on unknown adapter [name='%s',id=0x%x]\n",adapter->name,adapter->id);
+	if (adapter->id != I2C_ALGO_SAA7146) {
+		dprintk("refusing to probe on unknown adapter [name='%s',id=0x%x]\n", adapter->name, adapter->id);
 		return -ENODEV;
 	}
 
-	return i2c_probe(adapter,&addr_data,&tea6420_detect);
+	return i2c_probe(adapter, &addr_data, &tea6420_detect);
 }
 
-static int tea6420_detach(struct i2c_client *client)
+static int detach(struct i2c_client *client)
 {
-	int err = 0;
-
-	if ( 0 != (err = i2c_detach_client(client))) {
-		printk("tea6420.o: Client deregistration failed, client not detached.\n");
-		return err;
-	}
-	
+	int ret = i2c_detach_client(client);
 	kfree(client);
-
-	return 0;
+	return ret;
 }
 
-static int tea6420_command(struct i2c_client *client, unsigned int cmd, void* arg)
+static int command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
-	struct tea6420_multiplex *a = (struct tea6420_multiplex*)arg;
+	struct tea6420_multiplex *a = (struct tea6420_multiplex *)arg;
 	int result = 0;
 
 	switch (cmd) {
-		case TEA6420_SWITCH: {
-			result = tea6420_switch(client,a->in,a->out,a->gain);
-			break;
-		}
-		default: {
-			return -ENOIOCTLCMD;
-		}
+	case TEA6420_SWITCH:
+		result = tea6420_switch(client, a->in, a->out, a->gain);
+		break;
+	default:
+		return -ENOIOCTLCMD;
 	}
 
-	if ( 0 != result )
-		return result;
-	
-	return 0;
+	return result;
 }
 
 static struct i2c_driver driver = {
-	.owner		= THIS_MODULE,
-	.name		= "tea6420 driver",
-	.id		= I2C_DRIVERID_TEA6420,
-	.flags		= I2C_DF_NOTIFY,
-        .attach_adapter = tea6420_attach,
-        .detach_client	= tea6420_detach,
-        .command	= tea6420_command,
+	.owner	= THIS_MODULE,
+	.name	= "tea6420",
+	.id	= I2C_DRIVERID_TEA6420,
+	.flags	= I2C_DF_NOTIFY,
+	.attach_adapter	= attach,
+	.detach_client	= detach,
+	.command	= command,
+};
+
+static struct i2c_client client_template = {
+	I2C_DEVNAME("tea6420"),
+	.driver = &driver,
 };
 
-static int __init tea6420_init_module(void)
+static int __init this_module_init(void)
 {
 	return i2c_add_driver(&driver);
 }
 
-static void __exit tea6420_cleanup_module(void)
+static void __exit this_module_exit(void)
 {
-        i2c_del_driver(&driver);
+	i2c_del_driver(&driver);
 }
 
-module_init(tea6420_init_module);
-module_exit(tea6420_cleanup_module);
+module_init(this_module_init);
+module_exit(this_module_exit);
 
 MODULE_AUTHOR("Michael Hunold <michael@mihu.de>");
 MODULE_DESCRIPTION("tea6420 driver");

--------------030500000502020904070601--
