Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317651AbSGJJll>; Wed, 10 Jul 2002 05:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317652AbSGJJlk>; Wed, 10 Jul 2002 05:41:40 -0400
Received: from coruscant.franken.de ([193.174.159.226]:25815 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S317651AbSGJJlj>; Wed, 10 Jul 2002 05:41:39 -0400
Date: Wed, 10 Jul 2002 10:38:33 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Marcus Sundberg <marcus@ingate.com>
Cc: netfilter-devel@lists.samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Iptables multiport match fix
Message-ID: <20020710083833.GL23676@naboo.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	Marcus Sundberg <marcus@ingate.com>,
	netfilter-devel@lists.samba.org, linux-kernel@vger.kernel.org
References: <veznx0ejov.fsf@inigo.ingate.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <veznx0ejov.fsf@inigo.ingate.se>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux naboo 2.4.19-pre4-ben0
X-Date: Today is Setting Orange, the 44th day of Confusion in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 10:21:36PM +0200, Marcus Sundberg wrote:
> Hi,
> 
> The multiport match checks for the IPT_INV_PROTO flag in the 'flags'
> member of struct ipt_ip instead of in the 'invflags' member.

thanks for this fix.
> 
> diff -ur linux.current/net/ipv4/netfilter/ipt_multiport.c linux-mine/net/ipv4/netfilter/ipt_multiport.c
> --- linux-2.4.19-rc1/net/ipv4/netfilter/ipt_multiport.c	Tue Jun 20 23:32:27 2000
> +++ linux/net/ipv4/netfilter/ipt_multiport.c	Tue Jul  9 10:43:23 2002
> @@ -78,7 +78,7 @@
>  
>  	/* Must specify proto == TCP/UDP, no unknown flags or bad count */
>  	return (ip->proto == IPPROTO_TCP || ip->proto == IPPROTO_UDP)
> -		&& !(ip->flags & IPT_INV_PROTO)
> +		&& !(ip->invflags & IPT_INV_PROTO)
>  		&& matchsize == IPT_ALIGN(sizeof(struct ipt_multiport))
>  		&& (multiinfo->flags == IPT_MULTIPORT_SOURCE
>  		    || multiinfo->flags == IPT_MULTIPORT_DESTINATION
> 
> (Where should I send this btw? The kernel part of iptables doesn't
> seem to be in the netfilter CVS. Was I supposed to create a p-o-m
> patch? Or send it directly to Marcelo?)

send it to the netfilter development list
(netfilter-devel@lists.samba.org). The netfilter developers will then 
check/test and submit to DaveM for kernel inclusion.

> //Marcus

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
