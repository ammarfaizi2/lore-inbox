Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274617AbSITBvE>; Thu, 19 Sep 2002 21:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274622AbSITBvE>; Thu, 19 Sep 2002 21:51:04 -0400
Received: from bitmover.com ([192.132.92.2]:17541 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S274617AbSITBvD>;
	Thu, 19 Sep 2002 21:51:03 -0400
Date: Thu, 19 Sep 2002 18:56:04 -0700
From: Larry McVoy <lm@bitmover.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020919185604.A25525@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ulrich Drepper <drepper@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3D8A6EC1.1010809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D8A6EC1.1010809@redhat.com>; from drepper@redhat.com on Thu, Sep 19, 2002 at 05:41:37PM -0700
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - - the new library is based on an 1-on-1 model.  Earlier design
>    documents stated that an M-on-N implementation was necessary to
>    support a scalable thread library.  This was especially true for
>    the IA-32 and x86-64 platforms since the ABI with respect to threads
>    forces the use of segment registers and the only way to use those
>    registers was with the Local Descriptor Table (LDT) data structure
>    of the processor.
> 
>    The kernel limitations the earlier designs were based on have been
>    eliminated as part of this project, opening the road to a 1-on-1
>    implementation which has many advantages such as
> 
>    + less complex implementation;
>    + avoidance of two-level scheduling, enabling the kernel to make all
>      scheduling decisions;
>    + direct interaction between kernel and user-level code (e.g., when
>      delivering signals);
>    + and more and more.

I'm just starting to look at this...  Without digging into it, my
impression is that this is 100% the right way to go.  Rob Pike (Mr Plan
9, which while it hasn't had the impact of Linux is actually a fantastic
chunk of work) once said "If you think you need threads, your processes
are too fat".  I believe that's another way of stating that a 1-on-1
model is the right approach.  He's saying "don't make threads to make
things lighter, that's bullshit, use processes as threads, that will
force the processes to be light and that's a good thing for processes
*and* threads".

My only issue with that approach (I'm a big time advocate of that
approach) is TLB & page table sharing.  My understanding (weak as it is)
of Linux is that it does the right thing here so there isn't much of
an issue.  In Linux the address space is a first class object so the
id in the TLB is an address space ID, not a process id, which means
a pile of unrelated processes could, in theory, share the same chunk
of address space.  That's cool.  A lot of processor folks have danced
around that issue for years, I fought with Mash at MIPS about it, he
knew it was something that was needed.  But Linux, as far as I can tell,
got it right in a different way that made the issue go away.  Which means
1-on-1 threads are the right approach for reasons which have nothing to
do with threads, as well as reasons which have to do with threads.

Kudos to Ulrich & team for getting it right.  I'll go dig into it and
see if I've missed the point or not, but this sounds really good.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
