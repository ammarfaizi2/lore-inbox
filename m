Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267140AbRHWOkl>; Thu, 23 Aug 2001 10:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbRHWOkb>; Thu, 23 Aug 2001 10:40:31 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:63492 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267140AbRHWOkR>; Thu, 23 Aug 2001 10:40:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrey Nekrasov <andy@spylog.ru>
Subject: Re: 2.4.8/2.4.9 problem
Date: Thu, 23 Aug 2001 16:46:54 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200108171310.PAA26032@lambik.cc.kuleuven.ac.be> <20010820211403Z16263-32383+585@humbolt.nl.linux.org> <20010823140444.A14798@spylog.ru>
In-Reply-To: <20010823140444.A14798@spylog.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010823144024Z16183-32384+397@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 23, 2001 12:04 pm, Andrey Nekrasov wrote:
> Hello Daniel Phillips,
> 
> > > I am have problem with "kernel: __alloc_pages: 0-order allocation failed."
> > 
> > Could you please try it with this patch, which will tell us a little more 
> > about what's happening (patch -p0):
> > 
> > --- ../2.4.9.clean/mm/page_alloc.c	Thu Aug 16 12:43:02 2001
> > +++ ./mm/page_alloc.c	Mon Aug 20 22:05:40 2001
> > @@ -502,7 +502,7 @@
> >  	}
> >  
> >  	/* No luck.. */
> > -	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", order);
> > +	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed (gfp=0x%x/%i).\n", order, gfp_mask, !!(current->flags & PF_MEMALLOC));
> >  	return NULL;
> >  }
> 
> I applied patch, this is result:
> 
> ...
> Aug 23 14:00:29 sol kernel: __alloc_pages: 0-order allocation failed (gfp=0x30/1).
> Aug 23 14:00:29 sol last message repeated 12 times
> Aug 23 14:00:29 sol kernel: cation failed (gfp=0x30/1).
> Aug 23 14:00:29 sol kernel: __alloc_pages: 0-order allocation failed (gfp=0x30/1).
> Aug 23 14:00:53 sol last message repeated 334 times
> Aug 23 14:00:53 sol kernel: cation failed (gfp=0x30/1).
> Aug 23 14:00:53 sol kernel: __alloc_pages: 0-order allocation failed (gfp=0x30/1).
> Aug 23 14:00:55 sol last message repeated 300 times
> Aug 23 14:00:55 sol kernel: cation failed (gfp=0x30/1).
> Aug 23 14:00:55 sol kernel: __alloc_pages: 0-order allocation failed (gfp=0x30/1).
> Aug 23 14:00:55 sol last message repeated 281 times
> ...
> 
> 
> Hm. That is it?

Marcelo already posted a patch to fix this problem (bounce buffer allocation). 
Look under subject "Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on
7899P)" with a correction in his next post.

--
Daniel
