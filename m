Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWHUTZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWHUTZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 15:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWHUTZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 15:25:58 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:49425 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750887AbWHUTZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 15:25:57 -0400
Date: Mon, 21 Aug 2006 20:25:48 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Christoph Hellwig <hch@infradead.org>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/wd33c93.c: cleanups
Message-ID: <20060821192548.GD11266@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Christoph Hellwig <hch@infradead.org>, James.Bottomley@SteelEye.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060821104357.GH11651@stusta.de> <20060821105344.GA28759@infradead.org> <20060821192215.GL11651@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821192215.GL11651@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 09:22:15PM +0200, Adrian Bunk wrote:
> On Mon, Aug 21, 2006 at 11:53:44AM +0100, Christoph Hellwig wrote:
> > On Mon, Aug 21, 2006 at 12:43:57PM +0200, Adrian Bunk wrote:
> > > This patch contains the following cleanups:
> > > - #include <linux/irq.h> for getting the prototypes of
> > >   {dis,en}able_irq()
> > 
> > nothing outside of arch code must ever include <linux/irq.h>
> 
> Why?
> It sounds rather strange that non-arch code should use asm headers.

Still the wrong header.  <linux/interrupt.h> is what you're looking for.

$ grep '\(en\|dis\)able_irq' include/linux/interrupt.h
extern void disable_irq_nosync(unsigned int irq);
extern void disable_irq(unsigned int irq);
extern void enable_irq(unsigned int irq);
static inline void disable_irq_nosync_lockdep(unsigned int irq)
        disable_irq_nosync(irq);
static inline void disable_irq_lockdep(unsigned int irq)
        disable_irq(irq);
static inline void enable_irq_lockdep(unsigned int irq)
        enable_irq(irq);
static inline int enable_irq_wake(unsigned int irq)
static inline int disable_irq_wake(unsigned int irq)
#  define disable_irq_nosync_lockdep(irq)       disable_irq_nosync(irq)
#  define disable_irq_lockdep(irq)              disable_irq(irq)
#  define enable_irq_lockdep(irq)               enable_irq(irq)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
