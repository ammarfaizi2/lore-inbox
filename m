Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbTELLxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 07:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbTELLxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 07:53:03 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7821 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261918AbTELLxA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 07:53:00 -0400
Date: Mon, 12 May 2003 14:05:26 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Parse new-style boot parameters just before initcalls 
In-Reply-To: <20030512040100.C7B972C0D7@lists.samba.org>
Message-ID: <Pine.SOL.4.30.0305121401560.7978-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 May 2003, Rusty Russell wrote:

> In message <Pine.SOL.4.30.0305101735410.20755-100000@mion.elka.pw.edu.pl> you w
> rite:
> >
> > Hi,
> >
> > I've redone this patch. I've tested it and works okay for me.
> > It is as minimal as possible and I hope it can go in 2.5 soon.
>
> Only one request, that you push this slightly more, and make
> setup_arch() call parse_early_args().  Does that break something?

Okay.
Shouldn't break anything, but it requires updating setup.c for each arch.

> That way the arch-specific parsing in setup_arch() can be converted to
> __setup (but doesn't need to be: archs can take their time).
>
> ie. we already have two-stage parsing, it'd be nice not to make it
> three.

Yep.

> Minor nitpick:
>
> > @@ -241,7 +279,7 @@ static int __init unknown_bootoption(cha
> >  		val[-1] = '=';
> >
> >  	/* Handle obsolete-style parameters */
> > -	if (obsolete_checksetup(param))
> > +	if (obsolete_test_checksetup(param))
> >  		return 0;
> >
>
> Change comment to /* Ignore early params: already done in
> parse_early_args */ or something, and maybe rename
> obsolete_test_checksetup() to is_early_setup().

Okay.

> Thanks!
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

