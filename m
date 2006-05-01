Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWEAIZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWEAIZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 04:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWEAIZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 04:25:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6360 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750963AbWEAIZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 04:25:50 -0400
Date: Mon, 1 May 2006 01:20:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] kernel/sys.c: possible cleanups
Message-Id: <20060501012043.6bf2e013.akpm@osdl.org>
In-Reply-To: <1146470421.20760.36.camel@laptopd505.fenrus.org>
References: <20060501071134.GH3570@stusta.de>
	<20060501001803.48ac34df.akpm@osdl.org>
	<20060501073514.GQ3570@stusta.de>
	<1146469146.20760.31.camel@laptopd505.fenrus.org>
	<20060501004925.36e4dd21.akpm@osdl.org>
	<1146470421.20760.36.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> On Mon, 2006-05-01 at 00:49 -0700, Andrew Morton wrote:
> > Arjan van de Ven <arjan@infradead.org> wrote:
> > >
> > > > If removing exports requires a process, adding exports requires a 
> > >  > similar process.
> > > 
> > >  alternatively we should bite the bullet, and just stick those 900 on the
> > >  "we'll kill all these in 3 months" list, have a thing to disable them
> > >  now via a config option (so that people actually notice rather than just
> > >  having them in the depreciation file) and fix the 5 or 10 or so that
> > >  actually will be used soon in those 3 months.
> > > 
> > 
> > I'd instead suggest that we implement a new EXPORT_SYMBOL_UNEXPORT_SCHEDULED
> 
> EXPORT_UNUSED_SYMBOL() ? (with comment of date)

OK.

> (well you didn't apply the patch for that I sent you so I suppose you
> hate it ;)

err, memory fails me.  Wanna dig it out?

> 
> > (?) and use that.  Suitable compile-time and modprobe-time warnings would
> 
> compiletime warning is hard, because it would require changing
> prototype, which is a lot more churn, and I'll bet a lot of exports
> don't even have a prototype at all. modprobe time is easy. (middle
> ground would be depmod time; that's almost compile time I suppose but a
> lot easier, but might need modutils help)

modprobe-time printk is good.

> > be needed.  Put the unexport date in a comment at the
> > EXPORT_SYMBOL_UNEXPORT_SCHEDULED site or even in the modprobe-time warning
> > message, if that's convenient:
> > 
> > EXPORT_SYMBOL_UNEXPORT_SCHEDULED(foo, "Dec 2006");
> 
> comment is easy, putting a date in is really sucky since it grows the size of exports even more..
> (which means people pay even more export tax than they do today)

ok, whatever.
