Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265634AbUFCQVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265634AbUFCQVA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUFCQVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:21:00 -0400
Received: from [193.232.119.74] ([193.232.119.74]:46725 "EHLO thong.s2s.msu.ru")
	by vger.kernel.org with ESMTP id S265634AbUFCQU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:20:57 -0400
Date: Thu, 3 Jun 2004 20:20:53 +0400
From: "Alexander V. Inyukhin" <shurick@sectorb.msk.ru>
To: linux-kernel@vger.kernel.org
Subject: i2c-matroxfb and i2c initialization order
Message-ID: <20040603162053.GA5016@shurick.s2s.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Since i2c-matroxfb is initialized before i2c subsystem,
there are troubles with accessing this module
via i2c interface.

I solved this problem using a patch attached.

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.26-i2c.patch"

--- Makefile.orig	2004-06-03 18:29:04.000000000 +0400
+++ Makefile	2004-06-03 18:29:19.000000000 +0400
@@ -175,6 +175,7 @@
 DRIVERS-$(CONFIG_PPC32) += drivers/macintosh/macintosh.o
 DRIVERS-$(CONFIG_MAC) += drivers/macintosh/macintosh.o
 DRIVERS-$(CONFIG_ISAPNP) += drivers/pnp/pnp.o
+DRIVERS-$(CONFIG_I2C) += drivers/i2c/i2c.o
 DRIVERS-$(CONFIG_VT) += drivers/video/video.o
 DRIVERS-$(CONFIG_PARIDE) += drivers/block/paride/paride.a
 DRIVERS-$(CONFIG_HAMRADIO) += drivers/net/hamradio/hamradio.o
@@ -186,7 +187,6 @@
 DRIVERS-$(CONFIG_HIL) += drivers/hil/hil.o
 DRIVERS-$(CONFIG_I2O) += drivers/message/i2o/i2o.o
 DRIVERS-$(CONFIG_IRDA) += drivers/net/irda/irda.o
-DRIVERS-$(CONFIG_I2C) += drivers/i2c/i2c.o
 DRIVERS-$(CONFIG_PHONE) += drivers/telephony/telephony.o
 DRIVERS-$(CONFIG_MD) += drivers/md/mddev.o
 DRIVERS-$(CONFIG_GSC) += drivers/gsc/gscbus.o

--WIyZ46R2i8wDzkSu--
