Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132500AbQLIApP>; Fri, 8 Dec 2000 19:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132890AbQLIApF>; Fri, 8 Dec 2000 19:45:05 -0500
Received: from cicero2.cybercity.dk ([212.242.40.53]:52752 "HELO
	cicero2.cybercity.dk") by vger.kernel.org with SMTP
	id <S132500AbQLIAo7>; Fri, 8 Dec 2000 19:44:59 -0500
Message-ID: <3A317948.10163CC3@2gen.com>
Date: Sat, 09 Dec 2000 01:14:00 +0100
From: David Härdeman <david@2gen.com>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Hard crash when trying to use PCI parallel port card
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the purpose of having two printers connected to my Linux server I
bought a PCI (single port) parallel port card thinking that installation
would be straightforward. 

Parport was already compiled into the kernel (version 2.2.17), and lp is
a module.

After looking at the output from 'lspci -vvx' (see below) I added
'append="parport=0x278,auto parport=0x7c00,11"' to lilo.conf and
rebooted, this far everything was looking good since parport even
managed to retrieve the printer info from the new card (lp1):

<text during bootup>
parport0: PC-style at 0x278 [SPP,PS2,EPP]
parport_probe: failed
parport0: no IEEE-1284 device present.
parport1: PC-style at 0x7c00, irq 11 [SPP,PS2]
parport_probe: succeeded
parport1: Printer, Hewlett-Packard HP LaserJet 1100


Now, as soon as I try to print to /dev/lp1 the box locks up hard
(without any oops messages), moving the printer to lp0 and changing only
the device in /etc/printcap allows me to print just fine.

By looking at the windows drivers provided with the card I came to the
conclusion that the onboard chip was an Oxford Semiconductor OX16PCI954
which as far as I could understand is documented in
http://www.oxsemi.com/products/uarts/ox16pci954/ox16pci954ds.pdf. I've
also searched the previous LKML archives for any posts about this
chipset and all I could find was an older post
(http://lists.insecure.org/linux-kernel/2000/Sep/0071.html) from Tim
Waugh <twaugh@redhat.com> claiming to add support for this chipset.
Looking at 2.2.18-pre25 I couldn't see that the patch had been included
though and as far as I could understand (with my limited knowledge of C)
the patch only added the PCI id's to the kernel.

Now, what can I do to solve this problem? (If any info is missing,
please just ask)


Thanks in advance,
David Härdeman


<lspci -vvx>
00:0c.0 Communication controller: Titan Electronics Inc: Unknown device
ffff
        Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: I/O ports at 7400
        Region 1: Memory at e4102000 (32-bit, non-prefetchable)
        Region 2: I/O ports at 7800
        Region 3: Memory at e4103000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: d2 14 ff ff 03 00 90 02 00 00 80 07 00 00 80 00
10: 01 74 00 00 00 20 10 e4 01 78 00 00 00 30 10 e4
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 14 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 00 00 00

00:0c.1 Parallel controller: Titan Electronics Inc: Unknown device a000
(prog-if 01 [BiDir])
        Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 7c00
        Region 1: I/O ports at 8000
        Region 2: I/O ports at 8400
        Region 3: Memory at e4104000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: d2 14 00 a0 03 00 90 02 00 01 01 07 00 00 80 00
10: 01 7c 00 00 01 80 00 00 01 84 00 00 00 40 10 e4
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 14 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
