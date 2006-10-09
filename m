Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWJIIes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWJIIes (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 04:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWJIIes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 04:34:48 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:54796 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932397AbWJIIer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 04:34:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sHOf54c+1EvAKUvIJLQyZe/aVfxeDuFTFdg99USp01jQ6HksvW73f9nCydPniM8f6gGTG6I6T6AkAf31NDE5z5ZVjuEsdtC3Kc6PiW4Tpb84YUNImKKlidevJd88VuljEPErDTRM7yKX3+LHOmEenKly4YuRGiW9CFBsnB8ZjH0=
Message-ID: <452A09A1.8040808@gmail.com>
Date: Mon, 09 Oct 2006 12:34:41 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Amit Choudhary <amit2030@gmail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, stable@kernel.org,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Subject: Re: [PATCH 2.6.19-rc1] drivers/media/dvb/bt8xx/dvb-bt8xx.c: check
 kmalloc() return value.
References: <20061008231034.e50118df.amit2030@gmail.com>
In-Reply-To: <20061008231034.e50118df.amit2030@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit Choudhary wrote:
> Description: Check the return value of kmalloc() in function frontend_init(), in file drivers/media/dvb/bt8xx/dvb-bt8xx.c.
> 
> Signed-off-by: Amit Choudhary <amit2030@gmail.com>
> 
> diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> index fb6c4cc..14e69a7 100644
> --- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> +++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> @@ -665,6 +665,10 @@ static void frontend_init(struct dvb_bt8
>  	case BTTV_BOARD_TWINHAN_DST:
>  		/*	DST is not a frontend driver !!!		*/
>  		state = (struct dst_state *) kmalloc(sizeof (struct dst_state), GFP_KERNEL);
> +		if (!state) {
> +			printk("dvb_bt8xx: No memory\n");
> +			break;
> +		}
>  		/*	Setup the Card					*/
>  		state->config = &dst_config;
>  		state->i2c = card->i2c_adapter;
> -


Signed-off-by: Manu Abraham <manu@linuxtv.org>



Thanks,
Manu
