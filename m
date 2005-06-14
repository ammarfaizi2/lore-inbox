Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVFNOOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVFNOOm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 10:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVFNOOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 10:14:42 -0400
Received: from smtp15.wanadoo.fr ([193.252.23.84]:313 "EHLO smtp15.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261228AbVFNOOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:14:24 -0400
X-ME-UUID: 20050614141422271.425F37000085@mwinf1503.wanadoo.fr
Message-ID: <26107136.1118758462265.JavaMail.www@wwinf1518>
From: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Reply-To: pascal.chapperon@wanadoo.fr
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: sis190
Cc: Andrew Hutchings <info@a-wing.co.uk>, linux-kernel@vger.kernel.org,
       vinay kumar <b4uvin@yahoo.co.in>, jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.14.41.85]
X-WUM-FROM: |~|
X-WUM-TO: |~|
X-WUM-CC: |~||~||~||~|
X-WUM-REPLYTO: |~|
Date: Tue, 14 Jun 2005 16:14:22 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you give a try at:
> http://www.fr.zoreil.com/people/francois/misc/20050613-2.6.12-rc-sis190-test.patch

> dmesg + ifconfig + tcpdump (please add a -e option) will be welcome as usual.

> If the driver starts to behave in an usually better way, please issue
> differently sized ping packets to cover the whole allowed range.

> --
> Ueimor

I tried it : 
- false mode detection
- as you expected, ping -s 157 was OK, ping -s 158 failed.

Nice, it begins to work!

BTW, i made a small typo in my diff yesterday :
line 833 : { LPA_100HALF,  0x0901, "100 Mbps Half Duplex" },
must be
line 833 : { LPA_100HALF,  0x0801, "100 Mbps Half Duplex" },
to match the old driver.

Results =>
# cat /var/log/messages
[...]
Jun 14 15:24:02 local kernel: sis190 Gigabit Ethernet driver 1.2 loaded
Jun 14 15:24:02 local kernel: ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
Jun 14 15:24:02 local kernel: 0000:00:04.0: sis190 at ffffc20000004c00 (IRQ: 11), 00:11:2f:e9:42:70
Jun 14 15:24:02 local kernel: eth0: Enabling Auto-negotiation.
Jun 14 15:24:02 local kernel: eth0: status = 63000000
Jun 14 15:24:02 local kernel: eth0: status = 20000000
Jun 14 15:24:03 local last message repeated 116 times
Jun 14 15:24:03 local kernel: eth0: status = 22000000
Jun 14 15:24:03 local kernel: eth0: status = 20000000
Jun 14 15:24:04 local last message repeated 44 times
Jun 14 15:24:04 local network: Bringing up interface eth0:  succeeded
Jun 14 15:24:04 local kernel: eth0: status = 20000000
Jun 14 15:24:12 local last message repeated 604 times
Jun 14 15:24:12 local kernel: eth0: mii 0x1f = 0000.
Jun 14 15:24:12 local kernel: eth0: mii lpa = 45e1.
Jun 14 15:24:12 local kernel: eth0: Link on 1000 Mbps Full Duplex mode.
Jun 14 15:24:12 local kernel: eth0: status = 20000000
Jun 14 15:24:43 local last message repeated 2360 times
Jun 14 15:25:13 local last message repeated 2285 times
Jun 14 15:25:13 local kernel: eth0: Promiscuous mode enabled.
[...]
Jun 14 15:26:00 local kernel: eth0: Rx status = 400c0040
Jun 14 15:26:00 local kernel: eth0: Rx PSize = 01010040
Jun 14 15:26:00 local kernel: sk_buff[0]->tail = ffff810007acb812
Jun 14 15:26:00 local kernel: eth0: Rx status = c0000000
Jun 14 15:26:00 local kernel: eth0: status = 0000000c
Jun 14 15:26:00 local kernel: eth0: status = 20000040
Jun 14 15:26:00 local kernel: eth0: Rx status = 640c0040
Jun 14 15:26:00 local kernel: eth0: Rx PSize = 01010066
Jun 14 15:26:00 local kernel: sk_buff[0]->tail = ffff810006a3e012
Jun 14 15:26:00 local kernel: eth0: Rx status = c0000000
Jun 14 15:26:00 local kernel: eth0: status = 20000000
Jun 14 15:26:01 local last message repeated 75 times
Jun 14 15:26:01 local kernel: eth0: status = 2000000c
Jun 14 15:26:01 local kernel: eth0: status = 20000040
Jun 14 15:26:01 local kernel: eth0: Rx status = 640c0040
Jun 14 15:26:01 local kernel: eth0: Rx PSize = 01010066
[...]
Jun 14 15:26:01 local kernel: eth0: Rx status = 640c0040
Jun 14 15:26:01 local kernel: eth0: Rx PSize = 01010066
Jun 14 15:26:01 local kernel: sk_buff[0]->tail = ffff810006a3e812
Jun 14 15:26:01 local kernel: eth0: Rx status = c0000000
Jun 14 15:26:01 local kernel: eth0: status = 20000000
Jun 14 15:26:05 local last message repeated 319 times
Jun 14 15:26:05 local kernel: eth0: status = 20000040
Jun 14 15:26:05 local kernel: eth0: Rx status = 400c0040
Jun 14 15:26:05 local kernel: eth0: Rx PSize = 01010040
Jun 14 15:26:05 local kernel: sk_buff[0]->tail = ffff810007205012
Jun 14 15:26:05 local kernel: eth0: Rx status = c0000000
[...]

# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:11:2F:E9:42:70
          inet addr:10.169.21.20  Bcast:10.169.23.255  Mask:255.255.252.0
          inet6 addr: fe80::211:2fff:fee9:4270/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:6 errors:0 dropped:0 overruns:0 frame:0
          TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:512 (512.0 b)  TX bytes:476 (476.0 b)
          Interrupt:11 Base address:0xdead

# ping -c 2 10.169.21.1
PING 10.169.21.1 (10.169.21.1) 56(84) bytes of data.
64 bytes from 10.169.21.1: icmp_seq=0 ttl=64 time=1.55 ms
64 bytes from 10.169.21.1: icmp_seq=1 ttl=64 time=0.416 ms

--- 10.169.21.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1000ms

=> tcpdump -enx
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 96 bytes
15:34:22.083935 00:11:2f:e9:42:70 > Broadcast, ethertype ARP (0x0806), length 42: arp who-has 10.169.21.1 tell 10.169.21.20
        0x0000:  0001 0800 0604 0001 0011 2fe9 4270 0aa9  ........../.Bp..
        0x0010:  1514 0000 0000 0000 0aa9 1501            ............
15:34:22.084201 00:30:4f:06:48:6e > 00:11:2f:e9:42:70, ethertype ARP (0x0806), length 60: arp reply 10.169.21.1 is-at 00:30:4f:06:48:6e
        0x0000:  0001 0800 0604 0002 0030 4f06 486e 0aa9  .........0O.Hn..
        0x0010:  1501 0011 2fe9 4270 0aa9 1514 0000 0000  ..../.Bp........
        0x0020:  0000 0000 0000 0000 0000 0000 0000       ..............
15:34:22.084216 00:11:2f:e9:42:70 > 00:30:4f:06:48:6e, ethertype IPv4 (0x0800), length 98: IP 10.169.21.20 > 10.169.21.1: icmp 64: echo request seq 0
        0x0000:  4500 0054 0000 4000 4001 fb42 0aa9 1514  E..T..@.@..B....
        0x0010:  0aa9 1501 0800 7dab 1a1b 0000 dedc ae42  ......}........B
        0x0020:  0000 0000 1347 0100 0000 0000 1011 1213  .....G..........
        0x0030:  1415 1617 1819 1a1b 1c1d 1e1f 2021 2223  .............!"#
        0x0040:  2425 2627 2829 2a2b 2c2d 2e2f 3031 3233  $%&'()*+,-./0123
        0x0050:  3435                                     45
15:34:22.084604 00:30:4f:06:48:6e > 00:11:2f:e9:42:70, ethertype IPv4 (0x0800), length 98: IP 10.169.21.1 > 10.169.21.20: icmp 64: echo reply seq 0
        0x0000:  4500 0054 c523 0000 4001 761f 0aa9 1501  E..T.#..@.v.....
        0x0010:  0aa9 1514 0000 85ab 1a1b 0000 dedc ae42  ...............B
        0x0020:  0000 0000 1347 0100 0000 0000 1011 1213  .....G..........
        0x0030:  1415 1617 1819 1a1b 1c1d 1e1f 2021 2223  .............!"#
        0x0040:  2425 2627 2829 2a2b 2c2d 2e2f 3031 3233  $%&'()*+,-./0123
        0x0050:  3435                                     45
