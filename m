Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVGGI1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVGGI1K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 04:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVGGI1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 04:27:09 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:56461 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261243AbVGGI0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 04:26:30 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-os@analogic.com, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: sent an invalid ICMP type 11, code 0 error to a broadcast: 0.0.0.0 on lo?
Date: Thu, 7 Jul 2005 11:25:39 +0300
User-Agent: KMail/1.5.4
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42CBCEDD.2020401@tls.msk.ru> <Pine.LNX.4.61.0507061319440.5241@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0507061319440.5241@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507071125.39046.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 July 2005 20:27, Richard B. Johnson wrote:
> Only the 127.0.0.0 network should be routed through the loop-back
> device.

This is the normal dose of disinformation embedded into
otherwise useful reply from Richard. Sometimes I wonder
whether he does this for fun for for some other dark
and obscure reason.

Anyway, lo is perfetly happy with packets other than 127.x.x.x
going thru it.

# ip a
1: if: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:04:23:15:ba:76 brd ff:ff:ff:ff:ff:ff
    inet 172.17.13.22/16 brd 172.17.255.255 scope global if
2: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo

# ip r
172.17.0.0/16 dev if  proto kernel  scope link  src 172.17.13.22
default via 172.17.0.1 dev if

# ping -c4 172.17.13.22
PING 172.17.13.22 (172.17.13.22) 56(84) bytes of data.
64 bytes from 172.17.13.22: icmp_seq=1 ttl=64 time=0.155 ms
64 bytes from 172.17.13.22: icmp_seq=2 ttl=64 time=0.113 ms
64 bytes from 172.17.13.22: icmp_seq=3 ttl=64 time=0.122 ms
64 bytes from 172.17.13.22: icmp_seq=4 ttl=64 time=0.121 ms
--- 172.17.13.22 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3011ms
rtt min/avg/max/mdev = 0.113/0.127/0.155/0.021 ms

On the other console:

# tcpdump -nlilo
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on lo, link-type EN10MB (Ethernet), capture size 68 bytes
11:20:37.669996 IP 172.17.13.22 > 172.17.13.22: icmp 64: echo request seq 1
11:20:37.670093 IP 172.17.13.22 > 172.17.13.22: icmp 64: echo reply seq 1
11:20:38.671066 IP 172.17.13.22 > 172.17.13.22: icmp 64: echo request seq 2
11:20:38.671125 IP 172.17.13.22 > 172.17.13.22: icmp 64: echo reply seq 2
11:20:39.672327 IP 172.17.13.22 > 172.17.13.22: icmp 64: echo request seq 3
11:20:39.672389 IP 172.17.13.22 > 172.17.13.22: icmp 64: echo reply seq 3
11:20:40.681857 IP 172.17.13.22 > 172.17.13.22: icmp 64: echo request seq 4
11:20:40.681922 IP 172.17.13.22 > 172.17.13.22: icmp 64: echo reply seq 4
--
vda

