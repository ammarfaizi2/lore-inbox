Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317894AbSGPRGs>; Tue, 16 Jul 2002 13:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317891AbSGPRGr>; Tue, 16 Jul 2002 13:06:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58523 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317895AbSGPRGq>;
	Tue, 16 Jul 2002 13:06:46 -0400
Date: Tue, 16 Jul 2002 19:09:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
Message-ID: <20020716170921.GX811@suse.de>
References: <20020716163636.GW811@suse.de> <Pine.LNX.4.44L.0207161349100.3009-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0207161349100.3009-100000@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16 2002, Rik van Riel wrote:
> On Tue, 16 Jul 2002, Jens Axboe wrote:
> > On Tue, Jul 16 2002, Rik van Riel wrote:
> > > On Tue, 16 Jul 2002, Andrew Morton wrote:
> > >
> > > > That's maybe wrong - if there are a decent number of pages
> > > > under writeback then we should be able to just wait it out.
> > > > But it gets tricky with the loop driver...
> > >
> > > I wonder if it is possible to exhaust the mempool with
> > > the loop driver requests before getting around to the
> > > requests to the underlying block device(s)...
> >
> > Given the finite size of the pool and the possibly infinite stacking
> > level, yes that is possible. You may just run out of loop minors before
> > this happens [1]. Also note that you need more than a simple remapping,
> > crypto setup for instance.
> 
> Or maybe SMP, with multiple CPUs submitting requests at the
> same time ?

It would still require a totally pathetic loop setup. More than 2 or 3
stacked loop devices that are not using remapping would crawl
performance wise. Now make that eg 32 "indirections" (allocations and
copies on _each_ i/o), and I think you'll find that the system would be
impossible to use long before this theoretical dead lock would be hit.

-- 
Jens Axboe

