Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263006AbUKYHRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbUKYHRU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 02:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbUKYHRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 02:17:20 -0500
Received: from zeus.kernel.org ([204.152.189.113]:26263 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263006AbUKYHPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 02:15:46 -0500
Date: Thu, 25 Nov 2004 08:11:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: neilb@cse.unsw.edu.au, phil@dier.us, linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm, and xfs
Message-ID: <20041125071114.GC10233@suse.de>
References: <20041122130622.27edf3e6.phil@dier.us> <20041122161725.21adb932.akpm@osdl.org> <16805.5470.892995.589150@cse.unsw.edu.au> <20041124155038.3716b8a5.akpm@osdl.org> <16805.9199.955186.236115@cse.unsw.edu.au> <20041125065728.GA10233@suse.de> <20041124230838.4d639c6d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124230838.4d639c6d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24 2004, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > On Thu, Nov 25 2004, Neil Brown wrote:
> > > On Wednesday November 24, akpm@osdl.org wrote:
> > > > Neil Brown <neilb@cse.unsw.edu.au> wrote:
> > > > >
> > > > > Would the following (untested-but-seems-to-compile -
> > > > > explanation-of-concept) patch be at all reasonable to avoid stack
> > > > > depth problems with stacked block devices, or is adding stuff to
> > > > > task_struct frowned upon? 
> > > > 
> > > > It's always a tradeoff - we've put things in task_struct before to get
> > > > around sticky situations.  Certainly, removing potentially unbounded stack
> > > > utilisation is a worthwhile thing to do.
> > > > 
> > > > The patch bends my brain a bit.
> > > 
> > > Recursion is like that (... like recursion, that is :-).
> > 
> > Pardon my ignorance, but where is the bug that called for something like
> > this?
> 
> Well there was an xfs-on-raid-on-lvm stack overrun reported, but the
> general problem we're addressing here is that stacking drivers can cause
> arbitrary amounts of kernel stack windup.

Ok. Without b[] on the stack locally, I don't think it's an issue.

> > I can't say I love the idea of adding a bio list structure to the
> > tasklist, it feels pretty hacky. generic_make_request() doesn't really
> > use that much stack, if you just kill the BDEVNAME_SIZE struct.
> 
> Looks like a sensible thing to do, although it would be tidier to move the
> whole thing into a separate function, no?

Yep, works for me.

-- 
Jens Axboe

