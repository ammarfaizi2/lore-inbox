Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265657AbUANBEg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 20:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265667AbUANBEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 20:04:36 -0500
Received: from waste.org ([209.173.204.2]:2222 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265657AbUANBEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 20:04:25 -0500
Date: Tue, 13 Jan 2004 19:04:18 -0600
From: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, amitkale@emsyssoft.com
Subject: Re: netpoll bug - kgdboe on x86_64
Message-ID: <20040114010418.GD28521@waste.org>
References: <20040114001830.60F5DC60FC@h00e098094f32.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114001830.60F5DC60FC@h00e098094f32.ne.client2.attbi.com>
User-Agent: Mutt/1.3.28i
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 07:18:30PM -0500, Jim Houston wrote:
> 
> Hi Matt,

Jim, fix your email address, you sent that as Jim Houston <jhouston@new.localdomain>.

> I'm trying to get kgdboe working on x86_64.  I noticed that
> netpoll_rx is calling the rx_hook with negative values for the length.
> The attached patch fixes the problem. 

This patch looks correct. I can't recall what I was thinking when I
tossed the -4 in there. It looks suspiciously like I did it to
mindlessly compensate for a bug where I took the sizeof a pointer
rather than a type, but I would _never_ do that. I'll send this on to
jgarzik who's queueing netpoll stuff for me.

> Jim Houston - Concurrent Computer Corp.
> 
> 
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
Matt Mackall : http://www.selenic.com : Linux development and consulting
