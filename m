Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266391AbUIMIL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266391AbUIMIL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 04:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUIMIKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 04:10:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34574 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266364AbUIMIKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 04:10:30 -0400
Date: Mon, 13 Sep 2004 09:10:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, spyro@f2s.com, linux390@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq_enter/irq_exit consolidation
Message-ID: <20040913091022.A27423@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
	spyro@f2s.com, linux390@de.ibm.com, linux-kernel@vger.kernel.org
References: <20040912112554.GA32550@lst.de> <20040912124448.A13676@flint.arm.linux.org.uk> <20040912155720.34b188d7.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040912155720.34b188d7.davem@davemloft.net>; from davem@davemloft.net on Sun, Sep 12, 2004 at 03:57:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 03:57:20PM -0700, David S. Miller wrote:
> On Sun, 12 Sep 2004 12:44:48 +0100
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > This guarantee must also exist on every other architecture, otherwise:
> > 
> > > ===== include/linux/hardirq.h 1.1 vs edited =====
> > > --- 1.1/include/linux/hardirq.h	2004-09-08 08:32:57 +02:00
> > > +++ edited/include/linux/hardirq.h	2004-09-11 21:26:28 +02:00
> > > +#define irq_exit()						\
> > > +do {								\
> > > +	preempt_count() -= IRQ_EXIT_OFFSET;			\
> > 
> > would be buggy - it's an inherently non-atomic operation.
> 
> It works out actually, if we take an interrupt in the middle
> of the operation, that's fine because the preemption count
> will be precisely the same as we first read it by the time
> we return from that interrupt, work out some example cases
> as I think that makes it easier to understand.

I realise that, and it's precisely why I wrote the sentence following
the one you quoted above.

However, ARM ain't buggy whatever.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
