Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbVHUXLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVHUXLK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 19:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbVHUXLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 19:11:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28309 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750932AbVHUXLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 19:11:09 -0400
Date: Sun, 21 Aug 2005 16:10:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ondrej Zary <linux@rainbow-software.org>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: FPU-intensive programs crashing with floating point   exception
 on Cyrix MII
In-Reply-To: <4308F1EF.9020609@rainbow-software.org>
Message-ID: <Pine.LNX.4.58.0508211606310.3317@g5.osdl.org>
References: <200508210550_MC3-1-A7CF-D29E@compuserve.com>
 <Pine.LNX.4.58.0508211043520.3317@g5.osdl.org> <4308F1EF.9020609@rainbow-software.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Aug 2005, Ondrej Zary wrote:
> 
> MATH ERROR: cwd = 0x37f, swd = 0x1820
> 
> Pid: 1699, comm:               mprime
> EIP: 0073:[<08181c73>] CPU: 0
> EIP is at 0x8181c73
>   ESP: 007b:bf927ab4 EFLAGS: 00010202    Not tainted  (2.6.12-pentium)
> EAX: 00000001 EBX: 00000000 ECX: 0000808d EDX: b7f09480
> ESI: b7455340 EDI: 080e01f0 EBP: bf927bf8 DS: 007b ES: 007b
> CR0: 8005003b CR2: b7ed6058 CR3: 006f0000 CR4: 00000080

Ahh, so it's actually all in user space. I was thinking that the Cyrix
chip might use the old external interrupt-based (as opposed to exception
16) FP error reporting, and that it could be some kind of asynchronous
error that raced with the kernel task switching (ie the interrupt had
triggered, and then the FPU control register had been modified before the
irq handler actually got to run).

But that doesn't seem to be the case.

I don't see _why_ that exception would happen, other than a CPU bug.

Can you dump more of the FP state (the kernel doesn't have helpers for
doing that, so you'd have to write the code to print out the state by
hand)? Maybe there's some clue there - denormals or something..

		Linus
