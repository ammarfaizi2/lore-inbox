Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQKRK0s>; Sat, 18 Nov 2000 05:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130664AbQKRK03>; Sat, 18 Nov 2000 05:26:29 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:14375 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129352AbQKRK0U>; Sat, 18 Nov 2000 05:26:20 -0500
Message-ID: <3A16521A.44B2B628@linux.com>
Date: Sat, 18 Nov 2000 01:55:39 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, David Hinds <dhinds@valinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <Pine.LNX.4.10.10011170814440.2272-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------AD9561CF48BC507C1C9B93AF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AD9561CF48BC507C1C9B93AF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
[...]

> If somebody still has a problem with the in-kernel stuff, speak up.

The kernel's irq detection for the card sockets doesn't work for me.  It's the NEC
Versa LX story.  The DH code also reports no IRQ found but still figures out a
working IRQ (normally 3) and assigns it for the tulip card.  I use the i82365 module
w/ the DH code.  The below is the output of the kernel pcmcia code.

[side note for David Hinds - please let me make both kernel pcmcia core modules and
dh modules without having to do workarounds]

(pci=biosirq makes no change in any discernable fashion, parts omitted for technical
clarity)

# dmesg
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: No IRQ known for interrupt pin B of device 00:03.1. Please try using
pci=biosirq.
PCI: No IRQ known for interrupt pin A of device 00:03.0. Please try using
pci=biosirq.
Intel PCIC probe: not found.
Databook TCIC-2 PCMCIA probe: not found.
Yenta IRQ list 0c90, PCI irq0
Socket status: 30000860
Yenta IRQ list 0898, PCI irq0
Socket status: 30000046
[...]
cs: cb_alloc(bus 2): vendor 0x1011, device 0x0019
PCI: Enabling device 02:00.0 (0000 -> 0003)
Linux Tulip driver version 0.9.11 (November 3, 2000)
PCI: No IRQ known for interrupt pin A of device 02:00.0. Please try using
pci=biosirq.
PCI: Setting latency timer of device 02:00.0 to 64
eth0: Digital DS21143 Tulip rev 65 at 0x1800, 00:E0:98:70:1E:AF, IRQ 0.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
eth0:  MII transceiver #0 config 3000 status 7809 advertising 01e1.
call_usermodehelper[/sbin/hotplug]: no root fs

# cardctl config
Socket 0:
  Vcc 3.3V  Vpp1 3.3V  Vpp2 3.3V
  interface type is "cardbus"
  function 0:
Socket 1:
  not configured

# lspci -vvv
00:03.0 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 03)
        Subsystem: NEC Corporation: Unknown device 8039
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00001800-000018ff
        I/O window 1: 00001c00-00001cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:03.1 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 03)
        Subsystem: NEC Corporation: Unknown device 8039
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin B routed to IRQ 0
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=06, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
        16-bit legacy interface ports at 0001

# dump_pirq
Interrupt routing table found at address 0xf5a80:
  Version 1.0, size 0x0080
  Interrupt router is device 00:07.0
  PCI exclusive interrupt mask: 0x0000
  Compatible router: vendor 0x8086 device 0x1234

Device 00:03.0 (slot 0):
  INTA: link 0x60, irq mask 0x0420
  INTB: link 0x61, irq mask 0x0420

Interrupt router: Intel 82371AB PIIX4/PIIX4E PCI-to-ISA bridge
  PIRQ1 (link 0x60): irq 10
  PIRQ2 (link 0x61): irq 5
  PIRQ3 (link 0x62): unrouted
  PIRQ4 (link 0x63): irq 9
  Serial IRQ: [enabled] [continuous] [frame=21] [pulse=4]



--------------AD9561CF48BC507C1C9B93AF
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------AD9561CF48BC507C1C9B93AF--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
