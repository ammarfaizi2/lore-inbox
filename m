Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318427AbSHENRq>; Mon, 5 Aug 2002 09:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318428AbSHENRq>; Mon, 5 Aug 2002 09:17:46 -0400
Received: from mnh-1-10.mv.com ([207.22.10.42]:13316 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S318427AbSHENRq>;
	Mon, 5 Aug 2002 09:17:46 -0400
Message-Id: <200208051424.JAA01884@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Andi Kleen <ak@suse.de>, torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode linux] 
In-Reply-To: Your message of "05 Aug 2002 10:38:16 +0200."
             <p73ado1k8ef.fsf@oldwotan.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Aug 2002 09:24:28 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ak@suse.de said:
> Also for special things like UML who can ensure their environment is
> sane it  could be still an useful optimization. 

I use libc, and I haven't been able to convince myself that it isn't
going to use FP instructions or registers on my behalf.  I use it as little
as possible, but it still makes me nervous.

> If it wcould speed up UML I think it would be certainly
> worth it.

After Ingo's numbers, I like the idea of just having a separate address
space and process for the UML kernel, and have that process ptrace UML 
processes and handle system calls and interrupts on their behalf.  One
context switch at the start of a system call and one at the end, as opposed
to a signal delivery and sigreturn.

This also solves the jail mode mprotect performance horrors.

The one thing standing in my way is the need for the kernel process to
be able to change the address space of its processes.

I made a proposal for that, and Alan didn't like it.  So, we'll see what
he likes better.

				Jeff

