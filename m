Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130463AbQLRI1t>; Mon, 18 Dec 2000 03:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131027AbQLRI1l>; Mon, 18 Dec 2000 03:27:41 -0500
Received: from pop3.web.de ([212.227.116.81]:51465 "HELO smtp.web.de")
	by vger.kernel.org with SMTP id <S130463AbQLRI1b>;
	Mon, 18 Dec 2000 03:27:31 -0500
From: "Michael Illgner" <fillg1@web.de>
To: <andrewm@uow.edu.au>
Cc: <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Problem with 3c59x and 3C905B
Date: Mon, 18 Dec 2000 08:55:27 +0100
Message-ID: <JDEJLKPAIGJAKBJPIALIIEKOCBAA.fillg1@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
I have some trouble using a 3COM NIC905B and the 3c59x driver with kernel
2.2.x
and 2.4.0.testx. First of all the card works fine with Windows or with linux
2.2.18
using the 3c90x driver supplied by 3COM. But with the 3c59x driver I get
transfer rates
below 10k/s or even lower. The card is connected to a 10/100 Hub (Netgear
DS104).

Here are some informations

Kernel version

2.2.18 SMP and 2.4.0.test12 SMP (latest kernel) but the problem seems
to be independent of the kernel version.


Banner message

Dec 17 19:44:48 ganerc kernel: 3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker
and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
Dec 17 19:44:48 ganerc kernel: See Documentation/networking/vortex.txt
Dec 17 19:44:48 ganerc kernel: eth0: 3Com PCI 3c905B Cyclone 100baseTx at
0xdc00,  00:10:5a:d8:25:f1, IRQ 19
Dec 17 19:44:48 ganerc kernel: Full duplex capable
Dec 17 19:44:48 ganerc kernel:   8K byte-wide RAM 5:3 Rx:Tx split,
autoselect/Autonegotiate interface.
Dec 17 19:44:48 ganerc kernel:   MII transceiver found at address 24, status
786d.
Dec 17 19:44:48 ganerc kernel:   MII transceiver found at address 0, status
786d.
Dec 17 19:44:48 ganerc kernel:   Enabling bus-master transmits and
whole-frame receives.
Dec 17 19:44:48 ganerc kernel: eth0: using NWAY autonegotiation


lspci -vx

00:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Flags: bus master, medium devsel, latency 64, IRQ 19
	I/O ports at dc00 [size=128]
	Memory at e1000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at df000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
00: b7 10 55 90 07 00 10 02 30 00 00 02 08 40 00 00
10: 01 dc 00 00 00 00 00 e1 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
30: 00 00 00 df dc 00 00 00 00 00 00 00 0a 01 0a 0a


Here are some messages from syslog

