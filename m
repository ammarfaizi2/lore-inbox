Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbTE0VWf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbTE0VWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:22:12 -0400
Received: from jet.sohoskyway.net ([216.251.128.11]:34491 "EHLO
	jet.sohoskyway.net") by vger.kernel.org with ESMTP id S264198AbTE0VVa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:21:30 -0400
Message-Id: <200305272134.h4RLYfG12942@jet.sohoskyway.net>
From: "Greg Varga" <gvarga@bvcompuworks.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 27 May 2003 14:29:03 -0700
X-Mailer: PMMail 2000 Professional (2.20.2661) For Windows 2000 (5.0.2195;3)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Problems with the Starfire network driver or PCI subsystem...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Everyone...

I've been trying to track down a problem with one of our linux router
for a while now.  I've searched the internet and although I have found
simular problems, the suggested fixes have not worked.

The basic problem is that after a random amount of time, a random
ethernet port controlled by the starfire driver stops working and the
only way to get it going is to either reboot (of course) or to do an
ifdown/ifup on that port. When this happens, all the other ports on
using that driver work properly.  Also the two onboard ethernet ports
never have a problem. 

We have troubleshooted on the below system, and on a stable system
using the same Kernel/Software, but diffrent hardware. The only major
diffrences in the hardware are the PCI 2.2 (64bit) bus, the Adaptec
card itself and one is a true SMP (one cpu tho) and the other is just a
Hyper Threading system.

(This has happened more then what I've shown in the below logs, but I
have only included when we did any changes to the system.  I'll first
explain the initial problem and go through what we saw at each stages
of our troubleshooting...)

Any insites would be greatly appreciated.


Problem System:
--------------------------
(This is a PCI 2.2 (64-bit) system, with the adaptec card being the
only PCI card installed period.)
SuperMicro SS6012P-6 package
  (Comes w/ SuperMicro's P4DPR-6GM+ Motherboard)
  (Dual Xeon, Intel E7500 chipset, dual Ultra160 SCSI)
CPU0:Intel(R) XEON(TM) CPU 2.00GHz stepping 04
eth0: (eepro100) OEM i82557/i82558 10/100 Ethernet, 00:30:48:23:BB:C8,
IRQ 17.
eth1: (e1000) Intel(R) PRO/1000 Network Connection
eth2-5: (starfire) Adaptec ANA-64044LV 4-Port, 64-bit/66 MHz PCI 2.2

Stable Server:
--------------------------
ASUS P3B-F Motherboard
CPU0: Intel Pentium III (Katmai) stepping 03
  (Hyper-Threading so it enabled APIC when booted)
eth0: (eepro100) Intel Corp. 82557/8/9 [Ethernet Pro 100]
  (No-name Intel Ethernet 10/100 PCI card)
eth1-4: (eepro100) Intel Corp. 82559ER
  (Matrox NS-FNIC/4, 32-bit PCI card)




Here is all the logs and troubleshooting we have done:

Initial setup:
------------------
===:::Problem:::===
Our BGP session went down for no aparrent reason... and then we got
Transmit Timed out errors on that port. Doing a tcpdump from the
problem machine on the problem port showed that no traffic was being
received but arp requests were being sent. A tcpdump on a remote
machine showed that no traffic was being sent from that problem port.
===:::Kernel:::===
Linux version 2.4.20 (root@fileserv) (gcc version 2.96 20000731 (Red
Hat Linux 7.3 2.96-113)) #6 SMP Fri May 16 15:29:18 
PDT 2003
===:::StarFire Driver:::===
starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>

(unofficial 2.2/2.4 kernel port, version 1.03+LK1.3.6, March 7, 2002) 
PCI: 03:04.0 PCI cache line size set incorrectly (32 bytes) by BIOS/FW,
expecting 16 
eth2: Adaptec Starfire 6915 at 0xe08ab000, 00:00:d1:ef:bc:d5, IRQ 48. 
PCI: 03:05.0 PCI cache line size set incorrectly (32 bytes) by BIOS/FW,
expecting 16 
eth3: scatter-gather and hardware TCP cksumming disabled. 
eth4: MII PHY found at address 1, status 0x7809 advertising 01e1. 
eth4: scatter-gather and hardware TCP cksumming disabled. 
PCI: 03:07.0 PCI cache line size set incorrectly (32 bytes) by BIOS/FW,
expecting 16 
eth5: scatter-gather and hardware TCP cksumming disabled.
===-:::Logs:::===
May 19 09:54:31 System Reboot
May 19 11:04:39 tanelorn gated[943]: bgp_traffic_timeout: holdtime
expired for 204.239.129.190 (External AS 852) 
May 19 11:04:39 tanelorn gated[943]: NOTIFICATION sent to
204.239.129.190 (External AS 852): code 4 (Hold Timer 
Expired Error) data 
May 19 11:05:23 tanelorn kernel: NETDEV WATCHDOG: eth4: transmit timed
out 
May 19 11:05:23 tanelorn kernel: eth4: Transmit timed out, status
0000b101, resetting... 
May 19 11:05:23 tanelorn kernel: 79011 1b6d4011 1b681011 17550811
1b658811 1b7f0011 1b628011 1b903011 
1b68c811 1b5cf811 1746e011 1b65e011 1b8f3011 1b551011 1b6bb011 1b6b0811
1b60a
811 1b5c2811 173c9811 173c8011 1b69a811 1b672011 1b5cb011 1b54b011
1b68e811 1b8f2811 1b62b011 1b664011 
1c2dd011 1f4f5011 1c498811 1add9011 183cc811 17558811 1b798011 1b666011
1b79
9011 1b553011 1b553811 1b585011 1b5ce811 1b69e811 1b636011 1b56d811
1b773011 1757b011 1757d011 19c87811 
1b641811 1b652011 1b54e811 1ad94811 1b665011 1b8f0011 1b7da011 1b6b5011
174
6e811 1b5bc811 1b564011 1b5a6011 1b65f811 1fdf3811 198ec011 1ad94011
1b5f2811 1b906011 1addb811 1b670011 
1b5eb811 1b6ad811 1b640011 1b55a011 1b618811 1b635811 1b7b0811 1b7fc011
1b
676011 1fdc6011 1b67e811 1b633811 1b5ef811 1b625011 1b5ae011 19e39011
1b611811 1b13a811 1b5b7011 1f76b011 
1b62f811 1b923811 1b5c8811 1b61a011 1b55c011 1b6cb811 1b684811 17559811
1
b7e1011 1b579011 1b629811 1ad6c011 1ad6c811 1b674811 1b674011 1b6b4011
1b6b4811 1746f811 1746f011 
1b5f6011 1b5a1811 173c8811 1b557011 
May 19 11:05:23 tanelorn kernel: f5811 1b64e811 1b6dc811 1b7e4811
1b568011 1759d811 1b66c811 1b783811 
1b554011 1b7a5811 1b6b1011 1b5fa811 1b75d811 1b900811 1b676811 1b690011
173cb
811 1b58b811 17562811 17562011 1b678011 1ad57011 1b5a5011 1b584011
1b570811 1b5f3811 1b601811 1b54b811 
1bead011 1b62a811 1b612011 183cc011 1bab4011 1ad99811 1b584811 1b7df811
1b6b
6013 
<<==Port stopped working. Restarted the network service to get port to
work agian.==>>


Test #1:
------------------
===:::Problem:::===
A bit better.  The new driver (1.4.1) doesn't dump as much debug info
out, and it seems to handle the PCI bus congrestion 
better.  Now the network port stops working and then the bgp session
goes down - this is correct because the bgp has a 
session watchdog timer. Something to note is that initial setup had the
bgp session crap out before the network driver 
produced any errors and now its the other way around. (I would expect
the second to happen, not the first.)  Also the amount 
of time between the last driver error and the bgp session going down
was quite some time.
===:::Kernel:::===
Linux version 2.4.20 (root@fileserv) (gcc version 2.96 20000731 (Red
Hat Linux 7.3 2.96-113)) #6 SMP Fri May 16 15:29:18 
PDT 2003
===:::StarFire Driver:::===
starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>

(unofficial 2.2/2.4 kernel port, version 1.03+LK1.4.1, February 10,
2002) 
PCI: 03:04.0 PCI cache line size set incorrectly (32 bytes) by BIOS/FW,
expecting 16 
eth2: Adaptec Starfire 6915 at 0xe08ab000, 00:00:d1:ef:bc:d5, IRQ 48. 
eth2: MII PHY found at address 1, status 0x7809 advertising 0x01e1. 
eth2: scatter-gather and hardware TCP cksumming disabled. 
PCI: 03:05.0 PCI cache line size set incorrectly (32 bytes) by BIOS/FW,
expecting 16 
eth3: Adaptec Starfire 6915 at 0xe092c000, 00:00:d1:ef:bc:d6, IRQ 48. 
eth3: MII PHY found at address 1, status 0x7809 advertising 0x01e1. 
eth3: scatter-gather and hardware TCP cksumming disabled. 
PCI: 03:06.0 PCI cache line size set incorrectly (32 bytes) by BIOS/FW,
expecting 16 
eth4: Adaptec Starfire 6915 at 0xe09ad000, 00:00:d1:ef:bc:d7, IRQ 48. 
eth4: MII PHY found at address 1, status 0x7809 advertising 0x01e1. 
eth4: scatter-gather and hardware TCP cksumming disabled. 
PCI: 03:07.0 PCI cache line size set incorrectly (32 bytes) by BIOS/FW,
expecting 16 
eth5: Adaptec Starfire 6915 at 0xe0a2e000, 00:00:d1:ef:bc:d8, IRQ 48. 
eth5: MII PHY found at address 1, status 0x7809 advertising 0x01e1. 
eth5: scatter-gather and hardware TCP cksumming disabled. 
===-:::Logs:::===
May 20 05:50:43 -- System Reboot
May 20 09:51:19 tanelorn kernel: eth2: PCI bus congestion, increasing
Tx FIFO threshold to 80 bytes 
May 20 10:17:28 tanelorn kernel: eth3: PCI bus congestion, increasing
Tx FIFO threshold to 80 bytes 
May 20 10:22:01 tanelorn kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
ide0(3,1), internal journal 
May 20 10:23:21 tanelorn kernel: NETDEV WATCHDOG: eth2: transmit timed
out 
May 20 10:23:21 tanelorn kernel: eth2: Transmit timed out, status
0x00000000, resetting... 
May 20 14:05:24 tanelorn kernel: eth2: PCI bus congestion, increasing
Tx FIFO threshold to 80 bytes 
May 20 14:13:59 tanelorn kernel: eth2: PCI bus congestion, increasing
Tx FIFO threshold to 96 bytes 
May 20 14:16:28 tanelorn kernel: eth4: PCI bus congestion, increasing
Tx FIFO threshold to 80 bytes 
May 20 15:11:24 tanelorn kernel: eth2: PCI bus congestion, increasing
Tx FIFO threshold to 112 bytes 
May 20 15:52:10 tanelorn kernel: eth2: PCI bus congestion, increasing
Tx FIFO threshold to 128 bytes 
May 20 16:22:33 tanelorn kernel: eth4: PCI bus congestion, increasing
Tx FIFO threshold to 96 bytes 
May 20 16:40:50 tanelorn kernel: eth2: PCI bus congestion, increasing
Tx FIFO threshold to 144 bytes 
May 20 16:50:40 tanelorn kernel: eth3: PCI bus congestion, increasing
Tx FIFO threshold to 96 bytes 
May 20 17:18:29 tanelorn kernel: eth4: PCI bus congestion, increasing
Tx FIFO threshold to 112 bytes 
May 21 03:59:46 tanelorn gated[955]: bgp_traffic_timeout: holdtime
expired for 216.18.31.99 (External AS 6539) 
May 21 03:59:46 tanelorn gated[955]: NOTIFICATION sent to 216.18.31.99
(External AS 6539): code 4 (Hold Timer Expired 
Error) data 
<<==Port stopped working. Restarted the network service to get port to
work agian.==>>


Test #2:
------------------
===:::Problem:::===
Found lots of refer's about the APIC code causing problems, so we
disabled SMP and all APIC code in the kernel.  This did 
clear up some of the messages in the log files (no more transmit
timeouts) but the problem is still there. It is using the same  
kernel config as below...
(Intrestingly as I write this, I see the first transmit timed out
message and is included included below...)
===:::Kernel:::===
version 2.4.20 (root@coffee.sohoskyway.net) (gcc version 3.2 20020903
(Red Hat Linux 8.0 3.2-7)) #7 Thu May 22 
21:58:54 PDT 2003
===:::StarFire Driver:::===
starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>
(unofficial 2.2/2.4 kernel port, version 1.03+LK1.4.1, February 10,
2002)
PCI: 03:04.0 PCI cache line size set incorrectly (32 bytes) by BIOS/FW,
expecting 16
eth2: Adaptec Starfire 6915 at 0xe08a5000, 00:00:d1:ef:bc:d5, IRQ 5.
eth2: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
eth2: scatter-gather and hardware TCP cksumming disabled.
PCI: 03:05.0 PCI cache line size set incorrectly (32 bytes) by BIOS/FW,
expecting 16
eth3: Adaptec Starfire 6915 at 0xe0926000, 00:00:d1:ef:bc:d6, IRQ 5.
eth3: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
eth3: scatter-gather and hardware TCP cksumming disabled.
PCI: 03:06.0 PCI cache line size set incorrectly (32 bytes) by BIOS/FW,
expecting 16
eth4: Adaptec Starfire 6915 at 0xe09a7000, 00:00:d1:ef:bc:d7, IRQ 5.
eth4: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
eth4: scatter-gather and hardware TCP cksumming disabled.
PCI: 03:07.0 PCI cache line size set incorrectly (32 bytes) by BIOS/FW,
expecting 16
eth5: Adaptec Starfire 6915 at 0xe0a28000, 00:00:d1:ef:bc:d8, IRQ 5.
eth5: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
eth5: scatter-gather and hardware TCP cksumming disabled.
===-:::Logs:::===
May 23 01:28:52 System Reboot
May 23 07:30:42 tanelorn kernel: eth2: PCI bus congestion, increasing
Tx FIFO threshold to 80 bytes
May 23 08:27:53 tanelorn kernel: eth2: PCI bus congestion, increasing
Tx FIFO threshold to 96 bytes
May 23 08:27:53 tanelorn kernel: eth2: PCI bus congestion, increasing
Tx FIFO threshold to 112 bytes
May 23 08:27:53 tanelorn kernel: eth2: PCI bus congestion, increasing
Tx FIFO threshold to 128 bytes
May 23 08:27:53 tanelorn kernel: eth2: PCI bus congestion, increasing
Tx FIFO threshold to 144 bytes
May 23 08:55:51 tanelorn gated[954]: bgp_traffic_timeout: holdtime
expired for 204.239.129.190 (External AS 852)
May 23 08:55:51 tanelorn gated[954]: NOTIFICATION sent to
204.239.129.190 (External AS 852): code 4 (Hold Timer 
Expired Error) data
<<==Port stopped working. Restarted the network service to get port to
work agian.==>>
May 23 08:58:32 tanelorn kernel: eth3: PCI bus congestion, increasing
Tx FIFO threshold to 80 bytes
May 23 09:23:13 tanelorn kernel: eth2: PCI bus congestion, increasing
Tx FIFO threshold to 80 bytes
May 23 10:24:53 tanelorn kernel: NETDEV WATCHDOG: eth3: transmit timed
out 
May 23 10:24:53 tanelorn kernel: eth3: Transmit timed out, status
0x00000000, resetting...
May 23 11:15:36 tanelorn kernel: eth2: PCI bus congestion, increasing
Tx FIFO threshold to 96 bytes
<<==Port is still working fine at this point, but who knows for how
long==>>
-------------------------------------
Greg Varga
Author for RocketryNews
http://www.rocketrynews.com
CAR # 677
-------------------------------------


