Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVBXXZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVBXXZu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVBXXZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:25:50 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:16100 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262541AbVBXXZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:25:24 -0500
Message-ID: <421E6262.9090107@acm.org>
Date: Thu, 24 Feb 2005 17:25:22 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] I2C patch 1 - minor I2C cleanups
Content-Type: multipart/mixed;
 boundary="------------010303030401050901050802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010303030401050901050802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is one in a series of patches for adding a non-blocking interface 
to the I2C driver for supporting the IPMI SMBus driver.  This patch is a 
simply some minor cleanups and is in addition to the patch by Mickey 
Stein (http://marc.theaimsgroup.com/?l=linux-kernel&m=110919738708916&w=2).

--------------010303030401050901050802
Content-Type: text/plain;
 name="i2c_cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_cleanup.diff"

Clean up some general I2C things.  Fix some grammar and put ()
around all the #defines that are compound to avoid nasty
side-effects.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc4/include/linux/i2c.h
===================================================================
--- linux-2.6.11-rc4.orig/include/linux/i2c.h
+++ linux-2.6.11-rc4/include/linux/i2c.h
@@ -190,7 +190,7 @@
 	char name[32];				/* textual description 	*/
 	unsigned int id;
 
-	/* If an adapter algorithm can't to I2C-level access, set master_xfer
+	/* If an adapter algorithm can't do I2C-level access, set master_xfer
 	   to NULL. If an adapter algorithm can do SMBus access, set 
 	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
 	   using common I2C messages */
@@ -423,22 +423,22 @@
 #define I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC  0x40000000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC 0x80000000 /* SMBus 2.0 */
 
-#define I2C_FUNC_SMBUS_BYTE I2C_FUNC_SMBUS_READ_BYTE | \
-                            I2C_FUNC_SMBUS_WRITE_BYTE
-#define I2C_FUNC_SMBUS_BYTE_DATA I2C_FUNC_SMBUS_READ_BYTE_DATA | \
-                                 I2C_FUNC_SMBUS_WRITE_BYTE_DATA
-#define I2C_FUNC_SMBUS_WORD_DATA I2C_FUNC_SMBUS_READ_WORD_DATA | \
-                                 I2C_FUNC_SMBUS_WRITE_WORD_DATA
-#define I2C_FUNC_SMBUS_BLOCK_DATA I2C_FUNC_SMBUS_READ_BLOCK_DATA | \
-                                  I2C_FUNC_SMBUS_WRITE_BLOCK_DATA
-#define I2C_FUNC_SMBUS_I2C_BLOCK I2C_FUNC_SMBUS_READ_I2C_BLOCK | \
-                                  I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
-#define I2C_FUNC_SMBUS_I2C_BLOCK_2 I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 | \
-                                   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2
-#define I2C_FUNC_SMBUS_BLOCK_DATA_PEC I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC | \
-                                      I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC
-#define I2C_FUNC_SMBUS_WORD_DATA_PEC  I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
-                                      I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC
+#define I2C_FUNC_SMBUS_BYTE (I2C_FUNC_SMBUS_READ_BYTE | \
+                             I2C_FUNC_SMBUS_WRITE_BYTE)
+#define I2C_FUNC_SMBUS_BYTE_DATA (I2C_FUNC_SMBUS_READ_BYTE_DATA | \
+                                  I2C_FUNC_SMBUS_WRITE_BYTE_DATA)
+#define I2C_FUNC_SMBUS_WORD_DATA (I2C_FUNC_SMBUS_READ_WORD_DATA | \
+                                  I2C_FUNC_SMBUS_WRITE_WORD_DATA)
+#define I2C_FUNC_SMBUS_BLOCK_DATA (I2C_FUNC_SMBUS_READ_BLOCK_DATA | \
+                                   I2C_FUNC_SMBUS_WRITE_BLOCK_DATA)
+#define I2C_FUNC_SMBUS_I2C_BLOCK (I2C_FUNC_SMBUS_READ_I2C_BLOCK | \
+                                  I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)
+#define I2C_FUNC_SMBUS_I2C_BLOCK_2 (I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 | \
+                                    I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2)
+#define I2C_FUNC_SMBUS_BLOCK_DATA_PEC (I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC | \
+                                       I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC)
+#define I2C_FUNC_SMBUS_WORD_DATA_PEC  (I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
+                                       I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC)
 
 #define I2C_FUNC_SMBUS_READ_BYTE_PEC		I2C_FUNC_SMBUS_READ_BYTE_DATA
 #define I2C_FUNC_SMBUS_WRITE_BYTE_PEC		I2C_FUNC_SMBUS_WRITE_BYTE_DATA
@@ -447,14 +447,14 @@
 #define I2C_FUNC_SMBUS_BYTE_PEC			I2C_FUNC_SMBUS_BYTE_DATA
 #define I2C_FUNC_SMBUS_BYTE_DATA_PEC		I2C_FUNC_SMBUS_WORD_DATA
 
-#define I2C_FUNC_SMBUS_EMUL I2C_FUNC_SMBUS_QUICK | \
-                            I2C_FUNC_SMBUS_BYTE | \
-                            I2C_FUNC_SMBUS_BYTE_DATA | \
-                            I2C_FUNC_SMBUS_WORD_DATA | \
-                            I2C_FUNC_SMBUS_PROC_CALL | \
-                            I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
-                            I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC | \
-                            I2C_FUNC_SMBUS_I2C_BLOCK
+#define I2C_FUNC_SMBUS_EMUL (I2C_FUNC_SMBUS_QUICK | \
+                             I2C_FUNC_SMBUS_BYTE | \
+                             I2C_FUNC_SMBUS_BYTE_DATA | \
+                             I2C_FUNC_SMBUS_WORD_DATA | \
+                             I2C_FUNC_SMBUS_PROC_CALL | \
+                             I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
+                             I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC | \
+                             I2C_FUNC_SMBUS_I2C_BLOCK)
 
 /* 
  * Data for SMBus Messages 

--------------010303030401050901050802--
