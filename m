Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269540AbUINScW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269540AbUINScW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269495AbUINScR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:32:17 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:20235 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269184AbUINSbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:31:47 -0400
Date: Tue, 14 Sep 2004 19:31:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: hch@lst.df, akpm@osdl.org, spyro@f2s.com, rmk@arm.linux.org.uk,
       linux390@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq_enter/irq_exit consolidation
Message-ID: <20040914193135.A10776@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, hch@lst.df,
	akpm@osdl.org, spyro@f2s.com, rmk@arm.linux.org.uk,
	linux390@de.ibm.com, linux-kernel@vger.kernel.org
References: <20040913130239.GA3086@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040913130239.GA3086@mschwid3.boeblingen.de.ibm.com>; from schwidefsky@de.ibm.com on Mon, Sep 13, 2004 at 03:02:40PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 03:02:40PM +0200, Martin Schwidefsky wrote:
> Hi Christoph,
> 
> > s390 has an assembly wrapper around do_softirq.
> > 
> > I've extended the invoke_softirq mechanism used by s390 (also called
> > by ksoftirqd) to the two arm variants, but the right thing to do is
> > probably to use the normal do_softirq call in arm and set
> > __ARCH_HAS_DO_SOFTIRQ + providing a per-arch do_softirq for all callers
> > for s390 and maybe arm26.
> 
> do_call_softirq switches to the asynchronous interrupt stack,
> just what i386 does now as well. Trouble is that on s390 it is
> non-trivial to do the switch in C with inline assembly. We need
> a bit of assembly. But we could get rid of invoke_softirq, define
> __ARCH_HAS_DO_SOFTIRQ and use do_softirq to call the assembly
> wrapper.

Well, the question is do you want the direct do_softirq invocations from
the networking code use the separate stack or not?  If not the current
code is fine.  If yes you should sent the patch to Andrew.

