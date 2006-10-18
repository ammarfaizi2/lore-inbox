Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422712AbWJRRVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422712AbWJRRVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422713AbWJRRVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:21:12 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:45476 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1422712AbWJRRVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:21:10 -0400
Date: Wed, 18 Oct 2006 21:21:03 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Prarit Bhargava <prarit@redhat.com>
Subject: Re: [RFC][PATCH] ->signal->tty locking
Message-ID: <20061018172103.GB2062@oleg>
References: <1160992420.22727.14.camel@taijtu> <20061017081018.GA115@oleg> <1161080221.3036.38.camel@taijtu> <20061017123307.GA209@oleg> <1161091781.24237.161.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161091781.24237.161.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17, Alan Cox wrote:
>
> Ar Maw, 2006-10-17 am 16:33 +0400, ysgrifennodd Oleg Nesterov:
> > I sent a patch,
> > 	http://marc.theaimsgroup.com/?l=linux-kernel&m=114268787415193
> > 
> > but it was ignored. Probably I should re-send it.
> 
> Definitely - we still see reports of tty slab scribbles

This patch can't fix anything, sorry for the confusion.

Yes, the 'if (new_sigh) {}' code in sys_unshare() is broken, but it is
never executed, because unshare_sighand() never populates new_sighp.

Probably it is better to just remove this code.

> > > Right, use tty_mutex when using the tty, use ->sighand when changing
> > > signal->tty.
> > 
> > I think that things like do_task_stat()/do_acct_process() do not need
> > global tty_mutex, they can use ->siglock.
> 
> Please keep the tty_mutex as it will protect against other stuff later.
> Once tty is a bit saner then someone brave can refcount it properly and
> that'll make it much prettier.

Oh, but it is silly to take the global tty_mutex in do_task_stat().
Why do we need it if ->siglock protects ->signal->tty ? We are only
reading the tty_struct, tty->driver can't go away ...

Oleg.

