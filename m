Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbTC1Okv>; Fri, 28 Mar 2003 09:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262534AbTC1Okv>; Fri, 28 Mar 2003 09:40:51 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:50648 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S261305AbTC1Okt>;
	Fri, 28 Mar 2003 09:40:49 -0500
Date: Fri, 28 Mar 2003 15:51:59 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 3c59x gives HWaddr FF:FF:...
Message-ID: <20030328145159.GA4265@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have just switched the network card for my internal network from a 8139
to a 3c905C-TX/TX-M. The 3c59x driver gives the buggy FF:FF:FF:FF:FF:FF
hardware address for the adapter. I had heard about the problem and looked
throug LKML archives, but they just point to a non existen web page.
I use 2.4.21-pre6+aa.

What happens ? Any solution available ?

Info:
werewolf:~# lspci -vx -s 00:12.0
00:12.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at ec00 [size=128]
        Memory at febfef80 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at feba0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
00: b7 10 00 92 17 01 10 a2 74 00 00 02 08 40 00 00
10: 01 ec 00 00 80 ef bf fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 00 10
30: 00 00 ba fe dc 00 00 00 00 00 00 00 05 01 0a 0a

werewolf:~# modprobe 3c59x debug=4
/var/log/syslog:
Mar 28 15:45:05 werewolf kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Mar 28 15:45:05 werewolf kernel: See Documentation/networking/vortex.txt
Mar 28 15:45:05 werewolf kernel: 00:12.0: 3Com PCI 3c905C Tornado at 0xec00. Vers LK1.1.16
Mar 28 15:45:05 werewolf kernel:  ff:ff:ff:ff:ff:ff, IRQ 5
Mar 28 15:45:05 werewolf kernel:   product code ffff rev ffff.15 date 15-31-127
Mar 28 15:45:05 werewolf kernel: Full duplex capable
Mar 28 15:45:05 werewolf kernel:   Internal config register is ffffffff, transceivers 0xffff.
Mar 28 15:45:05 werewolf kernel:   1024K word-wide RAM 3:5 Rx:Tx split, autoselect/<invalid transceiver> interface.
Mar 28 15:45:05 werewolf kernel:   Enabling bus-master transmits and early receives.
Mar 28 15:45:05 werewolf kernel: 00:12.0: scatter/gather enabled. h/w checksums enabled

Relevant dmesg:

3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:12.0: 3Com PCI 3c905C Tornado at 0xec00. Vers LK1.1.16
 ff:ff:ff:ff:ff:ff, IRQ 5
  product code ffff rev ffff.15 date 15-31-127
Full duplex capable
  Internal config register is ffffffff, transceivers 0xffff.
  1024K word-wide RAM 3:5 Rx:Tx split, autoselect/<invalid transceiver> interfac
e.
  Enabling bus-master transmits and early receives.
00:12.0: scatter/gather enabled. h/w checksums enabled
eth1: command 0x5800 did not complete! Status=0xffff
eth1: command 0x2804 did not complete! Status=0xffff
eth1: command 0x5800 did not complete! Status=0xffff
eth1: command 0x2804 did not complete! Status=0xffff
eth1: command 0x3002 did not complete! Status=0xffff
eth1: command 0x3002 did not complete! Status=0xffff
eth1: command 0x3002 did not complete! Status=0xffff
eth1: command 0x3002 did not complete! Status=0xffff
eth1: command 0x5800 did not complete! Status=0xffff
eth1: command 0x2804 did not complete! Status=0xffff

Any suggestion ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Bamboo) for i586
Linux 2.4.21-pre6-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
