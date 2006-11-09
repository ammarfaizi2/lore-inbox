Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424071AbWKIQma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424071AbWKIQma (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 11:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424106AbWKIQm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 11:42:29 -0500
Received: from kurby.webscope.com ([204.141.84.54]:14820 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1424104AbWKIQm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 11:42:28 -0500
Message-ID: <45535A16.9060706@linuxtv.org>
Date: Thu, 09 Nov 2006 11:40:54 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Subject: Re: [v4l-dvb-maintainer] [PATCH] flexcop-usb.c: fix "&& 0xff" typos
 and	...
References: <20061108222527.GF4972@martell.zuzino.mipt.ru>
In-Reply-To: <20061108222527.GF4972@martell.zuzino.mipt.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> .. fix debug printk. Why, oh why, one would want to do
> 
> 	(u16 & 0xff) << 8
> 
> and print it with %02x format?
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

I spoke to Patrick in irc and confirmed the fix...

Acked-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

> ---
> 
>  drivers/media/dvb/b2c2/flexcop-usb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/media/dvb/b2c2/flexcop-usb.c
> +++ b/drivers/media/dvb/b2c2/flexcop-usb.c
> @@ -246,7 +246,7 @@ static int flexcop_usb_i2c_req(struct fl
>  	wIndex = (chipaddr << 8 ) | addr;
>  
>  	deb_i2c("i2c %2d: %02x %02x %02x %02x %02x %02x\n",func,request_type,req,
> -			((wValue && 0xff) << 8),wValue >> 8,((wIndex && 0xff) << 8),wIndex >> 8);
> +		wValue & 0xff, wValue >> 8, wIndex & 0xff, wIndex >> 8);
>  
>  	len = usb_control_msg(fc_usb->udev,pipe,
>  			req,
> 
> 
> _______________________________________________
> v4l-dvb-maintainer mailing list
> v4l-dvb-maintainer@linuxtv.org
> http://www.linuxtv.org/cgi-bin/mailman/listinfo/v4l-dvb-maintainer


-- 
Michael Krufky