Dec 17 19:59:15 ganerc kernel: vortex_up(): writing 0x3800000 to
InternalConfig
Dec 17 19:59:15 ganerc kernel: eth0: MII #24 status 786d, link partner
capability 40a1, setting half-duplex.
Dec 17 19:59:15 ganerc kernel: eth0: MII #24 status 786d, link partner
capability 40a1, setting half-duplex.
Dec 17 19:59:15 ganerc kernel: eth0: vortex_up() InternalConfig 03800000.
Dec 17 19:59:15 ganerc kernel: eth0: vortex_up() irq 19 media status 8080.
Dez 17 19:59:16 ganerc network: Bringing up interface eth0:  succeeded
Dec 17 19:59:18 ganerc kernel: eth0: Media selection timer tick happened,
Autonegotiate.
Dec 17 19:59:18 ganerc kernel: dev->watchdog_timeo=40
Dec 17 19:59:18 ganerc kernel: eth0: MII transceiver has status 7869.
Dec 17 19:59:18 ganerc kernel: eth0: Media selection timer finished,
Autonegotiate.
Dec 17 19:59:29 ganerc kernel: boomerang_start_xmit()
Dec 17 19:59:29 ganerc kernel: eth0: Trying to send a packet, Tx index 0.
Dec 17 19:59:29 ganerc kernel: boomerang_interrupt. status=0xe201
Dec 17 19:59:29 ganerc kernel: eth0: interrupt, status e201, latency 8
ticks.
Dec 17 19:59:29 ganerc kernel: eth0: In interrupt loop, status e201.
Dec 17 19:59:29 ganerc kernel: eth0: exiting interrupt, status e000.
Dec 17 19:59:29 ganerc kernel: boomerang_interrupt. status=0xe401
Dec 17 19:59:29 ganerc kernel: eth0: interrupt, status e401, latency 6
ticks.
Dec 17 19:59:29 ganerc kernel: eth0: In interrupt loop, status e401.
Dec 17 19:59:29 ganerc kernel: boomerang_interrupt->boomerang_rx
Dec 17 19:59:29 ganerc kernel: boomerang_rx(): status e001
Dec 17 19:59:29 ganerc kernel: Receiving packet size 60 status 803c.
Dec 17 19:59:29 ganerc kernel: eth0: exiting interrupt, status e000.
Dec 17 19:59:29 ganerc kernel: boomerang_start_xmit()
Dec 17 19:59:29 ganerc kernel: eth0: Trying to send a packet, Tx index 1.
Dec 17 19:59:29 ganerc kernel: boomerang_interrupt. status=0xe201
Dec 17 19:59:29 ganerc kernel: eth0: interrupt, status e201, latency 5
ticks.
Dec 17 19:59:29 ganerc kernel: eth0: In interrupt loop, status e201.
Dec 17 19:59:29 ganerc kernel: eth0: exiting interrupt, status e000.
Dec 17 19:59:29 ganerc kernel: boomerang_interrupt. status=0xe401
Dec 17 19:59:29 ganerc kernel: eth0: interrupt, status e401, latency 6
ticks.
Dec 17 19:59:29 ganerc kernel: eth0: In interrupt loop, status e401.
Dec 17 19:59:29 ganerc kernel: boomerang_interrupt->boomerang_rx
Dec 17 19:59:29 ganerc kernel: boomerang_rx(): status e001
Dec 17 19:59:29 ganerc kernel: Receiving packet size 98 status 20008062.
Dec 17 19:59:29 ganerc kernel: eth0: exiting interrupt, status e000.
Dec 17 19:59:30 ganerc kernel: boomerang_start_xmit()
Dec 17 19:59:30 ganerc kernel: eth0: Trying to send a packet, Tx index 2.
Dec 17 19:59:30 ganerc kernel: boomerang_interrupt. status=0xe201
Dec 17 19:59:30 ganerc kernel: eth0: interrupt, status e201, latency 5
ticks.
Dec 17 19:59:30 ganerc kernel: eth0: In interrupt loop, status e201.
Dec 17 19:59:30 ganerc kernel: eth0: exiting interrupt, status e000.
Dec 17 19:59:30 ganerc kernel: boomerang_interrupt. status=0xe401
Dec 17 19:59:30 ganerc kernel: eth0: interrupt, status e401, latency 5
ticks.
Dec 17 19:59:30 ganerc kernel: eth0: In interrupt loop, status e401.
Dec 17 19:59:30 ganerc kernel: boomerang_interrupt->boomerang_rx
Dec 17 19:59:30 ganerc kernel: boomerang_rx(): status e001
Dec 17 19:59:30 ganerc kernel: Receiving packet size 98 status 20008062.
Dec 17 19:59:30 ganerc kernel: eth0: exiting interrupt, status e000.
Dec 17 19:59:31 ganerc kernel: boomerang_start_xmit()
Dec 17 19:59:31 ganerc kernel: eth0: Trying to send a packet, Tx index 3.
Dec 17 19:59:31 ganerc kernel: boomerang_interrupt. status=0xe201
Dec 17 19:59:31 ganerc kernel: eth0: interrupt, status e201, latency 4
ticks.
Dec 17 19:59:31 ganerc kernel: eth0: In interrupt loop, status e201.
Dec 17 19:59:31 ganerc kernel: eth0: exiting interrupt, status e000.
Dec 17 19:59:31 ganerc kernel: boomerang_interrupt. status=0xe401
Dec 17 19:59:31 ganerc kernel: eth0: interrupt, status e401, latency 5
ticks.
Dec 17 19:59:31 ganerc kernel: eth0: In interrupt loop, status e401.
Dec 17 19:59:31 ganerc kernel: boomerang_interrupt->boomerang_rx


the ouput from vortex-diag -aaee is

