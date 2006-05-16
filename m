Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWEPAVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWEPAVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 20:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWEPAVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 20:21:34 -0400
Received: from stinky.trash.net ([213.144.137.162]:13796 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1750871AbWEPAVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 20:21:33 -0400
Message-ID: <44691B07.6070003@trash.net>
Date: Tue, 16 May 2006 02:21:27 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: shemminger@osdl.org, ranjitm@google.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] tcpdump may trace some outbound packets twice.
References: <20060515.142645.94689626.davem@davemloft.net>	<Pine.LNX.4.56.0605151602330.29636@ranjit.corp.google.com>	<20060515164101.054afa29@localhost.localdomain> <20060515.170835.126804002.davem@davemloft.net>
In-Reply-To: <20060515.170835.126804002.davem@davemloft.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Stephen Hemminger <shemminger@osdl.org>
> Date: Mon, 15 May 2006 16:41:01 -0700
> 
> 
>>kfree_skb(NULL) is legal so the conditional here is unneeded.
>>
>>But the increased calls to kfree_skb(NULL) would probably bring the
>>"unlikely()" hordes descending on kfree_skb, so maybe:
> 
> 
> And unfortunately as Patrick McHardy states, we can't use
> this trick here because things like tc actions can do stuff
> like pskb_expand_head() which cannot handle shared SKBs.
> 
> We need another solution to this problem, because cloning an
> extra SKB is just rediculious overhead so isn't something we
> can seriously consider to solve this problem.
> 
> Another option is to say this anomaly doesn't matter enough
> to justify the complexity we're looking at here just to fix
> this glitch.
> 
> Other implementation possibility suggestions welcome :-)


We could just mark the skb to make sure its only passed to taps
on the first transmission attempt. Since we have the timestamp
optimization there shouldn't be any visible change besides
the desired effect.
