Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317814AbSHDMyp>; Sun, 4 Aug 2002 08:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317833AbSHDMyp>; Sun, 4 Aug 2002 08:54:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:50423 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317814AbSHDMyo>; Sun, 4 Aug 2002 08:54:44 -0400
Subject: Re: [PATCH] 2.4.19 warnings cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <m3znw3k8qq.fsf@defiant.pm.waw.pl>
References: <m3znw3k8qq.fsf@defiant.pm.waw.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Aug 2002 15:16:23 +0100
Message-Id: <1028470583.14196.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux/drivers/net/ppp_generic.c.orig	Sat Aug  3 17:13:58 2002
> +++ linux/drivers/net/ppp_generic.c	Sat Aug  3 19:11:54 2002
> @@ -378,7 +378,7 @@
>  {
>  	struct ppp_file *pf = file->private_data;
>  	DECLARE_WAITQUEUE(wait, current);
> -	ssize_t ret;
> +	ssize_t ret = 0; /* suppress compiler warning */
>  	struct sk_buff *skb = 0;
>  
>  	if (pf == 0)


Please don't do this. I'm regularly having to fix drivers where people
hid bugs this way rather than working out if it was a real problem. If
it is genuinely a compiler corner case then let the gcc folks know and
comment it but leave the warning.

