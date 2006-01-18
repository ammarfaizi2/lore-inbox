Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWARI4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWARI4j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 03:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWARI4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 03:56:38 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:34968 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030198AbWARI4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 03:56:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=ftQFRIKA780R52igwyChsP9enn5KRvkNxD6m+OcjgPfO4aV+H1p+lTbfTtENin8TMjjtXIXB7LsuRtaM90Ecs1Lqdcwdhxd5ZnBkvhPG1wcQMllHAGf/BT/tKHloJGGAJtiQH/2r358I2xuzJT057yPOvzcSdR0kx3INL5dIJgw=
Message-ID: <43CE02BD.8060309@gmail.com>
Date: Wed, 18 Jan 2006 09:56:29 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] e1000 C style badness
References: <5wgyi-18w-7@gated-at.bofh.it>
In-Reply-To: <5wgyi-18w-7@gated-at.bofh.it>
X-Enigmail-Version: 0.93.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe ha scritto:
> Hi,
> 
> Recent e1000 updates introduced variable declarations after code. Fix
> those up again.
> 
> Signed-off-by: Jens Axboe <axboe@suse.de>
> 
> diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
> index d0a5d16..ca68a04 100644
> --- a/drivers/net/e1000/e1000_main.c
> +++ b/drivers/net/e1000/e1000_main.c
> @@ -2142,9 +2142,11 @@ e1000_leave_82542_rst(struct e1000_adapt
>  		e1000_pci_set_mwi(&adapter->hw);
>  
>  	if(netif_running(netdev)) {
> +		struct e1000_rx_ring *ring;
> +
>  		e1000_configure_rx(adapter);
>  		/* No need to loop, because 82542 supports only 1 queue */
> -		struct e1000_rx_ring *ring = &adapter->rx_ring[0];
> +		ring = &adapter->rx_ring[0];
>  		adapter->alloc_rx_buf(adapter, ring, E1000_DESC_UNUSED(ring));
>  	}
>  }
> @@ -3583,8 +3585,8 @@ e1000_clean_rx_irq(struct e1000_adapter 
>  	rx_desc = E1000_RX_DESC(*rx_ring, i);
>  
>  	while(rx_desc->status & E1000_RXD_STAT_DD) {
> -		buffer_info = &rx_ring->buffer_info[i];
>  		u8 status;
> +		buffer_info = &rx_ring->buffer_info[i];
>  #ifdef CONFIG_E1000_NAPI
>  		if(*work_done >= work_to_do)
>  			break;
> 

Shouldn't variables declaration be on top of function and not on top of
a block (like if, while, for...)?

--
Patrizio Bassi
www.patriziobassi.it
