Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318790AbSIITwx>; Mon, 9 Sep 2002 15:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318806AbSIITwx>; Mon, 9 Sep 2002 15:52:53 -0400
Received: from waste.org ([209.173.204.2]:13285 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318790AbSIITww>;
	Mon, 9 Sep 2002 15:52:52 -0400
Date: Mon, 9 Sep 2002 14:57:34 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Kent Borg <kentborg@borg.org>
Cc: David Wagner <daw@mozart.cs.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020909195733.GC31597@waste.org>
References: <1029760150.19376.14.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0209072328240.21724-100000@redshift.mimosa.com> <alg3ct$pru$1@abraham.cs.berkeley.edu> <20020909165303.GA31597@waste.org> <20020909145451.G14891@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020909145451.G14891@borg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 02:54:51PM -0400, Kent Borg wrote:
> Most of this thread is about on-going sources of entropy, but what
> about initial state?  Yes, distributions such as Red Hat save the pool
> when shutting down and restore it on booting.  But what about initial
> initial state?  What about those poor headless servers that get built
> by Kickstart?  What about the individual blades in a server?  What
> about poor embedded routers that are really impoverished: Nothing but
> a CPU, timers, ethernet hardware, and ROM.  And DRAM!
> 
> Why not use the power-on state of DRAM as a source of initial pool
> entropy?  

There's actually not a lot there, and what is there is not random, but
rather a rapidly fading "ghost" of what was there last. And for most
folks, this gets wiped by POST or the kernel long before the RNG gets
its hands on it.
 
Nonetheless, there's no reason not to take whatever state we get when
we allocate our pool. Amusingly, the current code needlessly zeroes out
its pool before using it - twice! I've already fixed this in my patches.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
