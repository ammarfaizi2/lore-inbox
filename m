Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbTEHJbC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 05:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTEHJbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 05:31:02 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:32157 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261244AbTEHJbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 05:31:00 -0400
Date: Thu, 8 May 2003 11:43:21 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Ming Lei <lei.ming@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux rt priority  thread corrupt  global variable?
Message-ID: <20030508094321.GH1469@wohnheim.fh-wedel.de>
References: <029601c31540$b57f1280$0305a8c0@arch.sel.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <029601c31540$b57f1280$0305a8c0@arch.sel.sony.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 May 2003 02:03:35 -0700, Ming Lei wrote:
> 
> Platform:
> Intel Pentium II; RedHat 7.2 with kernel version 2.4.7-10, libc 2.2.4-13 and
> gcc 2.96.

You should either upgrade to 2.4.20 or similar or post the question to
RedHat for their kernels. If the problem can be reproduced with
2.4.20, come back here. :)

> Problem description:
> 
> a program has 3 threads of priority 12, 10, 6 respectively, and the main
> process at priority 0. All the threads except main process is created with
> pthread_create, and defined SCHED_FIFO as real time scheduler policy.
> 
> There is a global variable I define with 'int cpl'. All the threads and main
> process may alter cpl at any time. cpl may have one of these values {0,
> 0xf000006e, 0xf0000068, 0xe0000000, 0xe0000060}. cpl is protected by mutex
> for any access.
> 
> <Problem=> at some point of execution which cpl should be a value say
> e0000060, but the actual value retained at cpl is another say e0000000; that
> is, the value is changed without the program actually done anything on it.
> The retained value I observed is kind of historic value(one of these value
> in the above set), not the arbituary value. The problem had occured just
> after context switch, also occured during a thread execution.
> 
> <Confirm> I used Intel debug register to track any writing to the cpl memory
> address globally, which is the way GDB use for x86 hardware watchpoint
> implementation. I could see all the writing from my program to change cpl,
> but failed to see the source from which the problem occured. So I dont know
> what cause the problem.
> 
> Can anyone listening give me a direction or hint on this annoying situation?

Sounds a bit like a caching problem. Old value in cache, new value
written to memory, chache line dirty => flushed, old value written to
memory again. But it could also be something else.

Jörn

-- 
Simplicity is prerequisite for reliability.
-- Edsger W. Dijkstra
