Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281478AbRLKP3J>; Tue, 11 Dec 2001 10:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281217AbRLKP27>; Tue, 11 Dec 2001 10:28:59 -0500
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:14816 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S280426AbRLKP2z>; Tue, 11 Dec 2001 10:28:55 -0500
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
From: Cory Bell <cory.bell@usa.net>
To: Pavel Machek <pavel@suse.cz>
Cc: John Clemens <john@deater.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20011211111458.A15007@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0112060938340.32381-100000@pianoman.cluster.toy>
	<1007685691.6675.1.camel@localhost.localdomain>
	<20011207213313.A176@elf.ucw.cz>
	<1007876254.17062.0.camel@localhost.localdomain> 
	<20011211111458.A15007@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 11 Dec 2001 07:19:21 -0800
Message-Id: <1008083964.17062.30.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-12-11 at 02:14, Pavel Machek wrote:
> The patch should contain:
> 
> 
> > The "honor the irq mask" approach (works on my machine):
> > --- /home/cbell/linux-2.4/arch/i386/kernel/pci-irq.c	Fri Dec  7 01:51:41 2001
> > +++ /home/cbell/linux-2.4-test/arch/i386/kernel/pci-irq.c	Sat Dec  8 21:04:37 2001
> > @@ -581,6 +581,7 @@
> >  	 * reported by the device if possible.
> >  	 */
> >  	newirq = dev->irq;
> > +	if (!((1 << newirq) & mask)) newirq = 0;
> 	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> printk(KERN_ERR "$PIR table inconsistent; chipset dependend code told
> us interrupt is at %d, but irq mask is %lx\n", dev->irq, newirq);
>   
> We should never ever workaround BIOS problem without complaining.

It may not be a bios problem. mask = (info->irq[pin].bitmap &
pcibios_irq_mask). So an IRQ might not match the mask because the user
specified a more restrictive mask than the $PIR table.

I suppose we could use a second variable (pir_mask?) that didn't get &'d
with pcibios_irq_mask to do the checks.

Ideas, anyone?

> Otherwise patch looks sane. Did you try submitting it to
> linus/marcelo?

Not yet. Wanted to do a bit more testing, especially considering the
pcmcia problems people have had. Do your pcmcia difficulties occur
without the patch, as well?

I'll test my 16-bit pcmcia modem/nic with my pcmcia scsi adapter, and
see if I get the same breakage.

Has anyone tried dual cardbus cards?

-Cory

