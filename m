Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTLDVHG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 16:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTLDVHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 16:07:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:5269 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263568AbTLDVHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 16:07:02 -0500
Date: Thu, 4 Dec 2003 13:06:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reproducable OOPS with MD RAID-5 on 2.6.0-test11
In-Reply-To: <E1AS0TP-0003ga-00@gondolin.me.apana.org.au>
Message-ID: <Pine.LNX.4.58.0312041304120.6638@home.osdl.org>
References: <E1AS0TP-0003ga-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Dec 2003, Herbert Xu wrote:
>
> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > Really? This actually makes a difference for you? I don't see why it
> > should matter: even if the sector offsets would overflow, why would that
> > cause _oopses_?
>
> Apart from the printk, he also changed dev_info_t which means that any
> place that uses it will be using the 64-bit type now.

I wasn't looking at the printk, I was looking at those 64-bit types. My
argument was that while the small size is incorrect, it shouldn't cause
system stability issues per se - it should just cause IO to potentially
"wrap around" and go to the wrong place on disk.

Which is very serious in itself, of course - but what surprised me was the
quoted system stability things.

Anyway, that patch only matters for the LINEAR MD module, and only for
2TB+ aggregate disks at that, so it doesn't explain any of the other
problematic behaviour. Something else is up.

		Linus
