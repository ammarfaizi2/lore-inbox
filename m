Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281913AbRKZQdk>; Mon, 26 Nov 2001 11:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281914AbRKZQda>; Mon, 26 Nov 2001 11:33:30 -0500
Received: from maho3msx2.isus.emc.com ([128.221.11.32]:61192 "EHLO
	maho3msx2.isus.emc.com") by vger.kernel.org with ESMTP
	id <S281913AbRKZQdQ>; Mon, 26 Nov 2001 11:33:16 -0500
Message-ID: <93F527C91A6ED411AFE10050040665D00241AB10@corpusmx1.us.dg.com>
From: berthiaume_wayne@emc.com
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: RE: Multicast Broadcast
Date: Mon, 26 Nov 2001 11:33:03 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Wouldn't the IP address for the two NIC's have to be different for
that to work? I'm binding the same VIP to the two eth's.

-----Original Message-----
From: Andi Kleen [mailto:ak@suse.de]
Sent: Monday, November 26, 2001 11:16 AM
To: berthiaume_wayne@emc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multicast Broadcast


berthiaume_wayne@emc.com writes:

> 	One potential work-around is a patch to
> net/ipv4/igmp.c:ip_mc_join_group.
> For example:
> 
> #ifdef DUAL_MCAST_BIND
>    if(!imr->imr_ifindex) {
>       imr->ifindex=2;  /* eth0 */
>       err=ip_mc_join_group(sk, imr);
>       if (!err) {
>         imr->ifindex=3; /* eth1 */
>         err=ip_mc_join_group(sk, imr);
>       }
>       return err;
>    }
> #else
>    if(!imr->imr_ifindex)
>      in_dev = ip_mc_find_dev(imr);
> #endif
> 
> 	I'm hoping that there is another way.

It depends on what you want to do, but this "fix" is the same
equivalent to executing IP_ADD_MEMBERSHIP twice with 2 and 3 in the
imr_ifindex field (except that the later doesn't break any programs) 

-Andi
