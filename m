Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265481AbUE0WBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265481AbUE0WBn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 18:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265492AbUE0WBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 18:01:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:7066 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265481AbUE0WB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 18:01:27 -0400
Subject: [PATCH] ppc32: Fix typo in USB sleep code on intrepid based laptops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085694966.7835.123.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 28 May 2004 07:56:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew !

This patch fixes a typo in the low level platform code that puts to
sleep and wakes up the USB cell. This fixes a problem when pmdisk is
used on those machines (pmdisk patch not merged yet, soon maybe...)

From: Guido Guenther <agx@sigxcpu.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff -ub -Naur ../linux-2.6.6.orig/arch/ppc/platforms/pmac_feature.c ./arch/ppc/platforms/pmac_feature.c
--- ../linux-2.6.6.orig/arch/ppc/platforms/pmac_feature.c	2004-05-09 23:33:19.000000000 -0300
+++ ./arch/ppc/platforms/pmac_feature.c	2004-05-26 16:23:47.000000000 -0300
@@ -1156,7 +1156,7 @@
 			(void)MACIO_IN32(KEYLARGO_FCR1);
 			mdelay(1);
 			LOCK(flags);
-			MACIO_BIS(KEYLARGO_FCR0, KL1_USB2_CELL_ENABLE);
+			MACIO_BIS(KEYLARGO_FCR1, KL1_USB2_CELL_ENABLE);
 		}
 		if (number < 4) {
 			reg = MACIO_IN32(KEYLARGO_FCR4);


