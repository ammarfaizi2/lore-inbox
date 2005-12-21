Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVLUHu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVLUHu5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 02:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVLUHu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 02:50:57 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:6079 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932313AbVLUHu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 02:50:56 -0500
Date: Wed, 21 Dec 2005 08:50:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Christoph Lameter <christoph@lameter.com>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
Message-ID: <20051221075015.GB2398@elte.hu>
References: <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com> <20051220135725.GA29392@elte.hu> <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com> <1135093460.13138.302.camel@localhost.localdomain> <20051220181921.GF3356@waste.org> <1135106124.13138.339.camel@localhost.localdomain> <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com> <1135114971.13138.396.camel@localhost.localdomain> <20051221065619.GC766@elte.hu> <Pine.LNX.4.58.0512210909040.23799@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0512210909040.23799@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:

> > SLAB-bashing has become somewhat fashionable, but i really challenge 
> > everyone to improve the SLAB code first (to make it more modular, easier 
> > to read, etc.), before suggesting replacements.
> 
> I dropped working on the replacement because I wanted to do just that. 
> I sent my patch only because Matt and Steve talked about writing a 
> replacement and thought they would be interested to see it.
> 
> I am all for gradual improvements but after taking a stab at it, I 
> starting to think rewriting would be easier, simply because the slab 
> allocator has been clean-up resistant for so long.

i'd suggest to try harder, unless you think the _fundamentals_ of the 
SLAB allocator are wrong. (which you are entitled to believe, but we 
also have to admit that the SLAB has been around for many years, and 
works pretty well)

most of the ugliness in slab.c comes from:

1) debugging. There's no easy solutions here, but it could be improved. 

2) bootstrapping. Bootstrapping an allocator in a generic way is hard.
   E.g. what if cache_cache gets larger than 1 page?

3) cache-footprint tricks and lockless fastpath. SLAB does things all 
   the right way, even that ugly memmove is the right thing. Maybe it 
   could be cleaned up, but the fundamental complexity will likely 
   remain.

	Ingo
