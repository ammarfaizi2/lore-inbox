Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbTJOL6R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 07:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbTJOL6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 07:58:16 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:56850 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262938AbTJOL6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 07:58:15 -0400
Date: Wed, 15 Oct 2003 21:57:40 +1000
To: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [SCSI] Set max_phys_segments to sg_tablesize
Message-ID: <20031015115740.GA23469@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

Many SCSI host drivers assume that use_sg will be <= sg_tablesize.
Hence they may break under 2.6 as the number of physical segments
is not limited by sg_tablesize.  This patch fixes that.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
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

--gKMricLos+KVdGMg--
