Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVBBEAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVBBEAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 23:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVBBDDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:03:41 -0500
Received: from [211.58.254.17] ([211.58.254.17]:2954 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262231AbVBBCvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:51:48 -0500
Date: Wed, 2 Feb 2005 11:51:42 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 09/29] ide: __ide_do_rw_disk() lba48 dma check fix
Message-ID: <20050202025142.GJ621@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 09_ide_do_rw_disk_lba48_dma_check_fix.patch
> 
> 	In __ide_do_rw_disk(), the shifted block, instead of the
> 	original rq->sector, should be used when checking range for
> 	lba48 dma.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-disk.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-disk.c	2005-02-02 10:27:15.819213531 +0900
+++ linux-ide-export/drivers/ide/ide-disk.c	2005-02-02 10:28:03.898413061 +0900
@@ -132,7 +132,7 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 	nsectors.all		= (u16) rq->nr_sectors;
 
 	if (hwif->no_lba48_dma && lba48 && dma) {
-		if (rq->sector + rq->nr_sectors > 1ULL << 28)
+		if (block + rq->nr_sectors > 1ULL << 28)
 			dma = 0;
 	}
 
