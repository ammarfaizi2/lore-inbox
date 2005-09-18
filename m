Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVIRPjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVIRPjP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 11:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbVIRPjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 11:39:14 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:51353 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932105AbVIRPjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 11:39:14 -0400
Message-ID: <432D8CF8.C14C48A0@tv-sign.ru>
Date: Sun, 18 Sep 2005 19:51:20 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: arjanv@redhat.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce setup_timer() helper
References: <432D70C8.EF7B0438@tv-sign.ru> <1127056369.30256.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> >                               unsigned long data)
> > +{
> > +     timer->function = function;
> > +     timer->data = data;
> > +     init_timer(timer);
> > +}
> 
> are you sure you want to do this in this order???
> I'd expect the init_timer to be first...

I think it does not matter from correctness point of view.

But if we have:

	setup_timer(timer, expr1(), expr2())

it is better to initialize ->func and ->data first, otherwise
the compiler should save the results from expr{1,2}, then call
init_timer(), then copy these results to *timer.

Oleg.
