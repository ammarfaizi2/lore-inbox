Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266256AbUANA0l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266258AbUANA0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:26:41 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49092 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266256AbUANA0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:26:39 -0500
Date: Wed, 14 Jan 2004 01:26:38 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jim Houston <jhouston@new.localdomain>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       amitkale@emsyssoft.com
Subject: Re: netpoll bug - kgdboe on x86_64
Message-ID: <20040114002638.GA4146@atrey.karlin.mff.cuni.cz>
References: <20040114001830.60F5DC60FC@h00e098094f32.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114001830.60F5DC60FC@h00e098094f32.ne.client2.attbi.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[Hmm, nice return address, Jim]

> I'm trying to get kgdboe working on x86_64.  I noticed that
> netpoll_rx is calling the rx_hook with negative values for the length.
> The attached patch fixes the problem. 

I was able to make -mm stuff work on i386, and there were not any
strange problems. (Hope this encourages you :-)



> Jim Houston - Concurrent Computer Corp.
> 
> ---
> 
> --- 2.6.1-rc1-mm2.orig/net/core/netpoll.c	2004-01-05 13:15:31.000000000 -0500
> +++ 2.6.1-rc1-mm2/net/core/netpoll.c	2004-01-13 18:58:09.311479928 -0500
> @@ -400,7 +400,7 @@ int netpoll_rx(struct sk_buff *skb)
>  
>  		if (np->rx_hook)
>  			np->rx_hook(np, ntohs(uh->source),
> -				    (char *)(uh+1), ulen-sizeof(uh)-4);
> +				    (char *)(uh+1), ulen-sizeof(struct udphdr));
>  
>  		return 1;
>  	}

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
