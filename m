Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVIZRZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVIZRZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 13:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVIZRZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 13:25:59 -0400
Received: from xenotime.net ([66.160.160.81]:4224 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932420AbVIZRZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 13:25:59 -0400
Date: Mon, 26 Sep 2005 10:25:58 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Valdis.Kletnieks@vt.edu
cc: Ed L Cashin <ecashin@coraid.com>, linux-kernel@vger.kernel.org,
       Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.14-rc2] aoe [1/2]: explicitly set minimum packet
 length to ETH_ZLEN 
In-Reply-To: <200509261710.j8QHAkE7008871@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0509261023330.11898@shark.he.net>
References: <87oe6fhj8y.fsf@coraid.com>            <87hdc7ept7.fsf@coraid.com>
 <200509261710.j8QHAkE7008871@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005 Valdis.Kletnieks@vt.edu wrote:
> On Mon, 26 Sep 2005 12:50:28 EDT, Ed L Cashin said:
> > "Ed L. Cashin" <ecashin@coraid.com> writes:
> >
> > ...
> > > Explicitly set the minimum packet length to ETH_ZLEN.
> > >
> > > Index: 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c
> > > ===================================================================
> > > --- 2.6.14-rc2-aoe.orig/drivers/block/aoe/aoecmd.c	2005-09-26 12:20:34.000000000 -0400
> > > +++ 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c	2005-09-26 12:27:49.000000000 -0400
> > > @@ -20,6 +20,9 @@
> > >  {
> > >  	struct sk_buff *skb;
> > >
> > > +	if (len < ETH_ZLEN)
> > > +		len = ETH_ZLEN;
> > > +
> > >  	skb = alloc_skb(len, GFP_ATOMIC);
> >
> > This change fixes some strange problems observed on a system that was
> > using the e1000 network driver.  Is the network driver supposed to
> > ensure that ethernet packets are up to spec, at least 60 bytes long?
>
> I haven't chased through the code in detail - will this change ensure that
> all ETH_ZLEN bytes are initialized?  We had a bunch of drivers a few years
> ago that set the length to the legal min, but then only copied some smaller
> number of bytes in, resulting in leakage of kernel memory contents....

Good point.

On Ed's other question (which I have already trashed -- sorry),
I am familiar with some NICs that automatically pad packets to
ensure min packet size packets, and they know to do so with
a safe data pattern.  However, it's been a few years since I
worked on NIC drivers, so I don't know the current state of
affairs.

-- 
~Randy
