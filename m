Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279885AbRKFSIG>; Tue, 6 Nov 2001 13:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279893AbRKFSH4>; Tue, 6 Nov 2001 13:07:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9227 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279885AbRKFSHr>; Tue, 6 Nov 2001 13:07:47 -0500
Subject: Re: Using %cr2 to reference "current"
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 6 Nov 2001 18:14:54 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111060949370.2194-100000@penguin.transmeta.com> from "Linus Torvalds" at Nov 06, 2001 09:59:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161AkQ-0001Fp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "get_current" interrupt safe (ie switching tasks is totally atomic, as
> it's the one single "movl ..,%esp" instruction that does the real switch
> as far as the kernel is concerned).
> 
> It does require using an order-2 allocation, which the current VM will
> allow anyway, but which is obviously nastier than an order-1.

I've seen boxes dead in the water from 8K NFS (ie 16K order-2 allocations),
let alone the huge memory hit. Michael's rtlinux approach looks even more
interesting and I may have to play with that (using the TSS to ident the
cpu)

Our memory bloat is already pretty gross in 2.4 without adding 16K task
stacks to the oversided struct page, bootmem and excess double linked lists.

I also need to try sticking a pointer to the task struct at the top of the
stack and loading that - since that should be a cache line that isnt being
shared around or swapped between processors
