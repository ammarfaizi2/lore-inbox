Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWBPPzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWBPPzH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 10:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWBPPzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 10:55:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932145AbWBPPzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 10:55:05 -0500
Date: Thu, 16 Feb 2006 07:54:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: SMP BUG
In-Reply-To: <20060216102056.GA24741@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0602160752290.916@g5.osdl.org>
References: <43F12207.9010507@watson.ibm.com> <20060215230701.GD1508@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0602151521320.22082@g5.osdl.org> <20060216102056.GA24741@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Feb 2006, Russell King wrote:
> 
> It fixes that exact oops but only by preventing us getting that far
> due to another oops.

Thanks for walking through it.

> We call cpu_up, which sends a CPU_UP_PREPARE event.  This causes the
> migration thread to be spawned, and rq->migration_thread to be set.
> 
> Eventually, we call the architecture __cpu_up(), which ends up
> calling init_idle().  Due to this patch, init_idle() then NULLs out
> rq->migration_thread.

Fair enough.

That actually does point to a real bug, I think. The fact that we 
apparently now survive the fact that we spawn the migration thread before 
the idle thread works looks like it just hides the bug that we shouldn't 
do that. Ingo?

Oh, well. For now the fix is clearly to just leave things well alone, and 
just have cpu_possible_map initialized early enough.

		Linus
