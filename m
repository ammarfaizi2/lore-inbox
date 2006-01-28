Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWA1Wae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWA1Wae (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 17:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWA1Wae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 17:30:34 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30219 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750767AbWA1Wad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 17:30:33 -0500
Date: Sat, 28 Jan 2006 23:30:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: -mm patch] kcalloc(): INT_MAX -> ULONG_MAX
Message-ID: <20060128223032.GP3777@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since size_t has the same size as a long on all architectures, it's 
enough for overflow checks to check against ULONG_MAX.

This change could allow a compiler better optimization (especially in 
the n=1 case).

The practical effect seems to be positive, but quite small:

    text           data     bss      dec            hex filename
21762380        5859870 1848928 29471178        1c1b1ca vmlinux-old
21762211        5859870 1848928 29471009        1c1b121 vmlinux-patched


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 20 Aug 2005

--- linux-2.6.13-rc6-mm1-full/include/linux/slab.h.old	2005-08-20 04:10:09.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/linux/slab.h	2005-08-20 04:11:04.000000000 +0200
@@ -113,7 +113,7 @@
  */
 static inline void *kcalloc(size_t n, size_t size, unsigned int __nocast flags)
 {
-	if (n != 0 && size > INT_MAX / n)
+	if (n != 0 && size > ULONG_MAX / n)
 		return NULL;
 	return kzalloc(n * size, flags);
 }

