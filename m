Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267856AbTBVI50>; Sat, 22 Feb 2003 03:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267859AbTBVI5Z>; Sat, 22 Feb 2003 03:57:25 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:1294 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S267856AbTBVI5Y>;
	Sat, 22 Feb 2003 03:57:24 -0500
Date: Sat, 22 Feb 2003 09:53:31 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-ac1, tulip driver falls into transmit timeouts
Message-ID: <20030222085331.GB5411@alpha.home.local>
References: <20030222084130.GB23827@torres.ka0.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030222084130.GB23827@torres.ka0.zugschlus.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc !

I suspect that your Catalyst has its interface in auto-negociation mode. This
switch behaves randomly when in auto-neg. I had some which spontaneously
renegociated after several months in production. You should force the ports
to 100FD on the switch to make the problem disappear. BTW, when forced, it
doesn't send its capabilities on the link and NICs often think it's a hub and
then switch to 100 half. So you may also have to force your NICs to 100 fdx
(ethtool or mii-diag).

BTW, ensure that there's no spanning tree on the switch since it may be an
external indirect cause of the link drops that your PC detected. BTW, note that
exactly one minute has elapsed between your half and full duplex state changes.
This might help in finding the origin of the problem.

Hoping this helps,
Willy

On Sat, Feb 22, 2003 at 09:41:30AM +0100, Marc Haber wrote:
> One of our Linux-based core routers has recently shown strange
> behavior wrt the tulip ethernet card.
> 
> Debian/GNU Linux
> Kernel 2.4.20-ac1 (with VLAN patches for the netcard drivers)
> zebra/ospfd running
> ~ 20 virtual interfaces configured on 802.1q trunk
> 00:0c.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
>         Subsystem: Digital Equipment Corporation DECchip 21142/43
>         Flags: bus master, medium devsel, latency 32, IRQ 11
>         I/O ports at a000 [size=128]
>         Memory at dd800000 (32-bit, non-prefetchable) [size=1K]
>         Expansion ROM at <unassigned> [disabled] [size=256K]
>         Capabilities: [dc] Power Management version 1
> The network card is connected to a Cisco Catalyst 3524XL.
> 
> The hardware hasn't been touched in four months; kernel 2.4.20-ac1 was
> installed in December 2002.
> 
> A few days ago, the machine started to drop off the network. Syslog
> shows
> Feb 21 12:03:32 joan kernel: vlan0: Setting half-duplex based on MII#1 link partner capability of 782d.
> Feb 21 12:03:41 joan kernel: NETDEV WATCHDOG: vlan0: transmit timed out
> Feb 21 12:03:49 joan kernel: NETDEV WATCHDOG: vlan0: transmit timed out
> Feb 21 12:04:16 joan kernel: bbo1: add 01:00:5e:00:00:06 mcast address to master interface
> Feb 21 12:04:21 joan kernel: NETDEV WATCHDOG: vlan0: transmit timed out
> Feb 21 12:04:29 joan kernel: NETDEV WATCHDOG: vlan0: transmit timed out
> Feb 21 12:04:32 joan kernel: vlan0: Setting full-duplex based on MII#1 link partner capability of 41e1.
> entries. After falling back to full-duplex, the NETDEV WATCHDOG
> message is repeated on a regular basis. Unloading and reloading
> the tulip module usually fixes the problem.
> 
> Are there any known issues with the tulip module in 2.4.20-ac1? We are
> using that configuration on other machines in our backbone as well,
> without any problems. After all, this particular machine has been
> working for months. But before I go out and swap the hardware, I'd
> like to know if there are known problems with this setup.
> 
> Any hints will be appreciated.
> 
> Greetings
> Marc
> 
> -- 
> -----------------------------------------------------------------------------
> Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
> Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
> Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
