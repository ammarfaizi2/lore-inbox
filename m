Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWHTTMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWHTTMz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 15:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWHTTMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 15:12:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8142 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751160AbWHTTMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 15:12:54 -0400
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy Tarreau <w@1wt.eu>
Cc: Solar Designer <solar@openwall.com>,
       Alex Riesen <fork0@users.sourceforge.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060820190151.GP602@1wt.eu>
References: <20060820003840.GA17249@openwall.com>
	 <20060820100706.GB6003@steel.home> <20060820153037.GA20007@openwall.com>
	 <1156097013.4051.14.camel@localhost.localdomain>
	 <20060820181025.GN602@1wt.eu>
	 <1156099006.4051.43.camel@localhost.localdomain>
	 <20060820182137.GO602@1wt.eu>
	 <1156099979.4051.45.camel@localhost.localdomain>
	 <20060820190151.GP602@1wt.eu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Aug 2006 20:33:27 +0100
Message-Id: <1156102407.4051.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-08-20 am 21:01 +0200, ysgrifennodd Willy Tarreau:
> 2.4 has no printk_ratelimit() function and I'm not sure it's worth adding
> one for only this user. One could argue that once it's implemented, we can
> uncomment some other warnings that are currently disabled due to lack of
> ratelimit.

Agreed. But if it isnt ratelimited then people will be able to use it
flush other "interesting" log messages out of existance...

> 
> In this special case (set*uid), the only reason we might fail is because
> kmem_cache_alloc(uid_cachep, SLAB_KERNEL) would return NULL. Do you think
> it could intentionnally be tricked into failing, or that under OOM we might
> bother about the excess of messages ?
> 
> If so I can backport the printk_ratelimit() function, I would just like an
> advice on this.

If there are multiple potential users then a backport might be sensible

