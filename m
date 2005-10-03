Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVJCJsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVJCJsa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 05:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVJCJsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 05:48:30 -0400
Received: from host-84-9-203-39.bulldogdsl.com ([84.9.203.39]:26757 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932209AbVJCJs3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 05:48:29 -0400
Date: Mon, 3 Oct 2005 10:48:03 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] release_resource() check for NULL resource
Message-ID: <20051003094803.GC3500@home.fluff.org>
References: <20051002170318.GA22074@home.fluff.org> <20051002103922.34dd287d.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051002103922.34dd287d.rdunlap@xenotime.net>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 10:39:22AM -0700, Randy.Dunlap wrote:
> On Sun, 2 Oct 2005 18:03:18 +0100 Ben Dooks wrote:
> 
> > If release_resource() is passed a NULL resource
> > the kernel will OOPS.
> 
> does this actually happen?  you are fixing a real oops?
> if so, what driver caused it?

I was developing a couple of new drivers, and found
that this does not behave like kfree() which does check
for NULL paramemters. I belive it would be helpful if
functions like this followed the example of kfree().
 
> btw, please use diff -p also (as in Documentation/SubmittingPatches)
> 
> 
> > Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> > 
> > diff -urN -X ../dontdiff linux-2.6.14-rc3/kernel/resource.c linux-2.6.14-rc3-bjd1/kernel/resource.c
> > --- linux-2.6.14-rc3/kernel/resource.c	2005-10-02 12:58:03.000000000 +0100
> > +++ linux-2.6.14-rc3-bjd1/kernel/resource.c	2005-10-02 17:58:09.000000000 +0100
> > @@ -181,6 +181,9 @@
> >  {
> >  	struct resource *tmp, **p;
> >  
> > +	if (!old)
> > +		return 0;
> > +
> >  	p = &old->parent->child;
> >  	for (;;) {
> >  		tmp = *p;

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
