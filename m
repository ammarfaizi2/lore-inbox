Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbTH2SsW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbTH2SrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:47:10 -0400
Received: from 200-184-119-102.intelignet.com.br ([200.184.119.102]:37224 "EHLO
	recexch.vpn.mmsi.com") by vger.kernel.org with ESMTP
	id S261572AbTH2Sqx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:46:53 -0400
content-class: urn:content-classes:message
Subject: Routing issue
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Fri, 29 Aug 2003 15:46:51 -0300
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <750101AD3F99AC48B736D925301067C11E0E32@recexch.vpn.mmsi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Routing issue
Thread-Index: AcNuXelBd+e+hzY0QOe+8CkHF5JJiw==
From: =?iso-8859-1?Q?Reinaldo_Brand=E3o_Gomes?= <rbgomes@mmsi.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Ray

For I have been told that trying NATing on a Linux SuSE sparc arch is not a good idea, as a friend had crashed its system repeated times trying to do it, besides there are some security issues related to NAT, I decided to update the routing table on the remote end

The point is that to do so, to route the 172.18.1.0 back to 192.168.14.0 using the INTRANET server (172.16.8.51) as gateway it (the INTRANET server) would need to have an IP address on the 172.18.1.0 subnet.

Traceroute from 172.18.1.204 to 172.16.8.51 gives:

Traceroute to 172.16.8.51 (172.16.8.51), 30 hops max, 40 byte packets  1  172.18.1.68 (172.18.1.68)  0.506 ms  0.422 ms  2.939 ms  2  172.18.1.1 (172.18.1.1)  1.991 ms  3.035 ms  3.167 ms  3  192.168.42.1 (192.168.42.1)  13.844 ms  10.905 ms  2.516 ms  4  192.168.43.1 (192.168.43.1)  9.808 ms  92.118 ms  26.526 ms  5  172.16.8.51 (172.16.8.51)  81.256 ms  115.822 ms  19.080 ms

My question now is:  HOW can I find out what would be the INTRANET server (172.16.8.51) IP address on 172.18.1.0 subnet (if any) or is there any other way to route 172.18.1.0 back to 192.168.14.0?

Responses are really appreciated.

Reinaldo

-----Mensagem original-----
De: Ray Olszewski [mailto:ray@comarre.com] 
Enviada em: quinta-feira, 28 de agosto de 2003 15:44
Para: Reinaldo Brandão Gomes
Assunto: Re: ENC: Routing issue

The obvious question: is boavista NATing the 192.168.14.0/24 network or 
simply routing it? If the second, the most likely source of your problem is 
that the remote router (172.16.8.51) does not know that boavista's ppp IP 
address (172.16.8.63, I think) is its route to network 192.168.14.0/24 . To 
fix this, either update the routing table on the remote end or NAT the 
local LAN.

At 02:20 PM 8/28/2003 -0300, Reinaldo Brandão Gomes wrote:


>Hi, ray
>
>Just got your email from google.  Really hope you can help me here.
>
>
>I am trying to create a connection from our office to a client net.
>
>What I want to do is showed in the following line:
>
>192.168.14.10 --etho-> 192.168.14.11 --ppp0--> 172.16.8.51 --eth0--> 
>172.18.1.0 (dispatch net in Itabira)
>  (bviagem)               (boavista)          (client 
> intranet)       client servers
>
>I have created a dialup connection from 192.168.14.11 (sparc_linux
>suse)
>to 172.16.8.51 (Client intranet server), using wvdial. After connecting to 
>172.16.8.51, I run, in 192.168.14.11:
>
>Route add -net 172.18.1.0 gateway 172.16.51 dev ppp0
>
>And can ping, telnet, rsh the clients servers in Itabira from
>192.168.14.11.
>
>So far so good.
>
>After that I ran
>
>
>192.168.14.11(boavista) is Linux, and its kernel supports ip_forward.
>
>echo "1" > /proc/sys/net/ipv4/ip_forward in boavista, then
>
>cat /proc/sys/net/ipv4/ip_forward returns 1
>
>In 192.168.14.10 (bviagem - Unix), after route add -net 172.18.1.0 
>192.168.14.11, netstat -r shows:
>
>Routing Table:
>   Destination           Gateway           Flags  Ref   Use   Interface
>-------------------- -------------------- ----- ----- ------ ---------
>172.18.1.0           boavista.vpn.mmsi.com UGH      0      0
>192.168.14.0         bviagem               U        3     16  hme0
>172.18.1.0           boavista.vpn.mmsi.com UG       0      4
>base-address.mcast.net bviagem             U        3      0  hme0
>default              192.168.14.1          UG       0     25
>localhost            localhost             UH       0      3  lo0
>
>Ifconfig in boavista shows:
>
>eth0      Link encap:Ethernet  HWaddr 08:00:20:F8:54:28
>           inet addr:192.168.14.11  Bcast:192.168.14.255  Mask:255.255.255.0
>           inet6 addr: fe80::a00:20ff:fef8:5428/10 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:32792 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:32484 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100
>           RX bytes:2228241 (2.1 Mb)  TX bytes:12791952 (12.1 Mb)
>           Interrupt:32 Base address:0x6000
>
>lo        Link encap:Local Loopback
>           inet addr:127.0.0.1  Mask:255.0.0.0
>           inet6 addr: ::1/128 Scope:Host
>           UP LOOPBACK RUNNING  MTU:16436  Metric:1
>           RX packets:61363 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:61363 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:12463074 (11.8 Mb)  TX bytes:12463074 (11.8 Mb)
>
>ppp0      Link encap:Point-to-Point Protocol
>           inet addr:172.16.8.63  P-t-P:172.16.8.51  Mask:255.255.255.255
>           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1600  Metric:1
>           RX packets:1937 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:2020 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:3
>           RX bytes:162484 (158.6 Kb)  TX bytes:169357 (165.3 Kb)
>
>
>I can ping 172.18.1.204 (client server) from boavista, but a ping 
>172.18.1.204 from bviagem fails:
>
>NO answer from 172.18.1.204.
>
>Can you see what I am missing here?
>
>Thanks,
>
>Reinaldo



                       .'.
Linux                  /V\       
Dont Fear The Penguin // \\  
rbgomes@mmsi.com     /(   )\
                      ^^-^^
 
