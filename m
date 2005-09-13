Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVIMFnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVIMFnI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 01:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVIMFnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 01:43:08 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:62884 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932317AbVIMFnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 01:43:07 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Lion Vollnhals <lion.vollnhals@web.de>
Subject: Re: [PATCH] use kzalloc instead of malloc+memset
Date: Tue, 13 Sep 2005 08:41:33 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200509130010.38483.lion.vollnhals@web.de> <200509130047.43301.lion.vollnhals@web.de>
In-Reply-To: <200509130047.43301.lion.vollnhals@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509130841.34104.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 September 2005 01:47, Lion Vollnhals wrote:
> On Tuesday 13 September 2005 00:10, Lion Vollnhals wrote:
> > This patch against 2.6.13-mm3 replaces malloc and memset with kzalloc in
> > drivers/base/class.c . 
> 
> The following patch converts further kmalllocs and memsets in drivers/base/* to kzallocs.
> 
> Please apply.
> 
> Signed-off-by: Lion Vollnhals <webmaster@schiggl.de>

> diff -Nurp 2.6.13-mm3/drivers/base/platform.c 2.6.13-mm3-changed/drivers/base/platform.c
> --- 2.6.13-mm3/drivers/base/platform.c	2005-09-12 23:42:47.000000000 +0200
> +++ 2.6.13-mm3-changed/drivers/base/platform.c	2005-09-13 00:23:43.000000000 +0200
> @@ -225,13 +225,12 @@ struct platform_device *platform_device_
>  	struct platform_object *pobj;
>  	int retval;
>  
> -	pobj = kmalloc(sizeof(struct platform_object) + sizeof(struct resource) * num, GFP_KERNEL);
> +	pobj = kzalloc(sizeof(struct platform_object) + sizeof(struct resource) * num, GFP_KERNEL);
>  	if (!pobj) {
>  		retval = -ENOMEM;
>  		goto error;
>  	}
>  
> -	memset(pobj, 0, sizeof(*pobj));

Was this a bug or did you just introduced one?
--
vda
