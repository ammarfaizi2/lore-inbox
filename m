Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbUJZLGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbUJZLGr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbUJZLGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:06:47 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:36877 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262223AbUJZLGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:06:34 -0400
Date: Tue, 26 Oct 2004 12:06:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, mingo@elte.hu,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: enable_irq/disable_irq
Message-ID: <20041026110632.GA12458@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, mingo@elte.hu,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20041026024049.3d327b8e.akpm@osdl.org> <20041026100656.GA11153@elte.hu> <20041026032018.653e380b.akpm@osdl.org> <20041026103913.GA12158@infradead.org> <20041026034908.6e57dc30.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026034908.6e57dc30.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 03:49:08AM -0700, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Oct 26, 2004 at 03:20:18AM -0700, Andrew Morton wrote:
> > > As all platforms must provide enable_irq() and disable_irq() we should put
> > > the declarations in a generic header.  Why not put them in
> > > linux/interrupt.h?
> > 
> > I looked into that a few days ago, but unfortunately a few architectures
> > have inlined variants.  
> 
> So where's the official declaration of enable_irq()?  For some
> architectures, linux/interrupt.h.  For others, asm/irq.h.  That's screwed.
> 
> I suggest that we move this:
> 
> #ifdef CONFIG_GENERIC_HARDIRQS
> extern void disable_irq_nosync(unsigned int irq);
> extern void disable_irq(unsigned int irq);
> extern void enable_irq(unsigned int irq);
> #endif
> 
> out of interrupt.h and into each relevant asm/irq.h.
> 
> Maybe.  It still sucks.

Well, ingo just moved it from <asm/irq.h> to <linux/interrupt.h> protected
by CONFIG_GENERIC_HARDIRQS, but maybe we should move it back.  Or say that
performance doesn't matter so much for these and they should be out of line
for all architectures.

What do the architecture maintainers think about this?
