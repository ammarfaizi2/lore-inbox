Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129535AbQKTX0M>; Mon, 20 Nov 2000 18:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129549AbQKTX0C>; Mon, 20 Nov 2000 18:26:02 -0500
Received: from [62.6.255.40] ([62.6.255.40]:28421 "EHLO relay.taligent.net")
	by vger.kernel.org with ESMTP id <S129535AbQKTXZu>;
	Mon, 20 Nov 2000 18:25:50 -0500
Date: Mon, 20 Nov 2000 22:59:01 GMT
From: root <root@relay.taligent.net>
Message-Id: <200011202259.eAKMx1K03231@relay.taligent.net>
Subject: Multi NICs. Single HOP (NIC) Problem.
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been struggling for a few months to get some internet servers
to use 3-4 NICs effectively. I want to bind deamons to their own
NIC so they are used independently. This is all IP software and i can get
software to bind to these IPs (usually as standalone daemons)

The host computers have 3-4 NICs running in 100MbpsTX-FD using a switch

I slight problem with DNS resolver on some computers is that it can
default to any NIC using the same address range/netmask though this
has nothing to do with the "hop node" to ethernet adapter.

This is one example. (ISP style)
 
Apache in master daemon mode (bind/listen on)   - bound to eth1 IP	
FTPD in standalone mode (daemonaddress)		- bound to eth2 IP
 
What I want to do is get each daemon using a seperate NIC (fastest
network performance with help from running without inetd and some
tuning)
 
At first i believed that, because the DNS resolver can use any NIC (using
the same address range as ip specified in resolv.conf file) the other NICs
are not being used. But a DNS Server using the listen-on directive for the
pair of NICs proved this not so.

I've tried ipchains & tcpdump to figure out what's happening

so I am doing things like the following
 
ipchains -A input -i eth1 -s $ETH2_IP ....etc 
 
Using tcpdump the second nic isn't used. Yet the daemon on this is bound
to eth2 ip address by a directive.
 
So i believe it's a matter of arriving packets, and has something to
do with the route taken when the packet was sent (on the last hop).
if the previous "hop node" has been told that eth1 is the route
to eth2's address, then this can happen.

Question is, is their anyway to force the kernel or TCP/IP stack
governing the IPs not to accept one IP (NIC1) destined for the other
(NIC2). It must go through it's corresponding path.

If not, then i believe that a single gigabit ethernet adapter with ip
aliases is a better solution and faster (isn't necassarily the case)
than 3 or 4 100baseTX cards in full duplex


Any Help/Advice appreciatted

Best Regards

Kevin D.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
