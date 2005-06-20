Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVFTVOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVFTVOl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVFTVNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:13:49 -0400
Received: from mail.dif.dk ([193.138.115.101]:6794 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261544AbVFTVF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:05:59 -0400
Date: Mon, 20 Jun 2005 23:11:19 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Luc Saillard <luc@saillard.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][1/3] pwc-uncompress cleanup - whitespace cleanups.
Message-ID: <Pine.LNX.4.62.0506202303050.2369@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes whitespace cleanups to 
drivers/usb/media/pwc/pwc-uncompress.c
It makes the following changes:
 - lines stay within 80 columns.
 - makes testing of pointer vs NULL use the !ptr form consistently, the 
   file was mixing (!ptr) and (ptr == NULL).
 - removes some trailing whitespace.
 - tabs vs spaces fixes.
 - make if statements match CodingStyle
     if (foo) {
       /* ... */
     } else {
       /* ... */
     }
 - remove empty lines at end of file.

There are no functional changes made by the patch.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/usb/media/pwc/pwc-uncompress.c |  135 ++++++++++++++++-----------------
 1 files changed, 67 insertions(+), 68 deletions(-)

--- linux-2.6.12-orig/drivers/usb/media/pwc/pwc-uncompress.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/drivers/usb/media/pwc/pwc-uncompress.c	2005-06-20 22:53:51.000000000 +0200
@@ -38,7 +38,7 @@ int pwc_decompress(struct pwc_device *pd
 	u16 *src;
 	u16 *dsty, *dstu, *dstv;
 
-	if (pdev == NULL)
+	if (!pdev)
 		return -EFAULT;
 #if defined(__KERNEL__) && defined(PWC_MAGIC)
 	if (pdev->magic != PWC_MAGIC) {
@@ -48,7 +48,7 @@ int pwc_decompress(struct pwc_device *pd
 #endif
 
 	fbuf = pdev->read_frame;
-	if (fbuf == NULL)
+	if (!fbuf)
 		return -EFAULT;
 	image = pdev->image_ptr[pdev->fill_image];
 	if (!image)
@@ -57,8 +57,7 @@ int pwc_decompress(struct pwc_device *pd
 	yuv = fbuf->data + pdev->frame_header_size;  /* Skip header */
 
 	/* Raw format; that's easy... */
-	if (pdev->vpalette == VIDEO_PALETTE_RAW)
-	{
+	if (pdev->vpalette == VIDEO_PALETTE_RAW) {
 		memcpy(image, yuv, pdev->frame_size);
 		return 0;
 	}
@@ -69,79 +68,79 @@ int pwc_decompress(struct pwc_device *pd
 		   size). Unfortunately we have to do a bit of byte stuffing
 		   to get the desired output format/size.
 		 */
-			/*
-			 * We do some byte shuffling here to go from the
-			 * native format to YUV420P.
-			 */
-			src = (u16 *)yuv;
-			n = pdev->view.x * pdev->view.y;
-
-			/* offset in Y plane */
-			stride = pdev->view.x * pdev->offset.y + pdev->offset.x;
-			dsty = (u16 *)(image + stride);
-
-			/* offsets in U/V planes */
-			stride = pdev->view.x * pdev->offset.y / 4 + pdev->offset.x / 2;
-			dstu = (u16 *)(image + n +         stride);
-			dstv = (u16 *)(image + n + n / 4 + stride);
-
-			/* increment after each line */
-			stride = (pdev->view.x - pdev->image.x) / 2; /* u16 is 2 bytes */
-
-			for (line = 0; line < pdev->image.y; line++) {
-				for (col = 0; col < pdev->image.x; col += 4) {
-					*dsty++ = *src++;
-					*dsty++ = *src++;
-					if (line & 1)
-						*dstv++ = *src++;
-					else
-						*dstu++ = *src++;
-				}
-				dsty += stride;
+
+		/*
+		 * We do some byte shuffling here to go from the
+		 * native format to YUV420P.
+		 */
+		src = (u16 *)yuv;
+		n = pdev->view.x * pdev->view.y;
+
+		/* offset in Y plane */
+		stride = pdev->view.x * pdev->offset.y + pdev->offset.x;
+		dsty = (u16 *)(image + stride);
+
+		/* offsets in U/V planes */
+		stride = pdev->view.x * pdev->offset.y / 4 + pdev->offset.x / 2;
+		dstu = (u16 *)(image + n +         stride);
+		dstv = (u16 *)(image + n + n / 4 + stride);
+
+		/* increment after each line */
+		stride = (pdev->view.x - pdev->image.x) / 2; /* u16 = 2 bytes */
+
+		for (line = 0; line < pdev->image.y; line++) {
+			for (col = 0; col < pdev->image.x; col += 4) {
+				*dsty++ = *src++;
+				*dsty++ = *src++;
 				if (line & 1)
-					dstv += (stride >> 1);
+					*dstv++ = *src++;
 				else
-					dstu += (stride >> 1);
+					*dstu++ = *src++;
 			}
-	}
-	else {
+			dsty += stride;
+			if (line & 1)
+				dstv += (stride >> 1);
+			else
+				dstu += (stride >> 1);
+		}
+	} else {
 		/* Compressed; the decompressor routines will write the data
 		   in planar format immediately.
 		 */
 		int flags;
                 
-                flags = PWCX_FLAG_PLANAR;
-                if (pdev->vsize == PSZ_VGA && pdev->vframes == 5 && pdev->vsnapshot)
-		 {
-		   printk(KERN_ERR "pwc: Mode Bayer is not supported for now\n");
-		   flags |= PWCX_FLAG_BAYER;
-		   return -ENXIO; /* No such device or address: missing decompressor */
-		 }
-
-		switch (pdev->type)
-		 {
-#if 0		 
-		  case 675:
-		  case 680:
-		  case 690:
-		  case 720:
-		  case 730:
-		  case 740:
-		  case 750:
-		    pwc_dec23_decompress(&pdev->image, &pdev->view, &pdev->offset,
-				yuv, image,
-				flags,
-				pdev->decompress_data, pdev->vbandlength);
-		    break;
-		  case 645:
-		  case 646:
-		    /* TODO & FIXME */
-#endif		    
-		    return -ENXIO; /* No such device or address: missing decompressor */
-		    break;
+		flags = PWCX_FLAG_PLANAR;
+		if (pdev->vsize == PSZ_VGA &&
+		    pdev->vframes == 5 && pdev->vsnapshot) {
+			printk(KERN_ERR 
+			       "pwc: Mode Bayer is not supported for now\n");
+			flags |= PWCX_FLAG_BAYER;
+			/* No such device or address: missing decompressor */
+			return -ENXIO;
+		}
+
+		switch (pdev->type) {
+#if 0
+			case 675:
+			case 680:
+			case 690:
+			case 720:
+			case 730:
+			case 740:
+			case 750:
+				pwc_dec23_decompress(&pdev->image, &pdev->view,
+						&pdev->offset, yuv, image,
+						flags, pdev->decompress_data,
+						pdev->vbandlength);
+				break;
+			case 645:
+			case 646:
+			/* TODO & FIXME */
+#endif
+			/* No such device or address: missing decompressor */
+				return -ENXIO;
+				break;
 		 }
 	}
 	return 0;
 }
-
-




