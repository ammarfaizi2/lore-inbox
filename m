Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266146AbUFUHmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266146AbUFUHmp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 03:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUFUHmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 03:42:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:4028 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266155AbUFUHko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 03:40:44 -0400
Date: Mon, 21 Jun 2004 00:39:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dan Aloni <da-x@colinux.org>
Cc: da-x@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing NULL check in drivers/char/n_tty.c
Message-Id: <20040621003944.48f4b4be.akpm@osdl.org>
In-Reply-To: <20040621073644.GA10781@callisto.yi.org>
References: <20040621063845.GA6379@callisto.yi.org>
	<20040620235824.5407bc4c.akpm@osdl.org>
	<20040621073644.GA10781@callisto.yi.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni <da-x@gmx.net> wrote:
>
> On Sun, Jun 20, 2004 at 11:58:24PM -0700, Andrew Morton wrote:
> > Dan Aloni <da-x@gmx.net> wrote:
> > >
> > > The rest of the kernel treats tty->driver->chars_in_buffer as a possible
> > >  NULL. This patch changes normal_poll() to be consistent with the rest of
> > >  the code.
> > 
> > It would be better to change the rest of the kernel - remove the tests.
> > 
> > If any driver fails to implement ->chars_in_buffer() then we get a nice
> > oops which tells us that driver needs a stub handler.
> 
> Are you sure that it won't affect the logic in tty_wait_until_sent() 
> drastically? It acts quite differently when ->chars_in_buffer == NULL.

I did a quick grep and it appears that all drivers have set ->chars_in_buffer().

I suspect there are no drivers which fail to set chars_in_buffer. 
Otherwise normal_poll() would have been oopsing in 2.4, 2.5 and 2.6?

