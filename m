Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315153AbSDWK5R>; Tue, 23 Apr 2002 06:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315150AbSDWK5Q>; Tue, 23 Apr 2002 06:57:16 -0400
Received: from whiskey.openminds.be ([212.35.126.198]:54719 "EHLO
	whiskey.openminds.be") by vger.kernel.org with ESMTP
	id <S315153AbSDWK5Q>; Tue, 23 Apr 2002 06:57:16 -0400
Date: Tue, 23 Apr 2002 12:57:18 +0200
From: Frank Louwers <frank@openminds.be>
To: Vincent Guffens <guffens@auto.ucl.ac.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
Message-ID: <20020423125718.B1322@openminds.be>
In-Reply-To: <20020423113935.A30329@openminds.be> <20020423124756.A3572@auto.ucl.ac.be> <20020423115710.A31456@openminds.be> <20020423134135.A7941@auto.ucl.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.21i
X-PGP2: 1024R/1A899409  C3 D8 FA D3 E0 0E 40 C5  10 32 83 74 36 F0 E5 95
X-oldGPG: 1024D/3F6A7EDD  D597 566A BDF5 BBFB C308  447A 5E81 1188 3F6A 7EDD
X-GPG: 1024D/E592712F  E857 266C 04BE 0772 B9C4  E798 3D34 D5E5 E592 712F
Organisation: Openminds - http://www.openminds.be/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 01:41:35PM +0200, Vincent Guffens wrote:
> I see it here too, 

[CCing back to list as Vincent saw the same behaviour]

> 
> usermode:~# ping 192.168.0.5
> PING 192.168.0.5 (192.168.0.5): 56 data bytes
> 64 bytes from 192.168.0.5: icmp_seq=0 ttl=255 time=20.3 ms
> 
> usermode:~# ping 192.168.0.6
> PING 192.168.0.6 (192.168.0.6): 56 data bytes
> 64 bytes from 192.168.0.6: icmp_seq=0 ttl=255 time=3.5 ms
> 
> usermode:~# arp -a
> ? (192.168.0.5) at FE:FD:C0:A8:00:05 [ether] on eth0
> ? (192.168.0.6) at FE:FD:C0:A8:00:05 [ether] on eth0
> usermode:~# 
> 
> 
> 
> bash-2.05# tcpdump -e -i eth0                                                                                                       
> tcpdump: listening on eth0
> 07:21:00.284894 fe:fd:c0:a8:0:1 Broadcast arp 42: arp who-has 192.168.0.5 tell 192.168.0.1
> 07:21:00.285020 fe:fd:c0:a8:0:5 fe:fd:c0:a8:0:1 arp 42: arp reply 192.168.0.5 is-at fe:fd:c0:a8:0:5
> 07:21:00.301634 fe:fd:c0:a8:0:5 Broadcast arp 42: arp who-has router tell 192.168.0.5
> 07:21:00.303418 fe:fd:c0:a8:0:1 fe:fd:c0:a8:0:5 ip 98: 192.168.0.1 > 192.168.0.5: icmp: echo request (DF)
> 07:21:00.303589 fe:fd:c0:a8:0:5 fe:fd:c0:a8:0:1 ip 98: 192.168.0.5 > 192.168.0.1: icmp: echo reply
> 07:21:01.324561 fe:fd:c0:a8:0:5 Broadcast arp 42: arp who-has router tell 192.168.0.5
> 07:21:02.364564 fe:fd:c0:a8:0:5 Broadcast arp 42: arp who-has router tell 192.168.0.5
> 07:21:03.544592 fe:fd:c0:a8:0:1 Broadcast arp 42: arp who-has 192.168.0.6 tell 192.168.0.1
> 07:21:03.544714 fe:fd:c0:a8:0:5 fe:fd:c0:a8:0:1 arp 42: arp reply 192.168.0.6 is-at fe:fd:c0:a8:0:5      <------
> 
> 
> the interface having .5 is replying on behalf of .6. It probably comes from the fact that it is not legal to put two different
> interfaces in the same subnet. You should probably be using a load balancer interface or a bridge interface or subnet your /24
> . But as I imagine, you can't subnet, if you use the bridge you will have to enable stp which will disable one of the link and
> if you use eql, you switch has to understand it (would probably be the best though)
> 
> You can still add some static arp entries but it not very scalable and not very beautifull either ...
> 
> I'm curious about what they will say on the list,

Well, load balancing or bridging is an option, but not the one I
want... I will use the first nic as "normal" (firewalled, traffic
shaped, ...) interface for my customer's websites, and eth1 as the
"backup" and maintenance nic in case something goes wrong ...

I don't understand why it should be illegal to have to nics on the
same server on the same subnet ...

Regarding static arps: am I correct these should be added to all
machines on the subnet and to the router? (That last is not possible,
I don't have permission to change stuff on the router)

Vriendelijke groeten,
Frank Louwers

-- 
Openminds bvba                www.openminds.be
Tweebruggenstraat 16  -  9000 Gent  -  Belgium
