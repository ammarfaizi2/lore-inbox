Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbTIJISw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 04:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264932AbTIJISw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 04:18:52 -0400
Received: from waste.org ([209.173.204.2]:34741 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264930AbTIJISt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 04:18:49 -0400
Date: Wed, 10 Sep 2003 03:18:45 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, rjwalsh@durables.org
Subject: Re: [PATCH 1/3] netpoll api
Message-ID: <20030910081845.GF4489@waste.org>
References: <20030910074030.GC4489@waste.org> <20030910004907.67b90bd1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910004907.67b90bd1.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 12:49:07AM -0700, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > +	spin_lock_irq(&irq_desc[ndev->irq].lock);
> >  +	for(a=irq_desc[ndev->irq].action; a; a=a->next) {
> 
> Lots of architectures do not use irq_desc[].   You'll need abstracted
> per-arch primitives for functions such as this.

Hmmm, linux/irq.h seemed pretty generic. Maybe those other, silly
arches can mend their ways?

Ok, looks like m68k, s390, and sparcx are the only ones not using
irq_desc, and only s390 seems to be far from the irq_desc model. Or I
could be quite mistaken.

I'll be damned if I know what's going on with s390, so I'm not sure
how to get from here to there in terms of coming up with an API for
poking around in ISR lists. Unless you're suggesting I simply make
try_to_find_handler_dev(dev, irq) which seems a little ungainly.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
