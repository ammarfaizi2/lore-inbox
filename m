Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbRGJRzq>; Tue, 10 Jul 2001 13:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267014AbRGJRzg>; Tue, 10 Jul 2001 13:55:36 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:18226 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S267013AbRGJRzT>; Tue, 10 Jul 2001 13:55:19 -0400
Date: Tue, 10 Jul 2001 19:54:51 +0200 (CEST)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.7-pre7, softirq and serial driver.
Message-ID: <Pine.LNX.4.33.0107101934270.3589-100000@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

In Changelog to pre5 we can read:

-pre5:
 - Andrea Arkangeli: softirq cleanups and fixes, and everybody is happy
   again (ie I changed some details to make me happy ;)

I'm happy, because  before pre5, I have a lot problems with my fast
serial cards (Titan Electronics) works with 921600 baud. Problems was with
reciving packets, ping  has looked like this:


# ping pc-5.chl.pl -s 1600 -c 35 (1500 is MTU)

[...]
1608 bytes from pc-5.chl.pl (212.160.254.134): icmp_seq=20 ttl=128
time=44.596 msec
[...]
--- pc-5.chl.pl ping statistics ---
35 packets transmitted, 14 packets received, 60% packet loss
round-trip min/avg/max/mdev = 44.545/44.946/48.502/1.004 ms

As You see, there was a lot of (60%) packet loss from this host.

Now (with 2.4.6-pre7) ,is almost OK (just after reboot):

# ping pc-5.chl.pl -s 1600 -c 20
--- pc-5.chl.pl ping statistics ---
20 packets transmitted, 18 packets received, 10% packet loss
round-trip min/avg/max/mdev = 44.988/45.378/48.094/0.779 ms

Only 2 packets was lost! I was very happy, but after few hours (4-5)
I have again 60% or more packet loss! Where is a problem? Maybe serial
driver is buggy?







Additional information about this host:

[root@vendeta /root]# lspci
00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 01)
00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
00:0e.0 Serial controller: Titan Electronics Inc: Unknown device a005
00:0e.1 Communication controller: Titan Electronics Inc: Unknown device ffff
00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
00:10.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
00:11.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
01:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
01:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
03:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
03:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)


[root@vendeta /root]# procinfo
Linux 2.4.7-pre5 (root@bofh.polvoice.pl) (gcc 2.96 20000731 ) #1 1CPU
[vendeta]

Memory:      Total        Used        Free      Shared     Buffers
Cached
Mem:      62504       18472       44032           0         392       11736
Swap:     19792           0       19792

Bootup: Tue Jul 10 19:21:54 2001    Load average: 0.00 0.00 0.00 1/24 904

user  :       0:00:12.37   0.8%  page in :    11357
nice  :       0:00:00.00   0.0%  page out:     1565
system:       0:01:52.31   7.0%  swap in :        1
idle  :       0:24:43.89  92.3%  swap out:        0
uptime:       0:26:48.55         context :    43998

irq  0:    160857 timer                 irq 10:     39388 wanpipe1
irq  1:         2 keyboard              irq 11:      6808 serial
irq  2:         0 cascade [4]           irq 12:    232420 eth1, eth2
irq  5:    236075 eth3, eth4            irq 14:     25849 ide0
irq  9:    125986 eth0

[root@vendeta /root]# cat /proc/tty/driver/serial
serinfo:1.0 driver:5.05c revision:2001-07-08
0: uart:unknown port:3F8 irq:4
1: uart:unknown port:2F8 irq:3
2: uart:unknown port:3E8 irq:4
3: uart:unknown port:2E8 irq:3
4: uart:16C950/954 port:6100 irq:11 baud:921600 tx:417044 rx:403722 oe:57
RTS|CTS|DTR|DSR|CD
5: uart:16C950/954 port:6108 irq:11 baud:38400 tx:133 rx:250
RTS|CTS|DTR|DSR


-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

