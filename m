Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280136AbRK2Vaf>; Thu, 29 Nov 2001 16:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283410AbRK2VaZ>; Thu, 29 Nov 2001 16:30:25 -0500
Received: from [168.159.129.100] ([168.159.129.100]:6928 "EHLO
	mxic1.isus.emc.com") by vger.kernel.org with ESMTP
	id <S280136AbRK2VaR>; Thu, 29 Nov 2001 16:30:17 -0500
Message-ID: <93F527C91A6ED411AFE10050040665D00241AB31@corpusmx1.us.dg.com>
From: berthiaume_wayne@emc.com
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: RE: Multicast Broadcast
Date: Thu, 29 Nov 2001 16:29:22 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Andi, forgive my ignorance. I've searched around and can't seem to
find any references to IP_ADD_MEMBERSHIP and how to use it. I did perform an
fgrep() and found the switch in net/ipv4/ip_socketglue.c, but where do I
implement it or how do I call it? Is this something I place in
/etc/sysconfig/network-scriptsifcfg-eth<x> file? Any help would be
appreciated.
Regards,
Wayne
EMC Corp
ObjectStor Engineering
4400 Computer Drive
M/S F213
Westboro,  MA    01580

email:       Berthiaume_Wayne@emc.com

"One man can make a difference, and every man should try."  - JFK


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
