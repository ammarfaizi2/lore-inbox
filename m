Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUKCUcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUKCUcf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbUKCUce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:32:34 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:55815 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261854AbUKCUcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:32:18 -0500
Date: Wed, 3 Nov 2004 20:32:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: uClinux development list <uclinux-dev@uclinux.org>, akpm@osdl.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [uClinux-dev] [PATCH 1/14] FRV: Fujitsu FR-V CPU arch implementation
Message-ID: <20041103203208.GA23494@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	uClinux development list <uclinux-dev@uclinux.org>, akpm@osdl.org,
	torvalds@osdl.org, linux-kernel@vger.kernel.org, mingo@elte.hu
References: <20041102234610.GB7040@lst.de> <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> <8632.1099511196@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8632.1099511196@redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[any reason you drop me from the cc list?]

> > Please use the generic kernel/irq/* code.
> 
> That code is not sufficient.

Why?  And what makes it impossible to extend the code to handle your
hardware. 

> > I can't see this beeing called from generic code ever, why do you
> > implement it?
> 
> It's a placeholder for something I'd like to implement for the FR451 CPU which
> has a decrementer counter. It is actually called from entry.S.

So add it when you implement that code.

> > > +void *dma_alloc_coherent(struct device *hwdev, size_t size, dma_addr_t *dma_handle, int flag)
> 
> > the last argument is the gfp mask.
> 
> It's called "flag" in include/asm-i386/dma-mapping.h. And shouldn't it be an
> "unsigned long" if it's GFP flags?

If you look at the callers it's use as gfp mask.  Feel free to send patches
to change the types to what you think makes sense.

> > does GFP_DMA really hae the same meaning as on i386 here?
> 
> I'm not sure whether it should put all of its memory in the DMA region, or
> none of it. There's no documentation on this.

There's no rules on how to do it anyway.  But it looks like you don't
have any arbitrary dma limits, so conditionally setting doesn't make
much sense.

> > Don't mess with per-arch fields in common procfs files.
> 
> Should I then add an arch-specific file to "/proc/<pid>/"?

That's not that bad at least.  But you'd need to convience us why
your port is the first that absolutely needs something like that.

