Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbULQPao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbULQPao (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 10:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbULQPao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 10:30:44 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:33410 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261303AbULQPaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 10:30:35 -0500
Message-ID: <41C2FB9A.9030305@tmr.com>
Date: Fri, 17 Dec 2004 10:30:34 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Gerd Knorr <kraxel@bytesex.org>, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] bttv-cards.c: #if 0 function bttv_reset_audio
References: <20041216221805.GU12937@stusta.de>
In-Reply-To: <20041216221805.GU12937@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The function bttv_reset_audio in drivers/media/video/bttv-cards.c is
> completely unused.

Looking at the comments and some old posts on the topic, are you sure 
this is the right fix? It is uncalled, and has been since 2.6.0 (oldest 
thing I have handy), but I think the actual bug may be that someone 
forget to call it, possibly from bttv_init_card2?

It would appear to not be needed because a reset clears it, but in the 
event that resume starts working, it might be useful.

> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.10-rc3-mm1-full/drivers/media/video/bttv-cards.c.old	2004-12-16 22:20:07.000000000 +0100
> +++ linux-2.6.10-rc3-mm1-full/drivers/media/video/bttv-cards.c	2004-12-16 22:20:30.000000000 +0100
> @@ -2498,7 +2498,7 @@
>  }
>  
>  /* ----------------------------------------------------------------------- */
> -
> +#if 0
>  void bttv_reset_audio(struct bttv *btv)
>  {
>  	/*
> @@ -2519,6 +2519,7 @@
>  	udelay(10);
>  	btwrite(     0, 0x058);
>  }
> +#endif  /*  0  */
>  
>  /* initialization part one -- before registering i2c bus */
>  void __devinit bttv_init_card1(struct bttv *btv)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
