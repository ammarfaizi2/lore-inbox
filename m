Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVIRPnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVIRPnI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 11:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVIRPnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 11:43:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56228 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932106AbVIRPnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 11:43:06 -0400
Date: Sun, 18 Sep 2005 17:43:01 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce setup_timer() helper
Message-ID: <20050918154301.GA9088@devserv.devel.redhat.com>
References: <432D70C8.EF7B0438@tv-sign.ru> <1127056369.30256.4.camel@localhost.localdomain> <432D8CF8.C14C48A0@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432D8CF8.C14C48A0@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Sep 18, 2005 at 07:51:20PM +0400, Oleg Nesterov wrote:
> Arjan van de Ven wrote:
> > 
> > >                               unsigned long data)
> > > +{
> > > +     timer->function = function;
> > > +     timer->data = data;
> > > +     init_timer(timer);
> > > +}
> > 
> > are you sure you want to do this in this order???
> > I'd expect the init_timer to be first...
> 
> I think it does not matter from correctness point of view.

right now.. it probably doesn't.
However I think conceptually, touching a timer before init_timer() is just
wrong. For one... it would prevent init_timer() from being able to use
memset() on the timer. Which it doesn't today but it's the kind of thing
that you don't want to prevent happening in the future.

> 	setup_timer(timer, expr1(), expr2())
> 
> it is better to initialize ->func and ->data first, otherwise
> the compiler should save the results from expr{1,2}, then call
> init_timer(), then copy these results to *timer.

I don't see how that is different.... 
