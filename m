Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSHOEAQ>; Thu, 15 Aug 2002 00:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSHOEAQ>; Thu, 15 Aug 2002 00:00:16 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:49884 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S316530AbSHOEAP>; Thu, 15 Aug 2002 00:00:15 -0400
Date: Thu, 15 Aug 2002 05:03:43 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
Message-ID: <20020815050343.A27963@kushida.apsleyroad.org>
References: <Pine.LNX.4.44.0208132307340.12804-100000@localhost.localdomain> <Pine.LNX.4.44.0208132320240.13244-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208132320240.13244-100000@localhost.localdomain>; from mingo@elte.hu on Tue, Aug 13, 2002 at 11:23:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> and here's a merged CLONE_VM_RELEASE patch against the previous
> clone-detached patch. (the sched.h reorganization broke it.)

I wonder if it makes more sense for the release word to be a futex --
then various ways of actually waiting for the stack are available.

It would be nice if the stored word were the exit() code, too.  This
would remove the need for zombie threads even when an exit status is
desired.

> +	/*
> +	 * Does the userspace VM want any unlock on mm_release()?
> +	 */
> +	if (clone_flags & CLONE_RELEASE_VM) {
> +		childregs->esp -= sizeof(0UL);
> +		p->user_vm_lock = (long *) esp;

Is this correct?  I would have expected this, given that stacks are
pre-decrement, and given that the value of `esp' is typically just after
the end of an mmaped region:

+		childregs->esp -= sizeof(0UL);
+		p->user_vm_lock = (long *) childregs->esp;

-- Jamie
