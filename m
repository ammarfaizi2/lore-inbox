Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281899AbRKZQQG>; Mon, 26 Nov 2001 11:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281901AbRKZQP5>; Mon, 26 Nov 2001 11:15:57 -0500
Received: from ns.suse.de ([213.95.15.193]:19978 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281899AbRKZQPn>;
	Mon, 26 Nov 2001 11:15:43 -0500
To: berthiaume_wayne@emc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multicast Broadcast
In-Reply-To: <93F527C91A6ED411AFE10050040665D00241AB08@corpusmx1.us.dg.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 26 Nov 2001 17:15:42 +0100
In-Reply-To: berthiaume_wayne@emc.com's message of "26 Nov 2001 16:51:37 +0100"
Message-ID: <p73y9kth5jl.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
