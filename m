Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWIFUr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWIFUr5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 16:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWIFUr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 16:47:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:33957 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751236AbWIFUr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 16:47:56 -0400
Date: Wed, 6 Sep 2006 13:47:47 -0700
From: Greg KH <greg@kroah.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Neil Brown <neilb@suse.de>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       Nix <nix@esperi.org.uk>, stable@kernel.org
Subject: Re: [stable] [2.6.17.8] NFS stall / BUG in UDP fragment processing / SKB trimming
Message-ID: <20060906204747.GA18780@kroah.com>
References: <87zme9fy94.fsf@hades.wkstn.nix> <20060813125910.GA18463@gondor.apana.org.au> <20060825230316.GA3254@kroah.com> <20060826011839.GA14010@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060826011839.GA14010@gondor.apana.org.au>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 11:18:39AM +1000, Herbert Xu wrote:
> On Fri, Aug 25, 2006 at 04:03:16PM -0700, Greg KH wrote:
> > 
> > This patch doesn't apply at all to the latest 2.6.17-stable kernel tree.
> > Care to rediff it?
> 
> Hmm, I just rebased and it actually applied as is to 2.6.17.11 :)
> Anyway, here is the result:

No, are you sure you are using the right tree?

> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index cff9c3a..d987a27 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -946,7 +946,7 @@ alloc_new_skb:
>  				skb_prev->csum = csum_sub(skb_prev->csum,
>  							  skb->csum);
>  				data += fraggap;
> -				skb_trim(skb_prev, maxfraglen);
> +				pskb_trim_unique(skb_prev, maxfraglen);
>  			}

Oh wait, this is already in the queue, no wonder it's failing...  Sorry
about this, my fault...

greg k-h