vortex-diag.c:v2.03 9/26/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a 3c905B Cyclone 100baseTx adapter at 0xdc00.
The Vortex chip may be active, so FIFO registers will not be read.
To see all register values use the '-f' flag.
Initial window 7, registers values by window:
  Window 0: 0000 0000 0000 0000 0000 00bf 0000 0000.
  Window 1: FIFO FIFO 0000 0000 0000 0000 0000 2000.
  Window 2: 1000 d85a f125 0000 0000 0000 000a 4000.
  Window 3: 0000 0380 05ea 0020 000a 0800 0800 6000.
  Window 4: 0000 0000 0000 0cd8 0003 8880 0000 8000.
  Window 5: 1ffc 0000 0000 0600 0805 06ce 06c6 a000.
  Window 6: 0000 0000 0000 4a01 0100 3c43 6176 c000.
  Window 7: 0000 0000 0000 0000 0000 0000 0000 e000.
Vortex chip registers at 0xdc00
  0xDC10: **FIFO** 00000000 0000000d *STATUS*
  0xDC20: 00000020 00000000 00080000 00000004
  0xDC30: 00000000 bea6415a 0c05e060 00080004
 Indication enable is 06c6, interrupt enable is 06ce.
 No interrupt sources are pending.
 Transceiver/media interfaces available:  100baseTx 10baseT.
Transceiver type in use:  Autonegotiate.
 MAC settings: full-duplex.
 Station address set to 00:10:5a:d8:25:f1.
 Configuration options 000a.
EEPROM contents (64 words, offset 0):
 0x000: 0010 5ad8 25f1 9055 c579 0036 5051 6d50
 0x008: 2971 0000 0010 5ad8 25f1 8010 0000 0022
 0x010: 32a2 0000 0000 0380 0000 0004 0000 10b7
 0x018: 9055 000a 0000 0000 0000 0000 0000 0000
 0x020: 00e6 0000 0000 0000 0000 0000 0000 0000
 0x028: 0000 0000 0000 0000 0000 0000 0000 0000
 0x030: 0000 0000 0000 0000 0000 0000 0000 0000
 0x038: 0000 0000 0000 0000 0000 0000 0000 0000
 The word-wide EEPROM checksum is 0x971c.
Parsing the EEPROM of a 3Com Vortex/Boomerang:
 3Com Node Address 00:10:5A:D8:25:F1 (used as a unique ID only).
 OEM Station address 00:10:5A:D8:25:F1 (used as the ethernet address).
 Manufacture date (MM/DD/YYYY) 11/25/1998, division 6, product QP.
Options: force full-duplex.
  Vortex format checksum is incorrect (008e vs. 10b7).
  Cyclone format checksum is correct (0xe6 vs. 0xe6).
  Hurricane format checksum is correct (0xe6 vs. 0xe6).


output from mii-diag -v

mii-diag.c:v2.00 4/19/2000  Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
 MII PHY #24 transceiver registers:
   3000 786d 0000 0000 01e1 40a1 0007 2801
   0000 0000 0000 0000 0000 0000 0000 0000
   8000 0afb f5ff 0000 0000 0005 2001 0000
   0000 2042 0044 1c11 0012 1000 0000 0000.
 Basic mode control register 0x3000: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
   This transceiver is capable of  100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Your link partner advertised 40a1: 100baseTx 10baseT.
 MII PHY #24 transceiver registers:
   3000 786d 0000 0000 01e1 40a1 0005 2801
   0000 0000 0000 0000 0000 0000 0000 0000
   8000 0008 0090 0000 0000 0005 2001 0000
   0000 2042 0044 1c11 0002 1000 0000 0000.
 Basic mode control register 0x3000: Auto-negotiation enabled.
 Basic mode status register 0x786d ... 786d.
   Link status: established.
   Capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 This transceiver has no vendor identification.
 I'm advertising 01e1: 100baseTx-FD 100baseTx 10baseT-FD 10baseT
   Advertising no additional info pages.
   IEEE 802.3 CSMA/CD protocol.
 Link partner capability is 40a1: 100baseTx 10baseT.
   Negotiation  completed.

Any idea what is going wrong here ?


Thanks in advance for your help...


Michael Illgner

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
