Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318271AbSHEAAt>; Sun, 4 Aug 2002 20:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318272AbSHEAAt>; Sun, 4 Aug 2002 20:00:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54370 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S318271AbSHEAAs>; Sun, 4 Aug 2002 20:00:48 -0400
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, Hubertus Franke <frankeh@watson.ibm.com>,
       "David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, gh@us.ibm.com, Martin.Bligh@us.ibm.com,
       wli@holomorpy.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: large page patch (fwd) (fwd)
References: <200208041331.24895.frankeh@watson.ibm.com.suse.lists.linux.kernel>
	<Pine.LNX.4.44.0208041131380.10314-100000@home.transmeta.com.suse.lists.linux.kernel>
	<3D4D7F24.10AC4BDB@zip.com.au.suse.lists.linux.kernel>
	<p73d6syjrzz.fsf@oldwotan.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Aug 2002 17:51:51 -0600
In-Reply-To: <p73d6syjrzz.fsf@oldwotan.suse.de>
Message-ID: <m17kj6rxm0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> Andrew Morton <akpm@zip.com.au> writes:
> 
> > If we instead clear out 4 or 8 pages, we trash a ton of cache and
> > the chances of userspace _using_ pages 1-7 in the short-term are
> > lower.   We could clear the pages with 7,6,5,4,3,2,1,0 ordering,
> > but the cache implications of faultahead are still there.
> 
> What you could do on modern x86 and probably most other architectures as 
> well is to clear the faulted page in cache and clear the other pages
> with a non temporal write. The non temporal write will go straight
> to main memory and not pollute any caches. 

Plus a non temporal write is 3x faster than a write that lands in
the cache on x86 (tested on Athlons, P4, & P3).
 
> When the process accesses it later it has to fetch the zeroes from
> main memory. This is probably still faster than a page fault at least
> for the first few accesses. It could be more costly when walking the full
> page (then the added up cache miss costs could exceed the page fault cost), 
> but then hopefully the CPU will help by doing hardware prefetch.
> 
> It could help or not help, may be worth a try at least :-)

Certainly.

Eric
