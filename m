Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbRBIFoH>; Fri, 9 Feb 2001 00:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129256AbRBIFn5>; Fri, 9 Feb 2001 00:43:57 -0500
Received: from crusoe.degler.net ([160.79.55.71]:2240 "EHLO degler.net")
	by vger.kernel.org with ESMTP id <S129030AbRBIFnq>;
	Fri, 9 Feb 2001 00:43:46 -0500
Date: Fri, 9 Feb 2001 00:43:16 -0500
From: Stephen Degler <sdegler@degler.net>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ARP out the wrong interface
Message-ID: <20010209004316.E2528@crusoe.degler.net>
In-Reply-To: <Pine.LNX.4.33.0102082058060.21439-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0102082058060.21439-100000@twinlark.arctic.org>; from dean-list-linux-kernel@arctic.org on Thu, Feb 08, 2001 at 09:09:49PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What you describe below is having the client mis-addressed to have
the same IP as the server.  Is this what you meant?

skd


On Thu, Feb 08, 2001 at 09:09:49PM -0800, dean gaudet wrote:
> this appears to occur with both 2.2.16 and 2.4.1.
> 
> server:
> 
> eth0 is 192.168.250.11 netmask 255.255.255.0
> eth1 is 192.168.251.11 netmask 255.255.255.0
> 
> they're both connected to the same switch.
> 
> client:
> 
> eth0 is 192.168.251.11 netmask 255.255.255.0
> 
> connected to the same switch as both of server's eth.
> 
> on client i try "ping 192.168.251.11".
> 
> responses come back from both eth0 and eth1, listing each of their
> respective MAC addresses...  it's essentially a race condition at this
> point as to whether i'll get the right MAC address.  ("right" means the
> MAC for server:eth1).
> 
> client# tcpdump -n arp
> Kernel filter, protocol ALL, datagram packet socket
> tcpdump: listening on all devices
> 21:03:05.695089 eth0 > arp who-has 192.168.251.11 tell 192.168.251.25 (0:3:47:0:25:80)
> 21:03:05.695405 eth0 < arp reply 192.168.251.11 is-at 0:d0:b7:be:3e:aa (0:3:47:0:25:80)
> 21:03:05.695523 eth0 < arp reply 192.168.251.11 is-at 0:d0:b7:1f:ea:35 (0:3:47:0:25:80)
> 
> 
> server# cat /proc/sys/net/ipv4/ip_forward
> 0
> server# cat /proc/sys/net/ipv4/conf/*/proxy_arp
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 
> is this expected?  it seems broken.
> 
> thanks
> -dean
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
