Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030543AbVIAXpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030543AbVIAXpd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 19:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbVIAXpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 19:45:33 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:50513 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030543AbVIAXpc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 19:45:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=guqFgYtJvfVmwRs789jF7qNICIvubLJHVERj06jnkEX2xffDD3d7IgBZAUKg+CxmAb8Zk6YiQWXwlllwAfyYgYZCq2vojzdJM0NHmLPeyZi2ExUcriaKhk2V+Run5l24AB8JavGTpAGVbtZ4+A9VHkwRKSJja/CLk3SPFs25YLk=
Message-ID: <9929d2390509011645346ef612@mail.gmail.com>
Date: Thu, 1 Sep 2005 16:45:31 -0700
From: Jeff Kirsher <tarbal@gmail.com>
To: dwalker@mvista.com
Subject: Re: [PATCH 2.6.13] Warning in the e1000 driver
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1125603508.4867.24.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1125603508.4867.24.camel@dhcp153.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/05, Daniel Walker <dwalker@mvista.com> wrote:
> 
> This should fix a small warning in the e1000 driver. It casts to the
> largest possible type dma field. This was found while compiling for
> X86_64 .
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.13/drivers/net/e1000/e1000_main.c
> ===================================================================
> --- linux-2.6.13.orig/drivers/net/e1000/e1000_main.c    2005-08-30 18:28:41.000000000 +0000
> +++ linux-2.6.13/drivers/net/e1000/e1000_main.c 2005-08-30 19:42:45.000000000 +0000
> @@ -2767,7 +2767,7 @@ e1000_clean_tx_irq(struct e1000_adapter
>                                         "  next_to_use          <%x>\n"
>                                         "  next_to_clean        <%x>\n"
>                                         "buffer_info[next_to_clean]\n"
> -                                       "  dma                  <%zx>\n"
> +                                       "  dma                  <%llx>\n"
>                                         "  time_stamp           <%lx>\n"
>                                         "  next_to_watch        <%x>\n"
>                                         "  jiffies              <%lx>\n"
> @@ -2776,7 +2776,7 @@ e1000_clean_tx_irq(struct e1000_adapter
>                                 E1000_READ_REG(&adapter->hw, TDT),
>                                 tx_ring->next_to_use,
>                                 i,
> -                               tx_ring->buffer_info[i].dma,
> +                               (unsigned long long)tx_ring->buffer_info[i].dma,
>                                 tx_ring->buffer_info[i].time_stamp,
>                                 eop,
>                                 jiffies,
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Just remove the following lines
> -                                       "  dma                  <%zx>\n"
and
> -                               tx_ring->buffer_info[i].dma,
from the DPRINTK statement.  The information being provided for debug
purposes is not that helpful when debugging anyway.

--
Cheers,
Jeff
