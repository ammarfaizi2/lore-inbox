Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266320AbTBGS41>; Fri, 7 Feb 2003 13:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266323AbTBGS40>; Fri, 7 Feb 2003 13:56:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:52380 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266320AbTBGS4Z>; Fri, 7 Feb 2003 13:56:25 -0500
Date: Fri, 7 Feb 2003 14:08:47 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: SA <bullet.train@ntlworld.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: interrupt latency k2.4 / i386?
In-Reply-To: <200302071847.36646.bullet.train@ntlworld.com>
Message-ID: <Pine.LNX.3.95.1030207140224.30719A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2003, SA wrote:

> 
> Dear list,
> 
> What latency should I expect for hardware interrupts under k2.4 / i386 ? 
> 
> ie how long should it take between the hardware signalling the interrupt and 
> the interrupt handler being called?
> 
> 
> I am wrting a driver which pace IO with interrupts, generating one interrupt 
> for after every transfer is done.  Looking at the hardware schematics the 
> interrupts should occur virtually instantly after each transfer but the 
> driver is waiting ~1ms/ interrupt.  
> 
> I can use polling instead with busy waits but this seems a bit wasteful.
> 
> 
> My interrupt is shared with my graphics card using the non-GPL nvidia driver - 
> could this be responsible for the delay (any experience with this)?
> 
> cat /proc/interrupts
> .....
>  10:       3028          XT-PIC  eth0, VIA 82C686A
>  11:    1117037          XT-PIC  nvidia, PI stage <-- my driver
>  12:      14776          XT-PIC  usb-uhci, usb-uhci
> .....
> 
> Thanks SA
> -

Well there are very great problems with a lot of drivers if you
want good latency, but are sharing interrupts. Many drivers poll
in the ISR! This means that they loop through their ISR code
in some "interrupt mitigation scheme" that some near-do-well taught
in web-page school. This means, that if you share an interrupt,
you are probably screwed. You need to put your board in some slot
where it will either be first on the IRQ chain, or not shared at
all. Typical latencies are around 1.2 microseconds on a 400 MHz
machine, better on faster, sometimes better with two CPUs and an
IOAPIC.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


