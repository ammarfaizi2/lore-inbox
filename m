Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTKWAYN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 19:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbTKWAYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 19:24:13 -0500
Received: from www.mail15.com ([62.118.249.44]:777 "EHLO www.mail15.com")
	by vger.kernel.org with ESMTP id S263053AbTKWAYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 19:24:08 -0500
Message-ID: <3FBFF7D8.8070404@myrealbox.com>
Date: Sat, 22 Nov 2003 15:57:12 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: tg3 / Broadcom question for Jeff
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

If you'll recall, I'm the one with the ASUS A7V8X with the built-in Broadcom ethernet
chip which won't work until I do an ifconfig down/up cycle.

I just learned about the -xxx flag to lspci and I hope the info below may shed some
light on this long-standing bug.

This is lspci -vvv -xxx right after booting the machine (ethernet not yet working):

00:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702 Gigabit Ethernet (rev 02)
         Subsystem: Asustek Computer, Inc.: Unknown device 80a9
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (16000ns min), cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at f1800000 (64-bit, non-prefetchable) [size=64K]
         Expansion ROM at f7ff0000 [disabled] [size=64K]
         Capabilities: [40] PCI-X non-bridge device.
                 Command: DPERE- ERO- RBC=0 OST=0
                 Status: Bus=255 Dev=31 Func=1 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=2, DMOST=0, DMCRS=1, RSCEM
-       Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [50] Vital Product Data
         Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                 Address: be7dffbff9fb5cfc  Data: d5fd
00: e4 14 a6 16 06 00 b0 02 02 00 00 02 08 40 00 00
10: 04 00 80 f1 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 a9 80
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 40 00
40: 07 48 00 00 f9 ff 43 04 01 50 02 c0 00 20 00 64
50: 03 58 f4 00 fd ed fb 79 05 00 86 00 fc 5c fb f9
60: bf ff 7d be fd d5 00 00 98 00 02 10 00 00 bf 76
70: 96 10 00 00 3f 00 00 80 bc 56 03 00 00 00 00 00
80: 00 00 00 00 99 b8 d5 89 34 00 11 24 82 00 08 00
90: 09 02 00 01 01 00 00 00 00 00 00 00 c8 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 01 00 00 00 00 00 00 00 01 00 00 00
c0: 00 00 00 00 01 00 00 00 00 00 00 00 01 00 00 00
d0: 00 00 00 00 01 00 00 00 00 00 00 00 01 00 00 00
e0: 00 00 00 00 01 00 00 00 00 00 00 00 01 00 00 00
f0: 00 00 00 00 01 00 00 00 00 00 00 00 01 00 00 00
======================================================================

This is the diff between the above and again right after an ifconfig down/up:

#diff lspci.1 lspci.2
143c143
< 90: 09 02 00 01 01 00 00 00 00 00 00 00 c8 00 00 00
---
 > 90: 09 02 00 01 00 00 00 00 00 00 00 00 c8 00 00 00
145,149c145,149
< b0: 00 00 00 00 01 00 00 00 00 00 00 00 01 00 00 00
< c0: 00 00 00 00 01 00 00 00 00 00 00 00 01 00 00 00
< d0: 00 00 00 00 01 00 00 00 00 00 00 00 01 00 00 00
< e0: 00 00 00 00 01 00 00 00 00 00 00 00 01 00 00 00
< f0: 00 00 00 00 01 00 00 00 00 00 00 00 01 00 00 00
---
 > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

You can see that only a few bits have flipped, but it makes everything
work until the next reboot.  I got the same result three different
times, so this is not random behavior.

Is this of any help to you?
