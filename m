Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267930AbUGaKJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267930AbUGaKJP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 06:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267929AbUGaKJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 06:09:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:44551 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S267932AbUGaKJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 06:09:11 -0400
Date: Sat, 31 Jul 2004 12:01:23 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: greearb@candelatech.com, akpm@osdl.org, alan@redhat.com,
       jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Message-ID: <20040731100123.GB25772@alpha.home.local>
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au> <20040731083308.GA24496@alpha.home.local> <20040731093545.GB16881@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731093545.GB16881@gondor.apana.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 07:35:45PM +1000, Herbert Xu wrote:
> On Sat, Jul 31, 2004 at 10:33:08AM +0200, Willy Tarreau wrote:
> > 
> > So several reasons :
> >   - the change_mtu() function might be called at any time after driver
> >     initialization. I don't know at all if there are things to do to
> 
> See the sungem.c for a working implementation.

Indeed, I remember having read parts of it several times because it was
very clean. I agree that the first half of the function does the same
thing as the initialization code. What is more of a problem is the second
half which resets the card, because inserting resets in the tulip driver
is not trivial (at least to me). But perhaps it would be acceptable to
only implement the dev->mtu change when the device is not up.

> BTW I presume this is for the tulip driver? Does it actually use the
> mtu parameter for anything? It seems to just store it in dev->mtu and
> then promptly forgets about it.

It's for the tulip driver. Now, you're right, it doesn't use dev->mtu at
all (just noticed now) ! So this is fairly simpler, since I then assume
that the driver will work up to PKT_BUF_SZ - 14 or 18.

Ok, I have the hardware, you've convinced me. I'll try it.

Cheers,
Willy

