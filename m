Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317591AbSGEWmX>; Fri, 5 Jul 2002 18:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSGEWmW>; Fri, 5 Jul 2002 18:42:22 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:35082
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317591AbSGEWmW>; Fri, 5 Jul 2002 18:42:22 -0400
Date: Fri, 5 Jul 2002 15:43:16 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org,
       sullivan@austin.ibm.com
Subject: Re: [BUG-2.5.24-BK] DriverFS panics on boot!
In-Reply-To: <20020705073845.GJ1007@suse.de>
Message-ID: <Pine.LNX.4.10.10207051526400.25668-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens, those numbers have meaning regardless.
The simple fact that "reads" were nearly constant dictats that small reads
suffer a penality, while small writes only suffered disk limitations for
the most part.

To prove it yourself just set the max_sectors to 16 or 8k.

The object is to get you to try it out and see, and maybe backport
something to try async io's based on direction for 2.4.

Cheers,

On Fri, 5 Jul 2002, Jens Axboe wrote:

> On Thu, Jul 04 2002, Andre Hedrick wrote:
> > On Fri, 5 Jul 2002, Jens Axboe wrote:
> > 
> > > On Thu, Jul 04 2002, Andre Hedrick wrote:
> > > > 	1) 8K writes and 64K (or larger) reads.
> > > 
> > > I've heard this before, but noone seems to have tested it yet. You know,
> > > this is a couple of lines of change in ll_rw_blk.c and blkdev.h to
> > > support this. Any reason you haven't done that, benched, and submitted
> > > something to that effect? I'll even walk you through the 2.5 changes
> > > needed to do this:
> > 
> > 
> > [root@localhost mnt2]# bonnie -s 256
> 
> [snip bonnie results]
> 
> These mean nothing to me -- what are they, the base line or the changed
> kernel? Or none of the above?!
> 
> > Using the hardware to help us and by working with it it, once can
> > basically boost the write and slash the cpu usage.
> 
> You need to add some context to that statement.
> 
> > > > 	2) ONE maybe TWO passes on elevator operations.
> > > 
> > > Explain.
> > 
> > On writes restrict which are small the ordering is almost instant.
> > Specifically ONE maybe TWO passes will sort.
> > 
> > Reads may need more as we optimize best on big reads.
> 
> So you are saying that writes don't need to be reordered as much,
> because the drive typically does that? I guess that will always be true
> with write back caching, I doubt that holds for write through.
> 
> And I don't quite follow the number of passes you compare, passes of
> what? Insert and merge are a single pass per request, tops.
> 
> -- 
> Jens Axboe
> 

Andre Hedrick
LAD Storage Consulting Group

