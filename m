Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318250AbSGQFh0>; Wed, 17 Jul 2002 01:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318251AbSGQFhZ>; Wed, 17 Jul 2002 01:37:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42698 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318250AbSGQFhX>;
	Wed, 17 Jul 2002 01:37:23 -0400
Date: Wed, 17 Jul 2002 07:40:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
Message-ID: <20020717054006.GZ811@suse.de>
References: <20020716163636.GW811@suse.de> <Pine.LNX.4.44L.0207161349100.3009-100000@duckman.distro.conectiva> <20020716170921.GX811@suse.de> <3D34773C.F61E7C0F@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D34773C.F61E7C0F@pp.inet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16 2002, Jari Ruusu wrote:
> Jens Axboe wrote:
> > On Tue, Jul 16 2002, Rik van Riel wrote:
> > > On Tue, 16 Jul 2002, Jens Axboe wrote:
> > > > On Tue, Jul 16 2002, Rik van Riel wrote:
> > > > Given the finite size of the pool and the possibly infinite stacking
> > > > level, yes that is possible. You may just run out of loop minors before
> > > > this happens [1]. Also note that you need more than a simple remapping,
> > > > crypto setup for instance.
> > >
> > > Or maybe SMP, with multiple CPUs submitting requests at the
> > > same time ?
> > 
> > It would still require a totally pathetic loop setup. More than 2 or 3
> > stacked loop devices that are not using remapping would crawl
> 
> remapping?
> 
> > performance wise. Now make that eg 32 "indirections" (allocations and
> > copies on _each_ i/o), and I think you'll find that the system would be
> > impossible to use long before this theoretical dead lock would be hit.
> 
> Jens,
> 
> Your remapping code has _never_ worked. This is because your remapping is
> supposedly enabled in none_status(), but init hook of type 0 transfer is
> never called (check the code in loop_init_xfer). And, even if were enabled,
> you would quickly notice that lo->lo_pending count is never decremented in
> your 'remap' code.

That might be so for the 2.5 code base, I know for a fact that it worked
when it was implemented in 2.4. Maybe with the same lo_pending bug, I
dunno.

> The patch below fixes that remap issue, plus uncounted number of other loop
> issues. For example, device backed loops use pre-allocated pages for zero VM
> pressure.
> 
> Too bad you seem to be filtering my emails.

Please calm down. You sent me two mails that I haven't gotten around to
yet, excuse me for not making loop my top priority.

That said, please do split up the patches as Andrew/wli suggested. For
the 2.5 one I'd be inclined to just take it as-is, but the 2.4 patch
definitely needs to be split.

-- 
Jens Axboe

