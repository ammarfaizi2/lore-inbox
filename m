Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293722AbSCZKWk>; Tue, 26 Mar 2002 05:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310241AbSCZKWa>; Tue, 26 Mar 2002 05:22:30 -0500
Received: from ns.suse.de ([213.95.15.193]:55565 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293722AbSCZKWT>;
	Tue, 26 Mar 2002 05:22:19 -0500
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Problems with Tigon v0.97
From: Andreas Jaeger <aj@suse.de>
Date: Tue, 26 Mar 2002 11:22:14 +0100
Message-ID: <ho1ye7tyqx.fsf@gee.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've plugged for testing a 3C996-T in a 32-bit slot on my Athlon system
lspci -v gives for the unused card:

00:09.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5700 Gigabit Ethernet (rev 12)
	Subsystem: 3Com Corporation 3C996-T 1000BaseTX
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
	Memory at effe0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] #07 [0002]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

If I access the card with the broadcom driver bcm5700 from 2.4.18
everything works fine (just brief testing).  But using the Tigeon
v0.97 I cannot send any data to the network.

A modprobe of bcm5700 gives:
Broadcom Gigabit Ethernet Driver bcm5700 with Broadcom NIC Extension (NICE) ver. 2.2.8 (03/07/02)
AMD756: dev 14e4:1644, router pirq : 2 get irq : 11
PCI: Found IRQ 11 for device 00:09.0
Cannot get MAC addr from NVRAM. Using default.
VPD read failed
eth1: 3Com 3C996 10/100/1000 Server NIC found at mem effe0000, IRQ 11, node addr 001018686176
eth1: Broadcom BCM5401 Copper transceiver found
eth1: Scatter-gather ON, 64-bit DMA OFF, Tx Checksum ON, Rx Checksum ON

A modprobe of tg3 gives:
tg3.c:v0.97 (Mar 13, 2002)
AMD756: dev 14e4:1644, router pirq : 2 get irq : 11
PCI: Found IRQ 11 for device 00:09.0
eth1: Tigon3 [partno(BCM95700A6) rev 7102 PHY(5401)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:04:76:3b:39:c7

And after ifconfig eth1 I get:
eth1: Link is up at 100 Mbps, full duplex.
eth1: Flow control is on for TX and on for RX.

But no packets go over the card - and sometimes the whole system
freezes.  Is there some kind of problem with plugging the card into a
32-bit slot?  The same card worked with no problems in a 64-bit slot..

Any further debugging that I can do?

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
