Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWHUUlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWHUUlE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 16:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWHUUlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 16:41:04 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61709 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750930AbWHUUlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 16:41:02 -0400
Date: Mon, 21 Aug 2006 22:41:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/wd33c93.c: cleanups
Message-ID: <20060821204102.GM11651@stusta.de>
References: <20060821104357.GH11651@stusta.de> <20060821105344.GA28759@infradead.org> <20060821192215.GL11651@stusta.de> <20060821192548.GD11266@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821192548.GD11266@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 08:25:48PM +0100, Russell King wrote:
> On Mon, Aug 21, 2006 at 09:22:15PM +0200, Adrian Bunk wrote:
> > On Mon, Aug 21, 2006 at 11:53:44AM +0100, Christoph Hellwig wrote:
> > > On Mon, Aug 21, 2006 at 12:43:57PM +0200, Adrian Bunk wrote:
> > > > This patch contains the following cleanups:
> > > > - #include <linux/irq.h> for getting the prototypes of
> > > >   {dis,en}able_irq()
> > > 
> > > nothing outside of arch code must ever include <linux/irq.h>
> > 
> > Why?
> > It sounds rather strange that non-arch code should use asm headers.
> 
> Still the wrong header.  <linux/interrupt.h> is what you're looking for.
> 
> $ grep '\(en\|dis\)able_irq' include/linux/interrupt.h
> extern void disable_irq_nosync(unsigned int irq);
> extern void disable_irq(unsigned int irq);
> extern void enable_irq(unsigned int irq);
> static inline void disable_irq_nosync_lockdep(unsigned int irq)
>         disable_irq_nosync(irq);
> static inline void disable_irq_lockdep(unsigned int irq)
>         disable_irq(irq);
> static inline void enable_irq_lockdep(unsigned int irq)
>         enable_irq(irq);
> static inline int enable_irq_wake(unsigned int irq)
> static inline int disable_irq_wake(unsigned int irq)
> #  define disable_irq_nosync_lockdep(irq)       disable_irq_nosync(irq)
> #  define disable_irq_lockdep(irq)              disable_irq(irq)
> #  define enable_irq_lockdep(irq)               enable_irq(irq)

Unfortunately, it isn't:

<--  snip  -->

...
#ifdef CONFIG_GENERIC_HARDIRQS
extern void disable_irq_nosync(unsigned int irq);
extern void disable_irq(unsigned int irq);
extern void enable_irq(unsigned int irq);
...

<--  snip  -->

> Russell King

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

