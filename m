Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262056AbREPSr7>; Wed, 16 May 2001 14:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262054AbREPSru>; Wed, 16 May 2001 14:47:50 -0400
Received: from unamed.infotel.bg ([212.39.68.18]:56702 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id <S262050AbREPSre>;
	Wed, 16 May 2001 14:47:34 -0400
Date: Wed, 16 May 2001 21:48:19 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: locked 3c905B with 2.4.5pre2
Message-ID: <Pine.LNX.4.10.10105162125480.2866-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

	eth0 locked after 20-30 seconds stress test, different setups:

- SMP with 2 CPUs and 2 3c905B Cyclone 100baseTx cards
- SMP with 1 CPU (maxcpus=1) and the same 2 cards

	No eth lock problems with 2.2.19 UP

	The scenario, a throughput test setup:

flood -> eth0 -> forwarding -> eth1 -> victim

	The eth0 stops to respond, no oopses or problems with eth1.
The system is running. Note that eth0 is used only to receive the
flood. There is no much out traffic through eth0.

	If the forwarding is disabled there are no problems, i.e. the
traffic is received and dropped.

	The funny messages:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e681.
  diagnostics: net 0cd8 media 8880 dma 0000003a.
eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
  Flags; bus-master 1, dirty 123(11) current 123(11)
  Transmit list 00000000 vs. dfe7f4c0.

...

	On boot:

testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
 WARNING: unexpected IO-APIC, please mail
	  to linux-smp@vger.kernel.org
.... register #02: 00000000
.......     : arbitration: 00


There are no IO-APIC errors!


/proc/pci:

  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266] (rev 1).

  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (rev 0).

  Bus  0, device   9, function  0:
    Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 48).
      IRQ 10.

  Bus  0, device  10, function  0:
    Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (#2) (rev 4
8).
      IRQ 11.


	More outputs on demand. Please, cc!

Regards

--
Julian Anastasov <ja@ssi.bg>

