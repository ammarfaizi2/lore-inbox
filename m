Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135422AbRDRWWC>; Wed, 18 Apr 2001 18:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135426AbRDRWVw>; Wed, 18 Apr 2001 18:21:52 -0400
Received: from blackhole.compendium-tech.com ([206.55.153.26]:51961 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S135422AbRDRWVq>; Wed, 18 Apr 2001 18:21:46 -0400
Date: Wed, 18 Apr 2001 15:21:17 -0700 (PDT)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
X-X-Sender: <kernel@sol.compendium-tech.com>
To: Kurt Garloff <kurt@garloff.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: APIC errors ...
In-Reply-To: <20010406005014.B9058@garloff.etpnet.phys.tue.nl>
Message-ID: <Pine.LNX.4.33.0104181516030.16915-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Um... Looks like when you clock the BX-chipset out of spec (>100MHz FSB)
you get the error. Since BX wasn't ever designed to be run at >100MHz
these errors are *expected*.

You have a couple solutions: Upgrade the motherboard to one of the VIA
133MHz chipsets (I dont care for the VIA chipset so this really doesn't
strike my fancy) or upgrade to that other Intel chipset that supports SMP;
unfortunately it also is a rambus board....Serverworks also has a chipset
out that does dual intel chips at 133MHz; I've heard only good things
about it.

but, from what it looks like, your board is flakey up high...

good luck,
-kelsey


On Fri, 6 Apr 2001, Kurt Garloff wrote:

> Hi,
>
> lately having upgraded my DUal-BX motherboard to two PIII-850 CPUs, I run
> into some trouble.
> FIrst, I had had an assymetric configuration (iPIII-850 + iPII-350) , which
> Linux did not support; I created a fix and sent it to LKML. It worked
> perfectly, i.e. without the problems described below.
>
> Now, I have two iPIII-850, but I run into different kind of troubles:
> (a) The BIOS will sometimes not recognize the second CPU
> (b) Linux reports APIC errors and occasionally stops to process IRQs on the
>     second CPU or crashes (2.4.x kernel).
>
> Some details: DFI P2XBL/D, i440BX, BIOS Award mid 2000 (MPS 1.4), microcode
> patches end 2000 patched into BIOS (which yields the rev. 08 for my pIII
> (868)). The board is unable to supply the needed 1.7V for the CPUs,
> therefore the Slot Adapter (from PowerLeap) contains voltage regulators and
> VID is faked to 2.2V. The mainboard by specs supports up to 800MHz (max
> multiplier 8 with FSB 100MHz).
>
> The config should be fine; the nmultipliers are fixe anyway nowadays. However:
> (a) If I explicitly specify 100, 103 or 112 MHz FSB freq., the second CPU is
>      not recognized by the BIOS (and subsequently not by Linux) most of the
>      times. If set to automatic (yields 100MHz), it always recognizes the
>      2nd CPU. Strange! Setting 83, 75, or 66 MHz FSB, the 2nd CPU is
>      recognized as well.
> (b) The 2.2.16 kernel seems to be happy (did not run long enough to really
>      check stability), but the 2.4.x kernels reports lots of APIC errors.
>      Lots is smth in between 1/minute (almost idle computer) and more than
>      1/second (gears Meas demo running). After some time, eventually the 2nd
>      CPU does not get IRQs any more; I've even seen some lockups (after a
>      day or so) of Linux, which I'm not used to :-(
>      Going back to 83/75/66 MHz FSB seems to also solve this problem, but
>      is not considered a solution by me.
>
> Here's some excerpt: (dmesg)
> APIC error on CPU1: 02(02)
> APIC error on CPU0: 01(01)
> APIC error on CPU1: 02(02)
> APIC error on CPU0: 01(05)
> APIC error on CPU1: 02(02)
> unexpected IRQ trap at vector d0
> unexpected IRQ trap at vector 88
> APIC error on CPU1: 02(02)
> APIC error on CPU0: 05(01)
> APIC error on CPU1: 02(02)
> APIC error on CPU0: 01(01)
> APIC error on CPU1: 02(02)
> APIC error on CPU0: 01(01)
> APIC error on CPU0: 01(01)
> APIC error on CPU1: 02(02)
> APIC error on CPU0: 01(01)
>
> pckurt:~ # cat /proc/interrupts
>            CPU0       CPU1
>   0:    5180522    2357505    IO-APIC-edge  timer
>   1:      24284      15803    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   3:          2          0    IO-APIC-edge
>   4:          0          2    IO-APIC-edge  serial
>   5:      35031      27240    IO-APIC-edge  snd-card-als100 - DSP
>   6:          1          2    IO-APIC-edge
>   7:          2          0    IO-APIC-edge  parport0
>   8:          0          1    IO-APIC-edge  rtc
>  10:          1          0    IO-APIC-edge  snd-card-als100 - MPU-401
>  12:       5124       5959    IO-APIC-edge  PS/2 Mouse
>  14:      18953      18258    IO-APIC-edge  ide0
>  17:      21728      20208   IO-APIC-level  eth0
>  18:      23418      22327   IO-APIC-level  sym53c8xx
>  19:       9553       9442   IO-APIC-level  aic7xxx, bttv
>  28:          0         13            none
> 136:          0         35            none
> 140:          0          3            none
> 152:          0          1            none
> 156:          0          2            none
> 160:          0          2            none
> 172:          0         14            none
> 200:          0          1            none
> 204:          0          2            none
> 208:          0         13            none
> NMI:          0          0
> LOC:    7538766    7538742
> ERR:        777
>
> (Note that I patched the IRQ reporting stuff, so you can get a count for
> bogus IRQ vectors.) The AGP slot (MGA400) is mapped to IRQ16. (Not visible
> above.)
>
> As you can see, the APIC on CPU1 seems eems to suffer under noise!
> It gets APIC errors (which it acknowledges and causes CPU0 to also get an
> error) and occasionally receives bogus IRQ vectors.
>
> So this looks like a HW problem. Some reports on LKML seem to indicate that
> this is indeed the case.
>
> Somebody is talking about the voltage regulators not giving a really stable
> voltage (without load?) causing the noise. A resistor with a capacitor
> should help then ... However, sensors reports 2.20V without any flakiness.
> Any details on this known?
> It could also be that the MoBo chipset (IO-APIC?) has problems to recognize
> the signals from 1.7V CPUs expecting at least 1.8 (or 2.2) V. Maybe faking
> the VID to 2.0V instead of 2.2V would be useful then.
>
> I would be thankful for any knowledge on this issue!
>
> (As this is slightly off-topic, you may reply via PM. If I happen to solve
>  my problems, I'll post a summary to LKML.)
>
> Regards,
>

-- 
 Kelsey Hudson                                           khudson@ctica.com
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

