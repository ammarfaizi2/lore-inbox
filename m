Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291812AbSBAP7f>; Fri, 1 Feb 2002 10:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291813AbSBAP7X>; Fri, 1 Feb 2002 10:59:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45320 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S291812AbSBAP7Q>;
	Fri, 1 Feb 2002 10:59:16 -0500
Date: Fri, 1 Feb 2002 16:58:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: Andrew Morton <akpm@zip.com.au>, Bob Miller <rem@osdl.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.3 remove global semaphore_lock spin lock.
Message-ID: <20020201165846.I12156@suse.de>
In-Reply-To: <20020131150139.A1345@doc.pdx.osdl.net> <3C59D956.4F2B85DB@zip.com.au> <20020131224117.E21864@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020131224117.E21864@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31 2002, Jeff Garzik wrote:
> On Thu, Jan 31, 2002 at 03:55:02PM -0800, Andrew Morton wrote:
> > > +       unsigned long flags;
> > > +       wq_write_lock_irqsave(&sem->wait.lock, flags);
> > > -       spin_lock_irq(&semaphore_lock);
> > 
> > I rather dislike spin_lock_irq(), because it's fragile (makes
> 
> It's less flexible for architectures, too.
> 
> spin_lock_irqsave is considered 100% portable AFAIK, and I make it my
> own policy to s/_irq/_irqsave/ when the opportunity strikes in my PCI
> drivers.

spin_lock_irq is cheaper, though, and sometimes you _know_ it's safe to
use. For instance, if the function in question can block (ie never
called with interrupts disabled) then using spin_lock_irq is always
safe.

I've heard this portability argument before, anyone care to outline
_what_ the problem allegedly is?? Major part of the kernel uses
spin_lock_irq and I suspect we would be seeing lots of request list
corruption did it not work.

-- 
Jens Axboe

