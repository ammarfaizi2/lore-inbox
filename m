Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129999AbQKURCz>; Tue, 21 Nov 2000 12:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130180AbQKURCp>; Tue, 21 Nov 2000 12:02:45 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:48903 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S129999AbQKURCa>; Tue, 21 Nov 2000 12:02:30 -0500
Date: Tue, 21 Nov 2000 10:32:12 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200011211632.KAA11096@tomcat.admin.navo.hpc.mil>
To: linux-kernel@vger.kernel.org, root@relay.taligent.net
Subject: Re: Multi NICs. Single HOP (NIC) Problem.
In-Reply-To: <200011202259.eAKMx1K03231@relay.taligent.net>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root <root@relay.taligent.net>:
> I have been struggling for a few months to get some internet servers
> to use 3-4 NICs effectively. I want to bind deamons to their own
> NIC so they are used independently. This is all IP software and i can get
> software to bind to these IPs (usually as standalone daemons)
> 
> The host computers have 3-4 NICs running in 100MbpsTX-FD using a switch
> 
> I slight problem with DNS resolver on some computers is that it can
> default to any NIC using the same address range/netmask though this
> has nothing to do with the "hop node" to ethernet adapter.
> 
> This is one example. (ISP style)
>  
> Apache in master daemon mode (bind/listen on)   - bound to eth1 IP	
> FTPD in standalone mode (daemonaddress)		- bound to eth2 IP
>  
> What I want to do is get each daemon using a seperate NIC (fastest
> network performance with help from running without inetd and some
> tuning)
>  
> At first i believed that, because the DNS resolver can use any NIC (using
> the same address range as ip specified in resolv.conf file) the other NICs
> are not being used. But a DNS Server using the listen-on directive for the
> pair of NICs proved this not so.
> 
> I've tried ipchains & tcpdump to figure out what's happening
> 
> so I am doing things like the following
>  
> ipchains -A input -i eth1 -s $ETH2_IP ....etc 
>  
> Using tcpdump the second nic isn't used. Yet the daemon on this is bound
> to eth2 ip address by a directive.
>  
> So i believe it's a matter of arriving packets, and has something to
> do with the route taken when the packet was sent (on the last hop).
> if the previous "hop node" has been told that eth1 is the route
> to eth2's address, then this can happen.
> 
> Question is, is their anyway to force the kernel or TCP/IP stack
> governing the IPs not to accept one IP (NIC1) destined for the other
> (NIC2). It must go through it's corresponding path.

No. Once it is inside the system it can be routed to any daemon that
will listen.

Multiple NICs work well IF the routers involved can use traffic analysis
to determine destination and path discovery at the source. Otherwise
the daemon will reply to the address in the packet header.

> If not, then i believe that a single gigabit ethernet adapter with ip
> aliases is a better solution and faster (isn't necassarily the case)
> than 3 or 4 100baseTX cards in full duplex

For a generic type server, yes. Especially if the traffic ends up at
the same place.

In a segmented network where some hosts are closer/partitioned from the
other interfaces then multiple NICs can work properly. This is a carefully
crafted network structure though, and not one that just "happens".

One place this works is in clusters. Each host can get a different hop
count for the various routes to the same destination - then it will choose
the route that is shortest. This is a "traveling saleman" problem in that
what is shortest at one moment may not be shortest in the next (traffic
load changes the definition of "shortest").

It is a basic assumption that rotating the DNS IP list is one way to
"balance" the load across several NICs where each NIC has equal connectivity,
though not identical routing.
> 
> Any Help/Advice appreciatted
> 
> Best Regards
> 
> Kevin D.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
