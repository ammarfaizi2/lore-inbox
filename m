Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279884AbRKFSY4>; Tue, 6 Nov 2001 13:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279893AbRKFSYq>; Tue, 6 Nov 2001 13:24:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27403 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279884AbRKFSYd>; Tue, 6 Nov 2001 13:24:33 -0500
Subject: Re: Using %cr2 to reference "current"
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 6 Nov 2001 18:31:41 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111061006150.2222-100000@penguin.transmeta.com> from "Linus Torvalds" at Nov 06, 2001 10:14:41 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161B0f-0001Io-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Our memory bloat is already pretty gross in 2.4 without adding 16K task
> > stacks to the oversided struct page, bootmem and excess double linked lists.
> 
> There are some people who think that the 5kB stack we have now is too
> small ;(

Yes but we dont want to let them win or next year 16K will be too small and
then they'll want to 16K C++ stack objects. At the very least we should
make them have to use

	really_slow_vmalloc_and_switch_to_big_temporary_stack()
	really_slow_vfree_and_return_to_old_stack()

_and_ make them type function names that long.

Granted its less of an issue in 2.5 because we can afford to finally make
DMA off the stack a crime (right now its an offence but one that is violated
in too many places to be sure of killing them all off) - scsi for one does
it. 

> That should work fairly well, and has the advantage that you can hide more
> state there if you want (ie it allows us, on demand, to move hot state of
> "struct task_struct" up there).

Sweet. Now that I'd completely missed. Task private state and task
public state splitting

> So it would basically be a small per-CPU/thread area, not just the "struct
> task_struct".

Yep

Alan
