Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbTJOMOx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 08:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbTJOMOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 08:14:52 -0400
Received: from fep07-0.kolumbus.fi ([193.229.0.51]:46704 "EHLO
	fep07-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262982AbTJOMOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 08:14:51 -0400
X-Mailer: Openwave WebEngine, version 2.8.10 (webedge20-101-191-20030113)
From: <mika.penttila@kolumbus.fi>
To: Herbert Xu <herbert@gondor.apana.org.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [SCSI] Set max_phys_segments to sg_tablesize
Date: Wed, 15 Oct 2003 15:14:49 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=____1066220089775_5eEc-n.1jT"
Message-Id: <20031015121449.CROQ7495.fep07-app.kolumbus.fi@mta.imail.kolumbus.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=____1066220089775_5eEc-n.1jT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

> Many SCSI host drivers assume that use_sg will be <= sg_tablesize.
> Hence they may break under 2.6 as the number of physical segments
> is not limited by sg_tablesize.  This patch fixes that.
> 

Physical segments don't matter,  hw segments does and it's bounded by sg_tablesize.

--Mika


------=____1066220089775_5eEc-n.1jT
Content-Type: text/plain; charset=us-ascii;
	name="p"
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/drivers/scsi/scsi_lib.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/scsi/scsi_lib.c,v
retrieving revision 1.1.1.16
diff -u -r1.1.1.16 scsi_lib.c
--- kernel-source-2.5/drivers/scsi/scsi_lib.c	28 Sep 2003 04:44:15 -0000	1.1.1.16
+++ kernel-source-2.5/drivers/scsi/scsi_lib.c	15 Oct 2003 11:32:20 -0000
@@ -1243,7 +1243,7 @@
 	blk_queue_prep_rq(q, scsi_prep_fn);
 
 	blk_queue_max_hw_segments(q, shost->sg_tablesize);
-	blk_queue_max_phys_segments(q, MAX_PHYS_SEGMENTS);
+	blk_queue_max_phys_segments(q, shost->sg_tablesize);
 	blk_queue_max_sectors(q, shost->max_sectors);
 	blk_queue_bounce_limit(q, scsi_calculate_bounce_limit(shost));
 	blk_queue_segment_boundary(q, shost->dma_boundary);


------=____1066220089775_5eEc-n.1jT--

