Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbUKYCEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbUKYCEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 21:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUKYCEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 21:04:39 -0500
Received: from mail.dif.dk ([193.138.115.101]:8080 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261458AbUKYCEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 21:04:33 -0500
Date: Thu, 25 Nov 2004 00:59:53 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Bob Picco <robert.picco@hp.com>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [patch] fix unusual placement of inline keyword in hpet ...
Message-ID: <Pine.LNX.4.61.0411250052290.3447@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trivial path to get rid of 
drivers/char/hpet.c:102: warning: `inline' is not at beginning of declaration
drivers/char/hpet.c:109: warning: `inline' is not at beginning of declaration
when building with gcc -W

Patch makes no actual code changes, just reduces the number of warnings 
peole have to sift through when using -W to look for trouble spots.
Please apply.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk9-orig/drivers/char/hpet.c linux-2.6.10-rc2-bk9/drivers/char/hpet.c
--- linux-2.6.10-rc2-bk9-orig/drivers/char/hpet.c	2004-11-17 01:19:33.000000000 +0100
+++ linux-2.6.10-rc2-bk9/drivers/char/hpet.c	2004-11-25 00:51:20.000000000 +0100
@@ -99,14 +99,14 @@ static struct hpets *hpets;
 #endif
 
 #ifndef readq
-static unsigned long long __inline readq(void __iomem *addr)
+static __inline unsigned long long readq(void __iomem *addr)
 {
 	return readl(addr) | (((unsigned long long)readl(addr + 4)) << 32LL);
 }
 #endif
 
 #ifndef writeq
-static void __inline writeq(unsigned long long v, void __iomem *addr)
+static __inline void writeq(unsigned long long v, void __iomem *addr)
 {
 	writel(v & 0xffffffff, addr);
 	writel(v >> 32, addr + 4);



