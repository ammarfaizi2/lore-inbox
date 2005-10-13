Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVJMXFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVJMXFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 19:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVJMXFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 19:05:05 -0400
Received: from mail.dvmed.net ([216.237.124.58]:46992 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932179AbVJMXFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 19:05:04 -0400
Message-ID: <434EE7FB.9010506@pobox.com>
Date: Thu, 13 Oct 2005 19:04:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Buesch <mbuesch@freenet.de>
CC: James Ketrenos <jketreno@linux.intel.com>,
       ieee80211-devel@lists.sourceforge.net, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH ieee80211] fix TX skb allocation flags and size
References: <200510132341.56670.mbuesch@freenet.de>
In-Reply-To: <200510132341.56670.mbuesch@freenet.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> @@ -221,11 +221,13 @@ static struct ieee80211_txb *ieee80211_a
>   txb->frag_size = txb_size;
>  
>  	for (i = 0; i < nr_frags; i++) {
> -		txb->fragments[i] = dev_alloc_skb(txb_size);
> +		txb->fragments[i] = __dev_alloc_skb(txb_size + headroom,
> +						    gfp_mask | GFP_DMA);
>  		if (unlikely(!txb->fragments[i])) {
>  			i--;

Very wrong.  GFP_DMA means ISA DMA.

See pci_map_xxx() and other DMA API functions.

	Jeff


