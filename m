Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262895AbVA2LOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbVA2LOm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 06:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVA2LOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 06:14:42 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:41230 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262895AbVA2LOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 06:14:39 -0500
Date: Sat, 29 Jan 2005 12:14:55 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Cc: Ian Campbell <icampbell@arcom.com>
Subject: [PATCH 2.4] I2C updates for 2.4.29 (1/3)
Message-Id: <20050129121455.1ee24c88.khali@linux-fr.org>
In-Reply-To: <20050129120235.5c7160e6.khali@linux-fr.org>
References: <20050129120235.5c7160e6.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Original reports and discussion:
http://archives.andrew.net.au/lm-sensors/msg28512.html
http://archives.andrew.net.au/lm-sensors/msg28581.html

Bottom line:
The "bit" and "pcf" i2c algorithms should declare themselves fully I2C
capable, but do not.

Credits go to Ian Campbell for noticing and proposing patches.

This is a backport from Linux 2.6.11-rc1.

--- linux-2.4.29/drivers/i2c/i2c-algo-bit.c.orig	2004-02-18 14:36:31.000000000 +0100
+++ linux-2.4.29/drivers/i2c/i2c-algo-bit.c	2005-01-29 11:33:33.000000000 +0100
@@ -522,8 +522,8 @@
 
 static u32 bit_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
-	       I2C_FUNC_PROTOCOL_MANGLING;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
+	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING;
 }
 
 
--- linux-2.4.29/drivers/i2c/i2c-algo-pcf.c.orig	2005-01-29 11:40:01.000000000 +0100
+++ linux-2.4.29/drivers/i2c/i2c-algo-pcf.c	2005-01-29 11:33:40.000000000 +0100
@@ -435,8 +435,8 @@
 
 static u32 pcf_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
-	       I2C_FUNC_PROTOCOL_MANGLING; 
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
+	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING;
 }
 
 /* -----exported algorithm data: -------------------------------------	*/


-- 
Jean Delvare
http://khali.linux-fr.org/
