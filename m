Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132958AbREHSeA>; Tue, 8 May 2001 14:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133088AbREHSdv>; Tue, 8 May 2001 14:33:51 -0400
Received: from opengraphics.com ([216.208.162.194]:37346 "EHLO
	hurricane.opengraphics.com") by vger.kernel.org with ESMTP
	id <S132958AbREHSdt>; Tue, 8 May 2001 14:33:49 -0400
Date: Tue, 8 May 2001 14:33:47 -0400
To: linux-kernel@vger.kernel.org
Subject: Problem: 'keyboard: Timeout - AT keyboard not present?'
Message-ID: <20010508143347.A15191@concord.opengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: Len Sorensen <lsorense@opengraphics.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been encountering the following problem for quite a while now
(in 2.4 pre kernels, and 2.4.x final kernels), and from what I have
been able to determine, it has affected people since 2.3.4x or so,
and is also affecting 2.2.17 and above.

The problem is that once in a while (which varies greatly and doesn't
appear at all consistent), the keyboard will lock up for a second or
two and the kernel prints the message 'keyboard: Timeout - AT keyboard
not present?'.  This almost always involves getting an extra character
(usually the one just hit or the one before it), or missing the character
just hit.  It can even occur when not typing at all, although that is
much more rare.

I used to think it was just a problem in the keyboard controller on my
machine, but I now have it happening on the machine I just switched to,
and have found a number of other posts about this problem by searching
www.google.com for the string in the error message.  I no longer think
it is necessarily a hardware problem (although I can't rule out this
error being caused by flaky keyboard controllers).  The same machines
that display this error, never even once have done so with 2.2.16
or lower.

Some interesting trends I found while searching for any info on this message on google are these:

initialize_kbd: Keyboard reset failed, no ACK
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize

initialize_kbd: Keyboard interface failed self test
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
Floppy drive(s): fd0 is 2.88M

initialize_kbd: Keyboard reset failed, no ACK
Serial driver version 4.92 (2000-1-27) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
ttyS00 at 0x03f8 (irq = 4) is a 16550A

and:

PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
hda: Maxtor 91366U4, ATA DISK drive

PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x84c0-0x84c7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x84c8-0x84cf, BIOS settings: hdc:pio, hdd:DMA
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
hda: QUANTUM FIREBALLP LM15, ATA DISK drive

SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS5597
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
hda: ST5660A, ATA DISK drive

It seems that it tends to occur just after the ide controller is
detected, and/or just around the unix98 pty init (which is right around
the serial port init).  Not sure if the probing of hardware involves
the interrupts being disabled, and that causing a problem.

It of course also happens lots while I am typing, so I am not sure what
can be causing interrupt loses, but it could be disk access or power
management.  I will try using a kernel without any power management and
see if that makes a difference.

Len Sorensen
