Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261329AbSJLTaH>; Sat, 12 Oct 2002 15:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261336AbSJLTaH>; Sat, 12 Oct 2002 15:30:07 -0400
Received: from cats-mx2.ucsc.edu ([128.114.129.35]:32926 "EHLO ucsc.edu")
	by vger.kernel.org with ESMTP id <S261329AbSJLTaG>;
	Sat, 12 Oct 2002 15:30:06 -0400
To: linux-kernel@vger.kernel.org
Subject: kernel hang, spurious 8259A interrupt: IRQ7
Message-Id: <E180RyS-000092-00@toraigh>
From: Jim McCloskey <mcclosk@ling.ucsc.edu>
Date: Sat, 12 Oct 2002 12:30:56 -0700
X-UCSC-CATS-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have had the `problem', discussed extensively here and in other places,
of the message:

  spurious 8259A interrupt: IRQ7

appearing on the console, at boot time regularly and at other times
occasionally. This is with 2.4.18, with APIC enabled (more details
below). 

The many discussions of this issue that I've read usually conclude
that it is a harmless nuisance rather than a problem.

Twice in the past year, though, I have had the system hang at the
point in the boot-process where the system printer daemon is started
(lprng in this case). At boot time, the spurious interrupt message
appears just before this part of the process:

Oct 12 09:54:15 toraigh kernel: spurious 8259A interrupt: IRQ7.
Oct 12 09:54:16 toraigh kernel: parport0: PC-style at 0x378 [PCSPP(,...)]
Oct 12 09:54:16 toraigh kernel: parport_pc: Via 686A parallel port: io=0x378
Oct 12 09:54:16 toraigh kernel: lp0: using parport0 (polling).
Oct 12 09:54:16 toraigh kernel: lp0: compatibility mode

Since, if I understand correctly, the parallel port interrupt is
standardly at IRQ7, I was curious whether the hang might be connected
in some way with IRQ handling or with whatever lies behind the
`spurious interrupt' message.

In both cases the machine would not respond to keyboard input of any
kind and I had to hit the reset button. I had to run fsck manually to
fix inconsistencies on the root partition (/dev/sda1), but once that
was done, the system re-booted normally.

I would be very grateful indeed for any advice or pointers. I reboot
frequently (energy conservation) and the system-hang is a little
frightening.

Jim

----------------------------------------------------------------------
kernel: Linux version 2.4.18 (root@toraigh) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Sun Aug 4 18:11:44 PDT 2002

        CONFIG_X86_GOOD_APIC=y
        CONFIG_X86_UP_APIC=y
        # CONFIG_X86_UP_IOAPIC is not set
        CONFIG_X86_LOCAL_APIC=y

        Mainboard:      Tyan Trinity K7 S2380
        CPU:            AMD Athlon K7 750MHz	
	SCSI HBA:	Tekram DC390U2W PCI Ultra2W LVD-SCSI HBA
        Boot HD:        Seagate 9.1GB LVD ST39236LW
        Ethernet Card:  KTI KF-221TX/2          
	Graphics:	Matrox G400  16MB SGRAM AGP
	Sound card:	Creative Ensoniq AudioPCI	

/proc/interrupts:

           CPU0       
  0:     831752          XT-PIC  timer
  1:      16493          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:     222989          XT-PIC  serial
 10:          0          XT-PIC  es1371
 11:          7          XT-PIC  eth0
 12:      93259          XT-PIC  PS/2 Mouse
 15:      33434          XT-PIC  sym53c8xx
NMI:          0 
LOC:     831722 
ERR:        158
----------------------------------------------------------------------

