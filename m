Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268929AbUIHNV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268929AbUIHNV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269003AbUIHNVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:21:50 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:8 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268929AbUIHNUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:20:06 -0400
Date: Wed, 8 Sep 2004 14:20:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
Message-ID: <20040908142002.A31831@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
References: <20040908120613.GA16916@elte.hu> <20040908133445.A31267@infradead.org> <20040908124547.GA19231@elte.hu> <20040908134903.A31498@infradead.org> <20040908130552.GC20132@elte.hu> <20040908141217.A31690@infradead.org> <20040908131720.GA22194@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040908131720.GA22194@elte.hu>; from mingo@elte.hu on Wed, Sep 08, 2004 at 03:17:20PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 03:17:20PM +0200, Ingo Molnar wrote:
> not at all different model. 90% of the important drivers (no,
> drivers/s390 doesnt count) are shared between multiple architectures
> using the same interface: request_irq()/free_irq() and a handler with an
> enumerated irq vector.

Sure, but that's not the level we're talking about.  The function we talk
about compare to the vfs_* routines (when looking at the arches with
i386-style generic irq code)(

> > s390 doesn't need it at all because it doesn't have the concept of hardirqs.
> > 
> > At least arm{,26}, m68k{,nommu} and parisc and sparc{,64} use extremly
> > different models for irq handling
> 
> it could be a bit like nommu - a noirq model.
> 
> i agree with enabling an architecture to exclude _all_ of hardirq.c, but 
> specifying per-function is excessive - if an architecture can make use 
> of some of them then weak symbols will get rid of the rest.

I never wanted to exclude individual functions.  But when you look at
arch/*/kernel/irq.c I don't see a reason for doing it at all.  It makes
sense to make this an all or nothing switch.

