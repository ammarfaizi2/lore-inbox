Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUILW7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUILW7A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 18:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUILW7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 18:59:00 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:37278
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263743AbUILW66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 18:58:58 -0400
Date: Sun, 12 Sep 2004 15:57:20 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: hch@arm.linux.org.uk, akpm@osdl.org, spyro@f2s.com, linux390@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq_enter/irq_exit consolidation
Message-Id: <20040912155720.34b188d7.davem@davemloft.net>
In-Reply-To: <20040912124448.A13676@flint.arm.linux.org.uk>
References: <20040912112554.GA32550@lst.de>
	<20040912124448.A13676@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004 12:44:48 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> This guarantee must also exist on every other architecture, otherwise:
> 
> > ===== include/linux/hardirq.h 1.1 vs edited =====
> > --- 1.1/include/linux/hardirq.h	2004-09-08 08:32:57 +02:00
> > +++ edited/include/linux/hardirq.h	2004-09-11 21:26:28 +02:00
> > +#define irq_exit()						\
> > +do {								\
> > +	preempt_count() -= IRQ_EXIT_OFFSET;			\
> 
> would be buggy - it's an inherently non-atomic operation.

It works out actually, if we take an interrupt in the middle
of the operation, that's fine because the preemption count
will be precisely the same as we first read it by the time
we return from that interrupt, work out some example cases
as I think that makes it easier to understand.
