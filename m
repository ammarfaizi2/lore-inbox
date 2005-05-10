Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVEJVCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVEJVCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVEJU7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:59:38 -0400
Received: from mail.dif.dk ([193.138.115.101]:57731 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261797AbVEJU6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:58:50 -0400
Date: Tue, 10 May 2005 23:02:42 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, Rui Prior <rprior@inescn.pt>, akpm@osdl.org
Subject: Re: [PATCH] atm/nicstar: remove a bunch of pointless casts of NULL
In-Reply-To: <200505110058.12932.adobriyan@mail.ru>
Message-ID: <Pine.LNX.4.62.0505102259330.2386@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0505102203170.2386@dragon.hyggekrogen.localhost>
 <200505110058.12932.adobriyan@mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2005, Alexey Dobriyan wrote:

> On Wednesday 11 May 2005 00:06, Jesper Juhl wrote:
> > It doesn't make sense to cast NULL. This patch removes the pointless casts 
> > from drivers/atm/nicstar.c
> 
> > --- linux-2.6.12-rc3-mm3-orig/drivers/atm/nicstar.c
> > +++ linux-2.6.12-rc3-mm3/drivers/atm/nicstar.c
> 
> >     scq = (scq_info *) kmalloc(sizeof(scq_info), GFP_KERNEL);
>             ^^^^^^^^^^^^
> > -   if (scq == (scq_info *) NULL)
> > -      return (scq_info *) NULL;
> > +   if (scq == NULL)
> > +      return NULL;
> 
> >     scq->skb = (struct sk_buff **) kmalloc(sizeof(struct sk_buff *) *
>                  ^^^^^^^^^^^^^^^^^^^
> >                                            (size / NS_SCQE_SIZE), GFP_KERNEL);
> > -   if (scq->skb == (struct sk_buff **) NULL)
> > +   if (scq->skb == NULL)
> 
> These are pointless too.
> 
True, but I wanted the patch to only do a single well defined thing. I was 
not 100% sure what the reaction to such a patch would be, so I didn't want 
to mix other things in as well...  Actually, thinking about it a bit; will 
gcc ever generate different code for NULL pointers cast to different 
types? As far as I know it won't, but if it will, then the casts could 
actually make sense.

I can submit a second patch to remove the casts of kmalloc return values if 
wanted.

-- 
Jesper 


