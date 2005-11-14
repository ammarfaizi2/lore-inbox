Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVKNLgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVKNLgs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 06:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVKNLgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 06:36:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45141 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751086AbVKNLgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 06:36:47 -0500
Date: Mon, 14 Nov 2005 12:34:42 +0100
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051114113442.GU3699@suse.de>
References: <20051114021127.GC5735@stusta.de> <4378650A.1070209@drzeus.cx> <1131964282.2821.11.camel@laptopd505.fenrus.org> <20051114111108.GR3699@suse.de> <1131967167.2821.14.camel@laptopd505.fenrus.org> <20051114112402.GT3699@suse.de> <1131967678.2821.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131967678.2821.21.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14 2005, Arjan van de Ven wrote:
> On Mon, 2005-11-14 at 12:24 +0100, Jens Axboe wrote:
> > > 
> > > not sure; I do know that it very much helps java (many more threads
> > > possible) and the VM (far less order 1 allocs). In addition the 4Kb
> > > allocation can be satisfied with the per cpu list of free 4Kb pages,
> > > while obviously an order 1 cannot and has to go global.
> > 
> > I realize it has nice advantages in theory, just wondering if anyone has
> > done a performance analysis of 4kb vs 8kb stacks lately (or at all?).
> 
> I don't think at least anyone at RH has done any; the functionality gain
> was already enough for us. One item I missed: in the many-thread cases,
> you also save a lot of memory that can now be used for pagecache; 
> this won't of course be visible in a microbenchmark but should help
> system wide.
> 
> Also in the implementation I don't see any way 4Kb stacks could show up
> in any benchmarks as negative; there are only 4 or 5 extra instructions
> in any path, and afaics no cache downsides (in fact the same irq stack
> memory is now reused for irqs instead of threadstack-du-jour, so less
> footprint/hotter caches)

The only downside is the potential crashes due to overflowing the stack,
I'm not worried about 4kb stacks performing worse.

-- 
Jens Axboe

