Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289772AbSA2R31>; Tue, 29 Jan 2002 12:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289776AbSA2R3S>; Tue, 29 Jan 2002 12:29:18 -0500
Received: from helen.CS.Berkeley.EDU ([128.32.131.251]:40588 "EHLO
	helen.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S289772AbSA2R3F>; Tue, 29 Jan 2002 12:29:05 -0500
Date: Tue, 29 Jan 2002 09:28:58 -0800
From: Josh MacDonald <jmacd@CS.Berkeley.EDU>
To: Alexander Viro <viro@math.psu.edu>
Cc: Hans Reiser <reiser@namesys.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: Note describing poor dcache utilization under high memory pressure
Message-ID: <20020129092858.D8740@helen.CS.Berkeley.EDU>
In-Reply-To: <3C55E9E3.50207@namesys.com> <Pine.GSO.4.21.0201281927320.6592-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0201281927320.6592-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Jan 28, 2002 at 07:30:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexander Viro (viro@math.psu.edu):
> 
> 
> On Tue, 29 Jan 2002, Hans Reiser wrote:
> 
> > This fails to recover an object (e.g. dcache entry) which is used once, 
> > and then spends a year in cache on the same page as an object which is 
> > hot all the time.  This means that the hot set of objects becomes 
> > diffused over an order of magnitude more pages than if garbage 
> > collection squeezes them all together.  That makes for very poor caching.
> 
> Any GC that is going to move active dentries around is out of question.
> It would need a locking of such strength that you would be the first
> to cry bloody murder - about 5 seconds after you look at the scalability
> benchmarks.

We're not talking about actively referenced entries, we're talking about
entries on the d_lru list with zero references.  Relocating those objects
should not require any more locking than currently required to remove and
re-insert the dcache entry.  Right?

-josh

-- 
PRCS version control system    http://sourceforge.net/projects/prcs
Xdelta storage & transport     http://sourceforge.net/projects/xdelta
Need a concurrent skip list?   http://sourceforge.net/projects/skiplist
