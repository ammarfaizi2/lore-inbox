Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbTCCP3l>; Mon, 3 Mar 2003 10:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266064AbTCCP3l>; Mon, 3 Mar 2003 10:29:41 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59781 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266010AbTCCP3h>; Mon, 3 Mar 2003 10:29:37 -0500
Date: Mon, 3 Mar 2003 10:41:57 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: ChristopherHuhn <c.huhn@gsi.de>
cc: linux-kernel@vger.kernel.org, linux-smp <linux-smp@vger.kernel.org>,
       support-gsi@credativ.de
Subject: Re: Kernel Bug at spinlock.h ?!
In-Reply-To: <3E637137.3010105@GSI.de>
Message-ID: <Pine.LNX.3.95.1030303103332.22802A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, ChristopherHuhn wrote:

> Hi again,
> 
> >>Sounds like possible memory corruption (can you vouch for the reliability 
> >>of your RAM?) Might be worthwhile posting the oops in it's entirety. Is 
> >>EIP normally in __run_timers? Do you run a heavy networking load?
> >>
> as apparently every machine in our farm is affected, I cannot believe in 
> a corrupted memory. I've started to run memtest86 on a machine that just 
> oopsed though, but it didn't find any errors (yet).
> 
> >Feb 24 14:45:34 lxb006 kernel: ICH3: BIOS setup was incomplete.
> >
> Does this mean we should upgrade to 2.5?
> 
> Kind regards,
> 
> Christopher
> 
> 
> Here comes a complete oops that just occured:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000002
> priniting eip:
> e40e5cfc
> *pde: 00000000
> Oops: 0002
> Cpu: 0
> EIP: 0010:[<e40e5cfc>]    Not tainted
> EFLAGS: 00010246
> eax: 00000002    ebx: e40e5cfc    ecx: c03f9208    edx: 00000000
> esi: e40e5cb0    edi: 00000001    ebp: d5d15cd0    esp: d5d15cbc
> ds: 0018    es: 0018    ss: 0018
> Process adsmcli (pid: 13223, stackpage=d5d15000)
> Stack: c02c6783 e40e5cb0 e40e4cb0 c02c66a0 0ac9682a d5d15d08 c012564b 
> e40e5cb0
>     00000000 00000000 00000000 00000001 00000000 c03f9600 c041c30c c041c30c
>     ...
> Call Trace: [<c02c6783>] [<c02c66a0>] [<c0125646>] [<c012139a>] [<c0121263>]
>     [<c0120fdd>] [<c02a50dc>] [<c02a3c68>] [<c02abc50>] [<c027eec2>] 
> [<c029c877>]
>     ...
> 
> Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 2b 68 c9 0a
> <0> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> 

What does "Process adsmcli" do? Does it make any special system-calls
or does in interface with a particular driver? Whatever it's doing
may have triggered the event.

> Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 2b 68 c9 0a
This code is not valid. Either some hardware burped or a pointer to
a function got corrupted, both quite likely RAM related.

The "Re: Kernel Bug at spinlock.h ?!" is an eye-catcher because this
inline code cannot have any bugs or you wouldn't even have booted.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


