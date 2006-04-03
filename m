Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWDCIyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWDCIyN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 04:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWDCIyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 04:54:13 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:50110 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751414AbWDCIyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 04:54:12 -0400
Date: Mon, 3 Apr 2006 10:54:09 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: George Petre <glpetre@bitdefender.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: stealth firewall problem
In-Reply-To: <442956F8.6070401@bitdefender.com>
Message-ID: <Pine.LNX.4.61.0604031050170.2220@yvahk01.tjqt.qr>
References: <442956F8.6070401@bitdefender.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ifconfig $INTERIOR_IFACE 0.0.0.0 promisc up -arp
> ifconfig $EXTERIOR_IFACE 0.0.0.0 promisc up -arp
> brctl addif $BRIDGE_IFACE $INTERIOR_IFACE
> brctl addif $BRIDGE_IFACE $EXTERIOR_IFACE
> ifconfig $BRIDGE_IFACE 0.0.0.0 up -arp

       [-]arp Enable or disable the use of the ARP protocol on this 
interface.

Maybe you should leave the arp bit on, i.e.
  ip l s eth0 up
  ip l s eth1 up
  brctl addif br0 eth0 eth1
  ip l s br0 up
  (by default it will take 15 seconds for the bridge to become alive now)

> /sbin/modprobe ipt_LOG

Not explicitly needed.

> echo "1" > /proc/sys/net/ipv4/ip_forward

This is not needed for brX.

> iptables -A FORWARD -i $EXTERIOR_IFACE -p tcp -m state --state NEW -j LOG
> --log-prefix "INBOUND TCP: "

That won't work. A bridged packet has -i br0 -o br0. You must match it with 
-m physdev --physdev-in $EXTERIOR --physdev-out $INTERIOR.



Jan Engelhardt
-- 
