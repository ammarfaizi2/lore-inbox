Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQJaTu7>; Tue, 31 Oct 2000 14:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129942AbQJaTuj>; Tue, 31 Oct 2000 14:50:39 -0500
Received: from nautique.cind.ornl.gov ([134.167.144.7]:46098 "HELO
	nautique.ciit.y12.doe.gov") by vger.kernel.org with SMTP
	id <S129097AbQJaTuf>; Tue, 31 Oct 2000 14:50:35 -0500
Message-ID: <39FF2280.1B0B7DB5@y12.doe.gov>
Date: Tue, 31 Oct 2000 14:50:24 -0500
From: Lawrence MacIntyre <lpz@y12.doe.gov>
Organization: Center for Information Infrastructure Technology
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: PCMCIA and 2.4.0-test6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I reported this to David Hinds, and he said that the PCI messages are
probably important, and I should send this to the lkml.

Details: I am trying to use a Lucent WaveLAN Silver card in  a Sony Vaio
PCG-Z505SX.  First, I tried 3.1.21 (with kernel pcmcia turned off). 
When the machine boots, I get this message (I don't know if it's
important):

PCI: PCI BIOS revision 2.10 entry at 0xfd9d4, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/122e] at 00:07.0
PCI: Found IRQ 9 for device 00:0a.0
PCI: The same IRQ used for device 00:08.1
PCI: Error while updating region 00:0a.0/1 (10000000 != 020000dc)
Limiting direct PCI/PCI transfers.

Later, when the PCMCIA package starts:

Linux PCMCIA Card Services 3.1.22
  kernel build: 2.4.0-test6 #6 Tue Oct 31 11:09:13 EST 2000
  options:  [pci] [cardbus] [apm]
ds: no socket drivers loaded!
unloading PCMCIA Card Services
Linux PCMCIA Card Services 3.1.22
  kernel build: 2.4.0-test6 #6 Tue Oct 31 11:09:13 EST 2000
  options:  [pci] [cardbus] [apm]
Intel PCIC probe: 
  Bridge register mapping failed: check cb_mem_base setting
not found.
ds: no socket drivers loaded!

I get the same thing with 3.1.21.  I also tried building the yenta
version, and this works better.  It loads, and I can use a PCMCIA modem
(it gets IRQ=3).  When I try the Wavelan, it beeps a lot of times, and
cardinfo reports about 5 card inserted card removed pairs.  With 3.1.21,
the PCMCIA module is dead.  It will no longer respond to card
insertions, and the yenta_socket module won't unload.  With 3.1.22, it
will still work with the modem.  With the Wavelan card inserted,
Cardinfo reports only the card name and CD, but no ioports, no irq, no
device.  I've tried excluding IRQs, but then either the card services
won't load, or the card won't load.  I also tried a 3Com/Megahertz
10/100 Cardbus card, and it gets IRQ=9, but no device, no ioports.  One
high, and one low beep.  Any Help?  At this point, I'm not sure whether
it's the pcmcia code or just the drivers for the wavelan and ethernet
cards.

p.s.  I know I should probably use a newer kernel, but I have to use a
binary-only driver for a USB camera that limits my choice of kernel to
2.4.0-test6.  
-- 
                                 Lawrence
                                    ~
------------------------------------------------------------------------
Lawrence MacIntyre      Center for Information Infrastructure Technology
lpz@ciit.y12.doe.gov   http://www.ciit.y12.doe.gov/~lpz     865.574.8696
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
