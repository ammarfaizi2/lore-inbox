Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315631AbSEIICz>; Thu, 9 May 2002 04:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSEIICy>; Thu, 9 May 2002 04:02:54 -0400
Received: from zok.SGI.COM ([204.94.215.101]:34506 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315631AbSEIICw>;
	Thu, 9 May 2002 04:02:52 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory Barrier Definitions 
In-Reply-To: Your message of "Thu, 09 May 2002 17:36:46 +1000."
             <20020509173646.5c1b5baa.rusty@rustcorp.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 May 2002 18:01:37 +1000
Message-ID: <17895.1020931297@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2002 17:36:46 +1000, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>Hmmm... could you explain more?  You're saying that every load is
>an "acquire" and every store a "release"?  Or that they can be flagged
>that way, but aren't always?

cc trimmed.

The IA64 default is unordered memory accesses, except for special
instructions.  From Intel IA-64 Architecture Software Developer's
Manual.  Volume 1: IA-64 Application Architecture.

4.4.7 Memory Access Ordering

Memory data access ordering must satisfy read-after-write (RAW), 
write-after-write (WAW), and write-after-read (WAR) data dependencies
to the same memory location. In addition, memory writes and flushes
must observe control dependencies. Except for these restrictions,
reads, writes, and flushes may occur in an order different from the
specified program order. Note that no ordering exists between
instruction accesses and data accesses or between any two instruction 
accesses. The mechanisms described below are defined to enforce a
particular memory access order. In the following discussion, the terms
"previous" and "subsequent" are used to refer to the program specified
order. The term "visible" is used to refer to all architecturally
visible effects of performing a memory access (at a minimum this
involves reading or writing memory).

Memory accesses follow one of four memory ordering semantics:
unordered, release, acquire or fence.  Unordered data accesses may
become visible in any order. Release data accesses guarantee that all
previous data accesses are made visible prior to being made visible
themselves. Acquire data accesses guarantee that they are made visible
prior to all subsequent data accesses.  Fence operations combine the
release and acquire semantics into a bi-directional fence, i.e. they
guarantee that all previous data accesses are made visible prior to any
subsequent data accesses being made visible.

Explicit memory ordering takes the form of a set of instructions:
ordered load and ordered check load (ld.acq, ld.c.clr.acq), ordered
store (st.rel), semaphores (cmpxchg, xchg, fetchadd), and memory fence
(mf). The ld.acq and ld.c.clr.acq instructions follow acquire
semantics. The st.rel follows release semantics. The mf instruction is
a fence operation. The xchg, fetchadd.acq, and cmpxchg.acq instructions
have acquire semantics. The cmpxchg.rel, and fetchadd.rel instructions
have release semantics. The semaphore instructions also have implicit
ordering. If there is a write, it will always follow the read. In
addition, the read and write will be performed atomically with no
intervening accesses to the same memory region.

