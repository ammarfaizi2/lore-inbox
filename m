Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbVHLShk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbVHLShk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVHLShk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:37:40 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:28809
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S1750897AbVHLShj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:37:39 -0400
Date: Fri, 12 Aug 2005 14:35:48 -0400
From: Sonny Rao <sonny@burdell.org>
To: Phil Dier <phil@icglink.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       ziggy@icglink.com, scott@icglink.com, jack@icglink.com
Subject: Re: 2.6.13-rc6 Oops with Software RAID, LVM, JFS, NFS
Message-ID: <20050812183548.GA2255@kevlar.burdell.org>
References: <20050811105954.31f25407.phil@icglink.com> <17148.1113.664829.360594@cse.unsw.edu.au> <20050812123505.1515634c.phil@icglink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050812123505.1515634c.phil@icglink.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 12:35:05PM -0500, Phil Dier wrote:
> On Fri, 12 Aug 2005 12:07:21 +1000
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> > You could possibly put something like
> > 
> > 	struct bio_vec *from;
> > 	int i;
> > 	bio_for_each_segment(from, bio, i)
> > 		BUG_ON(page_zone(from->bv_page)==NULL);
> > 
> > in generic_make_requst in drivers/block/ll_rw_blk.c, just before
> > the call to q->make_request_fn.
> > This might trigger the bug early enough to see what is happening.
> 
> 
> I've got tests running with this code in place, by I/O is so slow now
> I don't think it's going to oops (or if it does, it'll be a while)..
> 
> Is there any other info I can collect to help track this down?

Well, while we are slowing things down in the name of debugging..
you might try setting the following debug options in your config:

CONFIG_DEBUG_PAGEALLOC
CONFIG_DEBUG_HIGHMEM
CONFIG_DEBUG_SLAB
CONFIG_FRAME_POINTER 

Can anyone think of anything else?

According to the website you don't have these on right now.

Sonny
