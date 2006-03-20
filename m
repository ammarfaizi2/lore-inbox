Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWCTOSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWCTOSF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 09:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWCTOSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 09:18:05 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:39812 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964806AbWCTOSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 09:18:04 -0500
Date: Mon, 20 Mar 2006 08:17:47 -0600
From: Dimitri Sivanich <sivanich@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, clameter@sgi.com,
       jes@sgi.com
Subject: Re: [PATCH] Add SA_PERCPU_IRQ flag support
Message-ID: <20060320141747.GA27114@sgi.com>
References: <20060317003114.GA1735@sgi.com> <20060317152645.52112021.akpm@osdl.org> <20060318014900.65889f69.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318014900.65889f69.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 01:49:00AM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > +#ifdef ARCH_HAS_IRQ_PER_CPU
> >  +	if (new->flags & SA_PERCPU_IRQ)
> >  +		desc->status |= IRQ_PER_CPU;
> >  +#endif
> 
> OK, five architectures define ARCH_HAS_IRQ_PER_CPU but only one of them
> defines SA_PERCPU_IRQ.    Giving up.

Could we do the following (at least for now)?:

+#if defined(ARCH_HAS_IRQ_PER_CPU) && defined(SA_PERCPU_IRQ)
+	if (new->flags & SA_PERCPU_IRQ)
+		desc->status |= IRQ_PER_CPU;
+#endif
