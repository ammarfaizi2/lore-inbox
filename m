Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270447AbTHQR2I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 13:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270445AbTHQR2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 13:28:07 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:63117 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270444AbTHQR2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 13:28:01 -0400
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Carlos Velasco <carlosev@newipnet.com>
Cc: Lamont Granquist <lamont@scriptkiddie.org>,
       Bill Davidsen <davidsen@tmr.com>, "David S. Miller" <davem@redhat.com>,
       bloemsaa@xs4all.nl, Marcelo Tosatti <marcelo@conectiva.com.br>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308171827130739.00C3905F@192.168.128.16>
References: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com>
	 <20030728213933.F81299@coredump.scriptkiddie.org>
	 <200308171509570955.003E4FEC@192.168.128.16>
	 <200308171516090038.0043F977@192.168.128.16>
	 <1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk>
	 <200308171555280781.0067FB36@192.168.128.16>
	 <1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk>
	 <200308171759540391.00AA8CAB@192.168.128.16>
	 <1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk>
	 <200308171827130739.00C3905F@192.168.128.16>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061141045.21885.74.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Aug 2003 18:24:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-17 at 17:27, Carlos Velasco wrote:
> Really, I don't know if you don't uderstand or you don't want to
> understand...
> 
> There is _NOT_ any problem of duplicated IPs or so.
> It's a Load Balancing scenary, similar to linuxvirtualserver and ARP
> problem that rise _ONLY_ when using Linux as real server:
> http://www.linuxvirtualserver.org/docs/arp.html

Which says

| In the LVS/TUN and LVS/DR clusters, the Virtual IP (VIP) addresses are
| shared by both the load balancer and real servers, because they all 
| configure the VIP address on one of their interfaces.

Which is not legal IP, and is why you are having problems.

> If you send a packet through dev eth0 to dev lo IP address or other
> interface, when Linux try to map the MAC address with the IP address of
> the default gateway (or the gateway to reach the packet Source IP
> address), it uses the lo IP address (or other dev) in the ARP Request.

So stick the address on eth0 not on lo since its not a loopback but an eth0
address, then use arpfilter so you don't arp for the invalid magic shared IP
address, or NAT it, or it may work to do

         ip route add nexthop-addr src my-virtual-addr dev eth0 scope local onlink
         ip route add default src my-virtual-addr via nexthop-addr dev eth0 scope global

if you have no other routes getting in the way, especially old style ifconfig ones


