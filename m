Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268266AbTB1XtX>; Fri, 28 Feb 2003 18:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268269AbTB1XtX>; Fri, 28 Feb 2003 18:49:23 -0500
Received: from daimi.au.dk ([130.225.16.1]:3246 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S268266AbTB1XtV>;
	Fri, 28 Feb 2003 18:49:21 -0500
Message-ID: <3E5FF7E4.FB290D8F@daimi.au.dk>
Date: Sat, 01 Mar 2003 00:59:32 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
CC: root@chaos.analogic.com, linux-kernel@vger.kernel.org,
       herp@wildsau.idv.uni.linz.at
Subject: Re: emm386 hangs when booting from linux
References: <200302282343.h1SNhiQN030734@wildsau.idv.uni.linz.at>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H.Rosmanith (Kernel Mailing List)" wrote:
> 
> > Booting DOS from Linux is not as easy as booting Linux from
> > DOS. DOS relies much more on the BIOS, and the state of the
> > computer as it is setup by the BIOS. What needs to be right
> > for DOS to work is the contents of the BIOS data areas of
> > RAM, and the interrupt vector table, and state of some of
> > the hardware.
> 
> as far as I know, linux does not touch the BIOS data areas,
> and "machine_real_start" sets the IDT to 0,3ff again (the
> contents of the real-mode IDT are not modified by linux).

I think you are right about that. But that of course only
helps if it was not modified by code before Linux is loaded.

> the only piece of hardware neccessary to reset was the interrupt
> controller, in particular, the IRQ mapping.

I believe you are right that the IRQ controller is the most
important hardware component to reprogram. But I don't think
it is the only. Certainly you ought to reprogram the PIT to
the right speed, but there might be other hardware that
needs to be reprogrammed as well.

> 
> > It is surprising it worked that well. You can't even boot
> > DOS from DOS, DOS will have changed interrupt vectors which
> > would cause a second DOS to fail. If Linux is booted from
> > LOADLIN there will already be messed enough with the
> 
> interesting that you mention loadlin. when I run loadlin in a
> DOS which I booted from linux, (boot linux->boot dos->boot linux),
> the 2nd linux boot (by loadlin) will hang with the following message:
> 
> C:\LOADLIN> loadlin
> [...]
> 
> Your current DOS/CPU configuration is:
>   load buffer size: 0x[*HANGING*]
> 
> This looks promising. I think I gonna download loadlin source now :-)
> 
> On the other hand, when instead of loadling MBR and executing it, I
> do a far jmp to 0xf000:0xfff0 from "machine_real_start",

Isn't that code conventionally called by jumping to
0xffff:0x0000? (Not that it matters, because the first
instruction in all BIOSes I have seen is a jump to
0xf000:0xe05b.)

> normal
> boot-procedure is exected without haning anywhere. So I think that the
> bios-setup is doing some kind of initialisation/modification to whatver(!?)
> which the "machine_real_start" function does not.

Yes, the BIOS code usually knows almost everything that
needs to be initialized. If you are in real mode, and
jump to 0xFFFF:0x0000 there is almost nothing that can
possibly go wrong because you left some hardware in the
wrong state.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
