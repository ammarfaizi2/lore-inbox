Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267108AbRGPKMv>; Mon, 16 Jul 2001 06:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267159AbRGPKMm>; Mon, 16 Jul 2001 06:12:42 -0400
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:1032 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S267108AbRGPKMi>; Mon, 16 Jul 2001 06:12:38 -0400
Date: Mon, 16 Jul 2001 12:12:37 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Evan Parker <nave@stanford.edu>
cc: <linux-kernel@vger.kernel.org>, <mc@cs.stanford.edu>
Subject: Re: [CHECKER] free errors for 2.4.6 and 2.4.6ac2
Message-ID: <Pine.LNX.4.33.0107161210120.10060-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2001, Evan Parker wrote:

> 1	|	/home/eparker/tmp/linux/2.4.6/drivers/isdn/isdn_common.c/

> ---------------------------------------------------------
> [BUG] double free (then again, dev_kfree_skb does referece counting--maybe
> not a bug?)
> /home/eparker/tmp/linux/2.4.6/drivers/isdn/isdn_common.c:1978:isdn_writebuf_skb_stub: ERROR:FREE:1960:1978: Use-after-free of 'skb'!  set by 'kfree_skb':1960 [nbytes = 168]  [distance=36]
> 			skb_tmp = skb_realloc_headroom(skb, hl);
> 			printk(KERN_DEBUG "isdn_writebuf_skb_stub: reallocating headroom%s\n", skb_tmp ? "" : " failed");
> 			if (!skb_tmp) return -ENOMEM; /* 0 better? */
> 			ret = dev->drv[drvidx]->interface->writebuf_skb(drvidx, chan, ack, skb_tmp);
> 			if( ret > 0 ){
> Start --->
> 				dev_kfree_skb(skb);
> 
> 	... DELETED 12 lines ...
> 
> 			atomic_dec(&dev->v110use[idx]);
> 			/* For V.110 return unencoded data length */
> 			ret = v110_ret;
> 			/* if the complete frame was send we free the skb;
> 			   if not upper function will requeue the skb */
> Error --->
> 			if (ret == skb->len)
> 				dev_kfree_skb(skb);
> 		}
> 	} else

This is a false positive, since the two dev_kfree_skb() happen in mutually 
exclusive branches.

Thanks anyway,
--Kai

