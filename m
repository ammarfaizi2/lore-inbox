Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSHOGc4>; Thu, 15 Aug 2002 02:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSHOGc4>; Thu, 15 Aug 2002 02:32:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:44690 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S313190AbSHOGcz>;
	Thu, 15 Aug 2002 02:32:55 -0400
Date: Thu, 15 Aug 2002 08:37:13 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <20020815050343.A27963@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208150836120.2197-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Jamie Lokier wrote:

> Is this correct?  I would have expected this, given that stacks are
> pre-decrement, and given that the value of `esp' is typically just after
> the end of an mmaped region:
> 
> +		childregs->esp -= sizeof(0UL);
> +		p->user_vm_lock = (long *) childregs->esp;

you are right. Fix against BK-curr attached.

	Ingo

--- linux/arch/i386/kernel/process.c.orig	Thu Aug 15 08:37:52 2002
+++ linux/arch/i386/kernel/process.c	Thu Aug 15 08:37:59 2002
@@ -627,7 +627,7 @@
 	 */
 	if (clone_flags & CLONE_RELEASE_VM) {
 		childregs->esp -= sizeof(0UL);
-		p->user_vm_lock = (long *) esp;
+		p->user_vm_lock = (long *) childregs->esp;
 	}
 	return 0;
 }

