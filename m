Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132323AbRCZFJB>; Mon, 26 Mar 2001 00:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132324AbRCZFIv>; Mon, 26 Mar 2001 00:08:51 -0500
Received: from samar.sasken.com ([164.164.56.2]:31457 "EHLO samar.sasi.com")
	by vger.kernel.org with ESMTP id <S132323AbRCZFIi>;
	Mon, 26 Mar 2001 00:08:38 -0500
Date: Mon, 26 Mar 2001 16:06:19 +0530 (IST)
From: Manoj Sontakke <manojs@sasken.com>
To: Oleg Drokin <green@dredd.crimea.edu>
cc: linux-kernel@vger.kernel.org, davem@redhat.com, kuznet@ms2.inr.ac.ru
Subject: Re: IP layer bug?
In-Reply-To: <20010325005731.A5243@dredd.crimea.edu>
Message-ID: <Pine.LNX.4.21.0103261555250.25563-100000@pcc65.sasi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
On Sun, 25 Mar 2001, Oleg Drokin wrote:

> Hello!
> 
>    2.4.x kernel. have not tried 2.2
>    I just found somethig, I believe is kernel bug.
>    I am working with usbnet.c driver, which stores some of its
>    internal state in sk_buff.cb area. But once such skb passed to
>    upper layer with netif_rx, net/ipv4/ip_input.c reuses content of cb
>    (line #345), 
ip_options_compile() when called with first argument NULL resets cb to 0.
This is probably because the cb is supposed to be used IP and above. The
underlying layer(link and phy) could be anything so where from the
ip_options should start will depend upon the underlying layer.

>    and all packets that should go outside of beyond hosts
>    we have direct routes to, fails, because we think, they have source routing
>    enabled.
>    For now I workarounded it with filling skb->cb with zeroes before
>    netif_rx(), but I believe it is a kludge and networking layer should be fixed
>    instead.
> 
>    Thank you.
> 
> Bye,
>     Oleg
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Regards,
Manoj Sontakke

