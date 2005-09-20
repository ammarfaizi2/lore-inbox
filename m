Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbVITHtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbVITHtA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbVITHtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:49:00 -0400
Received: from mail24.sea5.speakeasy.net ([69.17.117.26]:14250 "EHLO
	mail24.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964906AbVITHs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:48:59 -0400
Date: Tue, 20 Sep 2005 00:48:59 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Andrey Panin <pazke@donpac.ru>
cc: colin <colin@realtek.com.tw>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PRINTK doesn't makes size smaller
In-Reply-To: <20050920063805.GB20363@pazke>
Message-ID: <Pine.LNX.4.58.0509200047120.3173@shell2.speakeasy.net>
References: <01bf01c5bdaa$9e8b81c0$106215ac@realtek.com.tw> <20050920063805.GB20363@pazke>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2005, Andrey Panin wrote:

> On 263, 09 20, 2005 at 02:14:55PM +0800, colin wrote:
> >
> > Hi there,
> > I tried to make kernel with CONFIG_PRINTK off. I considered it should become
> > smaller, but it didn't because it actually isn't an empty function, and
> > there are many copies of it in vmlinux, not just one. Here is its
> > definition:
> >     static inline int printk(const char *s, ...) { return 0; }
> >
> > I change the definition to this and it can greatly reduce the size by about
> > 5%:
> >     #define printk(...) do {} while (0)
> > However, this definition would lead to error in some situations. For
> > example:
> >     1. (printk)
> >     2. ret = printk
> >
> > I hope someone could suggest a better definition of printk that can both
> > make printk smaller and eliminate errors.
>
> What about the macro below ?
>
> #define printk(...) ({ do { } while(0); 0; })

So what does the do-while loop give us in the above case? In other
words, why not just do the following...?

#define printk(...) ({ 0; })

-VadimL
