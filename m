Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVBSQ7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVBSQ7A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 11:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVBSQ7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 11:59:00 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:37762 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261740AbVBSQ6t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 11:58:49 -0500
Message-ID: <42177048.2000109@pacbell.net>
Date: Sat, 19 Feb 2005 08:58:48 -0800
From: Mickey Stein <yekkim@pacbell.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] i2c.h: Fix another gcc 4.0 compile failure
Content-Type: multipart/mixed;
 boundary="------------020901060603080009000002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020901060603080009000002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Mickey Stein
  Versions:   linux-2.6.11-rc4-bk7, gcc4 (GCC) 4.0.0 20050217 (latest fc 
rawhide from 19Feb DL)

  gcc4 cvs seems to dislike "include/linux/i2c.h file":
 
  Error msg:   include/linux/i2c.h:{55,194} error: array type has 
incomplete element type
 
  A. Daplas has recently done a workaround for this on another header 
file. A thread discussing this
  can be found by following the link below:
 
  http://gcc.gnu.org/ml/gcc/2005-02/msg00053.html
 
  The patch changes the array declaration from "struct x y[]" format to 
"struct x *y".
  I realize its only a workaround, but the gcc guys seem to be aware of 
this.
  ** Note: I'm a noob at this, so feel free to make chopped liver out of 
this if its incorrect.
  patch below is also attached since I'm not sure formatting survives 
the cut&paste.

 
  Signed-off-by: Mickey Stein <yekkim@pacbell.net>
 
---

--- include/linux/i2c.h.sav     2005-02-19 07:02:52.000000000 -0800
+++ include/linux/i2c.h 2005-02-19 07:26:22.000000000 -0800
@@ -55,7 +55,7 @@

 /* Transfer num messages.
  */
-extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg 
msg[],int num)
;
+extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg 
*msg,int num);

 /*
  * Some adapter types (i.e. PCF 8584 based ones) may support slave 
behaviuor.
@@ -194,7 +194,7 @@
           to NULL. If an adapter algorithm can do SMBus access, set
           smbus_xfer. If set to NULL, the SMBus protocol is simulated
           using common I2C messages */
-       int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg msgs[],
+       int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg *msgs,
                           int num);
        int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr,
                           unsigned short flags, char read_write,


--------------020901060603080009000002
Content-Type: text/plain;
 name="i2c.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c.h.patch"

--- include/linux/i2c.h.sav	2005-02-19 07:02:52.000000000 -0800
+++ include/linux/i2c.h	2005-02-19 07:26:22.000000000 -0800
@@ -55,7 +55,7 @@
 
 /* Transfer num messages.
  */
-extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],int num);
+extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msg,int num);
 
 /*
  * Some adapter types (i.e. PCF 8584 based ones) may support slave behaviuor. 
@@ -194,7 +194,7 @@
 	   to NULL. If an adapter algorithm can do SMBus access, set 
 	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
 	   using common I2C messages */
-	int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg msgs[], 
+	int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg *msgs, 
 	                   int num);
 	int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr, 
 	                   unsigned short flags, char read_write,

--------------020901060603080009000002--
