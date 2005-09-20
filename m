Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbVITPlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbVITPlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbVITPlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:41:51 -0400
Received: from mail23.sea5.speakeasy.net ([69.17.117.25]:18097 "EHLO
	mail23.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965049AbVITPlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:41:51 -0400
Date: Tue, 20 Sep 2005 08:41:48 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Andrey Panin <pazke@donpac.ru>
cc: colin <colin@realtek.com.tw>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PRINTK doesn't makes size smaller
In-Reply-To: <20050920090252.GC20363@pazke>
Message-ID: <Pine.LNX.4.58.0509200839550.29585@shell3.speakeasy.net>
References: <01bf01c5bdaa$9e8b81c0$106215ac@realtek.com.tw> <20050920063805.GB20363@pazke>
 <Pine.LNX.4.58.0509200047120.3173@shell2.speakeasy.net> <20050920090252.GC20363@pazke>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2005, Andrey Panin wrote:

> On 263, 09 20, 2005 at 12:48:59AM -0700, Vadim Lobanov wrote:
> > On Tue, 20 Sep 2005, Andrey Panin wrote:
> >
> > > On 263, 09 20, 2005 at 02:14:55PM +0800, colin wrote:
> > > >
> > > > Hi there,
> > > > I tried to make kernel with CONFIG_PRINTK off. I considered it should become
> > > > smaller, but it didn't because it actually isn't an empty function, and
> > > > there are many copies of it in vmlinux, not just one. Here is its
> > > > definition:
> > > >     static inline int printk(const char *s, ...) { return 0; }
> > > >
> > > > I change the definition to this and it can greatly reduce the size by about
> > > > 5%:
> > > >     #define printk(...) do {} while (0)
> > > > However, this definition would lead to error in some situations. For
> > > > example:
> > > >     1. (printk)
> > > >     2. ret = printk
> > > >
> > > > I hope someone could suggest a better definition of printk that can both
> > > > make printk smaller and eliminate errors.
> > >
> > > What about the macro below ?
> > >
> > > #define printk(...) ({ do { } while(0); 0; })
> >
> > So what does the do-while loop give us in the above case? In other
> > words, why not just do the following...?
>
> do-while loop eliminates "statement with no effect" warnings from gcc4.
>
> > #define printk(...) ({ 0; })
> >

Funky: gcc3.3.4 seems to like it just fine. I am rather curious why gcc4
has different semantics in this case. But that is probably off-topic for
this list...

In either case, as Andrew Morton pointed out, function invokations as
arguments don't get expanded out in the case of it being a macro, so no
dice.

> --
> Andrey Panin		| Linux and UNIX system administrator
> pazke@donpac.ru		| PGP key: wwwkeys.pgp.net
>

-VadimL
