Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTJGLET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 07:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbTJGLET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 07:04:19 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:16280 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262161AbTJGLER
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 07:04:17 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 7 Oct 2003 13:06:04 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: saa7146 driver update
Message-ID: <20031007110603.GA3649@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch adapts the saa7146 driver to the videobuf changes mailed
earier today.

  Gerd

diff -u linux-2.6.0-test6/drivers/media/common/saa7146_vbi.c linux/drivers/media/common/saa7146_vbi.c
--- linux-2.6.0-test6/drivers/media/common/saa7146_vbi.c	2003-10-06 17:44:29.000000000 +0200
+++ linux/drivers/media/common/saa7146_vbi.c	2003-10-06 17:48:03.000000000 +0200
@@ -235,7 +235,7 @@
 		saa7146_pgtable_free(dev->pci, &buf->pt[2]);
 		saa7146_pgtable_alloc(dev->pci, &buf->pt[2]);
 
-		err = videobuf_iolock(dev->pci,&buf->vb);
+		err = videobuf_iolock(dev->pci,&buf->vb,NULL);
 		if (err)
 			goto oops;
 		saa7146_pgtable_build_single(dev->pci, &buf->pt[2], buf->vb.dma.sglist, buf->vb.dma.sglen);
diff -u linux-2.6.0-test6/drivers/media/common/saa7146_video.c linux/drivers/media/common/saa7146_video.c
--- linux-2.6.0-test6/drivers/media/common/saa7146_video.c	2003-10-06 17:45:45.000000000 +0200
+++ linux/drivers/media/common/saa7146_video.c	2003-10-06 17:48:03.000000000 +0200
@@ -1090,7 +1090,8 @@
 
 		q = &fh->video_q;
 		down(&q->lock);
-		err = videobuf_mmap_setup(file,q,gbuffers,gbufsize); // ,V4L2_MEMORY_MMAP);
+		err = videobuf_mmap_setup(file,q,gbuffers,gbufsize,
+					  V4L2_MEMORY_MMAP);
 		if (err < 0) {
 			up(&q->lock);
 			return err;
@@ -1185,7 +1186,7 @@
 			saa7146_pgtable_alloc(dev->pci, &buf->pt[0]);
 		}
 		
-		err = videobuf_iolock(dev->pci,&buf->vb);
+		err = videobuf_iolock(dev->pci,&buf->vb,NULL);
 		if (err)
 			goto oops;
 		err = saa7146_pgtable_build(dev,buf);

-- 
You have a new virus in /var/mail/kraxel
