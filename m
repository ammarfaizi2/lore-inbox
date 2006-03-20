Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWCTOWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWCTOWL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 09:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWCTOWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 09:22:10 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:51618 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S964813AbWCTOWI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 09:22:08 -0500
Date: Mon, 20 Mar 2006 07:22:07 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, clameter@sgi.com, jes@sgi.com
Subject: Re: [PATCH] Add SA_PERCPU_IRQ flag support
Message-ID: <20060320142207.GG8980@parisc-linux.org>
References: <20060317003114.GA1735@sgi.com> <20060317152645.52112021.akpm@osdl.org> <20060318014900.65889f69.akpm@osdl.org> <20060320141747.GA27114@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320141747.GA27114@sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 08:17:47AM -0600, Dimitri Sivanich wrote:
> On Sat, Mar 18, 2006 at 01:49:00AM -0800, Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > +#ifdef ARCH_HAS_IRQ_PER_CPU
> > >  +	if (new->flags & SA_PERCPU_IRQ)
> > >  +		desc->status |= IRQ_PER_CPU;
> > >  +#endif
> > 
> > OK, five architectures define ARCH_HAS_IRQ_PER_CPU but only one of them
> > defines SA_PERCPU_IRQ.    Giving up.
> 
> Could we do the following (at least for now)?:
> 
> +#if defined(ARCH_HAS_IRQ_PER_CPU) && defined(SA_PERCPU_IRQ)
> +	if (new->flags & SA_PERCPU_IRQ)
> +		desc->status |= IRQ_PER_CPU;
> +#endif

Why not just

#ifdef SA_PERCPU_IRQ
	if (new->flags & SA_PERCPU_IRQ)
		desc->status |= IRQ_PER_CPU;
#endif
