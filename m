Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWEWRnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWEWRnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWEWRnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:43:14 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:40662 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932081AbWEWRnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:43:13 -0400
Date: Tue, 23 May 2006 19:43:11 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] -mm: constify drivers/char/keyboard.c
Message-ID: <20060523174311.GA24461@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

patch run-tested on linux-2.6.17-rc4-mm3.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc4-mm3.orig/drivers/char/keyboard.c linux-2.6.17-rc4-mm3.my/drivers/char/keyboard.c
--- linux-2.6.17-rc4-mm3.orig/drivers/char/keyboard.c	2006-05-23 19:14:14.000000000 +0200
+++ linux-2.6.17-rc4-mm3/drivers/char/keyboard.c	2006-05-22 15:47:05.000000000 +0200
@@ -678,7 +678,7 @@
  */
 static void k_dead(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
-	static unsigned char ret_diacr[NR_DEAD] = {'`', '\'', '^', '~', '"', ',' };
+	static const unsigned char ret_diacr[NR_DEAD] = {'`', '\'', '^', '~', '"', ',' };
 	value = ret_diacr[value];
 	k_deadunicode(vc, value, up_flag, regs);
 }
@@ -715,8 +715,8 @@
 
 static void k_pad(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
-	static const char *pad_chars = "0123456789+-*/\015,.?()#";
-	static const char *app_map = "pqrstuvwxylSRQMnnmPQS";
+	static const char pad_chars[] = "0123456789+-*/\015,.?()#";
+	static const char app_map[] = "pqrstuvwxylSRQMnnmPQS";
 
 	if (up_flag)
 		return;		/* no action, if this is a key release */
@@ -1043,7 +1043,7 @@
 #define HW_RAW(dev) (test_bit(EV_MSC, dev->evbit) && test_bit(MSC_RAW, dev->mscbit) &&\
 			((dev)->id.bustype == BUS_I8042) && ((dev)->id.vendor == 0x0001) && ((dev)->id.product == 0x0001))
 
-static unsigned short x86_keycodes[256] =
+static const unsigned short x86_keycodes[256] =
 	{ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
 	 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
 	 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
