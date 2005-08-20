Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVHTTcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVHTTcj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 15:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbVHTTcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 15:32:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34059 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750858AbVHTTcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 15:32:39 -0400
Date: Sat, 20 Aug 2005 21:32:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: -mm patch] kcalloc(): INT_MAX -> ULONG_MAX
Message-ID: <20050820193237.GG3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change could (at least in theory) allow a compiler better 
optimization (especially in the n=1 case).

The practical effect seems to be nearly zero:
    text           data     bss      dec            hex filename
25617207        5850138 1827016 33294361        1fc0819 vmlinux-old
25617191        5850138 1827016 33294345        1fc0809 vmlinux-patched

Is there any reason against this patch?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

