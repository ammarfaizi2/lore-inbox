Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270163AbSISG5y>; Thu, 19 Sep 2002 02:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270165AbSISG5y>; Thu, 19 Sep 2002 02:57:54 -0400
Received: from smtp2.sooninternet.net ([212.246.17.84]:16381 "EHLO
	smtp2.sooninternet.net") by vger.kernel.org with ESMTP
	id <S270163AbSISG5x>; Thu, 19 Sep 2002 02:57:53 -0400
Date: Thu, 19 Sep 2002 10:02:40 +0300
From: Kari Hameenaho <khaho@koti.soon.fi>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] to fix 2.5.36 MTRR for X  (Was: X freezes and input problems)
Message-Id: <20020919100240.41be5687.khaho@koti.soon.fi>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes MTRR for me, restoring the mtrr_add_page() old return value behaviour that X seems to need.

The input problem (mouse pointer jumping) seems to be in sylpheed only, so it is application problem. 

diff -urN linux-2.5.36/arch/i386/kernel/cpu/mtrr/main.c linux-2.5.36-kjh/arch/i386/kernel/cpu/mtrr/main.c
--- linux-2.5.36/arch/i386/kernel/cpu/mtrr/main.c	Wed Sep 18 03:58:43 2002+++ linux-2.5.36-kjh/arch/i386/kernel/cpu/mtrr/main.c	Thu Sep 19 09:33:06 2002@@ -348,6 +348,7 @@
 			       "mtrr: 0x%lx000,0x%lx000 overlaps existing"
 			       " 0x%lx000,0x%lx000\n", base, size, lbase,
 			       lsize);
+			error = -EINVAL;
 			goto out;
 		}
 		/*  New region is enclosed by an existing region  */
@@ -357,6 +358,7 @@
 			printk ("mtrr: type mismatch for %lx000,%lx000 old: %s new: %s\n",
 			     base, size, attrib_to_str(ltype),
 			     attrib_to_str(type));
+			error = -EINVAL;
 			goto out;
 		}
 		if (increment)

---
Kari Hämeenaho
