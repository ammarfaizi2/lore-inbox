Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131118AbRAMSZT>; Sat, 13 Jan 2001 13:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131108AbRAMSZD>; Sat, 13 Jan 2001 13:25:03 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130991AbRAMSYw>;
	Sat, 13 Jan 2001 13:24:52 -0500
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <20010112212427.A2829@suse.cz> <E14HDv7-0005G6-00@the-village.bc.nu> <20010113144528.D1155@suse.cz>
Keywords: isopiestic, equally, hinge joint, generalize, jailer, blob,
   dramatis personae, corner, meliorism
From: "Bryan O'Sullivan" <bos@serpentine.com>
Date: 13 Jan 2001 09:09:05 -0800
In-Reply-To: Vojtech Pavlik's message of "Sat, 13 Jan 2001 14:45:28 +0100"
Message-ID: <87bstbpefi.fsf@pelerin.serpentine.com>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Channel Islands"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

v> I can make one for you, but first I'd like to find out what exactly are
v> the problem cases.

I have a VT82C686 motherboard.  It has one UDMA-100 slot and two
regular IDE slots.  I have an IBM DTTA-371440 (about 18 months old) as
hda (only fat32 filesystems), and an IBM DTLA-307030 as hde
(i.e. plugged into the UDMA-100 slot).  I've never seen any problems
with DMA on the newer drive, but if I turn on DMA and do anything with
the older drive, I get stuff like this:

  /dev/ide/host0/bus0/target0/lun0:hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
  hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
  hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
  hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
  hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
  hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
  hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
  hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 

The driver attempts to reset ide0 a few times, gets more of the above,
then gives up with an I/O error.

I've been seeing these problems as long as I've been tracking the 2.3
series, up to and including 2.4.0.  I can't boot a 2.2 kernel on this
machine to compare, as it doesn't recognise hde (which is where Linux
lives).

Here's the output of lspci under 2.4.0, in case it's useful:

  00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
  00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
  00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
  00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
  00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
  00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
  00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
  00:09.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
  00:09.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
  00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
  00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
  00:0b.1 Input device controller: Creative Labs SB Live! (rev 08)
  00:11.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 0d30 (rev 02)
  01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0150 (rev a3)

If you need any more information, I can dig it out.

	<b
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
