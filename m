Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316997AbSHPUqT>; Fri, 16 Aug 2002 16:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317024AbSHPUqT>; Fri, 16 Aug 2002 16:46:19 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:7694 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id <S316997AbSHPUqS>; Fri, 16 Aug 2002 16:46:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: henrique <henrique@cyclades.com>
Reply-To: henrique@cyclades.com
Organization: Cyclades Corporation
To: Oliver Xymoron <oxymoron@waste.org>
Subject: Re: Problem with random.c and PPC
Date: Fri, 16 Aug 2002 17:51:35 +0000
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <80256C17.00376E92.00@notesmta.eur.3com.com> <20020816195254.GL5418@waste.org>
In-Reply-To: <20020816195254.GL5418@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208161751.35895.henrique@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oliver !!!

What would you do in my situation. I am dealing with the Motorola MPC860T and 
my system has no disk (I use a flash), no mouse, no keyboard, no PCI bus. It 
has just a fast-ethernet, a console port and some serial ports. 

After reading the discussion on the lkml I realize that the only places I can 
get randomness in my system is in the serial.c (that controls the serial 
ports) and arch/ppc/8xx_io/fec.c (fast eth driver) interrupts.

What do you think about this solution ???

regards
Henrique

My fast ethernet is controlled by processor internal controler (called MII)

On Friday 16 August 2002 07:52 pm, Oliver Xymoron wrote:
> On Fri, Aug 16, 2002 at 11:00:00AM +0100, Jon Burgess wrote:
> > >BTW, does anyone know where I can found the patch to get randomness from
> > > the network cards interrupt ?
> >
> > Add the flag SA_SAMPLE_RANDOM into the request_irq() flags in the driver
> > for whichever interrupt source you want to use
> > e.g. from drivers/net/3c523.c
> >
> >      ret = request_irq(dev->irq, &elmc_interrupt, SA_SHIRQ |
> > SA_SAMPLE_RANDOM, dev->name, dev);
>
> Don't do this. This is the Enron method of entropy accounting.
>
> There is little to no reliably unpredictable data in network
> interrupts and the current scheme does not include for the mixing of
> untrusted sources. It's very likely that an attacker can measure,
> model, and control such timings down to the resolution of the PCI bus
> clock on a quiescent system. This is more than good enough to defeat
> entropy generation on systems without a TSC and given that the bus
> clock is a multiple of the processor clock, it's likely possible to
> extend this to TSC-based systems as well.
>
> Entropy accounting is very fickle - if you overestimate _at all_, your
> secret state becomes theoretically predictable. I have some patches
> that create an API for adding such hard to predict but potentially
> observable data to the entropy pool without accounting it as actual
> entropy, as well as cleaning up some other major accounting errors but
> I'm not quite done testing them.

-- 

