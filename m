Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751792AbWB1FBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbWB1FBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 00:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbWB1FBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 00:01:19 -0500
Received: from koto.vergenet.net ([210.128.90.7]:56208 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1750777AbWB1FBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 00:01:18 -0500
Date: Tue, 28 Feb 2006 11:38:56 +0900
From: Horms <horms@verge.net.au>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Bernard Pidoux <pidoux@ccr.jussieu.fr>,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       wensong@linux-vs.org, netdev@vger.kernel.org, ja@ssi.bg,
       "David S. Miller" <davem@davemloft.net>,
       Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [patch 04/39] [PATCH] [BRIDGE]: netfilter missing symbol has_bridge_parent
Message-ID: <20060228023853.GA30884@verge.net.au>
References: <20060227223200.865548000@sorel.sous-sol.org> <20060227223321.042696000@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227223321.042696000@sorel.sous-sol.org>
X-Cluestick: seven
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 02:32:04PM -0800, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> 5dce971acf2ae20c80d5e9d1f6bbf17376870911 in Linus' tree,
> otherwise known as bridge-netfilter-races-on-device-removal.patch in
> 2.5.15.4 removed has_bridge_parent, however this symbol is still
> called with NETFILTER_DEBUG is enabled.
> 
> This patch uses the already seeded realoutdev value to detect if a parent
> exists, and if so, the value of the parent.
> 
> Signed-Off-By: Horms <horms@verge.net.au>
> Acked-by: Stephen Hemminger <shemminger@osdl.org>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
> 
>  net/bridge/br_netfilter.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.15.4.orig/net/bridge/br_netfilter.c
> +++ linux-2.6.15.4/net/bridge/br_netfilter.c
> @@ -794,8 +794,8 @@ static unsigned int br_nf_post_routing(u
>  print_error:
>  	if (skb->dev != NULL) {
>  		printk("[%s]", skb->dev->name);
> -		if (has_bridge_parent(skb->dev))
> -			printk("[%s]", bridge_parent(skb->dev)->name);
> +		if (realoutdev)
> +			printk("[%s]", realoutdev->name);
>  	}
>  	printk(" head:%p, raw:%p, data:%p\n", skb->head, skb->mac.raw,
>  					      skb->data);
> 
> --

I double checked, and that is the aggregate fix that was added
to Linus' tree, it should solve the problem at hand.

-- 
Horms
