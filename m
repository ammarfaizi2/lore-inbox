Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316008AbSEJTKj>; Fri, 10 May 2002 15:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316019AbSEJTKi>; Fri, 10 May 2002 15:10:38 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18962 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316008AbSEJTKi>; Fri, 10 May 2002 15:10:38 -0400
Date: Fri, 10 May 2002 15:07:14 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Robert Love <rml@tech9.net>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x86 question: Can a process have > 3GB memory?
In-Reply-To: <1020980411.880.93.camel@summit>
Message-ID: <Pine.LNX.3.96.1020510145244.14035A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 May 2002, Robert Love wrote:

> All 32-bit architectures have a 4GB address space, 64-bit architectures
> obviously have a much bigger one (depends on the arch how many bits are
> used for the address space).
> 
> PPC obviously does not have the dumb physical memory limitations x86
> has, however.

As others have noted, the recent ia32 chips support 36 (or more) bits of
physical memory, and there is even code to use it AFAIK in the current
kernel. It would be possible to allow program access to this RAM, although
both Kernel and gcc support would be needed. M$ had "huge" memory models
to go over 64k in the old 8086 days, doing loads of segment registers.
 
> Anyhow, Rik's mmap trick will work on any arch, not just x86.

Rik's mmap trick is like the dancing elephant, "the wonder is not that he
does it well but that he does it at all." In the first place most
programmers could not get the code to work reliably in a realistic time
frame (if at all) due to complexity, and if they did the implementation
would not be usefully fast for random access, which is why you use memory
in the most cases. 

Imagine *a++ = *b++ with four system calls per byte. Or imagine an FFT,
where even if you could do range checking to see if mmap() was needed you
would still add multiples to the integer portion, and probably beat the
cache to a pulp.

As a technique for special applications and programmers it works well, but
as a general solution it is totally impractical in both time to code and
time to run. Not to mention portability issues to 64 bit hardware, where
you need still other code unless you want to run multiples slower.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

