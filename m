Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318749AbSIKNDN>; Wed, 11 Sep 2002 09:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318751AbSIKNDM>; Wed, 11 Sep 2002 09:03:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15781 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318749AbSIKNDM>;
	Wed, 11 Sep 2002 09:03:12 -0400
Date: Wed, 11 Sep 2002 15:07:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] highmem I/O for ide-pmac.c
Message-ID: <20020911130754.GM1089@suse.de>
References: <15743.15275.412038.388540@argo.ozlabs.ibm.com> <20020911130209.GL1089@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020911130209.GL1089@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11 2002, Jens Axboe wrote:
> Also, can you grow sg segments indefinitely?

Maybe you copied that from ide-dma? I think it would be safer to just
remove it, btw, there's no (if any) benefit to making the sg segments
bigger than a page since we'll much sooner hit the max sectors
limitation than the segment one.

Marcelo, please apply.

--- drivers/ide/ide-dma.c~	2002-09-11 15:06:48.000000000 +0200
+++ drivers/ide/ide-dma.c	2002-09-11 15:07:26.000000000 +0200
@@ -268,15 +268,6 @@
 		struct scatterlist *sge;
 
 		/*
-		 * continue segment from before?
-		 */
-		if (bh_phys(bh) == lastdataend) {
-			sg[nents - 1].length += bh->b_size;
-			lastdataend += bh->b_size;
-			continue;
-		}
-
-		/*
 		 * start new segment
 		 */
 		if (nents >= PRD_ENTRIES)

-- 
Jens Axboe

