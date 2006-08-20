Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWHTTCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWHTTCg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 15:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWHTTCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 15:02:36 -0400
Received: from 1wt.eu ([62.212.114.60]:56592 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751154AbWHTTCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 15:02:36 -0400
Date: Sun, 20 Aug 2006 21:01:51 +0200
From: Willy Tarreau <w@1wt.eu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Solar Designer <solar@openwall.com>,
       Alex Riesen <fork0@users.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Message-ID: <20060820190151.GP602@1wt.eu>
References: <20060820003840.GA17249@openwall.com> <20060820100706.GB6003@steel.home> <20060820153037.GA20007@openwall.com> <1156097013.4051.14.camel@localhost.localdomain> <20060820181025.GN602@1wt.eu> <1156099006.4051.43.camel@localhost.localdomain> <20060820182137.GO602@1wt.eu> <1156099979.4051.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156099979.4051.45.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 07:52:59PM +0100, Alan Cox wrote:
> Ar Sul, 2006-08-20 am 20:21 +0200, ysgrifennodd Willy Tarreau:
> > Arjan proposed to add a __must_check on the set*uid() function in glibc.
> > I think that if killing the program is what makes you nervous, we could
> > at least print a warning in the kernel logs so that the admin of a machine
> > being abused has a chance to detect what's going on. Would you accept
> > something like this ?
> 
> That ratelimited doesn't sound unreasonable - you want to know its
> happening whatever the cause. You could do it with the kernel or with
> the audit daemon I guess.

Alan,

2.4 has no printk_ratelimit() function and I'm not sure it's worth adding
one for only this user. One could argue that once it's implemented, we can
uncomment some other warnings that are currently disabled due to lack of
ratelimit.

In this special case (set*uid), the only reason we might fail is because
kmem_cache_alloc(uid_cachep, SLAB_KERNEL) would return NULL. Do you think
it could intentionnally be tricked into failing, or that under OOM we might
bother about the excess of messages ?

If so I can backport the printk_ratelimit() function, I would just like an
advice on this.

Thanks,
Willy

