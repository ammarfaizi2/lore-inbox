Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbWHRWhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWHRWhf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbWHRWhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:37:35 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1965 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751550AbWHRWhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:37:34 -0400
Subject: Re: [PATCH 2.6.18-rc4] aoe [07/13]: jumbo frame support 2 of 2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Ed L. Cashin" <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
In-Reply-To: <89aa13bbceac9f7580cfa29d3a05a236@coraid.com>
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
	 <89aa13bbceac9f7580cfa29d3a05a236@coraid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Aug 2006 23:58:32 +0100
Message-Id: <1155941912.31543.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-18 am 13:39 -0400, ysgrifennodd Ed L. Cashin:
> Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
> 
> Add support for jumbo ethernet frames.
> (This patch follows patch 5.)
> 
> diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c
> --- 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c	2006-08-17 16:45:34.000000000 -0400
> +++ 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c	2006-08-17 16:45:34.000000000 -0400
> @@ -28,7 +28,7 @@ new_skb(ulong len)
>  		skb->protocol = __constant_htons(ETH_P_AOE);
>  		skb->priority = 0;
>  		skb_put(skb, len);
> -		memset(skb->head, 0, len);
> +		memset(skb->head, 0, ETH_ZLEN);

You realise the tail of a short packet is cleared by the network drivers
either in software or hardware ?

