Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265653AbSJSTab>; Sat, 19 Oct 2002 15:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265660AbSJSTab>; Sat, 19 Oct 2002 15:30:31 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:52496 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S265653AbSJSTab>; Sat, 19 Oct 2002 15:30:31 -0400
Date: Sat, 19 Oct 2002 14:36:17 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
Message-ID: <63160000.1035056177@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.3.96.1021019151523.29078E-200000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1021019151523.29078E-200000@gatekeeper.tmr.com>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Saturday, October 19, 2002 15:17:31 -0400 Bill Davidsen
<davidsen@tmr.com> wrote:

> Don't tease, what did that do for performance? I see that someone has
> already posted a possible problem, and the code would pass for complex for
> most people, so is the gain worth the pain?

I posted some fork/exec/exit microbenchmark results last week, in which for
large processes fork becomes much faster, and exec/exit become much faster
for processes with lots of shared memory.

As for results from larger benchmarks, those haven't been done.  The TPC-H
test we used was primarily for stability testing, and secondarily to see if
we could reduce page table/pte_chain memory overhead, which we did.  The
pte_chain overhead was reduced by close to a factor of 100.

This patch isn't primarily a performance patch.  It does help for some
things, notably the fork/exec/exit cases mentioned above.  But its primary
goal is to reduce the amount of memory wasted in page tables mapping the
same pages into multiple processes.  We have seen an application that
consumed on the order of 10 GB of page tables to map a single shared memory
chunk across hundreds of processes.  Shared page tables would eliminate
this overhead.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

