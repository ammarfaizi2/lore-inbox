Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270418AbRHHImG>; Wed, 8 Aug 2001 04:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270419AbRHHIlz>; Wed, 8 Aug 2001 04:41:55 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:42952 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S270418AbRHHIlq>; Wed, 8 Aug 2001 04:41:46 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200108080841.KAA26569@sunrise.pg.gda.pl>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
To: rhw@MemAlpha.CX (Riley Williams)
Date: Wed, 8 Aug 2001 10:41:09 +0200 (MET DST)
Cc: mra@pobox.com (Mark Atwood), linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0108080729480.12565-200000@infradead.org> from "Riley Williams" at Aug 08, 2001 07:40:56 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Riley Williams wrote:"
>  > If I build a system with several identical (other than MAC)
>  > FooCorp PCI ethernics, they will number up in order of ascending
>  > MAC address.
>  >
>  > I take the same system, replace the FooCorp cards with BarInc
>  > NICs, they will number up in reverse MAC address.
>  >
>  > Replace them instead with Baz Systems NICs, and I get them in
>  > bus scan order (at which point I'm dependent on the firmware
>  > version of my PCI bridge too!).
>  >
>  > And if I elect to use Frob Networking NICs, I instead get them
>  > in the *random* order that their oncard processors won the race
>  > to power up.
>  >
>  > Gods and demons help me if I try putting several of all four
>  > brands in one box, or the firmware on my NICs or in my PCI
>  > bridges changes!
> 
> I dealt with this problem in a previous email, but will repeat it for
> your benefit. The ONLY provisos I will use are the following two:
> 
>  1. All ethernet interfaces in your machine have distinct MAC's.
> 
>  2. If the firmware in your NIC's changes, the MAC's do not.
> 
> Providing both of these are met, the enclosed BASH SHELL SCRIPT
> implements the `ifconfig` command with the port name replaced by its
> MAC address.

1. NFS-root needs to have RARP/NFS servers on eth0.
   How can you deal with it if you have two boards supported by a single
   driver and, unfortunately, the one you need is detected as eth1 ?
   Assume that you cannot switch them as they use different media type...

> With this change, it doesn't actually matter what port name a
> particular interface is given, because ALL of the other network config
> tools refer to the interface by its assigned IP address, not its port
> name. As a result, if its port name changes between boots, the routing
> automatically changes with it.

2. ipfwadm / ipchains / iptables may use interface names,
3. dhcpd may need interface names to be provided,
4. you may want to pass an interface name argument to tcpdump...

In 2.2+ you can deal with 2.-4. changing interface names using ip from
iproute2. But I doubt whether ifconfig based scripts would work properly
then. And problem 1. is still valid ...

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