15:34:23.083813 00:11:2f:e9:42:70 > 00:30:4f:06:48:6e, ethertype IPv4 (0x0800), length 98: IP 10.169.21.20 > 10.169.21.1: icmp 64: echo request seq 1
        0x0000:  4500 0054 0001 4000 4001 fb41 0aa9 1514  E..T..@.@..A....
        0x0010:  0aa9 1501 0800 4baa 1a1b 0001 dfdc ae42  ......K........B
        0x0020:  0000 0000 4447 0100 0000 0000 1011 1213  ....DG..........
        0x0030:  1415 1617 1819 1a1b 1c1d 1e1f 2021 2223  .............!"#
        0x0040:  2425 2627 2829 2a2b 2c2d 2e2f 3031 3233  $%&'()*+,-./0123
        0x0050:  3435                                     45
15:34:23.084199 00:30:4f:06:48:6e > 00:11:2f:e9:42:70, ethertype IPv4 (0x0800), length 98: IP 10.169.21.1 > 10.169.21.20: icmp 64: echo reply seq 1
        0x0000:  4500 0054 c524 0000 4001 761e 0aa9 1501  E..T.$..@.v.....
        0x0010:  0aa9 1514 0000 53aa 1a1b 0001 dfdc ae42  ......S........B
        0x0020:  0000 0000 4447 0100 0000 0000 1011 1213  ....DG..........
        0x0030:  1415 1617 1819 1a1b 1c1d 1e1f 2021 2223  .............!"#
        0x0040:  2425 2627 2829 2a2b 2c2d 2e2f 3031 3233  $%&'()*+,-./0123
        0x0050:  3435                                     45
15:34:27.084058 00:30:4f:06:48:6e > 00:11:2f:e9:42:70, ethertype ARP (0x0806), length 60: arp who-has 10.169.21.20 tell 10.169.21.1
        0x0000:  0001 0800 0604 0001 0030 4f06 486e 0aa9  .........0O.Hn..
        0x0010:  1501 0000 0000 0000 0aa9 1514 0000 0000  ................
        0x0020:  0000 0000 0000 0000 0000 0000 0000       ..............
15:34:27.084078 00:11:2f:e9:42:70 > 00:30:4f:06:48:6e, ethertype ARP (0x0806), length 42: arp reply 10.169.21.20 is-at 00:11:2f:e9:42:70
        0x0000:  0001 0800 0604 0002 0011 2fe9 4270 0aa9  ........../.Bp..
        0x0010:  1514 0030 4f06 486e 0aa9 1501            ...0O.Hn....

# ping -c 1 -s 157 10.169.21.1
PING 10.169.21.1 (10.169.21.1) 157(185) bytes of data.
165 bytes from 10.169.21.1: icmp_seq=0 ttl=64 time=0.481 ms

--- 10.169.21.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms

=> tcpdump (local)
15:39:06.194120 00:11:2f:e9:42:70 > 00:30:4f:06:48:6e, ethertype IPv4 (0x0800), length 199: IP 10.169.21.20 > 10.169.21.1: icmp 165: echo request seq 0
        0x0000:  4500 00b9 0000 4000 4001 fadd 0aa9 1514  E.....@.@.......
        0x0010:  0aa9 1501 0800 1832 231b 0000 fadd ae42  .......2#......B
        0x0020:  0000 0000 1ff6 0200 0000 0000 1011 1213  ................
        0x0030:  1415 1617 1819 1a1b 1c1d 1e1f 2021 2223  .............!"#
        0x0040:  2425 2627 2829 2a2b 2c2d 2e2f 3031 3233  $%&'()*+,-./0123
        0x0050:  3435                                     45
