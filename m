Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285403AbRLNQSl>; Fri, 14 Dec 2001 11:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285404AbRLNQSc>; Fri, 14 Dec 2001 11:18:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14085 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285403AbRLNQSW>;
	Fri, 14 Dec 2001 11:18:22 -0500
Date: Fri, 14 Dec 2001 17:15:06 +0100
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: lord@sgi.com, gibbs@scsiguy.com, LB33JM16@yahoo.com,
        linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
Message-ID: <20011214161506.GB1180@suse.de>
In-Reply-To: <200112132048.fBDKmog10485@aslan.scsiguy.com> <1008277112.22093.7.camel@jen.americas.sgi.com> <1008278244.22208.12.camel@jen.americas.sgi.com> <20011213.132734.38711065.davem@redhat.com> <20011214151642.GE30529@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011214151642.GE30529@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14 2001, Jens Axboe wrote:
> *.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre11/bio-pre11-5.bz2

Steve Lord caught two typos in the patch, here's an incremental diff
attached. There will also be a bio-pre11-6 at the above location in a
few minutes.

--- linux/drivers/scsi/scsi.c~	Fri Dec 14 11:06:25 2001
+++ linux/drivers/scsi/scsi.c	Fri Dec 14 11:06:46 2001
@@ -2590,7 +2590,6 @@
 	/*
 	 * setup sg memory pools
 	 */
-	ts = 0;
 	for (i = 0; i < SG_MEMPOOL_NR; i++) {
 		struct scsi_host_sg_pool *sgp = scsi_sg_pools + i;
 		int size = scsi_host_sg_pool_sizes[i] * sizeof(struct scatterlist);
--- linux/drivers/scsi/sym53c8xx.c~	Fri Dec 14 11:10:38 2001
+++ linux/drivers/scsi/sym53c8xx.c	Fri Dec 14 11:10:51 2001
@@ -12174,7 +12174,7 @@
 
 		use_sg = map_scsi_sg_data(np, cmd);
 		if (use_sg > MAX_SCATTER) {
-			unmap_scsi_sg_data(np, cmd);
+			unmap_scsi_data(np, cmd);
 			return -1;
 		}
 		data = &cp->phys.data[MAX_SCATTER - use_sg];

-- 
Jens Axboe

