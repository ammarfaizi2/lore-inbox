Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290518AbSAYCpT>; Thu, 24 Jan 2002 21:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290516AbSAYCpJ>; Thu, 24 Jan 2002 21:45:09 -0500
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:56074 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S290521AbSAYCo6>;
	Thu, 24 Jan 2002 21:44:58 -0500
Date: Thu, 24 Jan 2002 21:15:45 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.3-pre5: drivers/ieee1394/video1394.c
Message-ID: <Pine.LNX.4.33.0201242111570.7307-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  This patch below updates video1394.c with the updated remap_page_range() 
function. Please review for inclusion. It's against 2.5.3-pre5
Regards,
Frank

--- drivers/ieee1394/video1394.c.old	Thu Jan 24 20:42:11 2002
+++ drivers/ieee1394/video1394.c	Thu Jan 24 21:07:04 2002
@@ -844,7 +844,7 @@
 	reg_write(ohci, OHCI1394_IsoXmitIntMaskSet, 1<<d->ctx);
 }
 
-static int do_iso_mmap(struct ti_ohci *ohci, struct dma_iso_ctx *d, 
+static int do_iso_mmap(struct vm_area_struct *vma, struct ti_ohci *ohci, struct dma_iso_ctx *d, 
 		       const char *adr, unsigned long size)
 {
         unsigned long start=(unsigned long) adr;
@@ -865,7 +865,7 @@
         pos=(unsigned long) d->buf;
         while (size > 0) {
                 page = kvirt_to_pa(pos);
-                if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
+                if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
                         return -EAGAIN;
                 start+=PAGE_SIZE;
                 pos+=PAGE_SIZE;
 

