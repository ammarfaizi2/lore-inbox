Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135243AbRDLSAl>; Thu, 12 Apr 2001 14:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135244AbRDLSAV>; Thu, 12 Apr 2001 14:00:21 -0400
Received: from dystopia.lab43.org ([209.217.122.210]:12734 "EHLO
	dystopia.lab43.org") by vger.kernel.org with ESMTP
	id <S135242AbRDLSAH>; Thu, 12 Apr 2001 14:00:07 -0400
Date: Thu, 12 Apr 2001 13:58:08 -0400 (EDT)
From: Rod Stewart <stewart@dystopia.lab43.org>
To: <linux-kernel@vger.kernel.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: 8139too: defunct threads
Message-ID: <Pine.LNX.4.33.0104121336040.31024-100000@dystopia.lab43.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Using the 8139too driver, 0.9.15c, we have noticed that we get a defunct
thread for each device we have; if the driver is built into the kernel.
If the driver is built as a module, no defunct threads appear.

This has happened with any 2.4 kernel we've used, up to and including
2.4.3.

Below is the output from a custom board (but the problem also shows up
with a standard PCI card with RTL-8139B) with three RealTek RTL8139
chipsets on it.

[root@stewart-nw34 /root]# ps uaxwwww|grep eth
root        14  0.0  0.0     0    0 ?  Z    13:39   0:00 [eth0  <defunct>]
root        15  0.0  0.0     0    0 ?  Z    13:39   0:00 [eth1  <defunct>]
root        16  0.0  0.0     0    0 ?  Z    13:39   0:00 [eth2  <defunct>]
root       240  0.0  0.0     0    0 ?        SW   13:39   0:00 [eth0]
root       572  0.0  0.0     0    0 pts/1    SW   13:49   0:00 [eth1]
root       538  0.0  0.4  1216  460 pts/0    S    13:41   0:00 grep eth

8139too Fast Ethernet driver 0.9.15c loaded
PCI: Enabling device 00:05.0 (0000 -> 0003)
PCI: Assigned IRQ 6 for device 00:05.0
PCI: Setting latency timer of device 00:05.0 to 64
eth0: RealTek RTL8139 Fast Ethernet at 0xc7800000, 00:10:57:01:00:19,
	IRQ 6
eth0:  Identified 8139 chip type 'RTL-8139C'
PCI: Enabling device 00:09.0 (0000 -> 0003)
PCI: Assigned IRQ 6 for device 00:09.0
PCI: Setting latency timer of device 00:09.0 to 64
eth1: RealTek RTL8139 Fast Ethernet at 0xc7802100, 00:10:57:02:00:19,
	IRQ 6
eth1:  Identified 8139 chip type 'RTL-8139C'
PCI: Enabling device 00:0a.0 (0000 -> 0003)
PCI: Assigned IRQ 6 for device 00:0a.0
PCI: Setting latency timer of device 00:0a.0 to 64
eth2: RealTek RTL8139 Fast Ethernet at 0xc7804200, 00:10:57:03:00:19,
	IRQ 6
eth2:  Identified 8139 chip type 'RTL-8139C'


I'm not certain if this is supposed to be expected behaviour or not, if it
is we'll tell QA to ignore it.

Thanks,
-Rms

