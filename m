Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267455AbUIHNRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267455AbUIHNRz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268382AbUIHNRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:17:47 -0400
Received: from mx2.elte.hu ([157.181.151.9]:14978 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268295AbUIHNQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:16:02 -0400
Date: Wed, 8 Sep 2004 15:17:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
Message-ID: <20040908131720.GA22194@elte.hu>
References: <20040908120613.GA16916@elte.hu> <20040908133445.A31267@infradead.org> <20040908124547.GA19231@elte.hu> <20040908134903.A31498@infradead.org> <20040908130552.GC20132@elte.hu> <20040908141217.A31690@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908141217.A31690@infradead.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> > i disagree. It's the same as the VFS model: we have generic_block_bmap()
> > which a filesystem might or might not make use of. It's still around
> > even if no filesystem makes use of it but do we care? I'd prefer fixing
> > our linking logic to get rid of unused functions than complicating code
> > and the architecture with conditionals.
> 
> Completley different model.  VFS supports lots of filesystem
> implementation with one interface.  IRQ code is a a single
> implementation for each architecture.

not at all different model. 90% of the important drivers (no,
drivers/s390 doesnt count) are shared between multiple architectures
using the same interface: request_irq()/free_irq() and a handler with an
enumerated irq vector.

> > is there any architecture that cannot make use of kernel/hardirq.c _at
> > all_?
> 
> s390 doesn't need it at all because it doesn't have the concept of hardirqs.
> 
> At least arm{,26}, m68k{,nommu} and parisc and sparc{,64} use extremly
> different models for irq handling

it could be a bit like nommu - a noirq model.

i agree with enabling an architecture to exclude _all_ of hardirq.c, but 
specifying per-function is excessive - if an architecture can make use 
of some of them then weak symbols will get rid of the rest.

	Ingo
