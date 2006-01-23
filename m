Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWAWFsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWAWFsq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 00:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWAWFsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 00:48:46 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:22376 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964812AbWAWFsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 00:48:45 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Guillemot joystick not working since 2.6.14
Date: Mon, 23 Jan 2006 00:48:42 -0500
User-Agent: KMail/1.9.1
Cc: Marek Va?ut <marek.vasut@gmail.com>, linux-kernel@vger.kernel.org
References: <200601221250.26792.marek.vasut@gmail.com> <20060122195550.GA19983@mipter.zuzino.mipt.ru>
In-Reply-To: <20060122195550.GA19983@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601230048.43360.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 January 2006 14:55, Alexey Dobriyan wrote:
> On Sun, Jan 22, 2006 at 12:50:26PM +0100, Marek Va?ut wrote:
> > I found a problem with guillemot "force feedback joystick". It?s not working
> > since 2.6.13.2-mm3. 2.6.14.2 wasn?t working too. 2.6.15-mm2 is the same. When
> > I plug it in, it prints "configuration #1 chosen from 1 choice" "registered
> > new driver iforce" and >"iforce: probe of 4-2:1.0 failed with error -12"<
> > It was working well on 2.6.13.1, but now it doesnt. I am not able to debug the 
> > kernel. Could you please fix this or tell me what am I doing wrong? Thanks.
> 
> Please try this patch
> 
> --- a/drivers/input/joystick/iforce/iforce-main.c
> +++ b/drivers/input/joystick/iforce/iforce-main.c
> @@ -345,7 +345,7 @@ int iforce_init_device(struct iforce *if
>  	int i;
>  
>  	input_dev = input_allocate_device();
> -	if (input_dev)
> +	if (!input_dev)
>  		return -ENOMEM;
>  
>  	init_waitqueue_head(&iforce->wait);
> 

Doh! Could you please add your signoff so I'd add it to the input tree?

Anyway, dynalloc went in 2.6.15 so something else is amiss...

-- 
Dmitry
