Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVAVQ1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVAVQ1A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 11:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbVAVQ1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 11:27:00 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:49833 "EHLO vana")
	by vger.kernel.org with ESMTP id S262575AbVAVQ05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 11:26:57 -0500
Date: Sat, 22 Jan 2005 17:26:56 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Chip Salzenberg <chip@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] restore skb_copy_datagram, removed from 2.6.11-rc2, breaking VMWare
Message-ID: <20050122162656.GA32149@vana.vc.cvut.cz>
References: <20050122160129.GA4693@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122160129.GA4693@perlsupport.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 11:01:29AM -0500, Chip Salzenberg wrote:
> Those of you who are using VMWare 4.5 will find that 2.6.11-rc2
> removes the public function "skb_copy_datagram", breaking VMWare
> (and any other module using that interface *sigh*).

There is no need for it.  It is fixed internally, and it will be
part of vmware-any-any-update89 and WS5.0 RC1.
						Petr Vandrovec

> The attached patch restores the (little harmless wrapper) function.
> -- 
> Chip Salzenberg            - a.k.a. -            <chip@pobox.com>
>  "What I cannot create, I do not understand." - Richard Feynman

> 
> --- x/include/linux/skbuff.h.old	2005-01-22 10:03:55.000000000 -0500
> +++ y/include/linux/skbuff.h	2005-01-22 10:42:33.000000000 -0500
> @@ -1087,4 +1087,6 @@
>  extern unsigned int    datagram_poll(struct file *file, struct socket *sock,
>  				     struct poll_table_struct *wait);
> +extern int	       skb_copy_datagram(const struct sk_buff *from,
> +					 int offset, char __user *to, int size);
>  extern int	       skb_copy_datagram_iovec(const struct sk_buff *from,
>  					       int offset, struct iovec *to,
> 
> --- x/net/core/datagram.c.old	2005-01-22 10:03:56.000000000 -0500
> +++ y/net/core/datagram.c	2005-01-22 10:43:40.000000000 -0500
> @@ -200,4 +200,17 @@
>  }
>  
> +/*
> + *	Copy a datagram to a linear buffer.
> + */
> +int skb_copy_datagram(const struct sk_buff *skb, int offset, char __user *to, int size)
> +{
> +	struct iovec iov = {
> +		.iov_base = to,
> +		.iov_len =size,
> +	};
> +
> +	return skb_copy_datagram_iovec(skb, offset, &iov, size);
> +}
> +
>  /**
>   *	skb_copy_datagram_iovec - Copy a datagram to an iovec.
> @@ -478,4 +491,5 @@
>  EXPORT_SYMBOL(datagram_poll);
>  EXPORT_SYMBOL(skb_copy_and_csum_datagram_iovec);
> +EXPORT_SYMBOL(skb_copy_datagram);
>  EXPORT_SYMBOL(skb_copy_datagram_iovec);
>  EXPORT_SYMBOL(skb_free_datagram);

