Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbVITJDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVITJDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 05:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVITJDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 05:03:05 -0400
Received: from relay.rost.ru ([80.254.111.11]:52632 "EHLO smtp.rost.ru")
	by vger.kernel.org with ESMTP id S964941AbVITJDE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 05:03:04 -0400
Date: Tue, 20 Sep 2005 13:02:52 +0400
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: colin <colin@realtek.com.tw>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PRINTK doesn't makes size smaller
Message-ID: <20050920090252.GC20363@pazke>
Mail-Followup-To: Vadim Lobanov <vlobanov@speakeasy.net>,
	colin <colin@realtek.com.tw>, linux-kernel@vger.kernel.org
References: <01bf01c5bdaa$9e8b81c0$106215ac@realtek.com.tw> <20050920063805.GB20363@pazke> <Pine.LNX.4.58.0509200047120.3173@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Pine.LNX.4.58.0509200047120.3173@shell2.speakeasy.net>
X-Uname: Linux 2.6.11-pazke i686
User-Agent: Mutt/1.5.9i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 263, 09 20, 2005 at 12:48:59AM -0700, Vadim Lobanov wrote:
> On Tue, 20 Sep 2005, Andrey Panin wrote:
> 
> > On 263, 09 20, 2005 at 02:14:55PM +0800, colin wrote:
> > >
> > > Hi there,
> > > I tried to make kernel with CONFIG_PRINTK off. I considered it should become
> > > smaller, but it didn't because it actually isn't an empty function, and
> > > there are many copies of it in vmlinux, not just one. Here is its
> > > definition:
> > >     static inline int printk(const char *s, ...) { return 0; }
> > >
> > > I change the definition to this and it can greatly reduce the size by about
> > > 5%:
> > >     #define printk(...) do {} while (0)
> > > However, this definition would lead to error in some situations. For
> > > example:
> > >     1. (printk)
> > >     2. ret = printk
> > >
> > > I hope someone could suggest a better definition of printk that can both
> > > make printk smaller and eliminate errors.
> >
> > What about the macro below ?
> >
> > #define printk(...) ({ do { } while(0); 0; })
> 
> So what does the do-while loop give us in the above case? In other
> words, why not just do the following...?

do-while loop eliminates "statement with no effect" warnings from gcc4.

> #define printk(...) ({ 0; })
> 

-- 
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net
