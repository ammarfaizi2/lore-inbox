Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287855AbSA2AbL>; Mon, 28 Jan 2002 19:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSA2Aau>; Mon, 28 Jan 2002 19:30:50 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:33271 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287855AbSA2Aam>;
	Mon, 28 Jan 2002 19:30:42 -0500
Date: Mon, 28 Jan 2002 19:30:37 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Hans Reiser <reiser@namesys.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: Note describing poor dcache utilization under
 high memory pressure
In-Reply-To: <3C55E9E3.50207@namesys.com>
Message-ID: <Pine.GSO.4.21.0201281927320.6592-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Jan 2002, Hans Reiser wrote:

> This fails to recover an object (e.g. dcache entry) which is used once, 
> and then spends a year in cache on the same page as an object which is 
> hot all the time.  This means that the hot set of objects becomes 
> diffused over an order of magnitude more pages than if garbage 
> collection squeezes them all together.  That makes for very poor caching.

Any GC that is going to move active dentries around is out of question.
It would need a locking of such strength that you would be the first
to cry bloody murder - about 5 seconds after you look at the scalability
benchmarks.

