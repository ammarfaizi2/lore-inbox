Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVGZOyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVGZOyE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 10:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVGZOyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 10:54:03 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12805 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261828AbVGZOx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 10:53:56 -0400
Date: Tue, 26 Jul 2005 16:53:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/linux/bio.h: "extern inline" -> "static inline"
Message-ID: <20050726145344.GO3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

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

