Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288850AbSA3Hzn>; Wed, 30 Jan 2002 02:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288828AbSA3HyF>; Wed, 30 Jan 2002 02:54:05 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:22188 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S288850AbSA3HyB>; Wed, 30 Jan 2002 02:54:01 -0500
Message-Id: <200201291829.g0TIT6br001418@tigger.cs.uni-dortmund.de>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: Note describing poor dcache utilization under high memory pressure 
In-Reply-To: Message from Alexander Viro <viro@math.psu.edu> 
   of "Mon, 28 Jan 2002 19:30:37 EST." <Pine.GSO.4.21.0201281927320.6592-100000@weyl.math.psu.edu> 
Date: Tue, 29 Jan 2002 19:29:06 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> said:
> On Tue, 29 Jan 2002, Hans Reiser wrote:
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

Then you'd need to somehow ensure that "hot" objects get into pages with
other "hot" objects... an LRU list (as was proposed here), but not just for
cleaning but also for considering as places for new objects? Keep a/this
list (somewhat) sorted by fullness, so that you preferently place new
objects in fullish pages, not in emptyish ones (perhaps slab is doing this
already)?
-- 
Horst von Brand			     http://counter.li.org # 22616
