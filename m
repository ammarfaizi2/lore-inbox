Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267621AbTACSby>; Fri, 3 Jan 2003 13:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267622AbTACSbx>; Fri, 3 Jan 2003 13:31:53 -0500
Received: from ns.suse.de ([213.95.15.193]:25874 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267621AbTACSbw>;
	Fri, 3 Jan 2003 13:31:52 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
References: <94F20261551DC141B6B559DC4910867204491F@blr-m3-msg.wipro.com.suse.lists.linux.kernel> <3E155903.F8C22286@digeo.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Jan 2003 19:40:22 +0100
In-Reply-To: Andrew Morton's message of "3 Jan 2003 10:36:28 +0100"
Message-ID: <p734r8qnkkp.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:
> 
> The teeny little microbenchmarks are telling us that the rmap overhead
> hurts, that the uninlining of copy_*_user may have been a bad idea, that
> the addition of AIO has cost a little and that the complexity which
> yielded large improvements in readv(), writev() and SMP throughput were
> not free.  All of this is already known.

If you mean the signal speed regressions they caused - I fixed 
that on x86-64 by inlining 1,2,4,8,10(used by signal fpu frame),16.
But it should not use the stupud rep ; ..., of the old ersio but direct 
unrolled moves.

x86-64 version in include/asm-x86_64/uaccess.h, could be ported
to i386 given that movqs need to be replaced by two movls.

-Andi

P.S.: regarding recent lmbench slow downs: I'm a bit
worried about the two wrmsrs which are in the i386 context switch
in load_esp0 for sysenter now. Last time I benchmarked WRMSRs on
Athlon they were really slow and knowing the P4 it is probably
even slower there. Imho it would be better to undo that patch
and use Linus' original trampoline stack.


