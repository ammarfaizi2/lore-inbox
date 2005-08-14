Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbVHNKfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbVHNKfr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 06:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVHNKfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 06:35:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29862 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932480AbVHNKfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 06:35:47 -0400
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Arjan van de Ven <arjan@infradead.org>
To: hyoshiok@miraclelinux.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <98df96d305081403222e75b232@mail.gmail.com>
References: <98df96d305081402164ce52f8@mail.gmail.com>
	 <1124012489.3222.13.camel@laptopd505.fenrus.org>
	 <98df96d305081403222e75b232@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 14 Aug 2005 12:35:43 +0200
Message-Id: <1124015743.3222.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-14 at 19:22 +0900, Hiro Yoshioka wrote:
> Thanks for your comments.
> 
> On 8/14/05, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Sun, 2005-08-14 at 18:16 +0900, Hiro Yoshioka wrote:
> > > Hi,
> > >
> > > The following is a patch to reduce a cache pollution
> > > of __copy_from_user_ll().
> > >
> > > When I run simple iozone benchmark to find a performance bottleneck of
> > > the linux kernel, I found that __copy_from_user_ll() spent CPU cycle
> > > most and it did many cache misses.
> > 
> > 
> > however... you copy something from userspace... aren't you going to USE
> > it? The non-termoral versions actually throw the data out of the
> > cache... so while this part might be nice, you pay BIG elsewhere....
> 
> The oprofile data does not give an evidence that we pay BIG elsewhere.


the problem is that the pay elsewhere is far more spread out, but not
less. At least generally....

I can see the point of a copy_from_user_nocache() or something, for
those cases where we *know* we are not going to use the copied data in
the cpu (but say, only do DMA).
But that should be explicit, not implicit, since the general case will
be that the kernel WILL use the data. And if that's the case your change
is a loss.... (just harder to see because the cost is spread out)

