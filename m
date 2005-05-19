Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVESG5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVESG5t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 02:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVESG5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 02:57:49 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:30080 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262421AbVESG5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 02:57:46 -0400
Message-ID: <428C3ABB.61B552E@tv-sign.ru>
Date: Thu, 19 May 2005 11:05:31 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, Mitchell Blank Jr <mitch@sfgoth.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Optimize sys_times for a single thread process
References: <428B09A6.DD188E8D@tv-sign.ru> <Pine.LNX.4.62.0505181503520.10958@graphe.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
>
> On Wed, 18 May 2005, Oleg Nesterov wrote:
>
> > Christoph Lameter wrote:
> > >
> > > +#ifdef CONFIG_SMP
> > > +		if (current == next_thread(current)) {
> > > +			/*
> > > +			 * Single thread case without the use of any locks.
> >
> > A nitpick, but wouldn't be it clearer to to use
> > thread_group_empty(current)?
>
> The thread ist needs to contain only one element which is current.
> thread_group_empty checks for no threads.

I think that thread_group_empty() means that there are no *other*
threads in the thread group, that means that we have only one thread.

In any case (p == next_thread(p)) == thread_group_empty(p).

But it is a very minor issue indeed, let's forget it.

Oleg.
