Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281717AbRLKPhK>; Tue, 11 Dec 2001 10:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280402AbRLKPhA>; Tue, 11 Dec 2001 10:37:00 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38663 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S280365AbRLKPgq>; Tue, 11 Dec 2001 10:36:46 -0500
Date: Tue, 11 Dec 2001 16:36:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: Cory Bell <cory.bell@usa.net>
Cc: John Clemens <john@deater.net>, linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-ID: <20011211163641.A25464@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0112060938340.32381-100000@pianoman.cluster.toy> <1007685691.6675.1.camel@localhost.localdomain> <20011207213313.A176@elf.ucw.cz> <1007876254.17062.0.camel@localhost.localdomain> <20011211111458.A15007@atrey.karlin.mff.cuni.cz> <1008083964.17062.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1008083964.17062.30.camel@localhost.localdomain>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The patch should contain:
> > 
> > 
> > > The "honor the irq mask" approach (works on my machine):
> > > --- /home/cbell/linux-2.4/arch/i386/kernel/pci-irq.c	Fri Dec  7 01:51:41 2001
> > > +++ /home/cbell/linux-2.4-test/arch/i386/kernel/pci-irq.c	Sat Dec  8 21:04:37 2001
> > > @@ -581,6 +581,7 @@
> > >  	 * reported by the device if possible.
> > >  	 */
> > >  	newirq = dev->irq;
> > > +	if (!((1 << newirq) & mask)) newirq = 0;
> > 	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > printk(KERN_ERR "$PIR table inconsistent; chipset dependend code told
> > us interrupt is at %d, but irq mask is %lx\n", dev->irq, newirq);
> >   
> > We should never ever workaround BIOS problem without complaining.
> 
> It may not be a bios problem. mask = (info->irq[pin].bitmap &
> pcibios_irq_mask). So an IRQ might not match the mask because the user
> specified a more restrictive mask than the $PIR table.

Okay, so it might be user error, but it is worth a printk, for sure.

> > Otherwise patch looks sane. Did you try submitting it to
> > linus/marcelo?
> 
> Not yet. Wanted to do a bit more testing, especially considering the
> pcmcia problems people have had. Do your pcmcia difficulties occur
> without the patch, as well?

Yep. That machine was always touchy w.r.t. pcmcia.

								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
