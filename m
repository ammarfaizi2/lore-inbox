Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbRHAO5k>; Wed, 1 Aug 2001 10:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267295AbRHAO5a>; Wed, 1 Aug 2001 10:57:30 -0400
Received: from h-207-228-73-44.gen.cadvision.com ([207.228.73.44]:64264 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S267268AbRHAO5Z>; Wed, 1 Aug 2001 10:57:25 -0400
Date: Wed, 1 Aug 2001 08:57:26 -0600
Message-Id: <200108011457.f71EvQX09093@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Kirk Reiser <kirk@braille.uwo.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: my patches won't compile under 2.4.7
In-Reply-To: <x7u1zsav6y.fsf@speech.braille.uwo.ca>
In-Reply-To: <x7itgglrmd.fsf@speech.braille.uwo.ca>
	<E15PUnL-0002bA-00@the-village.bc.nu>
	<200107312154.f6VLsLl00530@mobilix.ras.ucalgary.ca>
	<x7u1zsav6y.fsf@speech.braille.uwo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirk Reiser writes:
> On another note related to devfs though when I compile devfs in the
> system just hangs.  I am wondering if I am registering my synth device
> before devfs has memory allocated.  I register very early in the boot
> process in console_init() and experienced similar problems before because I
> don't think  kmalloc() may be available that early in the sequence.
> 
> The question then is, do you think that could be why the system is
> hanging with devfs configured in?

Yes. Calling kmalloc() before MM is set up is not allowed. See the
comments in drivers/char/console.c which talks about not calling
kmalloc() before console_init().

Simply move your driver registration after MM is set up. Use
module_init() to declare your initialisation function. This works for
both modules and built-in drivers. Registering a driver before MM
setup is considered bad practice.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
