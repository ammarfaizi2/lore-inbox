Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVDLArM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVDLArM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 20:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVDLArM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 20:47:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:58005 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261994AbVDLArJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 20:47:09 -0400
Date: Mon, 11 Apr 2005 17:46:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Claudio Martins <ctpm@rnl.ist.utl.pt>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au
Subject: Re: Processes stuck on D state on Dual Opteron
Message-Id: <20050411174654.536e1d79.akpm@osdl.org>
In-Reply-To: <200504120122.48168.ctpm@rnl.ist.utl.pt>
References: <200504050316.20644.ctpm@rnl.ist.utl.pt>
	<200504111505.44284.ctpm@rnl.ist.utl.pt>
	<425B013A.5020108@yahoo.com.au>
	<200504120122.48168.ctpm@rnl.ist.utl.pt>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Claudio Martins <ctpm@rnl.ist.utl.pt> wrote:
>
>   I think I'm going to give a try to Neil's patch, but I'll have to apply some 
>  patches from -mm.

Just this one if you're using 2.6.12-rc2:

--- 25/drivers/md/md.c~avoid-deadlock-in-sync_page_io-by-using-gfp_noio	Mon Apr 11 16:55:07 2005
+++ 25-akpm/drivers/md/md.c	Mon Apr 11 16:55:07 2005
@@ -332,7 +332,7 @@ static int bi_complete(struct bio *bio, 
 static int sync_page_io(struct block_device *bdev, sector_t sector, int size,
 		   struct page *page, int rw)
 {
-	struct bio *bio = bio_alloc(GFP_KERNEL, 1);
+	struct bio *bio = bio_alloc(GFP_NOIO, 1);
 	struct completion event;
 	int ret;
 
_

