Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289208AbSANMEl>; Mon, 14 Jan 2002 07:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289217AbSANMEb>; Mon, 14 Jan 2002 07:04:31 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:44241 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289208AbSANMEU>; Mon, 14 Jan 2002 07:04:20 -0500
Date: Mon, 14 Jan 2002 14:03:09 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Andrew Morton <akpm@zip.com.au>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 3c905B doing 10/HD w/ crossover cable
Message-ID: <Pine.LNX.4.33.0201141401000.28735-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Jeff
	My 3c905B[1] (2.4.18-pre3) always autonegotiates 10baseTx Half
Duplex whenever i use a crossover cable (works fine on a 100 switch and a
10/100 Hub). The link partner is a Realtek RTL-8139A [2] (2.5.2-pre11) and
reports the following if i boot it after the 3com box;

eth0: Setting half-duplex based on auto-negotiated partner ability 0000.

Forcing 100BaseTx/FD on the 3com ends up in nothing being able to go out
the wire (destination host unreachable).

mii-diag on the 3com box gives the following
Basic registers of MII PHY #0:  c000 c000 c000 c000 c000 c000 c000 c000.
 The autonegotiated capability is 0000.
No common media type was autonegotiated!
This is extremely unusual and typically indicates a configuration error.
Perhaps the advertised capability set was intentionally limited.
 Basic mode control register 0xc000: Auto-negotiation disabled, with
 Speed fixed at 10 mbps, half-duplex.
  Transceiver in loopback mode!
  Transceiver currently being reset!
 Basic mode status register 0xc000 ... c000.
   Link status: not established.
 Your link partner advertised c000:.
   End of basic transceiver information.

mii-diag on the 8139A box
Basic registers of MII PHY #32:  0000 0000 0000 0000 0000 0000 0000 0000.
 Basic mode control register 0x0000: Auto-negotiation disabled, with
 Speed fixed at 10 mbps, half-duplex.
 Basic mode status register 0x0000 ... 0000.
   Link status: not established.
 Link partner information is not exchanged when in fixed speed mode.
   End of basic transceiver information.

All drivers are modular with no module parameters. The 3com negotiates
100BaseTx/FD in FreeBSD 4.4 and NetBSD 1.5 using the same link partner.

[1] Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
[2] Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev 10)

Thanks,
	Zwane Mwaikambo


