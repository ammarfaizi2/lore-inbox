Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288995AbSAIULi>; Wed, 9 Jan 2002 15:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289001AbSAIUJQ>; Wed, 9 Jan 2002 15:09:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S289005AbSAIUIX>; Wed, 9 Jan 2002 15:08:23 -0500
Date: Wed, 9 Jan 2002 15:08:18 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Brian Gerst <bgerst@didntduck.org>
cc: Sipos Ferenc <sferi@dumballah.tvnet.hu>, linux-kernel@vger.kernel.org
Subject: Re: system time issue
In-Reply-To: <3C3CA078.52242C57@didntduck.org>
Message-ID: <Pine.LNX.3.95.1020109145747.144A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Brian Gerst wrote:

> "Richard B. Johnson" wrote:
> > 
> > The code works by disabling paging while executing code where
> > there is not a 1:1 physical/virtual page mapping. I have never
> > found a system, even one with two CPUs that did not instantly
> > reset.
> 
> All you are doing is causing a triple fault, started with most likely an
> invalid op fault.  There are many ways of doing that, including the no
> idt way the kernel currently uses, which IMHO would be more reliable
> that depending on the processor crashing on random memory.
> 
> --
> 
> 				Brian Gerst

Kernel version 2.4.1 through 17 (last I checked 17) used a bunch of
ways including the keyboard controller, the aux control port, then
finaly a transition to 16-bit address space with direct execution
of the reset vector. I found that the only reason the transition
to 16-bits "worked" was because of coding errors which caused the
processor reset.

Therefore, I created a deliberate "coding error" which actually
doesn't require fetching random instructions. The processor never
even gets to fetch anything because a CS selector for the correct
segment has never been loaded. It can't fetch instructions and,
in fact a logic analyzer shows that the last memory access was
the dword load of the trash CR0 instructions plus some additional
cache-line fill of valid code.
 
Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


