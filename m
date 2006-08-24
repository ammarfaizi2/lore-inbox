Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbWHXQN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbWHXQN5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWHXQN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:13:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:59577 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030306AbWHXQN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:13:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=nGHBXmx2fqqLNDmsPG2HoM9B3VKbuYj0i4aaA8BIcbllqZbmguXumdvVCuSZNgOkCNKlNzngtg9N1VEJuWoALMHZ2n/XwkbztS+liz+hHU3lehkeqku+YMZ+/W78QFLx8pS2NxjPozbV+sub0Q4r2Ci7X/UnRS+5q1mHe41wVy4=
Date: Thu, 24 Aug 2006 20:13:44 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1/4] Inconsistent extern declarations.
Message-ID: <20060824161344.GB5205@martell.zuzino.mipt.ru>
References: <1156429585.3012.58.camel@pmac.infradead.org> <1156433118.3012.117.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156433118.3012.117.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 04:25:18PM +0100, David Woodhouse wrote:
> When you compile multiple files together with --combine, the compiler
> starts to _notice_ when you do things like this in one file:
>
>  extern int ipxrtr_route_packet(struct sock *sk, struct sockaddr_ipx *usipx,
>                                 struct iovec *iov, int len, int noblock);
>
> .. but the actual function looks like this:
>
>  extern int ipxrtr_route_packet(struct sock *sk, struct sockaddr_ipx *usipx,
>                                 struct iovec *iov, size_t len, int noblock);

El-cheapo bug-finder, good. ;-)

> --- a/net/ipx/af_ipx.c
> +++ b/net/ipx/af_ipx.c
> @@ -87,7 +87,7 @@ extern int ipxrtr_add_route(__u32 networ
>  			    unsigned char *node);
>  extern void ipxrtr_del_routes(struct ipx_interface *intrfc);
>  extern int ipxrtr_route_packet(struct sock *sk, struct sockaddr_ipx *usipx,
> -			       struct iovec *iov, int len, int noblock);
> +			       struct iovec *iov, size_t len, int noblock);

Better move proto to include/net/ipx.h since net/ipx/af_ipx.c already
including it.

In general, this patch is wrong. Every external declaration and every
proto should be in only one place.

