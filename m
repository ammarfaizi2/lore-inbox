Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130765AbRBLKWB>; Mon, 12 Feb 2001 05:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130870AbRBLKVv>; Mon, 12 Feb 2001 05:21:51 -0500
Received: from [194.213.32.137] ([194.213.32.137]:8452 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130765AbRBLKVU>;
	Mon, 12 Feb 2001 05:21:20 -0500
Message-ID: <20010212002354.M3748@bug.ucw.cz>
Date: Mon, 12 Feb 2001 00:23:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: dag@brattli.net, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-irda@pasta.cs.uit.no
Subject: Re: [patch] patch-2.4.1-irda4 (irlap speed)
In-Reply-To: <200102082221.WAA90927@tepid.osl.fast.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200102082221.WAA90927@tepid.osl.fast.no>; from Dag Brattli on Thu, Feb 08, 2001 at 10:21:27PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> --- linux-2.4.1-patch/include/net/irda/irda_device.h	Tue Jan 30 08:24:54 2001
> +++ linux-2.4.1-irda-patch/include/net/irda/irda_device.h	Thu Feb  8 22:34:07 2001
> @@ -218,29 +218,54 @@ extern inline __u16 irda_get_mtt(struct 
>  #endif
>  
>  /*
> - * Function irda_get_speed (skb)
> + * Function irda_get_next_speed (skb)
>   *
> - *    Extact the speed this frame should be sent out with from the skb
> + *    Extract the speed that should be set *after* this frame from the skb
>   *
> + * Note : return -1 for user space frames
>   */
> -#define irda_get_speed(skb) (	                                        \
> +#define irda_get_next_speed(skb) (	                                        \
>  	(((struct irda_skb_cb*) skb->cb)->magic == LAP_MAGIC) ? 	\
> -                  ((struct irda_skb_cb *)(skb->cb))->speed : 9600 	\
> +                  ((struct irda_skb_cb *)(skb->cb))->next_speed : -1 	\
>  )
>  
>  #if 0
> -extern inline __u32 irda_get_speed(struct sk_buff *skb)
> +extern inline __u32 irda_get_next_speed(struct sk_buff *skb)


This is kernel code, you do not have to use __u32 here. Use u32
instead (it looks much better).
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
