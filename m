Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVB0Etq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVB0Etq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 23:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVB0Etq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 23:49:46 -0500
Received: from B3114.karlshof.wh.tu-darmstadt.de ([130.83.219.14]:62106 "HELO
	B3114.karlshof.wh.tu-darmstadt.de") by vger.kernel.org with SMTP
	id S261346AbVB0Etp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 23:49:45 -0500
To: greg@kroah.com
Subject: [PATCH] possible bug in i2c-algo-bit's inb function
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com,
       simon@tk.uni-linz.ac.at
Message-Id: <E1D5GN2-0000Bi-KG@localhost.localdomain>
From: Andreas Oberritter <obi@saftware.de>
Date: Sun, 27 Feb 2005 05:49:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while writing a driver for a cardbus card which is supposed to use the
bit-banging algorithm I noticed that communication with the I2C slave
(Philips TDA10046) would fail without this patch. It forces SDA to high
for every bit in i2c_inb() instead of once per byte. Can this patch go
into the mainline kernel or will this break other drivers? I am using
Kernel version 2.6.10.

Signed-off-by: Andreas Oberritter <obi@saftware.de>

--- linux-2.6/drivers/i2c/algos/i2c-algo-bit.c.orig	2005-02-27 04:39:33.663444536 +0100
+++ linux-2.6/drivers/i2c/algos/i2c-algo-bit.c	2005-02-27 04:39:54.978204200 +0100
@@ -197,8 +197,8 @@ static int i2c_inb(struct i2c_adapter *i
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 
 	/* assert: scl is low */
-	sdahi(adap);
 	for (i=0;i<8;i++) {
+		sdahi(adap);
 		if (sclhi(adap)<0) { /* timeout */
 			DEB2(printk(KERN_DEBUG " i2c_inb: timeout at bit #%d\n", 7-i));
 			return -ETIMEDOUT;
