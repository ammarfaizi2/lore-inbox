Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265476AbUF3AKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265476AbUF3AKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 20:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUF3AKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 20:10:24 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:34058 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S265476AbUF3AKT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 20:10:19 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [PATCH 2.6.7 and 2.4.27-pre6] new device support for forcedeth.c
Date: Tue, 29 Jun 2004 17:10:18 -0700
Message-ID: <4A182287221ED6448097C03F2E60B60701339160@mail-sc-3.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE: [PATCH 2.6.7 and 2.4.27-pre6] new device support for forcedeth.c
Thread-Index: AcReNqBSGgQAyuOvQ6OU7aonPkJd2A==
From: "Ayaz Abdulla" <AAbdulla@nvidia.com>
To: <manfred@colorfullife.com>
Cc: <linux-kernel@vger.kernel.org>, <c-d.hailfinger.kernel.2004@gmx.net>,
       "Brian Lazara" <blazara@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is the fix for full duplex handling.

In the function nv_update_linkspeed(), there is an "if" statement that
was missing the "else" section:

if (np->duplex == 0)
        phyreg |= PHY_HALF;
else
        phyreg &= ~PHY_HALF;

Ayaz

> -----Original Message-----
> From: Manfred Spraul [mailto:manfred@xxxxxxxxxxxxxxxx] 
> Sent: Sunday, June 27, 2004 1:33 PM
> To: Brian Lazara
> Cc: linux-kernel@xxxxxxxxxxxxxxx; Carl-Daniel Hailfinger
> Subject: [PATCH 2.6.7 and 2.4.27-pre6] new device support for 
> forcedeth.c
> 
> 
> Hi Brian,
> 
> could you check the full duplex handling? I'm testing my new 
> nforce-250 Gb (epox 8KDA3J) with a normal 100 MBit 
> autonegotiation link partner and I'm getting bad performance 
> (30 kB/sec) when sending. Half duplex works. The nic reports 
> late collisions:
> 
> nv_tx_done: looking at packet 233, Flags 0x28200.
> -> packet not yet completed
> nv_tx_done: looking at packet 233, Flags 0x1a810.
> bits 16, 15, 13, 11, 4
> error, lastpacket, late collision, deferred, retryerror.
> nv_tx_done: looking at packet 234, Flags 0x8000.
> -> successful
> nv_tx_done: looking at packet 235, Flags 0x28200.
> -> not yet completed.
> 
> Autonegotiation seems to work correctly: np->linkspeed is set 
> to 65636, 
> np->duplex to 1.
> lspci reports:
> 
> 00:05.0 Bridge: nVidia Corporation: Unknown device 00df (rev a2)
> Subsystem: Unknown device 1695:100c
> Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 11
> Memory at ec000000 (32-bit, non-prefetchable)
> I/O ports at b400 [size=8]
> Capabilities: [44] Power Management version 2
> 00: de 10 df 00 07 00 b0 00 a2 00 80 06 00 00 00 00
> 10: 00 00 00 ec 01 b4 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 0c 10
> 30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 01 14
> 
> Could you give me a hint what's wrong? If you need further register 
> values, just ask.
> 
> Thanks,
> --
> Manfred
> 




