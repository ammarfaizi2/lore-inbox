Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130027AbRADXMI>; Thu, 4 Jan 2001 18:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131400AbRADXL7>; Thu, 4 Jan 2001 18:11:59 -0500
Received: from law2-f115.hotmail.com ([216.32.181.115]:14852 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S131399AbRADXLV>;
	Thu, 4 Jan 2001 18:11:21 -0500
X-Originating-IP: [208.5.125.50]
From: "Kambo Lohan" <kambo77@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.2.18 eepro100 hangs (cmd_wait for(0xffffff80) timedout with(0xffffff80)!)
Date: Thu, 04 Jan 2001 18:11:15 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW2-F115vXee4fDGCl0000b907@hotmail.com>
X-OriginalArrivalTime: 04 Jan 2001 23:11:15.0300 (UTC) FILETIME=[A302F240:01C076A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

600mhz celery 2.2.18 vanilla, intel 815EE mobo, onboard eepro100 and pci 
3com 905b.  Happens when traffic is high to the eepro.

FWIW, the 3c905 (3c59x module) also reports 'too much work in interrupt' but 
it did not hang like the eepro100, and by adding max_interrupt_work=40 with 
modprobe, that also solved the warnings. But the intel card actually hangs 
after it shows those warnings, so we thought it was a problem.

messages:Jan  4 09:01:44 axiom1 kernel: eepro100.c:v1.09j-t 9/29/99 Donald 
Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
Jan  4 09:01:44 axiom1 kernel: eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 
Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Jan  4 09:01:44 axiom1 kernel: eepro100.c: VA Linux custom, Dragan Stancevic 
<visitor@valinux.com> 2000/11/15
Jan  4 09:01:44 axiom1 kernel: eth0: Intel PCI EtherExpress Pro100 82562EM, 
00:03:47:0A:C0:97, IRQ 11.
Jan  4 09:01:44 axiom1 kernel:   Receiver lock-up bug exists -- enabling 
work-around.
Jan  4 09:01:44 axiom1 kernel:   Board assembly 000000-000, Physical 
connectors present: RJ45
Jan  4 09:01:44 axiom1 kernel:   Primary interface chip i82555 PHY #1.
Jan  4 09:01:44 axiom1 kernel:   General self-test: passed.
Jan  4 09:01:44 axiom1 kernel:   Serial sub-system self-test: passed.
Jan  4 09:01:44 axiom1 kernel:   Internal registers self-test: passed.
Jan  4 09:01:44 axiom1 kernel:   ROM checksum self-test: passed 
(0x04f4518b).
Jan  4 09:01:44 axiom1 kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
Jan  4 09:01:44 axiom1 kernel: eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 
Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Jan  4 09:01:44 axiom1 kernel: eepro100.c: VA Linux custom, Dragan Stancevic 
<visitor@valinux.com> 2000/11/15
...
Jan  4 17:14:03 axiom1 kernel: eth1: Too much work in interrupt, status 
e401.
Jan  4 17:14:42 axiom1 kernel: eth1: Too much work in interrupt, status 
e481.
Jan  4 17:16:36 axiom1 kernel: eepro100: cmd_wait for(0xffffff80) timedout 
with(0xffffff80)!
Jan  4 17:17:09 axiom1 last message repeated 18 times
Jan  4 17:18:49 axiom1 last message repeated 8 times
Jan  4 17:20:49 axiom1 last message repeated 3 times
Jan  4 17:22:49 axiom1 last message repeated 3 times
Jan  4 17:24:49 axiom1 last message repeated 3 times
Jan  4 17:26:49 axiom1 last message repeated 3 times
Jan  4 17:28:49 axiom1 last message repeated 3 times
Jan  4 17:30:49 axiom1 last message repeated 3 times
Jan  4 17:32:49 axiom1 last message repeated 3 times
Jan  4 17:59:28 axiom1 last message repeated 3 times
Jan  4 17:59:42 axiom1 last message repeated 7 times
Jan  4 17:59:50 axiom1 kernel: eth0: Transmit timed out: status 0050  0c80 
at 13421/13481 command 000c0000.
Jan  4 17:59:50 axiom1 kernel: eepro100: cmd_wait for(0xffffff80) timedout 
with(0xffffff80)!


lspci -v:00:00.0 Host bridge: Intel Corporation: Unknown device 1130 (rev 
02)
        Flags: bus master, fast devsel, latency 0
        Capabilities: [88] #09 [f104]

00:02.0 VGA compatible controller: Intel Corporation: Unknown device 1132 
(rev 02) (prog-if 00 [VGA])
        Subsystem: Intel Corporation: Unknown device 4541
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 11
        Memory at f8000000 (32-bit, prefetchable)
        Memory at ffa80000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2

00:1e.0 PCI bridge: Intel Corporation: Unknown device 244e (rev 01) (prog-if 
00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ff800000-ff8fffff
        Prefetchable memory behind bridge: f6a00000-f6afffff

00:1f.0 ISA bridge: Intel Corporation: Unknown device 2440 (rev 01)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation: Unknown device 244b (rev 01) 
(prog-if 80 [Master])
        Subsystem: Intel Corporation: Unknown device 4541
        Flags: bus master, medium devsel, latency 0
        I/O ports at ffa0

00:1f.2 USB Controller: Intel Corporation: Unknown device 2442 (rev 01) 
(prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 4541
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at ef40

00:1f.3 SMBus: Intel Corporation: Unknown device 2443 (rev 01)
        Subsystem: Intel Corporation: Unknown device 4541
        Flags: medium devsel, IRQ 6
        I/O ports at efa0

00:1f.4 USB Controller: Intel Corporation: Unknown device 2444 (rev 01) 
(prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 4541
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at ef80

00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2445 
(rev 01)
        Subsystem: Intel Corporation: Unknown device 4541
        Flags: bus master, medium devsel, latency 0, IRQ 6
        I/O ports at e800
        I/O ports at ef00

01:08.0 Ethernet controller: Intel Corporation: Unknown device 2449 (rev 01)
        Subsystem: Intel Corporation: Unknown device 3013
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at ff8fe000 (32-bit, non-prefetchable)
        I/O ports at df00
        Capabilities: [dc] Power Management version 2

01:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 30)
        Subsystem: 3Com Corporation: Unknown device 9055
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at dc00
        Memory at ff8ffc00 (32-bit, non-prefetchable)
        Expansion ROM at ff8c0000 [disabled]
        Capabilities: [dc] Power Management version 1

any other info I'm happy to supply!

Thanks,

Kambo

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
