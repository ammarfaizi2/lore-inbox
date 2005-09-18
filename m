Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVIRQKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVIRQKK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 12:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVIRQKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 12:10:10 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:33948 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932109AbVIRQKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 12:10:09 -0400
Message-ID: <432D9432.5C5B64D6@tv-sign.ru>
Date: Sun, 18 Sep 2005 20:22:10 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce setup_timer() helper
References: <432D70C8.EF7B0438@tv-sign.ru> <1127056369.30256.4.camel@localhost.localdomain> <432D8CF8.C14C48A0@tv-sign.ru> <20050918154301.GA9088@devserv.devel.redhat.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> On Sun, Sep 18, 2005 at 07:51:20PM +0400, Oleg Nesterov wrote:
> >
> > I think it does not matter from correctness point of view.
> 
> right now.. it probably doesn't.
> However I think conceptually, touching a timer before init_timer() is just
> wrong.

It is indeed wrong outside timer.{h,c}, but setup_timer() is a
part of timers subsystem, so I hope it's ok.

> For one... it would prevent init_timer() from being able to use
> memset() on the timer. Which it doesn't today but it's the kind of thing
> that you don't want to prevent happening in the future.

Yes, in that case we will have to change setup_timer(). But I
doubt this will happen. init_timer() only needs to set timer's
->base, and to ensure the timer is not pending.

> 
> >       setup_timer(timer, expr1(), expr2())
> >
> > it is better to initialize ->func and ->data first, otherwise
> > the compiler should save the results from expr{1,2}, then call
> > init_timer(), then copy these results to *timer.
> 
> I don't see how that is different....

I think this can save a couple of cpu cycles. The init_timer()
is not inline, gcc can't reorder exprx() and init_timer() calls.

Ok, I do not want to persist very much, I can resend this patch.

Andrew, should I?

Oleg.
