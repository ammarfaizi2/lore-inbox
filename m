Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbTB1XfB>; Fri, 28 Feb 2003 18:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265589AbTB1XfA>; Fri, 28 Feb 2003 18:35:00 -0500
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:63373 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S264940AbTB1Xe7>; Fri, 28 Feb 2003 18:34:59 -0500
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200302282343.h1SNhiQN030734@wildsau.idv.uni.linz.at>
Subject: Re: emm386 hangs when booting from linux
In-Reply-To: <3E5FF026.F892B2F7@daimi.au.dk> from Kasper Dupont at "Mar 1, 3 00:26:30 am"
To: kasperd@daimi.au.dk (Kasper Dupont)
Date: Sat, 1 Mar 2003 00:43:44 +0100 (MET)
Cc: root@chaos.analogic.com, kernel@wildsau.idv.uni.linz.at,
       linux-kernel@vger.kernel.org, herp@wildsau.idv.uni.linz.at
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Booting DOS from Linux is not as easy as booting Linux from
> DOS. DOS relies much more on the BIOS, and the state of the
> computer as it is setup by the BIOS. What needs to be right
> for DOS to work is the contents of the BIOS data areas of
> RAM, and the interrupt vector table, and state of some of
> the hardware.

as far as I know, linux does not touch the BIOS data areas,
and "machine_real_start" sets the IDT to 0,3ff again (the
contents of the real-mode IDT are not modified by linux).
the only piece of hardware neccessary to reset was the interrupt
controller, in particular, the IRQ mapping.

> It is surprising it worked that well. You can't even boot
> DOS from DOS, DOS will have changed interrupt vectors which
> would cause a second DOS to fail. If Linux is booted from
> LOADLIN there will already be messed enough with the

interesting that you mention loadlin. when I run loadlin in a
DOS which I booted from linux, (boot linux->boot dos->boot linux),
the 2nd linux boot (by loadlin) will hang with the following message:

C:\LOADLIN> loadlin
[...]

Your current DOS/CPU configuration is:
  load buffer size: 0x[*HANGING*]

This looks promising. I think I gonna download loadlin source now :-)

On the other hand, when instead of loadling MBR and executing it, I
do a far jmp to 0xf000:0xfff0 from "machine_real_start", normal
boot-procedure is exected without haning anywhere. So I think that the
bios-setup is doing some kind of initialisation/modification to whatver(!?)
which the "machine_real_start" function does not.

thanks,
herbert rosmanith

