Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWIARUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWIARUL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 13:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWIARUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 13:20:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21639 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750795AbWIARUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 13:20:09 -0400
Date: Fri, 1 Sep 2006 10:13:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Tom Tucker <tom@opengridcomputing.com>,
       Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: 2.6.18-rc5-mm1: drivers/infiniband/hw/amso1100/c2.c compile
 error
Message-Id: <20060901101340.962150cb.akpm@osdl.org>
In-Reply-To: <20060901160023.GB18276@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
	<20060901160023.GB18276@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2006 18:00:23 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> On Fri, Sep 01, 2006 at 01:58:18AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.18-rc4-mm3:
> >...
> > +amso1100-build-fix.patch
> > 
> >  Fix git-infiniband.patch
> >...
> 
> This causes the following compile error on i386:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/infiniband/hw/amso1100/c2.o
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2.c: In function ‘c2_tx_ring_alloc’:
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2.c:133: error: implicit declaration of function ‘__raw_writeq’
> make[4]: *** [drivers/infiniband/hw/amso1100/c2.o] Error 1
> 

That would have been me cheerfully deleting stuff because it didn't build
on powerpc.

> 
> There seems to be some confusion regarding whether __raw_writeq() is 
> considered a platform independent API.
> 

It appears to be undocumented and uncommented hence it's not an API
_at all_, is it?

What's __raw_writeq() supposed to do, anyway?  On alpha it's writeq()
without an mb().  On parisc it's writeq() only the data is byte-reversed. 
On sparc64() it's incomprehensible.  On everything else it's writeq().

What a crock.
