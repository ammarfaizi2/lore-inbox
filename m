Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276682AbRJBVAc>; Tue, 2 Oct 2001 17:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276684AbRJBVAX>; Tue, 2 Oct 2001 17:00:23 -0400
Received: from cx552039-a.elcjn1.sdca.home.com ([24.177.44.17]:6784 "EHLO
	tigger.unnerving.org") by vger.kernel.org with ESMTP
	id <S276682AbRJBVAM>; Tue, 2 Oct 2001 17:00:12 -0400
Date: Tue, 2 Oct 2001 14:00:40 -0700 (PDT)
From: Gregory Ade <gkade@bigbrother.net>
X-X-Sender: <gkade@tigger.unnerving.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.{4,10} freeze w/ network load?
Message-ID: <Pine.LNX.4.33.0110021006070.1551-100000@tigger.unnerving.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, after a fair bit of experimentation, i've discovered that my home
machine really REALLY doesn't like doing large network transfers.

Symptom:

While doing a large transfer of data (my 12GB of mp3's of my cd
collection) from my workstation to my notebook, my workstation will lock
up, hard.  keyboard and mouse stop responding, any playing music stops
playing, I can't switch virtual consoles, X becomes a static picture, and
the system stops responding to pings or other network traffic.

The only recourse seems to be a system reset.  looking through the
syslogs, there's absolutely _NO_ information there.  I don't think it
oops()'ed, BUG()'ed or panic()'ed.  It just... stopped, for lack of a
better description.

I've just enabled the Magic SysReq key, so the next time it happens maybe
I can get lucky and get some useful information.

some system information:

Kernel:
     Both SuSE's 2.4.4-64GB-SMP and a self-built clean 2.4.10 (SMP) kernel
     exhibit this problem.

Distribution:
     SuSE Linux 7.2

Hardware:
     Dual Pentium II 450, Supermicro P6DBE motherboard, 256MB ram
	  USB (modules)
	  30GB IDE drive (hda)
	  DVD-ROM (hdc)
     3Dfx Voodoo 3 3000 AGP (tdfx module, DRI)
     Promise Ultra/66 IDE controller (ide2 & ide3)
	  2x 30GB IDE drives (hde & hdg, one per channel)
     Adaptec 2940/AU Ultra SCSI2 PCI controller (module)
	  CD-R drive
	  Zip drive
	  DAT drive
	  Microtek Scanner
     3Com 3c905b PCI network card (module)
     Ensonic Soundscape VIVO90 (ISA) (Uses ad1848 & mpu401 modules)
     Parallel printer

     Occasionally I attach a sony camera via USB.

I've got 32-bit & DMA turned on for all four IDE devices (the three disks
and the dvd-rom).

As I write this, I'm beginning to susupect that perhaps the hdparm settings
on the disks on the Promise controller and the IRQ sharing that my system
has decided to use could be one possible source of this problem.  How
well does linux handle IRQ sharing?  I think my next step will be to move
my root disk off the motherboard IDE controller, deactivate the controller
in BIOS (to free up the IRQ), and move it to the Promise controller, in
hopes that Plug-n-Pray will reallocate at least one of the devices currently
on IRQ 11 to IRQ 14.

/proc/interrupts:
           CPU0       CPU1
  0:     293594     153539    IO-APIC-edge  timer
  1:        115        196    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:          1          3    IO-APIC-edge  serial
  5:          1          0    IO-APIC-edge  MS Sound System
  8:          0          1    IO-APIC-edge  rtc
  9:          0          0    IO-APIC-edge  mpu401
 10:         23         22   IO-APIC-level  aic7xxx
 11:      20142      20642   IO-APIC-level  ide2, ide3, eth0, usb-uhci
 12:         12         36    IO-APIC-edge  PS/2 Mouse
 14:       6065       6012    IO-APIC-edge  ide0
 15:          2          3    IO-APIC-edge  ide1
NMI:          0          0
LOC:     447051     447049
ERR:          0
MIS:          0

In each instance of the system locking up, the data being transferred
resided on one of the disks on the Promise controller (on IRQ 11).

Is there any way to further isolate what's causing the lockups, other than
my creative educated guessing?

Any help at all is appreciated.  Thanks in advance!

-- 
Gregory K. Ade <gkade@unnerving.org>
http://unnerving.org/~gkade
OpenPGP Key ID: EAF4844B  keyserver: pgpkeys.mit.edu