15:39:06.194560 00:30:4f:06:48:6e > 00:11:2f:e9:42:70, ethertype IPv4 (0x0800), length 199: IP 10.169.21.1 > 10.169.21.20: icmp 165: echo reply seq 0
        0x0000:  4500 00b9 c52d 0000 4001 75b0 0aa9 1501  E....-..@.u.....
        0x0010:  0aa9 1514 0000 2032 231b 0000 fadd ae42  .......2#......B
        0x0020:  0000 0000 1ff6 0200 0000 0000 1011 1213  ................
        0x0030:  1415 1617 1819 1a1b 1c1d 1e1f 2021 2223  .............!"#
        0x0040:  2425 2627 2829 2a2b 2c2d 2e2f 3031 3233  $%&'()*+,-./0123
        0x0050:  3435                                     45
15:39:11.192978 00:11:2f:e9:42:70 > 00:30:4f:06:48:6e, ethertype ARP (0x0806), length 42: arp who-has 10.169.21.1 tell 10.169.21.20
        0x0000:  0001 0800 0604 0001 0011 2fe9 4270 0aa9  ........../.Bp..
        0x0010:  1514 0000 0000 0000 0aa9 1501            ............
15:39:11.193170 00:30:4f:06:48:6e > 00:11:2f:e9:42:70, ethertype ARP (0x0806), length 60: arp reply 10.169.21.1 is-at 00:30:4f:06:48:6e
        0x0000:  0001 0800 0604 0002 0030 4f06 486e 0aa9  .........0O.Hn..
        0x0010:  1501 0011 2fe9 4270 0aa9 1514 0000 0000  ..../.Bp........
        0x0020:  0000 0000 0000 0000 0000 0000 0000       ..............

# ping -c 1 -s 158 10.169.21.1
PING 10.169.21.1 (10.169.21.1) 158(186) bytes of data.

--- 10.169.21.1 ping statistics ---
1 packets transmitted, 0 received, 100% packet loss, time 0ms

=> tcpdump 
15:41:29.529515 00:11:2f:e9:42:70 > 00:30:4f:06:48:6e, ethertype IPv4 (0x0800), length 200: IP 10.169.21.20 > 10.169.21.1: icmp 166: echo request seq 0
        0x0000:  4500 00ba 0000 4000 4001 fadc 0aa9 1514  E.....@.@.......
        0x0010:  0aa9 1501 0800 5c76 261b 0000 89de ae42  ......\v&......B
        0x0020:  0000 0000 4314 0800 0000 0000 1011 1213  ....C...........
        0x0030:  1415 1617 1819 1a1b 1c1d 1e1f 2021 2223  .............!"#
        0x0040:  2425 2627 2829 2a2b 2c2d 2e2f 3031 3233  $%&'()*+,-./0123
        0x0050:  3435                                     45
15:41:29.529940 4f:06:48:6e:08:00 > 2f:e9:42:70:00:30, ethertype Unknown (0x4500), length 200:
        0x0000:  00ba c52f 0000 4001 75ad 0aa9 1501 0aa9  .../..@.u.......
        0x0010:  1514 0000 6476 261b 0000 89de ae42 0000  ....dv&......B..
        0x0020:  0000 4314 0800 0000 0000 1011 1213 1415  ..C.............
        0x0030:  1617 1819 1a1b 1c1d 1e1f 2021 2223 2425  ...........!"#$%
        0x0040:  2627 2829 2a2b 2c2d 2e2f 3031 3233 3435  &'()*+,-./012345
        0x0050:  3637                                     67
15:41:34.528188 00:11:2f:e9:42:70 > 00:30:4f:06:48:6e, ethertype ARP (0x0806), length 42: arp who-has 10.169.21.1 tell 10.169.21.20
        0x0000:  0001 0800 0604 0001 0011 2fe9 4270 0aa9  ........../.Bp..
        0x0010:  1514 0000 0000 0000 0aa9 1501            ............
15:41:34.528396 00:30:4f:06:48:6e > 00:11:2f:e9:42:70, ethertype ARP (0x0806), length 60: arp reply 10.169.21.1 is-at 00:30:4f:06:48:6e
        0x0000:  0001 0800 0604 0002 0030 4f06 486e 0aa9  .........0O.Hn..
        0x0010:  1501 0011 2fe9 4270 0aa9 1514 0000 0000  ..../.Bp........
        0x0020:  0000 0000 0000 0000 0000 0000 0000       ..............

I could not make tcpdump on the server, as now i have only one monitor (the other is out of order since yesterday evening).


Regards
Pascal


