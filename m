Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbUEQXc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUEQXc2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbUEQXc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:32:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:31961 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263154AbUEQXc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:32:27 -0400
Date: Mon, 17 May 2004 16:33:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Robert.Picco@hp.com, linux-kernel@vger.kernel.org,
       venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] HPET driver
Message-Id: <20040517163356.506a9c8f.akpm@osdl.org>
In-Reply-To: <40A94857.9030507@pobox.com>
References: <40A3F805.5090804@hp.com>
	<40A40204.1060509@pobox.com>
	<40A93DA5.4020701@hp.com>
	<20040517160508.63e1ddf0.akpm@osdl.org>
	<20040517161212.659746db.akpm@osdl.org>
	<40A94857.9030507@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Andrew Morton wrote:
> > +static inline u64 readq(void *addr)
> > +{
> > +	return readl(addr) | (((u64)readl(addr + 4)) << 32);
> > +}
> > +
> > +static inline void writeq(u64 v, void *addr)
> > +{
> > +	writel(v & 0xffffffff, addr);
> > +	writel(v >> 32, addr + 4);
> > +}
> 
> 
> Seems sane, though I wonder about two things:
> 
> * better home is probably asm-generic

It's only applicable to 32-bit machines.  I thik I'd prefer to let the
various arch maintainers decide if this is an appropriate implementation.

> * It seems to me that a poorly-written writel() macro might prefer some 
> guarantee that it's argument is pre-cast to u32.  I dunno if this is 
> just paranoia or not.

That could be an issue if other architectures were to use this
particular implementation.  I'll stick the typecasts in there anyway.
