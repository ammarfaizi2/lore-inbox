Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264401AbUF0Ueg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbUF0Ueg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 16:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbUF0Ueg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 16:34:36 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:23218 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264401AbUF0Ue1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 16:34:27 -0400
Message-ID: <40DF2F0D.6030804@colorfullife.com>
Date: Sun, 27 Jun 2004 22:33:17 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Lazara <blazara@nvidia.com>
CC: linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Subject: [PATCH 2.6.7 and 2.4.27-pre6] new device support for forcedeth.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

could you check the full duplex handling? I'm testing my new nforce-250
Gb (epox 8KDA3J) with a normal 100 MBit autonegotiation link partner and
I'm getting bad performance (30 kB/sec) when sending. Half duplex works.
The nic reports late collisions:

nv_tx_done: looking at packet 233, Flags 0x28200.
	-> packet not yet completed
nv_tx_done: looking at packet 233, Flags 0x1a810.
	bits 16, 15, 13, 11, 4
	error, lastpacket, late collision, deferred, retryerror.
nv_tx_done: looking at packet 234, Flags 0x8000.
	-> successful
nv_tx_done: looking at packet 235, Flags 0x28200.
	-> not yet completed.

Autonegotiation seems to work correctly: np->linkspeed is set to 65636, 
np->duplex to 1.
lspci reports:

00:05.0 Bridge: nVidia Corporation: Unknown device 00df (rev a2)
        Subsystem: Unknown device 1695:100c
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 11
        Memory at ec000000 (32-bit, non-prefetchable)
        I/O ports at b400 [size=8]
        Capabilities: [44] Power Management version 2
00: de 10 df 00 07 00 b0 00 a2 00 80 06 00 00 00 00
10: 00 00 00 ec 01 b4 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 0c 10
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 01 14

Could you give me a hint what's wrong? If you need further register 
values, just ask.

Thanks,
--
	Manfred
