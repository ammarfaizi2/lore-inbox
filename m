Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264173AbRFNXNk>; Thu, 14 Jun 2001 19:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264183AbRFNXNb>; Thu, 14 Jun 2001 19:13:31 -0400
Received: from [213.96.124.18] ([213.96.124.18]:57581 "HELO dardhal")
	by vger.kernel.org with SMTP id <S264172AbRFNXNP>;
	Thu, 14 Jun 2001 19:13:15 -0400
Date: Fri, 15 Jun 2001 01:14:16 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jldomingo@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.2.19 -> 80% Packet Loss
Message-ID: <20010615011415.A5210@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0106141325210.20189-100000@localhost.localdomain>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 14 June 2001, at 14:17:11 -0700,
chuckw@altaserv.net wrote:

> 
> 1. When pinging a machine using kernel 2.2.19 I consistently get an 80%
> packet loss when doing a ping -f with a packet size of 64590 or higher.
> 
What happens here is (under kernel 2.2.19):
ping -f -s 49092 localhost -->>   0 % packet loss
ping -f -s 49093 localhost -->> 100 % packet loss

Maybe this has something to do with fragmentation of IP packets to fit in
the underlying protocol's MTU (3929 in my loopback device).

When pinging from the network, it is expected to get an increasing number
of lost packets due to collisions in the medium. Moreover, IP
fragmentation, encapsulation and reassembly can be a reason for lost
packets, but is clear that what you get is quite strange :)

What I have noticed is that pinging from the network with large packet
sizes (for example, ping -s 55000 destinationIP), causes the ping program
to sometimes dump a echo_reply packet to stdout with the following message:

55008 bytes from 192.168.1.10: icmp_seq=8 ttl=255 time=145.9 ms
wrong data byte #190 should be 0xbe but was 0x3e

And some other times I get ping results with interesting patterns:

55008 bytes from 192.168.1.10: icmp_seq=45 ttl=255 time=1155.6 ms
55008 bytes from 192.168.1.10: icmp_seq=46 ttl=255 time=143.3 ms
55008 bytes from 192.168.1.10: icmp_seq=47 ttl=255 time=1155.2 ms
55008 bytes from 192.168.1.10: icmp_seq=48 ttl=255 time=143.8 ms


On a slower box, I get the following (kernel 2.4.4):
ping -f -s 32293 localhost -->>   0 % packet loss
ping -f -s 32294 localhost -->> 100 % packet loss

I've no idea what this could mean.

--
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

