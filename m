Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280775AbRKGFHi>; Wed, 7 Nov 2001 00:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280773AbRKGFHa>; Wed, 7 Nov 2001 00:07:30 -0500
Received: from zero.tech9.net ([209.61.188.187]:64015 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S280762AbRKGFHU>;
	Wed, 7 Nov 2001 00:07:20 -0500
Subject: Re: disaster with 2.4.14+preempt
From: Robert Love <rml@tech9.net>
To: J Sloan <jjs@pobox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BE8B460.A23E1A67@pobox.com>
In-Reply-To: <3BE8B460.A23E1A67@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0+cvs.2001.11.06.15.04 (Preview Release)
Date: 07 Nov 2001 00:07:26 -0500
Message-Id: <1005109646.884.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-06 at 23:11, J Sloan wrote:
> HI all,
> 
> I upgraded my test box (Compaq 6500,
> 4 CPUs, 1.2 GB RAM) to Red Hat 7.2,
> which went very nicely. It seems stable
> and tux is very very fast.
> 
> I have been pleased with 2.4.14 on several
> desktop systems, so my next step was to
> build 2.4.14 on the Compaq - I decided to
> apply the 2.4.14-1-preempt-patch as well.

Well, I'm a caring guy so I went and tried to duplicate (in much fear
for my data) your problem.

I use RedHat 7.2, too.  Compiled with gcc 2.96.

I compiled 2.4.14+preempt+ext3.  Booted, ran multiple dbench runs,
booted X, compiled a new kernel.  (Un)fortunately, I could not reproduce
the problem (or any problem).

So I compiled 2.4.14+preempt, this time using ext2 like you.  I also
enabled highmem and SMP, although I don't need those.  Again I ran
multiple dbench runs, went into X, and here I am ... the kernel is
solid.

So I am a tad baffled.  This is a first post.  Let's start the game...

What was the last kernel you had no problems with when used with
preempt?

Is 2.4.14 running now? Without preempt?  Fine?

Can you attach your .config?

> I built/booted the new kernel, and started
> my usual dbench run to check it out -
> 
> Ironically, I then witnessed a disastrous
> file corruption, the likes of which I'd never
> seen in years of using ext2 - in short, the
> old lockup that was previously fixed is back,
> nastier than ever - and this time it caused
> the box to scribble on /usr/lib before dying.
> 
> A few seconds after starting "dbench 16",
> the server locked hard. (When it came back
> up, many programs were not functional, with
> claims of invalid or corrupt libraries)
> 
> I was however able to hand copy the oops
> from the console and run through ksymoops
> after bringing the box backup again:
> 
> Invalid operand: 0000
> CPU:    2
> EIP:    0010:[<c01300ee>]  Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010082
> eax: 00010086   ebx: ea416dap   ecx: c0269f20   edx: 00000004
> esi: c1a9e1c0   edi: f7bb3000   ebp: 00000000   esp: c2213eb8
> ds: 0018   es: 0018  ss: 0018
> Process swapper (pid:0, stackpage=c2213000)
> Stack: c0238c3e 0000004a 00000082 00000001 00000003 00000046 f628fbc0
> ea416da0
>        00000082 f7bb3000 00000000 c0135ab6 c019ed8a c0423f00 00000000
> 00000001
>        00000000 f7b916dc c019edef ea416da0 00000000 00000012 00000000
> 00000040
> Call Trace:  [<c0135ab6>] [<c019ed8a>] [<c019edef>] [<c0108a3e>]
> [<c0108ccb>]
> [<c0105240>] [<c0105240>] [<c0105240>] [<c010526c>] [<c01052f2>]
> [<c011611f>]
> Code: 0f 0b 58 5a 8b 7e 08 85 ff 74 10 6a 4c 68 3e 8c 23 c0 e8 bb
> 
> >>EIP; c01300ee <__free_pages_ok+1e/2e0>   <=====
> Trace; c0135ab6 <bounce_end_io_write+46/f0>
> Trace; c019ed8a <do_ida_intr+1ba/2c0>
> Trace; c019edef <do_ida_intr+21f/2c0>
> Trace; c0108a3e <handle_IRQ_event+5e/90>
> Trace; c0108ccb <do_IRQ+bb/140>
> Trace; c0105240 <default_idle+0/40>
> Trace; c0105240 <default_idle+0/40>
> Trace; c0105240 <default_idle+0/40>
> Trace; c010526c <default_idle+2c/40>
> Trace; c01052f2 <cpu_idle+52/70>
> Trace; c011611f <printk+15f/1a0>
> Code;  c01300ee <__free_pages_ok+1e/2e0>
> 00000000 <_EIP>:
> Code;  c01300ee <__free_pages_ok+1e/2e0>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c01300f0 <__free_pages_ok+20/2e0>
>    2:   58                        pop    %eax
> Code;  c01300f1 <__free_pages_ok+21/2e0>
>    3:   5a                        pop    %edx
> Code;  c01300f2 <__free_pages_ok+22/2e0>
>    4:   8b 7e 08                  mov    0x8(%esi),%edi
> Code;  c01300f5 <__free_pages_ok+25/2e0>
>    7:   85 ff                     test   %edi,%edi
> Code;  c01300f7 <__free_pages_ok+27/2e0>
>    9:   74 10                     je     1b <_EIP+0x1b> c0130109
> <__free_pages_ok+39/2e0>
> Code;  c01300f9 <__free_pages_ok+29/2e0>
>    b:   6a 4c                     push   $0x4c
> Code;  c01300fb <__free_pages_ok+2b/2e0>
>    d:   68 3e 8c 23 c0            push   $0xc0238c3e
> Code;  c0130100 <__free_pages_ok+30/2e0>
>   12:   e8 bb 00 00 00            call   d2 <_EIP+0xd2> c01301c0
> <__free_pages_ok+f0/2e0>
> 
> <0>Kernel panic: Aiee, killing interrupt handler!
> 
> In interrupt handler - not syncing

	Robert Love

