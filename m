Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266923AbTGHKEb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 06:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266928AbTGHKEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 06:04:31 -0400
Received: from catv-50622120.szolcatv.broadband.hu ([80.98.33.32]:48017 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266923AbTGHKED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 06:04:03 -0400
Message-ID: <3F0A9A79.6010809@freemail.hu>
Date: Tue, 08 Jul 2003 12:18:33 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, hu
MIME-Version: 1.0
To: dgp85@users.sourceforge.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] LIRC drivers for 2.5
Content-Type: multipart/mixed;
 boundary="------------080208090300080309020407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080208090300080309020407
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I tried to compile it  but at first only lirc_sir.c compiled.
The drivers/char/lirc/Makefile contains

obj-$(LIRC_NNN) := lirc_nnn.o

lines. These override any previously defined obj-y or obj-m defines.
These lines should be

obj-$(LIRC_NNN) += lirc_nnn.o

instead.

lirc_i2c.c does not compile:

drivers/char/lirc/lirc_i2c.c: In function `get_key_asus':
drivers/char/lirc/lirc_i2c.c:106: structure has no member named `name'
drivers/char/lirc/lirc_i2c.c:117: structure has no member named `name'
drivers/char/lirc/lirc_i2c.c: In function `set_use_inc':
drivers/char/lirc/lirc_i2c.c:251: structure has no member named `inc_use'
drivers/char/lirc/lirc_i2c.c:252: structure has no member named `inc_use'
drivers/char/lirc/lirc_i2c.c:254: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:481)
drivers/char/lirc/lirc_i2c.c: In function `set_use_dec':
drivers/char/lirc/lirc_i2c.c:262: structure has no member named `dec_use'
drivers/char/lirc/lirc_i2c.c:263: structure has no member named `dec_use'
drivers/char/lirc/lirc_i2c.c:264: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:493)
drivers/char/lirc/lirc_i2c.c: At top level:
drivers/char/lirc/lirc_i2c.c:292: unknown field `name' specified in
initializer
drivers/char/lirc/lirc_i2c.c:292: warning: initialization makes integer
from pointer without a cast
drivers/char/lirc/lirc_i2c.c: In function `ir_attach':
drivers/char/lirc/lirc_i2c.c:311: structure has no member named `data'
drivers/char/lirc/lirc_i2c.c:320: structure has no member named `name'
drivers/char/lirc/lirc_i2c.c:325: structure has no member named `name'
drivers/char/lirc/lirc_i2c.c:331: structure has no member named `name'
drivers/char/lirc/lirc_i2c.c:336: structure has no member named `name'
drivers/char/lirc/lirc_i2c.c:342: structure has no member named `name'
drivers/char/lirc/lirc_i2c.c:353: structure has no member named `name'
drivers/char/lirc/lirc_i2c.c:358: structure has no member named `inc_use'
drivers/char/lirc/lirc_i2c.c:359: structure has no member named `inc_use'
drivers/char/lirc/lirc_i2c.c: In function `ir_detach':
drivers/char/lirc/lirc_i2c.c:366: structure has no member named `data'
drivers/char/lirc/lirc_i2c.c:369: structure has no member named `dec_use'
drivers/char/lirc/lirc_i2c.c:370: structure has no member named `dec_use'
drivers/char/lirc/lirc_i2c.c: In function `ir_probe':
drivers/char/lirc/lirc_i2c.c:400: structure has no member named `name'
drivers/char/lirc/lirc_i2c.c:444: structure has no member named `name'
drivers/char/lirc/lirc_i2c.c: At top level:
drivers/char/lirc/lirc_i2c.c:459: parse error before "lirc_i2c_init"
drivers/char/lirc/lirc_i2c.c:460: warning: return type defaults to `int'
drivers/char/lirc/lirc_i2c.c:467: parse error before "lirc_i2c_exit"
drivers/char/lirc/lirc_i2c.c:468: warning: return type defaults to `int'
drivers/char/lirc/lirc_i2c.c:477: warning: type defaults to `int' in
declaration of `module_init'
drivers/char/lirc/lirc_i2c.c:477: warning: parameter names (without
types) in function declaration
drivers/char/lirc/lirc_i2c.c:477: warning: data definition has no type
or storage class
drivers/char/lirc/lirc_i2c.c:478: warning: type defaults to `int' in
declaration of `module_exit'
drivers/char/lirc/lirc_i2c.c:478: warning: parameter names (without
types) in function declaration
drivers/char/lirc/lirc_i2c.c:478: warning: data definition has no type
or storage class
make[3]: *** [drivers/char/lirc/lirc_i2c.o] Error 1
make[2]: *** [drivers/char/lirc] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

And don't use MOD_[DEC|INC]_USE_COUNT on late 2.5.x,
they are deprecated. Use try_module_get()/module_put() instead.
I tried to fix them, the patch is attached.

Here are all the warnings after my fixes:


-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.

--------------080208090300080309020407
Content-Type: text/plain;
 name="lirc-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lirc-fixes.patch"

--- ./drivers/char/lirc/lirc_dev.c.old	2003-07-08 11:42:29.000000000 +0200
+++ ./drivers/char/lirc/lirc_dev.c	2003-07-08 11:45:16.000000000 +0200
@@ -307,7 +307,7 @@
 	}
 	up(&plugin_lock);
 
-	MOD_INC_USE_COUNT;
+	try_module_get(THIS_MODULE);
 
 	dprintk("lirc_dev: plugin %s registered at minor number = %d\n",
 		ir->p.name, ir->p.minor);
@@ -377,7 +377,7 @@
 	init_irctl(ir);
 	up(&plugin_lock);
 
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 
 	return SUCCESS;
 }
--- ./drivers/char/lirc/lirc_gpio.c.old	2003-07-08 11:42:37.000000000 +0200
+++ ./drivers/char/lirc/lirc_gpio.c	2003-07-08 11:46:10.000000000 +0200
@@ -336,13 +336,13 @@
 
 static int set_use_inc(void* data)
 {
-	MOD_INC_USE_COUNT;
+	try_module_get(THIS_MODULE);
 	return 0;
 }
 
 static void set_use_dec(void* data)
 {
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 }
 
 static wait_queue_head_t* get_queue(void* data)
--- ./drivers/char/lirc/lirc_it87.c.old	2003-07-08 11:42:44.000000000 +0200
+++ ./drivers/char/lirc/lirc_it87.c	2003-07-08 11:49:45.000000000 +0200
@@ -150,7 +150,7 @@
 		spin_unlock(&dev_lock);
 		return -EBUSY;
 	}
-	MOD_INC_USE_COUNT;
+	try_module_get(THIS_MODULE);
 	spin_unlock(&dev_lock);
 	return 0;
 }
@@ -159,7 +159,7 @@
 static int lirc_close(struct inode * inode,
 		      struct file *file)
 {
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 	return 0;
 }
 
@@ -374,7 +374,7 @@
 static int set_use_inc(void* data)
 {
 #if WE_DONT_USE_LOCAL_OPEN_CLOSE
-       MOD_INC_USE_COUNT;
+       try_module_get(THIS_MODULE);
 #endif
        return 0;
 }
@@ -382,7 +382,7 @@
 static void set_use_dec(void* data)
 {
 #if WE_DONT_USE_LOCAL_OPEN_CLOSE
-       MOD_DEC_USE_COUNT;
+       module_put(THIS_MODULE);
 #endif
 }
 static struct lirc_plugin plugin = {
--- ./drivers/char/lirc/lirc_parallel.c.old	2003-07-08 11:42:52.000000000 +0200
+++ ./drivers/char/lirc/lirc_parallel.c	2003-07-08 11:50:47.000000000 +0200
@@ -547,7 +547,7 @@
 	rptr=wptr=0;
 	lost_irqs=0;
 
-	MOD_INC_USE_COUNT;
+	try_module_get(THIS_MODULE);
 	is_open=1;
 	return(0);
 }
@@ -560,7 +560,7 @@
 		parport_release(ppdevice);
 	}
 	is_open=0;
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 	return(0);
 }
 
@@ -578,7 +578,7 @@
 static int set_use_inc(void* data)
 {
 #if WE_DONT_USE_LOCAL_OPEN_CLOSE
-       MOD_INC_USE_COUNT;
+       try_module_get(THIS_MODULE);
 #endif
        return 0;
 }
@@ -586,7 +586,7 @@
 static void set_use_dec(void* data)
 {
 #if WE_DONT_USE_LOCAL_OPEN_CLOSE
-       MOD_DEC_USE_COUNT;
+       module_put(THIS_MODULE);
 #endif
 }
 static struct lirc_plugin plugin = {
--- ./drivers/char/lirc/lirc_serial.c.old	2003-07-08 11:42:58.000000000 +0200
+++ ./drivers/char/lirc/lirc_serial.c	2003-07-08 11:51:27.000000000 +0200
@@ -833,7 +833,7 @@
 	/* Init read buffer. */
 	lirc_buffer_init(&rbuf, sizeof(lirc_t), RBUF_LEN);
 
-	MOD_INC_USE_COUNT;
+	try_module_get(THIS_MODULE);
 	spin_unlock(&lirc_lock);
 	return 0;
 }
@@ -857,7 +857,7 @@
 #       endif
 	lirc_buffer_free(&rbuf);
 
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 }
 
 static ssize_t lirc_write(struct file *file, const char *buf,


--------------080208090300080309020407--

