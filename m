Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289058AbSB0A1b>; Tue, 26 Feb 2002 19:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290277AbSB0A1W>; Tue, 26 Feb 2002 19:27:22 -0500
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:55815 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S289058AbSB0A1M>; Tue, 26 Feb 2002 19:27:12 -0500
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200202270026.g1R0QOa14113@wildsau.idv-edu.uni-linz.ac.at>
Subject: pcmcia problems with IDE & cardbus
To: linux-kernel@vger.kernel.org
Date: Wed, 27 Feb 2002 01:26:23 +0100 (MET)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

I've been trying to get a CompactFlash act as an IDE-drive, 2nd or 3rd
ide-channel, that is, IDE1 or IDE2 resp. Didn't work. Seems to be driver
related.

I downloaded 2.4.18 and pcmcia-3.1.31, from the later I got "ide_cs.o"

The hardware I am using a a two socket PCI to PCMCIA bridge:

hale-bopp:~ # cat /proc/interrupts
[...]
 10:          1          XT-PIC  Texas Instruments PCI1221, Texas Instruments PCI1221 (#2)


when the init-script starts the pcmcia modules + cardmgr, the following
messages will appear in the kernel-log:

   : Linux Kernel Card Services 3.1.22
   :   options:  [pci] [cardbus] [pm]
   : PCI: Found IRQ 10 for device 00:09.0
   : PCI: Sharing IRQ 10 with 00:09.1
   : PCI: Found IRQ 10 for device 00:09.1
   : PCI: Sharing IRQ 10 with 00:09.0
   : Yenta IRQ list 0000, PCI irq10
   : Socket status: 30000006
   : Yenta IRQ list 0000, PCI irq10
   : Socket status: 30000010
   : cs: IO port probe 0x0c00-0x0cff: clean.
   : cs: IO port probe 0x0800-0x08ff: clean.
   : cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
   : cs: IO port probe 0x0a00-0x0aff: clean.
   : cs: memory probe 0xa0000000-0xa0ffffff: clean.
   : hde: SanDisk SDCFB-16, ATA DISK drive
   : ide2: Disabled unable to get IRQ 10.
   : hde: ERROR, PORTS ALREADY IN USE
   : ide2: ports already in use, skipping probe
   : ide2: ports already in use, skipping probe
   : ide2: ports already in use, skipping probe
   : ide2: ports already in use, skipping probe
   : ide2: ports already in use, skipping probe
   : ide2: ports already in use, skipping probe
   : ide2: ports already in use, skipping probe
   : ide2: ports already in use, skipping probe
   : ide_cs: ide_register() at 0x100 & 0x10e, irq 10 failed
   : Trying to free nonexistent resource <00000100-0000010f>

"unable to get IRQ 10" is somewhat funny, since IRQ-10 is used by
the cardbus device. what I don't understand is if the IDE-drive
sould get its own interrupt or not.

"ports already in use" doesnt go away even when I remove all IDE-drives
(one CDROM, that is ;-) from ide1 and try to have the CompactFlash as
2ndry IDE (the message would then read: ide1: ports alread yin use,
skipping probe).

and finally an ugly detail: when removing the ComapctFlash and
unloading pcmcia, ide_cs will still have the ioport-ressources
clailed form /proc/ioport. seems there's a call to *_unregister
missing.

/herp

