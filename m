Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSKNTVl>; Thu, 14 Nov 2002 14:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSKNTVl>; Thu, 14 Nov 2002 14:21:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20486 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263246AbSKNTVk>;
	Thu, 14 Nov 2002 14:21:40 -0500
Message-ID: <3DD3F960.6000501@pobox.com>
Date: Thu, 14 Nov 2002 14:28:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David.Mosberger@acm.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] remove hugetlb syscalls
References: <Pine.LNX.4.44L.0211132239370.3817-100000@imladris.surriel.com>	<08a601c28bbb$2f6182a0$760010ac@edumazet>	<20021114141310.A25747@infradead.org>	<ugel9oavk4.fsf@panda.mostang.com>	<1037298675.16000.47.camel@irongate.swansea.linux.org.uk> <15827.61722.800066.756875@panda.mostang.com>
In-Reply-To: <Pine.LNX.4.44L.0211132239370.3817-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger-Tang wrote:

> But that's excactly the point.  The hugepage interface returns a
> different kind of virtual memory.  There are tons of programs out
> there using mmap().  If such a program gets fed a path to the
> hugepagefs, it might end up with huge pages without knowing anything
> about huge pages.  For the most part, that might work fine, but it
> could lead to subtle failures.


Yeah, that was one of Linus's points about the syscalls, in a private 
email.  I mentioned how the new syscalls were in poor taste, when 
existing syscalls would work fine, and he flamed me right back ;-)

One of his main points to me was exactly what you are elucidating: 
there are subtle differences between normal pages and superpages that 
are exposed to userland, and we should make that explicit [with the 
syscalls] rather than hide it [with hugetlbfs/mmap/etc.].  So I think 
this is further indication Linus has a very valid point ;-)

However, that said, I think hugetlbfs will almost always get used in 
preference to the syscalls, so leaving them in may be more a statement 
of technical correctness/cleanliness than anything else.

[tangent warning]
This whole hugetlb affair is unfortunately pretty ugly, and this thread 
is just one component of that.  All these discussions occurred off-list, 
and it's _still_ a political football.  Sigh.  I just hope that the 
furor dies down soon, that smart technical [apolitical] decisions are 
made, and future discussions are at least CC'd to lkml.

	Jeff



