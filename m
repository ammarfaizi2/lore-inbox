Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130666AbRBMPt6>; Tue, 13 Feb 2001 10:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129422AbRBMPts>; Tue, 13 Feb 2001 10:49:48 -0500
Received: from colorfullife.com ([216.156.138.34]:31495 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130462AbRBMPti>;
	Tue, 13 Feb 2001 10:49:38 -0500
Message-ID: <3A895795.56741320@colorfullife.com>
Date: Tue, 13 Feb 2001 16:49:41 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Martin Rode <Martin.Rode@programmfabrik.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG in sched.c, Kernel 2.4.1?
In-Reply-To: <3A8942FA.484BE2FC@programmfabrik.de> <3A8944F1.93C252EB@didntduck.org> <3A895194.89D69AE9@programmfabrik.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Rode wrote:
> 
> >
> > Run this oops message through ksymoops please.  It will make debugging
> > it alot easier.
> >
> >
> 
> Since I did not compile the kernel myself, ksymoops is not too happy with
> what is has to analyse the dump. I tried compile the Mandrake kernel myself
> but there seems to be something unmatched. See below for what ksymoops
> gives me.
>
looks good.

> Warning (compare_maps): mismatch on symbol vt_cons  , ksyms_base says
> c02b06e0, vmlinux says c02ac6e0.  Ignoring ksyms_base entry
> 
> (I get about > 300 msgs of that kind)
> 
> Let me know who I can prepare for the next crash with my own kernel. Are
> there any options I have to turn on for compiling?
> 
> kernel BUG at sched.c:714!
> invalid operand: 0000
> CPU: 0
> EIP: 0010:[<c0113781>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010282
> eax: 0000001b ebx 00000000 ecx df4f6000 edx 00000001
> esi: 001cffe3 edi db5eede0 ebp dc0e9f40 esp dc0e9ef0
> stack: c01f26f3 c01f2856 000002ca db5eed80 dc0e8000 db5eede0 dc0e9f18
> dc0e8000 000033ba 00000000 00000000 000000e7 0000001c 0000001c
> fffffff3 dc0e8000 00000800 00000000 dc0e8000 dc0e9f68 c0139c44
> d488bf80 00000000

esp is quite high, only 0x110 bytes of the stack are used.

> call trace: [<cc0139c44>] [<c0139d1c>] [<c0130af6>] [<c0108e93>]
                ^^^^^^^^^
> code: 0f 0b 8d 65 bc 5b 5e 5f 89 ec 5d c3 8d 76 00 55 89 e5 83 ec
> 
> >>EIP; c0113781 <schedule+421/430>   <=====
> Trace; cc0139c44 <END_OF_CODE+bdf830401/????>
         ^^^^^^^^^

did you manually copy the oops from the screen?
that value should be c0139c44 <pipe_wait...>

> Trace; c0139d1c <pipe_read+80/238>
> Trace; c0130af6 <sys_read+5e/c4>
> Trace; c0108e93 <system_call+33/40>
>
> [snip]
> 
> Kernel panic: Aiee, killing interrupt handler!
>
I don't see that interrupt handler!
it seems to be a normal syscall, just a pipe read that blocks because
the pipe is empty.

Is that the first oops, or was there another oops before this one?

--
	Manfred
