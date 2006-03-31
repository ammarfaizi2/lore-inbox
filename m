Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWCaSJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWCaSJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWCaSJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:09:19 -0500
Received: from nacho.alt.net ([207.14.113.18]:18335 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S932184AbWCaSJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:09:18 -0500
Date: Fri, 31 Mar 2006 18:09:14 +0000 (GMT)
To: erich <erich@areca.com.tw>, Jens Axboe <axboe@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: about ll_rw_blk.c of void generic_make_request(struct bio *bio)
In-Reply-To: <Pine.LNX.4.64.0603311700310.14317@nacho.alt.net>
Message-ID: <Pine.LNX.4.64.0603311748010.14317@nacho.alt.net>
References: <001d01c65302$0fee8e10$b100a8c0@erich2003>
	<20060330155804.GP13476@suse.de>
	<Pine.LNX.4.64.0603311700310.14317@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2006, Chris Caputo wrote:
> On Thu, 30 Mar 2006, Jens Axboe wrote:
> > I can't really say, from my recollection of leafing over lkml emails, I
> > seem to recall someone saying he hit this with a newer kernel where as
> > the older one did not?
> > 
> > What are the sectors exactly it complains about, eg the full line you
> > see?
> 
> I see:
> 
>   attempt to access beyond end of device
>   sdb1: rw=0, want=134744080, limit=128002016

I believe the "rw=0" means that was a simple read request, and not a 
read-ahead.

128002016 equals about 62 gigs, which is the correct volume size:

  Filesystem           1K-blocks      Used Available Use% Mounted on
  /dev/sdb1             62995364   2832696  56962620   5% /xxx

  /dev/sdb1 on /xxx type ext2 (rw,noatime)

I'm at a loss as to why ext2 would want to read 3+ gigs past the end of 
the volume or why the arcmsr driver setting max_sectors to be 4096 instead 
of 512 makes a difference.

Erich, while using 4096 as the max_sectors count, in your lab can you make 
it so ll_rw_blk.c:handle_bad_sector() makes a call to dump_stack() after 
the printk's?  What does it show as the call trace?

Chris
