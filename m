Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311242AbSDBAqT>; Mon, 1 Apr 2002 19:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293119AbSDBAqK>; Mon, 1 Apr 2002 19:46:10 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:35323 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S311242AbSDBAqB>; Mon, 1 Apr 2002 19:46:01 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15528.65345.247701.695992@wombat.chubb.wattle.id.au>
Date: Tue, 2 Apr 2002 10:45:53 +1000
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: tulip driver again
CC: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <483868577@toto.iv>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:

Jeff> David Ford wrote:
>> "Me too" however I managed to get mine to work by swaping PCI cards
>> in/out and doing power off reboots.  It is working on this
>> particular boot up so I'm leaving it running.
>> 
>> Jeff Garzik, if you want the lspci, register dump, etc, please
>> speak up.


Jeff> Yes, please do.

Hi Jeff,
   I have a Digital Tulip card that fails to work in recent kernels.
There seems to be a problem with normal-sized packets.

On 2.5.7, this is what I see:
>From the machine with the tulip card, 
     ping -s 70 works;
     ping -s 71 gives
     `wrong data byte #70 should be 0x46 but was 0x0'
     ping -s 79 doesn't work.

>From another machine:
     ping -s 70 works
     ping -s 71 does not work.

Here's the lspci -vvvn output 

00:0a.0 Class 0200: 1011:0014 (rev 11)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 6100 [size=128]
	Region 1: Memory at e2000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=256K]

Here's the messages from the kernel:
Apr  2 10:26:08 crash kernel: de2104x PCI Ethernet driver v0.5.4 (Jan 1, 2002)
Apr  2 10:26:08 crash kernel: de0: SROM leaf offset 30, default media 10baseT auto
Apr  2 10:26:08 crash kernel: de0:   media block #0: BNC
Apr  2 10:26:08 crash kernel: de0:   media block #1: AUI
Apr  2 10:26:08 crash kernel: de0:   media block #2: 10baseT-FD
Apr  2 10:26:08 crash kernel: de0:   media block #3: 10baseT-HD
Apr  2 10:26:08 crash kernel: eth0: 21041 at 0xc2820000, 00:80:48:ea:27:7a, IRQ 11
Apr  2 10:26:27 crash kernel: eth0: set link 10baseT auto
Apr  2 10:26:27 crash kernel: eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
Apr  2 10:26:27 crash kernel: eth0:    set mode 0x7ffc0000, set sia 0xef01,0xffff,0x8
Apr  2 10:26:29 crash kernel: eth0: link up, media 10baseT auto
Apr  2 10:38:03 crash kernel: sending pkt_too_big to self
Apr  2 10:38:16 crash last message repeated 14 times


And here's the output of tulip_diag -mmaavvveef

tulip-diag.c:v2.10 3/08/2002 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Digital DC21041 Tulip adapter at 0x6100.
Digital DC21041 Tulip chip registers at 0x6100:
 0x00: ffe00000 ffffffff ffffffff 0195c000 0195c400 fc660000 7ffc2002 ffffb0d5
 0x40: fffe0000 ffff03ff ffffffff fffe0000 45e1d1c8 ffffef01 ffffffff ffff0008
 Port selection is half-duplex.
 Transmit started, Receive started, half-duplex.
  The Rx process state is 'Waiting for packets'.
  The Tx process state is 'Idle'.
  The transmit unit is set to store-and-forward.
  The NWay status register is 45e1d1c8.
EEPROM 64 words, 6 address bits.
PCI Subsystem IDs, vendor 0000, device 0000.
CardBus Information Structure at offset 00000000.
Ethernet MAC Station Address 00:80:48:EA:27:7A.
EEPROM transceiver/media description table.
Leaf node at offset 30, default media type 0800 (Autosense).
 4 transceiver description blocks:
  21041 media index 00 (10baseT).
  21041 media index 01 (10base2).
  21041 media index 02 (AUI).
  21041 media index 04 (10baseT-Full Duplex).
EEPROM contents (64 words):
0x00:  0000 0000 0000 0000 0000 0000 0000 0000
0x08:  0000 0101 8000 ea48 7a27 1e00 0000 0800
0x10:  0004 0201 0004 0000 0000 0000 0000 0000
0x18:  0000 0000 0000 0000 0000 0000 0000 0000
0x20:  0000 0000 0000 0000 0000 0000 0000 0000
0x28:  0000 0000 0000 0000 0000 0000 0000 0000
0x30:  0000 0000 0000 0000 0000 0000 0000 0000
0x38:  0000 0001 0000 0000 0000 0000 0000 08f5
 ID block CRC 0xe3 (vs. 00).
  Full contents CRC 0x08f5 (read as 0x08f5).
 mdio_read(0x6100, 1, 1).. mdio_read(0x6100, 2, 1).. mdio_read(0x6100, 3, 1).. mdio_read(0x6100, 4, 1).. mdio_read(0x6100, 5, 1).. mdio_read(0x6100, 6, 1).. mdio_read(0x6100, 7, 1).. mdio_read(0x6100, 8, 1).. mdio_read(0x6100, 9, 1).. mdio_read(0x6100, 10, 1).. mdio_read(0x6100, 11, 1).. mdio_read(0x6100, 12, 1).. mdio_read(0x6100, 13, 1).. mdio_read(0x6100, 14, 1).. mdio_read(0x6100, 15, 1).. mdio_read(0x6100, 16, 1).. mdio_read(0x6100, 17, 1).. mdio_read(0x6100, 18, 1).. mdio_read(0x6100, 19, 1).. mdio_read(0x6100, 20, 1).. mdio_read(0x6100, 21, 1).. mdio_read(0x6100, 22, 1).. mdio_read(0x6100, 23, 1).. mdio_read(0x6100, 24, 1).. mdio_read(0x6100, 25, 1).. mdio_read(0x6100, 26, 1).. mdio_read(0x6100, 27, 1).. mdio_read(0x6100, 28, 1).. mdio_read(0x6100, 29, 1).. mdio_read(0x6100, 30, 1).. mdio_read(0x6100, 31, 1).. mdio_read(0x6100, 0, 1)..   No MII transceivers found!
  Internal autonegotiation state is 'Negotiation complete'.



Jeff> The more bug reports I can receive (in private or CC'd to lkml),
Jeff> the better picture I get.  If you have multiple tulips, feel
Jeff> free to email reports on those too :)

Jeff> Best output is: lspci -vvvn dmesg, after updating
Jeff> drivers/net/tulip/tulip.h TULIP_DEBUG to 5, and recompiling
Jeff> tulip-diag -mmaavvveef

Jeff> tulip-diag was written by Donald Becker, and is available from
Jeff> ftp://www.scyld.com/pub/diag/ Compiling instructions are at the
Jeff> end of tulip-diag.c.  You should grab libmii.c as well.

Jeff>     Jeff




Jeff> - To unsubscribe from this list: send the line "unsubscribe
Jeff> linux-kernel" in the body of a message to
Jeff> majordomo@vger.kernel.org More majordomo info at
Jeff> http://vger.kernel.org/majordomo-info.html Please read the FAQ
Jeff> at http://www.tux.org/lkml/


