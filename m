Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270230AbTHQNmP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 09:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270228AbTHQNmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 09:42:15 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:44684 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270227AbTHQNmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 09:42:07 -0400
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Carlos Velasco <carlosev@newipnet.com>
Cc: Lamont Granquist <lamont@scriptkiddie.org>,
       Bill Davidsen <davidsen@tmr.com>, "David S. Miller" <davem@redhat.com>,
       bloemsaa@xs4all.nl, Marcelo Tosatti <marcelo@conectiva.com.br>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308171509570955.003E4FEC@192.168.128.16>
References: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com>
	 <20030728213933.F81299@coredump.scriptkiddie.org>
	 <200308171509570955.003E4FEC@192.168.128.16>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061127485.21878.32.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Aug 2003 14:38:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-17 at 14:09, Carlos Velasco wrote:>
> >I can only think of one scenario where an arp request would come in
> from
> >192.168.140.x to a router interface that has 192.168.128.1.  That one
> >scenario is a misconfiguration.    

Two virtual networks sharing the same lan is a perfectly valid one.
There since the router doesn't know how to reach 140.x it wouldnt reply,
if it also *is* 140.1 for example then it can reply if it wishes but I
see nothing in 826 requiring it does. In normal situations the routing
tables will indicate preferred routes and gateways.

> >I believe that reason we do the sanity check is because of basic IP
> >routing. If the source is not from an IP address on the interface we
> >received it on, we cannot reply to that IP address.  It is simple as
> that.

Thats not true at the IP level for basic situations like asymmetric
routing.

> >As I stated, ARP is designed to be used on a LAN.  This means that all
> >stations that send/receive ARP packets are on the same subnet.  This
> is
> >the reason we do the check.   

Actual ARP is used on everything from 300 baud radio networks up

> >correctly.   There is no case where a properly configured host should
> ever
> >send a ARP request for an IP address on a different subnet.

See above, multiple virtual networks. 

> >not on the same network, then the host/router/client needs to find the
> >gateway which is on the local network

See "both are my address" case above

> >Basic and proper implementations of the TCP/IP stack should never ARP
> out
> >for a device that it is not located on the same logical network the
> host
> >is, the reason for this being they cannot communicate directly unless

See above, multiple lans co-existing.

> >I hope this clears up the reson why Cisco's ARP implementation has
> this
> >safeguard you have found along with several others, HOWEVER, please
> refer
> >to RFC 1027, (http://www.ietf.org/rfc/rfc1027.txt) and under section
> 2.4,
> >it contains the following paragraph:

RFC1027 covers proxy ARP only


