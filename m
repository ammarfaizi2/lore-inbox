Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281215AbRLDQ5Y>; Tue, 4 Dec 2001 11:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278932AbRLDQz4>; Tue, 4 Dec 2001 11:55:56 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:7703 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281116AbRLDQzs>; Tue, 4 Dec 2001 11:55:48 -0500
Date: Tue, 4 Dec 2001 17:55:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Peter Zaitsev <pz@spylog.ru>, Andrew Morton <akpm@zip.com.au>,
        theowl@freemail.c3.hu, theowl@freemail.hu,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: your mail on mmap() to the kernel list
Message-ID: <20011204175504.E3447@athlon.random>
In-Reply-To: <16498470022.20011204183624@spylog.ru> <Pine.LNX.4.33L.0112041439210.4079-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33L.0112041439210.4079-100000@imladris.surriel.com>; from riel@conectiva.com.br on Tue, Dec 04, 2001 at 02:42:28PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 02:42:28PM -0200, Rik van Riel wrote:
> On Tue, 4 Dec 2001, Peter Zaitsev wrote:
> > Tuesday, December 04, 2001, 5:15:49 PM, you wrote:
> 
> > AA> You can fix the problem in userspace by using a meaningful 'addr' as
> > AA> hint to mmap(2), or by using MAP_FIXED from userspace, then the kernel
> > AA> won't waste time searching the first available mapping over
> > AA> TASK_UNMAPPED_BASE.
> 
> > Well. Really you can't do this, because you can not really track all of
> > the mappings in user program as glibc and probably other libraries
> > use mmap for their purposes.
> 
> There's no reason we couldn't do this hint in kernel space.
> 
> In arch_get_unmapped_area we can simply keep track of the
> lowest address where we found free space, while on munmap()
> we can adjust this hint if needed.
>
> OTOH, I doubt it would help real-world workloads where the
> application maps and unmaps areas of different sizes and
> actually does something with the memory instead of just
> mapping and unmapping it ;)))

exactly, while that would be simple to implement and very lightweight at
runtime, that's not enough to mathematically drop the complexity of the
get_unmapped_area algorithm. It would optimize only the case where
there's no fragmentation of the mapped virtual address space.

For finding the best fit in the heap with O(log(N)) complexity (rather
than the current O(N) complexity of the linked list) one tree indexed by
the size of each hole would be necessary.

Andrea
