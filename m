Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284952AbRLKKRG>; Tue, 11 Dec 2001 05:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284953AbRLKKQ4>; Tue, 11 Dec 2001 05:16:56 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1039 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S284952AbRLKKQs>; Tue, 11 Dec 2001 05:16:48 -0500
Date: Tue, 11 Dec 2001 11:14:58 +0100
From: Pavel Machek <pavel@suse.cz>
To: Cory Bell <cory.bell@usa.net>
Cc: John Clemens <john@deater.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-ID: <20011211111458.A15007@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0112060938340.32381-100000@pianoman.cluster.toy> <1007685691.6675.1.camel@localhost.localdomain> <20011207213313.A176@elf.ucw.cz> <1007876254.17062.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1007876254.17062.0.camel@localhost.localdomain>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hey, this gross hack fixed USB on HP OmniBook xe3. Good! (Perhaps you
> > know what interrupt is right for maestro3, also on omnibook? ;-).
> 
> On my Pavilion (and the other 5400's as far as I can tell), maestro's on
> irq 5. Wanna send me a "dump_pirq" and a "lspci -vvvxxx"? Could you try
> the patch below (inspired by/stolen from Kai Germaschewski)? Also, the
> newest acpi patch will print out the acpi irq routing table - might have
> your info. You can tell if the patch below had any effect because it
> will say it ASSIGNED IRQ XX instead of FOUND.

The patch should contain:


> The "honor the irq mask" approach (works on my machine):
> --- /home/cbell/linux-2.4/arch/i386/kernel/pci-irq.c	Fri Dec  7 01:51:41 2001
> +++ /home/cbell/linux-2.4-test/arch/i386/kernel/pci-irq.c	Sat Dec  8 21:04:37 2001
> @@ -581,6 +581,7 @@
>  	 * reported by the device if possible.
>  	 */
>  	newirq = dev->irq;
> +	if (!((1 << newirq) & mask)) newirq = 0;
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
printk(KERN_ERR "$PIR table inconsistent; chipset dependend code told
us interrupt is at %d, but irq mask is %lx\n", dev->irq, newirq);
  
We should never ever workaround BIOS problem without complaining.

Otherwise patch looks sane. Did you try submitting it to
linus/marcelo?
								Pavel 
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
