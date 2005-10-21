Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbVJURl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbVJURl0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 13:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVJURl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 13:41:26 -0400
Received: from mail.velocity.net ([66.211.211.55]:58788 "EHLO
	mail.velocity.net") by vger.kernel.org with ESMTP id S965044AbVJURlZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 13:41:25 -0400
X-AV-Checked: Fri Oct 21 13:41:24 2005 clean
Subject: Treason uncloaked! Peer shrinks window caused by rsync or drivers?
From: Dale Blount <linux-kernel@dale.us>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 21 Oct 2005 13:41:24 -0400
Message-Id: <1129916484.23920.30.camel@dale.velocity.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

I'm posting here first since I've seen these messages elsewhere not
using rsync, but my specific problem today is with rsync on Linux 2.6 ->
Linux 2.6.

I've gotten these messages for a while now, but this is the first time
where they've actually affected the data transfer that I've noticed, so
I decided to post about it.  I have two servers, connected via gigE link
through a switch.  FWIW, I've also had it happen via gigE crossover
cable as well on different hosts (still Linux 2.6).

Attempting to copy large amounts of data in small files ends up (now?)
with rsync hanging or continuing very slowly.  Before I'd get these
messages but rsync would continue.  I haven't been able to narrow what
changed when the rsync started to become slow.

# dmesg | grep Treason | sort | uniq -c
      8 TCP: Treason uncloaked! Peer *lan_host*:34299/873 shrinks window
1558728006:1558730902. Repaired.
     10 TCP: Treason uncloaked! Peer *lan_host*:37490/873 shrinks window
2901903719:2901907291. Repaired.
     19 TCP: Treason uncloaked! Peer *lan_host*:41397/873 shrinks window
870232981:870237929. Repaired.
      8 TCP: Treason uncloaked! Peer *lan_host*:41963/873 shrinks window
256141191:256144763. Repaired.
      9 TCP: Treason uncloaked! Peer *lan_host*:45482/873 shrinks window
1037480438:1037482634. Repaired.
      8 TCP: Treason uncloaked! Peer *lan_host*:56224/873 shrinks window
2645781433:2645784329. Repaired.
     12 TCP: Treason uncloaked! Peer *lan_host*:60495/873 shrinks window
3862006382:3862009954. Repaired.


All hosts (4 totally separate boxes) are 2.6.13.3 or 2.6.13.4.  Network
card lspci -v output is listed at the end of the message.  Is it
possible that there's a bug in one of the drivers (maybe e1000 for
82541GI) or is this just a bug in rsync that needs fixed?  

Thanks for any input,
Dale

Network card info:

Receiver on Switch: 
06:07.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit
Ethernet Controller (rev 05)
        Subsystem: Dell: Unknown device 016d
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 20
        Memory at fe4e0000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at ccc0 [size=64]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.

Sender on Switch:
02:05.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T
[Marvell] (rev 12)
        Subsystem: ASUSTeK Computer Inc. P4P800/K8V Deluxe motherboard
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 18
        Memory at feaf8000 (32-bit, non-prefetchable) [size=16K]
        I/O ports at d800 [size=256]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data

-----------------------------

Receiver on Xover:
03:0a.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit
Ethernet Controller
        Subsystem: Intel Corporation PRO/1000 MT Network Connection
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 19
        Memory at f4000000 (32-bit, non-prefetchable) [size=128K]
        Memory at f4020000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at b400 [size=64]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.

Sender on Xover:
09:08.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet
Controller (rev 05)
        Subsystem: Dell: Unknown device 016d
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 225
        Memory at df5e0000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at ccc0 [size=64]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.

