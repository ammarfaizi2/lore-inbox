Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289692AbSA2Oww>; Tue, 29 Jan 2002 09:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289667AbSA2Own>; Tue, 29 Jan 2002 09:52:43 -0500
Received: from 216-42-72-173.ppp.netsville.net ([216.42.72.173]:39600 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S289692AbSA2Owb>; Tue, 29 Jan 2002 09:52:31 -0500
Date: Tue, 29 Jan 2002 09:50:17 -0500
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>, Alexander Viro <viro@math.psu.edu>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: Note describing poor dcache utilization under high memory pressure
Message-ID: <3567610000.1012315817@tiny>
In-Reply-To: <3C567D93.7030602@namesys.com>
In-Reply-To: <Pine.GSO.4.21.0201281927320.6592-100000@weyl.math.psu.edu> <3C567D93.7030602@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, January 29, 2002 01:46:43 PM +0300 Hans Reiser <reiser@namesys.com> wrote:

> Alexander Viro wrote:
> 
>> 
>> On Tue, 29 Jan 2002, Hans Reiser wrote:
>> 
>>> This fails to recover an object (e.g. dcache entry) which is used once, 
>>> and then spends a year in cache on the same page as an object which is 
>>> hot all the time.  This means that the hot set of objects becomes 
>>> diffused over an order of magnitude more pages than if garbage 
>>> collection squeezes them all together.  That makes for very poor caching.
>>> 
>> 
>> Any GC that is going to move active dentries around is out of question.
>> It would need a locking of such strength that you would be the first
>> to cry bloody murder - about 5 seconds after you look at the scalability
>> benchmarks.
>> 
>> 
> 
> I don't mean to suggest that the dentry cache locking is an easy problem to solve, but the problem discussed is a real one, and it is sufficient to illustrate that the unified cache is fundamentally flawed as an algorithm compared to using subcache plugins.

It isn't just dentries.  If a subcache object is in use, it can't be moved
to a warmer page without invalidating all existing pointers to it.

If it isn't in use, it can be migrated when the VM asks for the page to
be flushed.

-chris

