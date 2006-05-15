Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965235AbWEOVP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbWEOVP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbWEOVP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:15:29 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:54438 "EHLO
	pne-smtpout4-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S965235AbWEOVP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:15:28 -0400
Message-Id: <20060515211506.272519000@gmail.com>
References: <20060515211229.521198000@gmail.com>
User-Agent: quilt/0.44-1
Date: Tue, 16 May 2006 00:12:31 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch 02/11] input: fix accuracy of fixp-arith.h
Content-Disposition: inline; filename=ff-refactoring-fixp-arith-accuracy.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the value of cos(90) = 0 to the table. This also moves the results so that
sin(x) == sin(180-x) is true as expected.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/input/fixp-arith.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.16-git20/drivers/input/fixp-arith.h
===================================================================
--- linux-2.6.16-git20.orig/drivers/input/fixp-arith.h	2006-04-10 21:02:50.000000000 +0300
+++ linux-2.6.16-git20/drivers/input/fixp-arith.h	2006-04-10 21:03:45.000000000 +0300
@@ -38,13 +38,13 @@ typedef s16 fixp_t;
 #define FRAC_MASK ((1<<FRAC_N)-1)
 
 // Not to be used directly. Use fixp_{cos,sin}
-static const fixp_t cos_table[45] = {
+static const fixp_t cos_table[46] = {
 	0x0100,	0x00FF,	0x00FF,	0x00FE,	0x00FD,	0x00FC,	0x00FA,	0x00F8,
 	0x00F6,	0x00F3,	0x00F0,	0x00ED,	0x00E9,	0x00E6,	0x00E2,	0x00DD,
 	0x00D9,	0x00D4,	0x00CF,	0x00C9,	0x00C4,	0x00BE,	0x00B8,	0x00B1,
 	0x00AB,	0x00A4,	0x009D,	0x0096,	0x008F,	0x0087,	0x0080,	0x0078,
 	0x0070,	0x0068,	0x005F,	0x0057,	0x004F,	0x0046,	0x003D,	0x0035,
-	0x002C,	0x0023,	0x001A,	0x0011,	0x0008
+	0x002C,	0x0023,	0x001A,	0x0011,	0x0008, 0x0000
 };
 
 
@@ -69,7 +69,7 @@ static inline fixp_t fixp_cos(unsigned i
 	unsigned int i = degrees % 90;
 
 	if (quadrant == 1 || quadrant == 3) {
-		i = 89 - i;
+		i = 90 - i;
 	}
 
 	i >>= 1;

--
Anssi Hannula
