Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTD2OH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 10:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTD2OH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 10:07:27 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:7560 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S262015AbTD2OHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 10:07:24 -0400
Date: Tue, 29 Apr 2003 09:19:23 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: David Woodhouse <dwmw2@infradead.org>
cc: marcelo@conectiva.com.br, <kkeil@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  Fix V.110 on HiSax HFC_PCI.
In-Reply-To: <1051608519.18316.118.camel@passion.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44.0304290918200.3902-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Apr 2003, David Woodhouse wrote:

> This patch fixes V.110 dialin to HFC_PCI ISDN adapters, which weren't
> sending V.110 idle frames correctly before due to missing wakeups from
> the low-level driver.
> 
> This is for 2.4 only -- 2.5 with ISDN doesn't even boot for me at the moment.
> 
> --- drivers/isdn/hisax/hfc_pci.c.orig	2003-04-26 00:19:36.000000000 +0100
> +++ drivers/isdn/hisax/hfc_pci.c	2003-04-26 00:19:43.000000000 +0100
> @@ -687,6 +687,10 @@
>  				debugl1(cs, "hfcpci_fill_fifo_trans %d frame length %d discarded",
>  					bcs->channel, bcs->tx_skb->len);
>  
> +			if (bcs->st->lli.l1writewakeup &&
> +                           (PACKET_NOACK != bcs->tx_skb->pkt_type))
> +				bcs->st->lli.l1writewakeup(bcs->st, bcs->tx_skb->len);
> +
>  			dev_kfree_skb_any(bcs->tx_skb);
>  			cli();
>  			bcs->tx_skb = skb_dequeue(&bcs->squeue);	/* fetch next data */
> 

Thanks, this looks fine. I'll merge it if Marcelo doesn't take it right 
away (please do ;)

--Kai


