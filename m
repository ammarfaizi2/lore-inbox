Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWESJH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWESJH3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 05:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWESJH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 05:07:29 -0400
Received: from lea.cs.unibo.it ([130.136.1.101]:63618 "EHLO lea.cs.unibo.it")
	by vger.kernel.org with ESMTP id S1751229AbWESJH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 05:07:27 -0400
Date: Fri, 19 May 2006 11:07:26 +0200
To: Ulrich Drepper <drepper@gmail.com>
Cc: Andi Kleen <ak@suse.de>, osd@cs.unibo.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2-ptrace_multi
Message-ID: <20060519090726.GA11789@cs.unibo.it>
References: <20060518155337.GA17498@cs.unibo.it> <20060518155848.GC17498@cs.unibo.it> <p73sln72im3.fsf@bragg.suse.de> <20060518211321.GC6806@cs.unibo.it> <a36005b50605181923k285b4d50y30d6b43baede95ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36005b50605181923k285b4d50y30d6b43baede95ca@mail.gmail.com>
User-Agent: Mutt/1.3.28i
From: renzo@cs.unibo.it (Renzo Davoli)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 07:23:13PM -0700, Ulrich Drepper wrote:
> On 5/18/06, Renzo Davoli <renzo@cs.unibo.it> wrote:
> >e.g. To virtualize a write you'd have to call PTRACE_PEEKDATA for each
> >word of the buffer, very many hundreds cycles lost.
> 
> No, this is not how programs should do it.  Just open /proc/PID/mem
> and use pread() with an offset corresponding to the address.  Now,
> repeat your timings using this technique.

That would be faster to access the memory but:
- the manager has to keep one open file per controlled process
- when the Virtual Machine manager has to access the ptraced memory and 
access its registers and finally restart the process, needs three system 
calls instead of just one. (one pread/pwrite to /proc/PID/mem + at least one
ptrace PEEK/POKEUSR and a ptrace SYSCALL or SYSVM).
For a Virtual Machine manager three syscalls instead of one makes the
difference. The gap will be not so large with respect to the figures
of my previous message but there will be for sure.
- the read/write of several words of memory using ptrace do exist
implemented in an horribly tricky way for sparc/sparc64 (addr2 is taken 
out from a register as an extra argument which is not part of ptrace 
definition, see arch/sparc/kernel/ptrace.c). Our proposal gives also a 
clean and efficient and general interface for the same feature.

renzo
