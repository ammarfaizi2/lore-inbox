Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVGGMAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVGGMAd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVGGL61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:58:27 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:58204 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261324AbVGGL4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:56:23 -0400
Message-ID: <42CD1860.1030804@tls.msk.ru>
Date: Thu, 07 Jul 2005 15:56:16 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sent an invalid ICMP type 11, code 0 error to a broadcast: 0.0.0.0
 on lo?
References: <42CBCEDD.2020401@tls.msk.ru> <Pine.LNX.4.61.0507061319440.5241@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0507061319440.5241@chaos.analogic.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Wed, 6 Jul 2005, Michael Tokarev wrote:
> 
>> kernel: 192.168.4.2 sent an invalid ICMP type 11, code 0 error to a
>> broadcast: 0.0.0.0 on lo
[]
>> All the IP addresses mentioned are local to this box.


[]
> Are you sure `lo` is configured properly, i.e.

Yes.  More, rp_filter is activated on all interfaces.

> ifconfig lo 127.0.0.1 netmask 255.0.0.0
> route add -net 127.0.0.0 netmask 255.0.0.0 dev lo
> 
> There should be no LAN routes going through lo.

There's no.

> It looks as though there are:
> 
>> kernel: 192.168.4.2 sent an invalid ICMP type 11, code 0 error
>> to a broadcast: 0.0.0.0 on lo
> 
>                              |________ 192.168.4.2 pinged lo
> 
> Only the 127.0.0.0 network should be routed through the loop-back
> device.

Again: All the IP addresses mentioned are local to this box.

If you ping an IP address on your eth0, the traffic will "go"
over loopback.  You can verify it using tcpdump:

1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:a0:d2:1d:a7:63 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.1/24 brd 192.168.1.255 scope global eth0

# tcpdump -npi lo proto ICMP
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on lo, link-type EN10MB (Ethernet), capture size 96 bytes
15:55:13.679234 IP 192.168.1.1 > 192.168.1.1: icmp 64: echo request seq 1
15:55:13.679269 IP 192.168.1.1 > 192.168.1.1: icmp 64: echo reply seq 1

$ ping 192.168.1.1
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=0.060 ms
--- 192.168.1.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.060/0.060/0.060/0.000 ms

/mjt
