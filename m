Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263049AbVDMAee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbVDMAee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVDMAd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 20:33:56 -0400
Received: from ciistr1.ist.utl.pt ([193.136.128.1]:39314 "EHLO
	ciistr1.ist.utl.pt") by vger.kernel.org with ESMTP id S262931AbVDMAbq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 20:31:46 -0400
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Processes stuck on D state on Dual Opteron
Date: Wed, 13 Apr 2005 01:31:31 +0100
User-Agent: KMail/1.7.1
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au
References: <200504050316.20644.ctpm@rnl.ist.utl.pt> <200504120122.48168.ctpm@rnl.ist.utl.pt> <20050411174654.536e1d79.akpm@osdl.org>
In-Reply-To: <20050411174654.536e1d79.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504130131.31319.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday 12 April 2005 01:46, Andrew Morton wrote:
> Claudio Martins <ctpm@rnl.ist.utl.pt> wrote:
> >   I think I'm going to give a try to Neil's patch, but I'll have to apply
> > some patches from -mm.
>
> Just this one if you're using 2.6.12-rc2:
>
> --- 25/drivers/md/md.c~avoid-deadlock-in-sync_page_io-by-using-gfp_noio Mon
> Apr 11 16:55:07 2005 +++ 25-akpm/drivers/md/md.c Mon Apr 11 16:55:07 2005
> @@ -332,7 +332,7 @@ static int bi_complete(struct bio *bio,
>  static int sync_page_io(struct block_device *bdev, sector_t sector, int
> size, struct page *page, int rw)
>  {
> - struct bio *bio = bio_alloc(GFP_KERNEL, 1);
> + struct bio *bio = bio_alloc(GFP_NOIO, 1);
>   struct completion event;
>   int ret;
>
> _


  Hi Andrew, all,

  Sorry for the delay in reporting. This patch does indeed fix the problem. 
The machine ran stress for almost 15h straight with no problems at all.

 As for Nick's patch  I, too, think it would be nice to be included (once the 
performance problems are sorted out), since it seemed to make the block layer 
more robust and well behaved (at least with stress),  although I didn't run 
performance tests to measure regressions.

  Thanks Nick, Neil, Andrew and all others for your great help with this 
issue. I'll have to put the machine on production now with the patch applied, 
but let me know if I can be of any further help with these issues.

 Thanks

Claudio

