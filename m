Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262448AbSI2LXc>; Sun, 29 Sep 2002 07:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbSI2LXc>; Sun, 29 Sep 2002 07:23:32 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:40883 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262448AbSI2LXb>;
	Sun, 29 Sep 2002 07:23:31 -0400
Date: Sun, 29 Sep 2002 13:28:53 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200209291128.NAA21889@harpo.it.uu.se>
To: mcornils@cornils.net
Subject: Re: PROBLEM: kernel crashes when recording audio
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2002 02:56:11 +0200, Malte Cornils wrote:
>Long description:
>When trying to capture audio/video from my bttv card (see lspci output 
>below), my system's reaction ranges from hard freezes to instant reboots to
>segfaults - the latter variant enabled me to capture a kernel oops. I'm
>using avicap from avifile project, with XviD capture codec. Video capture
>works flawlessly. When I enable audio capture in addition (48 kHz, 16bit,
>Mono) is when the problem starts (not after some time, but at the moment I
>start the capture process). I do not have many ideas on why 
>smp_apic_timer_interrupt is the problem, since this is a uniprocessor
>system.

smp_apic_timer_interrupt is also used in UP local APIC kernels.
You're either running an SMP kernel on a UP box, or a local APIC
enabled kernel.

>Unable to handle kernel paging request at virtual address ffffe0b0
>c0111f6b
>*pde = 00001063
>Oops: 0002
>...
>Code;  c0111f6b <smp_apic_timer_interrupt+b/d0>
>00000000 <_EIP>:
>Code;  c0111f6b <smp_apic_timer_interrupt+b/d0>   <=====
>   0:   c7 05 b0 e0 ff ff 00      movl   $0x0,0xffffe0b0   <=====
>Code;  c0111f72 <smp_apic_timer_interrupt+12/d0>
>   7:   00 00 00 
>Code;  c0111f75 <smp_apic_timer_interrupt+15/d0>
>   a:   ff 05 84 53 25 c0         incl   0xc0255384
>Code;  c0111f7b <smp_apic_timer_interrupt+1b/d0>
>  10:   31 d2                     xor    %edx,%edx
>Code;  c0111f7d <smp_apic_timer_interrupt+1d/d0>
>  12:   f6 40 00 00               testb  $0x0,0x0(%eax)

You got a page fault in ack_APIC_irq(). This should never happen.
