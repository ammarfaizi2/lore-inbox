Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262219AbTCMKQU>; Thu, 13 Mar 2003 05:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbTCMKQU>; Thu, 13 Mar 2003 05:16:20 -0500
Received: from [80.190.48.67] ([80.190.48.67]:33030 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id <S262219AbTCMKQT> convert rfc822-to-8bit; Thu, 13 Mar 2003 05:16:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Jens Axboe <axboe@suse.de>, Joe Korty <joe.korty@ccur.com>
Subject: Re: [PATCH] bug in 2.4 bh_kmap_irq() breaks IDE under preempt patch
Date: Thu, 13 Mar 2003 11:26:43 +0100
User-Agent: KMail/1.4.3
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <200303122213.WAA17415@rudolph.ccur.com> <20030313092601.GB827@suse.de>
In-Reply-To: <20030313092601.GB827@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303131126.17963.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 March 2003 10:26, Jens Axboe wrote:

Hi Jens,

> There's a tiny bit missing from your patch:
> > -	 * it's a highmem page
> > -	 */
> > -	__cli();
> > +	local_irq_save(*flags);
>
> 	local_irq_disable();
>
> >  	addr = (unsigned long) kmap_atomic(bh->b_page, KM_BH_IRQ);
> >
> > -	if (addr & ~PAGE_MASK)
> > -		BUG();
> > +	BUG_ON (addr & ~PAGE_MASK);
> >
> >  	return (char *) addr + bh_offset(bh);
> >  }
> > @@ -58,7 +46,7 @@
> >  	unsigned long ptr = (unsigned long) buffer & PAGE_MASK;
> >
> >  	kunmap_atomic((void *) ptr, KM_BH_IRQ);
> > -	__restore_flags(*flags);
> > +	local_irq_restore(*flags);
	local_irq_enable();

^ isn't this missing too with your suggested one-liner?

ciao, Marc
