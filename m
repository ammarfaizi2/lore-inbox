Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbRE2Wvf>; Tue, 29 May 2001 18:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262379AbRE2WvZ>; Tue, 29 May 2001 18:51:25 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:42249 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S262355AbRE2WvN>;
	Tue, 29 May 2001 18:51:13 -0400
From: Steve Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200105292256.XAA16415@gw.chygwyn.com>
Subject: Re: [CHECKER] 84 bugs in 2.4.4/2.4.4-ac8 where NULL pointers are deref'd
To: davem@redhat.com (David S. Miller)
Date: Tue, 29 May 2001 23:56:10 +0100 (BST)
Cc: engler@csl.Stanford.EDU (Dawson Engler), linux-kernel@vger.kernel.org,
        mc@cs.Stanford.EDU, philb@gnu.org
In-Reply-To: <15124.9340.77101.588276@pizda.ninka.net> from "David S. Miller" at May 29, 2001 03:36:44 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> 
> [ Steve: Just skim down to the decnet bug, you should have a look
>          at it.
> 
[various bits deleted]

Thanks for pointing this out. At first glance the problem is not where the
error says that it is since it should be impossible to get here with a NULL
neighbour cache entry (well we shouldn't be creating an output route without
a next hop :-)

I've got some other little DECnet fixes to forward shortly, but I'm probably
not going to get a chance to do so before the end of the week now so I'll
look at this properly and send fixes then,

Steve.

[DECnet bug report reproduced here for context]
>  > ---------------------------------------------------------
>  > [BUG] contradicts
>  > /u2/engler/mc/oses/linux/2.4.4/net/decnet/dn_route.c:808:dn_route_output_slow: ERROR:INTERNAL_NULL:798:808: [type=set] (set at line 798) Dereferencing NULL ptr "neigh" illegally! [val=1000]
>  > 	
>  > 	rt->key.saddr  = src;
>  > 	rt->rt_saddr   = src;
>  > 	rt->key.daddr  = dst;
>  > 	rt->rt_daddr   = dst;
>  > Start --->
>  > 	rt->key.oif    = neigh ? neigh->dev->ifindex : -1;
>  > 	rt->key.iif    = 0;
>  > 	rt->key.fwmark = 0;
>  > 
>  > 	rt->u.dst.neighbour = neigh;
>  > 	rt->u.dst.dev = neigh ? neigh->dev : NULL;
>  > 	rt->u.dst.lastuse = jiffies;
>  > 	rt->u.dst.output = dn_output;
>  > 	rt->u.dst.input  = dn_rt_bug;
>  > 
>  > Error --->
>  > 	if (dn_dev_islocal(neigh->dev, rt->rt_daddr))
>  > 		rt->u.dst.input = dn_nsp_rx;
>  > 
>  > 	hash = dn_hash(rt->key.saddr, rt->key.daddr);
> 
> Yeah, this one is wrong, I'll leave this to Steve Whitehouse though,
> the DecNET maintainer.
> 
