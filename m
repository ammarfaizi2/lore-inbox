Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWCaUiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWCaUiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWCaUiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:38:09 -0500
Received: from nacho.alt.net ([207.14.113.18]:17284 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S1751333AbWCaUhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:37:34 -0500
Date: Fri, 31 Mar 2006 20:37:30 +0000 (GMT)
To: Jens Axboe <axboe@suse.de>
cc: erich <erich@areca.com.tw>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: about ll_rw_blk.c of void generic_make_request(struct bio *bio)
In-Reply-To: <20060331202202.GH14022@suse.de>
Message-ID: <Pine.LNX.4.64.0603312028500.14317@nacho.alt.net>
References: <001d01c65302$0fee8e10$b100a8c0@erich2003>
	<20060330155804.GP13476@suse.de>
	<Pine.LNX.4.64.0603311700310.14317@nacho.alt.net>
	<Pine.LNX.4.64.0603311748010.14317@nacho.alt.net>
	<20060331202202.GH14022@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2006, Jens Axboe wrote:
> On Fri, Mar 31 2006, Chris Caputo wrote:
> > On Fri, 31 Mar 2006, Chris Caputo wrote:
> > > On Thu, 30 Mar 2006, Jens Axboe wrote:
> > > > I can't really say, from my recollection of leafing over lkml emails, I
> > > > seem to recall someone saying he hit this with a newer kernel where as
> > > > the older one did not?
> > > > 
> > > > What are the sectors exactly it complains about, eg the full line you
> > > > see?
> > > 
> > > I see:
> > > 
> > >   attempt to access beyond end of device
> > >   sdb1: rw=0, want=134744080, limit=128002016
> > 
> > I believe the "rw=0" means that was a simple read request, and not a 
> > read-ahead.
> 
> Correct.
> 
> > 128002016 equals about 62 gigs, which is the correct volume size:
> > 
> >   Filesystem           1K-blocks      Used Available Use% Mounted on
> >   /dev/sdb1             62995364   2832696  56962620   5% /xxx
> > 
> >   /dev/sdb1 on /xxx type ext2 (rw,noatime)
> 
> How are you reproducing this, through the file system (reading files),
> or reading the device? If the former, is the file system definitely
> sound - eg does it pass fsck?

Filesystem level interaction via bonnie++.  Basic repro is, using ccaputo 
user, is:

  mke2fs -j -L /xxx /dev/sdb1
  mount -t ext2 /dev/sdb1 /xxx
  cd /xxx ; mkdir ccaputo ; chown ccaputo ccaputo ; cd ccaputo ; su ccaputo
  /usr/sbin/bonnie++

Filesystem is believed to be sound since it is from a fresh mke2fs.

The one strange thing I do is that I format it as ext3 (-j) but mount it 
as ext2, but I didn't think that would be an issue and I'd be surprised if 
Erich is doing the same in his tests, which also fail, with ext2.  (I do 
it in case I later decide to mount the volume as ext3.)

Chris
