Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbUC2RDN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 12:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbUC2RDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 12:03:13 -0500
Received: from sea2-dav28.sea2.hotmail.com ([207.68.164.85]:19475 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263028AbUC2QbA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 11:31:00 -0500
X-Originating-IP: [80.204.235.254]
X-Originating-Email: [pupilla@hotmail.com]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: "Chris Friesen" <cfriesen@nortelnetworks.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: proxy arp behaviour
Date: Mon, 29 Mar 2004 18:30:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1123
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1123
Message-ID: <Sea2-DAV28PFR6sKBEr0001522a@hotmail.com>
X-OriginalArrivalTime: 29 Mar 2004 16:30:57.0464 (UTC) FILETIME=[36B50380:01C415AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies Chris.
I haven't full explained my configuration.
Here is:

ifconfig eth0 172.17.1.1 netmask 255.255.255.0
ifconfig eth1 10.77.77.1 netmask 255.255.255.252


ip route del 172.17.1.0/24 dev eth0
ip route del 10.77.77.0/30 dev eth1

ip route add 172.17.1.254 dev eth0
ip route add 172.17.1.0/24 dev eth1

ip rule add iif eth1 table dmz-ipsec priority 504

ip route add default via 172.17.1.254 dev eth0 table main metric 1
ip route add default via 172.17.1.254 dev eth0 table dmz-ipsec metric 1
ip route flush cache

echo 1 > /proc/sys/net/ipv4/conf/eth0/proxy_arp
echo 1 > /proc/sys/net/ipv4/conf/eth1/proxy_arp


Now, hosts connected to eth1 are all 172.17.1.0/24.

The linux box is now replying to arp requests for
172.17.1.0/24 hosts, sent by 172.17.1.0/24 hosts,
on the eth1 network segment.


Chris Friesen wrote:

> Marco Berizzi wrote:
> 
> > eth1 configuration is here:
> > 
> > ifconfig eth1 10.77.77.1 broadcast 10.77.77.3 netmask 255.255.255.252
> > ip route del 10.77.77.0/30 dev eth1
> > ip route add 172.17.1.0/24 dev eth1
> > 
> > echo 1 > /proc/sys/net/ipv4/conf/eth1/proxy_arp
> > 
> > Hosts connected to eth1 are all 172.17.1.0/24.
> > The linux box is now replying to arp requests
> > that are sent by 172.17.1.0/24 hosts on the eth1
> > network segment.
> 
> Arp requests for what IP addresses?

The linux box is replying to arp requests for 172.17.1.0/24, sent
by 172.17.1.0/24 systems (windoze 2000 and Linux 2.4.25).
