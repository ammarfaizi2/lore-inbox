Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUGUL4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUGUL4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 07:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbUGUL4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 07:56:15 -0400
Received: from pop.gmx.net ([213.165.64.20]:53720 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266498AbUGUL4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 07:56:11 -0400
X-Authenticated: #4399952
Date: Wed, 21 Jul 2004 14:04:38 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>
Cc: thomas@undata.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: pci gfx card / jack xruns / pci latencies (was: Re:
 [linux-audio-dev] Re: [announce] [patch] Voluntary	Kernel	Preemption Patch)
Message-Id: <20040721140438.2f4bd412@mango.fruits.de>
In-Reply-To: <1090408695.5179.4.camel@localhost>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	<1090306769.22521.32.camel@mindpipe>
	<20040720071136.GA28696@elte.hu>
	<200407202011.20558.musical_snake@gmx.de>
	<1090353405.28175.21.camel@mindpipe>
	<40FDAF86.10104@gardena.net>
	<1090369957.841.14.camel@mindpipe>
	<20040721125352.7e8e95a1@mango.fruits.de>
	<1090408695.5179.4.camel@localhost>
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2004 13:18:15 +0200
Thomas Charbonnel <thomas@undata.org> wrote:

> You could try to adjust the pci latency timer value of your graphic card
> and sound card, see this link for a paper on the subject by Daniel
> Robbins :
> http://www-106.ibm.com/developerworks/library/l-hw2.html

Hi,

good idea. Sadly it doesn't make a difference. Interesting is that lspci -v doesn't show any latency for my mga card:

tapas@mango:~$ lspci -v

[parts snipped, see end of mail]

0000:00:0d.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
        Subsystem: TERRATEC Electronic GmbH: Unknown device 112e
        Flags: bus master, medium devsel, latency 248, IRQ 5
        Memory at cfffb000 (32-bit, non-prefetchable)
        Memory at cfe00000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: <available only to root>

This is the relevant entry:

0000:00:0f.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium] (rev 01) (prog-if 00 [VGA])
        Flags: stepping, medium devsel, IRQ 11
        Memory at cfffc000 (32-bit, non-prefetchable) [size=cffe0000]
        Memory at cd000000 (32-bit, prefetchable) [size=8M]
        Expansion ROM at 00010000 [disabled]

0000:01:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3 Ti 200] (rev a3) (prog-if 00 [VGA])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 8503
        Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 3
        Memory at ce000000 (32-bit, non-prefetchable) [size=cfcf0000]
        Memory at c0000000 (32-bit, prefetchable) [size=128M]
        Memory at cca80000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at 00010000 [disabled]
        Capabilities: <available only to root>


Besides not showing a latency the mga card seems to be the only device which has the Flag: "stepping" instead of "bus master".. I tried setting the latency to 0 anyways, and increased it to ffh for my soundcard. The mga card has become really slow though switching desktops still provokes xruns just as easily.. Any other mga card users here? Is this normal behaviour for a dual gfx card setup? Other values didn't help either..


The rest of the lspci -v output:

0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01)
        Flags: bus master, medium devsel, latency 32
        Memory at d0000000 (32-bit, non-prefetchable)
        Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        Memory behind bridge: cdc00000-cfcfffff
        Prefetchable memory behind bridge: bc900000-ccafffff

0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC Bridge)
        Flags: bus master, medium devsel, latency 0

0000:00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
        Flags: medium devsel
        I/O ports at 0c00 [size=32]

0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
        Flags: bus master, fast devsel, latency 128
        I/O ports at ff00 [size=16]

0000:00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI Fast Ethernet (rev 90)
        Subsystem: Elitegroup Computer Systems: Unknown device 0a14
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at dc00 [size=cffa0000]
        Memory at cfff9000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 00020000 [disabled]
        Capabilities: <available only to root>


Thanks, Florian Schmidt

-- 
Palimm Palimm!
Sounds/Ware:
http://affenbande.org/~tapas/

