Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292920AbSCHNZh>; Fri, 8 Mar 2002 08:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310862AbSCHNZ0>; Fri, 8 Mar 2002 08:25:26 -0500
Received: from [217.79.102.244] ([217.79.102.244]:56046 "EHLO
	monkey.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S292920AbSCHNZM>; Fri, 8 Mar 2002 08:25:12 -0500
Subject: Re: SUN GEM on 32bit x86 looses connectivity
From: Beezly <beezly@beezly.org.uk>
To: davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1015545071.4147.23.camel@monkey>
In-Reply-To: <1015545071.4147.23.camel@monkey>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 08 Mar 2002 13:25:08 +0000
Message-Id: <1015593909.24643.12.camel@montgomery>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More infomation re: this problem,

It appears my problem is this;

Mar  7 23:15:05 monkey kernel: eth0: RX MAC fifo overflow
smac[03910440].

It looks like the Sun GEM driver is not handling this condition
gracefully.

Beezly

On Thu, 2002-03-07 at 23:51, Beezly wrote:
> Hi,
> 
> after sorting out the non-existant MAC address problem, I've hit another
> road block.
> 
> The kernel is 2.4.19-pre1
> 
> The GEM card connects fine (although the multiple "Link is up" messages
> might be interesting);
> 
> 
> sungem.c:v0.96 11/17/01 David S. Miller (davem@redhat.com)
> PCI: Found IRQ 5 for device 00:0a.0
> PCI: Sharing IRQ 5 with 00:0b.1
> eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:00:00:00:00:00=20
> eth0: Link is up at 1000 Mbps, full-duplex.
> eth0: PCS AutoNEG complete.
> eth0: PCS link is now up.
> eth0: Link is up at 1000 Mbps, full-duplex.
> eth0: Link is up at 1000 Mbps, full-duplex.
> eth0: Link is up at 1000 Mbps, full-duplex.
> eth0: Link is up at 1000 Mbps, full-duplex.
> eth0: Link is up at 1000 Mbps, full-duplex.
> eth0: Link is up at 1000 Mbps, full-duplex.
> eth0: Link is up at 1000 Mbps, full-duplex.
> 
> Everything appears to work fine; Ping works fine;
> 
> But after a short while (usually around a minute), the connection stops
> working.=20
> 
> ifconfig shows this interesting output;
> 
> eth0      Link encap:Ethernet  HWaddr 00:10:5A:41:E6:14 =20
>           inet addr:10.0.0.12  Bcast:10.0.0.255  Mask:255.255.255.0
>           inet6 addr: fe80::210:5aff:fe41:e614/10 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:5244 errors:0 dropped:1 overruns:1 frame:1
>           TX packets:5252 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100=20
>           RX bytes:7833582 (7.4 MiB)  TX bytes:7812928 (7.4 MiB)
>           Interrupt:5 Base address:0x8400=20
> 
> notice the RX - dropped:1 overruns:1 frame:1
> 
> I suspect that only RX capability is lost, although I haven't been able
> to check this yet. I believe this because if I ping from the box with
> the GE card in to another box (which is stable), once the GEM stops
> working, TX packets increases, whilst RC packets does not.
> 
> I /think/ I can reproduce this problem quicker by doing a ping -f -s
> 1472 <somehost> from this host, although this is a purely qualitative
> judgement.
> 
> The switch i am connecting to is an extreme summit 48 - which supports
> the 802.1q VLAN protocol, if this has anything to do with the problem.
> 
> At the moment, my "workaround" is to ifdown the interface every 30
> seconds, rmmod sungem and then modprobe sungem (auto-reconfiguring the
> interface). This gets the interface going again, but means I loose
> connectivity for about 2 seconds out of 30!
> 
> Any help gratefully appreciated,
> 
> Beezly


