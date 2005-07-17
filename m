Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVGQPBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVGQPBi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 11:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVGQO7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 10:59:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21004 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261300AbVGQO5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 10:57:35 -0400
Date: Sun, 17 Jul 2005 16:57:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Bob Picco <robert.picco@hp.com>
Subject: [2.6 patch] fix unusual placement of inline keyword in hpet
Message-ID: <20050717145733.GL3613@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
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
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Jesper Juhl on:
- 25 Nov 2004

--- linux-2.6.10-rc2-bk9-orig/drivers/char/hpet.c	2004-11-17 01:19:33.000000000 +0100
+++ linux-2.6.10-rc2-bk9/drivers/char/hpet.c	2004-11-25 00:51:20.000000000 +0100
@@ -99,14 +99,14 @@ static struct hpets *hpets;
 #endif
 
 #ifndef readq
-static unsigned long long __inline readq(void __iomem *addr)
+static inline unsigned long long readq(void __iomem *addr)
 {
 	return readl(addr) | (((unsigned long long)readl(addr + 4)) << 32LL);
 }
 #endif
 
 #ifndef writeq
-static void __inline writeq(unsigned long long v, void __iomem *addr)
+static inline void writeq(unsigned long long v, void __iomem *addr)
 {
 	writel(v & 0xffffffff, addr);
 	writel(v >> 32, addr + 4);



