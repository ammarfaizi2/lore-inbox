Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVEJU6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVEJU6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVEJU6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:58:51 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:16679 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261796AbVEJUyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:54:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=WMaAJlISL24DAyUmbC3E8gWxLcdg+SMWQN2gcMW4/jro1EOfsa8CNhPaOMYKeWrxfTp2QOngSRqgi6C0mMYT9C+VO3vueGkV+NkxHKEfvjmIB3hIs8xYC3j4Et4x3if2VAY0qML1dEEDVJCd/zj+be6rNa0Rw6+KRYPcX+gIuAE=
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH] atm/nicstar: remove a bunch of pointless casts of NULL
Date: Wed, 11 May 2005 00:58:12 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Rui Prior <rprior@inescn.pt>, akpm@osdl.org
References: <Pine.LNX.4.62.0505102203170.2386@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0505102203170.2386@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505110058.12932.adobriyan@mail.ru>
From: Alexey Dobriyan <adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 May 2005 00:06, Jesper Juhl wrote:
> It doesn't make sense to cast NULL. This patch removes the pointless casts 
> from drivers/atm/nicstar.c

> --- linux-2.6.12-rc3-mm3-orig/drivers/atm/nicstar.c
> +++ linux-2.6.12-rc3-mm3/drivers/atm/nicstar.c

>     scq = (scq_info *) kmalloc(sizeof(scq_info), GFP_KERNEL);
            ^^^^^^^^^^^^
> -   if (scq == (scq_info *) NULL)
> -      return (scq_info *) NULL;
> +   if (scq == NULL)
> +      return NULL;

>     scq->skb = (struct sk_buff **) kmalloc(sizeof(struct sk_buff *) *
                 ^^^^^^^^^^^^^^^^^^^
>                                            (size / NS_SCQE_SIZE), GFP_KERNEL);
> -   if (scq->skb == (struct sk_buff **) NULL)
> +   if (scq->skb == NULL)

These are pointless too.
