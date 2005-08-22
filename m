Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbVHVX4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVHVX4X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVHVX4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:56:23 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:33990 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1751272AbVHVX4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:56:22 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=HXkMjg8sGUrGD6z7Q2DlvftSSTNA0TbNlFEfgy0Nw8uD9rdt2n+pvYw9NC0qobqnO
	P9r3kcGcLUdpxm9GmfaVg==
Date: Mon, 22 Aug 2005 16:56:03 -0700
From: David Brownell <david-b@pacbell.net>
To: ytht.net@gmail.com
Subject: Re: [PATCH 2.6.12.5]fix gl_skb/skb type error in genelink driver in 
 usbnet in 2.6
Cc: linux-kernel@vger.kernel.org
References: <20050822060239.GA4155@gsy2.lepton.home>
In-Reply-To: <20050822060239.GA4155@gsy2.lepton.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050822235603.963C8BFE91@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    I think there is a type error when port genelink driver to 2.6..
>    With this error, a linux host will panic when it link with a windows
>    host.
>    
>    See the following patch.
>

Looks right to me; thanks!  Would you happen to know if this
GL620a chip is still manufactured?

If this oops fix doesn't make 2.6.13, I'll roll this change into
the upcoming split of "usbnet" into eight minidrivers around a
shared core library.

- Dave


> --- linux-2.6-curr/drivers/usb/net/usbnet.c	2005-06-30 07:00:53.000000000 +0800
> +++ linux-2.6-curr-lepton/drivers/usb/net/usbnet.c	2005-08-22 13:55:18.000000000 +0800
> @@ -1922,7 +1922,7 @@ static int genelink_rx_fixup (struct usb
>  
>  			// copy the packet data to the new skb
>  			memcpy(skb_put(gl_skb, size), packet->packet_data, size);
> -			skb_return (dev, skb);
> +			skb_return (dev, gl_skb);
>  		}
>  
>  		// advance to the next packet
>

