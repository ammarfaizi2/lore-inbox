Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264557AbUANUfF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 15:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264558AbUANUfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 15:35:05 -0500
Received: from mail.wlanmail.com ([194.100.155.139]:3085 "HELO
	mail.wlanmail.com") by vger.kernel.org with SMTP id S264557AbUANUe4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 15:34:56 -0500
From: Joonas Koivunen <rzei@mbnet.fi>
Reply-To: rzei@mbnet.fi
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Duplex setting with pcnet32 driver, help appriciated
Date: Wed, 14 Jan 2004 22:34:27 +0200
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401142234.27757.rzei@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everone,

A friend of mine just told me that my Internet connection should be 1024/1024 
(full duplex), not 1024(hf) shared by up- and download -- as it is at the 
moment. The connection is HomePNA for which I've got this cheap pci card, 
can't know who has made it. 
So this is what I've tried so far:

For eth0 (homepna, pcnet32 driver) mii-tool tells me:
SIOCGMIIPHY on 'eth0' failed: Operation not supported
Which must equal as bad luck.

ethtool on the otherhand is able to dig something out of the card:
# ethtool eth0
Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full 100baseT/Half 
100baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  Not reported
        Advertised auto-negotiation: No
        Speed: 10Mb/s
        Duplex: Half
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: off
        Current message level: 0x00000001 (1)
        Link detected: no

Bingo, it seems to support 10baseT/Full but is only at Half at the moment.
# ethtool -s eth0 duplex full; ethtool eth0 | grep Duplex
        Duplex: Half
Damn.

I have tried:
# ifconfig eth0 down; ethtool -s eth0 duplex full; ifconfig eth0 up; ethtool 
eth0 | grep Duplex
        Duplex: Half
Still no change.

lspci's thoughts about this cheap HomePNA card:
# lspci -v -s 00:0b.0
00:0b.0 Ethernet controller: Advanced Micro Devices [AMD] 79c978 [HomePNA] 
(rev 52)
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 2000
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at a000 [size=32]
        Memory at eb000000 (32-bit, non-prefetchable) [size=32]
        Capabilities: [40] Power Management version 2

I haven't been able to check with Windows' drivers but as those are generic 
pcnet32 too, I doubt that the outcome would be any different. Just that 
ethtool doesn't give out any warnings, as it does with for example autoneg:
# ethtool -s eth0 autoneg on
Cannot set new settings: Invalid argument
  not setting autoneg

Here it seems that it's not supported by the cheap card of mine? But nothing 
is said about duplex setting even being "heard" by the card itself. How to 
proceed? The kernel I'm using is linux-2.6.0-rc1 with the rmmap security 
patch by Linus.

-rzei
