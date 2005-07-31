Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVGaW1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVGaW1Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVGaW1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:27:25 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27147 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262013AbVGaW0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:26:18 -0400
Date: Mon, 1 Aug 2005 00:26:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/linux/bio.h: "extern inline" -> "static inline"
Message-ID: <20050731222617.GQ3608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.

This patch was already ACK'ed by Jens Axboe.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 26 Jul 2005

 include/linux/bio.h |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.13-rc3-mm1-full/include/linux/bio.h.old	2005-07-26 13:40:47.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/include/linux/bio.h	2005-07-26 13:41:13.000000000 +0200
@@ -314,9 +314,8 @@
  * bvec_kmap_irq and bvec_kunmap_irq!!
  *
  * This function MUST be inlined - it plays with the CPU interrupt flags.
- * Hence the `extern inline'.
  */
-extern inline char *bvec_kmap_irq(struct bio_vec *bvec, unsigned long *flags)
+static inline char *bvec_kmap_irq(struct bio_vec *bvec, unsigned long *flags)
 {
 	unsigned long addr;
 
@@ -332,7 +331,7 @@
 	return (char *) addr + bvec->bv_offset;
 }
 
-extern inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
+static inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
 {
 	unsigned long ptr = (unsigned long) buffer & PAGE_MASK;
 
@@ -345,7 +344,7 @@
 #define bvec_kunmap_irq(buf, flags)	do { *(flags) = 0; } while (0)
 #endif
 
-extern inline char *__bio_kmap_irq(struct bio *bio, unsigned short idx,
+static inline char *__bio_kmap_irq(struct bio *bio, unsigned short idx,
 				   unsigned long *flags)
 {
 	return bvec_kmap_irq(bio_iovec_idx(bio, idx), flags);

