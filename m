Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbUKIBAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbUKIBAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUKIBAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:00:23 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46601 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261332AbUKIA56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 19:57:58 -0500
Date: Tue, 9 Nov 2004 01:57:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [5/11] bttv-risc.c: make some functions static
Message-ID: <20041109005727.GT15077@stusta.de>
References: <20041107175017.GP14308@stusta.de> <20041108114008.GB20607@bytesex> <20041109004341.GO15077@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109004341.GO15077@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some functions in drivers/media/video/bttv-risc.c 
that currently have no other in-kernel users static.


diffstat output:
 drivers/media/video/bttv-risc.c |    8 ++++----
 drivers/media/video/bttvp.h     |   16 ----------------
 2 files changed, 4 insertions(+), 20 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttvp.h.old	2004-11-07 16:34:44.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttvp.h	2004-11-07 16:47:42.000000000 +0100
@@ -173,22 +170,6 @@
 		     struct scatterlist *sglist,
 		     unsigned int offset, unsigned int bpl,
 		     unsigned int pitch, unsigned int lines);
-int bttv_risc_planar(struct bttv *btv, struct btcx_riscmem *risc,
-		     struct scatterlist *sglist,
-		     unsigned int yoffset,  unsigned int ybpl,
-		     unsigned int ypadding, unsigned int ylines,
-		     unsigned int uoffset,  unsigned int voffset,
-		     unsigned int hshift,   unsigned int vshift,
-		     unsigned int cpadding);
-int bttv_risc_overlay(struct bttv *btv, struct btcx_riscmem *risc,
-		      const struct bttv_format *fmt,
-		      struct bttv_overlay *ov,
-		      int skip_top, int skip_bottom);
-
-/* calculate / apply geometry settings */
-void bttv_calc_geo(struct bttv *btv, struct bttv_geometry *geo,
-		   int width, int height, int interleaved, int norm);
-void bttv_apply_geo(struct bttv *btv, struct bttv_geometry *geo, int top);
 
 /* control dma register + risc main loop */
 void bttv_set_dma(struct bttv *btv, int override);
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-risc.c.old	2004-11-07 16:47:52.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-risc.c	2004-11-07 16:48:22.000000000 +0100
@@ -109,7 +109,7 @@
 	return 0;
 }
 
-int
+static int
 bttv_risc_planar(struct bttv *btv, struct btcx_riscmem *risc,
 		 struct scatterlist *sglist,
 		 unsigned int yoffset,  unsigned int ybpl,
@@ -227,7 +227,7 @@
 	return 0;
 }
 
-int
+static int
 bttv_risc_overlay(struct bttv *btv, struct btcx_riscmem *risc,
 		  const struct bttv_format *fmt, struct bttv_overlay *ov,
 		  int skip_even, int skip_odd)
@@ -315,7 +315,7 @@
 
 /* ---------------------------------------------------------- */
 
-void
+static void
 bttv_calc_geo(struct bttv *btv, struct bttv_geometry *geo,
 	      int width, int height, int interleaved, int norm)
 {
@@ -363,7 +363,7 @@
         }
 }
 
-void
+static void
 bttv_apply_geo(struct bttv *btv, struct bttv_geometry *geo, int odd)
 {
         int off = odd ? 0x80 : 0x00;

