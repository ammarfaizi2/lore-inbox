Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293092AbSDDSwQ>; Thu, 4 Apr 2002 13:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293204AbSDDSwF>; Thu, 4 Apr 2002 13:52:05 -0500
Received: from zero.tech9.net ([209.61.188.187]:21511 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293092AbSDDSvw>;
	Thu, 4 Apr 2002 13:51:52 -0500
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at
	boot time
From: Robert Love <rml@tech9.net>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: torvalds@transmeta.com, "Adam J. Richter" <adam@yggdrasil.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3CAC9B32.2050000@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 04 Apr 2002 13:51:49 -0500
Message-Id: <1017946309.22303.492.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-04 at 13:28, Dave Hansen wrote:

> I've replicated the problem too.
> I've diabled preemption in the area where it used to be disabled because 
> of the old lock_kernel().  I'm sending this message from a machine with 
> that patch applied, so the patch does fix it.  As the comment says, this 
> is something that the preempt experts need to take a look at.
> Linus, this is a hack, and there is probably still a window where 
> preemption can happen.  But, it is a band-aid until we find the real 
> problem.

Thanks for the CC.  I've been looking into this problem.  I am not too
sure why we require protection from concurrency via preemption and not
via SMP.  In other words, why are we SMP-safe but not preempt-safe here.

I don't really have an answer.

The problem I saw on boot was the BUG being triggered on the last line.
If we are able to preempt here and cause some problem, what proof is
there that we don't have a race wrt SMP?

	Robert Love

