Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281842AbRKZPrx>; Mon, 26 Nov 2001 10:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281894AbRKZPrd>; Mon, 26 Nov 2001 10:47:33 -0500
Received: from [168.159.129.100] ([168.159.129.100]:3334 "EHLO
	mxic1.isus.emc.com") by vger.kernel.org with ESMTP
	id <S281842AbRKZPra>; Mon, 26 Nov 2001 10:47:30 -0500
Message-ID: <93F527C91A6ED411AFE10050040665D00241AB08@corpusmx1.us.dg.com>
From: berthiaume_wayne@emc.com
To: lk@tantalophile.demon.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: RE: Multicast Broadcast
Date: Mon, 26 Nov 2001 10:47:11 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	One potential work-around is a patch to
net/ipv4/igmp.c:ip_mc_join_group.
For example:

#ifdef DUAL_MCAST_BIND
   if(!imr->imr_ifindex) {
      imr->ifindex=2;  /* eth0 */
      err=ip_mc_join_group(sk, imr);
      if (!err) {
        imr->ifindex=3; /* eth1 */
        err=ip_mc_join_group(sk, imr);
      }
      return err;
   }
#else
   if(!imr->imr_ifindex)
     in_dev = ip_mc_find_dev(imr);
#endif

	I'm hoping that there is another way.

Wayne
EMC Corp
ObjectStorEngineering
4400 Computer Drive
M/S F213
Westboro,  MA    01580

email:       Berthiaume_Wayne@emc.com

"One man can make a difference, and every man should try."  - JFK


-----Original Message-----
From: Jamie Lokier [mailto:lk@tantalophile.demon.co.uk]
Sent: Friday, November 23, 2001 3:53 PM
To: berthiaume_wayne@emc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multicast Broadcast


berthiaume_wayne@emc.com wrote:
> 	I have a cluster that I wish to be able to perform a multicast
> broadcast over two backbones, primary and secondary, simultaneously. The
two
> eth's are bound to the same VIP. When I perform the broadcast, it only
goes
> out on eth0. 

I have seen this problem when trying to use an NTP server to multicast
to two ethernets.  Unfortunately, NTP's output would only send to one of
the networks (eth0).

I never did find a workaround.

-- Jamie
