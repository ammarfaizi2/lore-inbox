Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269779AbRHIMP1>; Thu, 9 Aug 2001 08:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269780AbRHIMPS>; Thu, 9 Aug 2001 08:15:18 -0400
Received: from pc40.e18.physik.tu-muenchen.de ([129.187.154.153]:57612 "EHLO
	pc40.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S269779AbRHIMPJ>; Thu, 9 Aug 2001 08:15:09 -0400
Date: Thu, 9 Aug 2001 14:15:15 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: <linux-net@vger.kernel.org>
cc: <linux-kernel@vger.kernel.org>
Subject: ARP misbehaviour
Message-ID: <Pine.LNX.4.31.0108091335210.25815-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

My question is about ARP behaviour: Why does my machine answer ARP
requests for eth1 on eth0, even if the address on eth1 has scope link and
arp_filter is on? What do I have to do to prevent this?

I am aware that this issue was already discussed, but I could not find a
solution to the problem even in the long threads. The recommendation
seems to be to turn on arp_filter, but that doesn't help a bit.

This is my setup (output beautified a bit):

======================================================================
[root@paco00 all]# ip addr show

1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 brd 127.255.255.255 scope host lo
2: eth0: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc pfifo_fast qlen
100
    link/ether 00:01:02:b9:18:8b brd ff:ff:ff:ff:ff:ff
    inet 129.187.154.217/24 brd 129.187.154.255 scope global eth0
    inet 129.187.154.218/24 brd 129.187.154.255 scope global secondary
eth0:0
    inet 129.187.154.219/24 brd 129.187.154.255 scope global secondary
eth0:1
3: eth1: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:60:08:f5:ec:0e brd ff:ff:ff:ff:ff:ff
    inet 10.187.185.12/24 brd 10.187.185.255 scope link eth1:0
    inet 192.168.1.254/24 brd 192.168.1.255 scope link eth1

[root@paco00 all]# ip route show

10.187.185.11    dev eth1                scope link
129.187.154.0/24 dev eth0  proto kernel  scope link  src 129.187.154.217
192.168.1.0/24   dev eth1  proto kernel  scope link  src 192.168.1.254
10.187.185.0/24  dev eth1  proto kernel  scope link  src 10.187.185.12
127.0.0.0/8      dev lo                  scope link
default via 129.187.154.254 dev eth0

[root@paco00 all]# cat /proc/sys/net/ipv4/conf/{all,eth0,eth1}/arp_filter

1
1
1
======================================================================

This shows the problem:

======================================================================
root@pc40:/ > arping 192.168.1.254
ARPING 192.168.1.254 from 129.187.154.153 eth0
Unicast reply from 192.168.1.254 [00:01:02:B9:18:8B]  0.837ms
======================================================================

I'm using kernel 2.4.6 from Linus, machine is a dual PIII450, 512MB RAM
eth0: 3Com PCI 3c905C Tornado, PROMISC because of arpwatch running
eth1: 3Com 3C985 Gigabit Ethernet

Ciao,
					Roland


