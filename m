Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291460AbSBAAkR>; Thu, 31 Jan 2002 19:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291461AbSBAAkI>; Thu, 31 Jan 2002 19:40:08 -0500
Received: from www.transvirtual.com ([206.14.214.140]:8979 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S291460AbSBAAkA>; Thu, 31 Jan 2002 19:40:00 -0500
Date: Thu, 31 Jan 2002 16:39:11 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
cc: linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Q40 input api support.
In-Reply-To: <20020201011543.A476@linux-m68k.org>
Message-ID: <Pine.LNX.4.10.10201311631100.6830-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This patch ports q40 PS/2 controller support over to the input api. Please
> > try it out. It is against the latest dave jones tree.
> 
> thanks, I will look at this over the weekend. Where do I get the DJ
> tree?

ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5


> > +static inline void q40kbd_write(unsigned char val)
> > +{
> > +	/* FIXME! We need a way how to write to the keyboard! */
> > +}
> 
> absolutely no way to write to the keyboard.

That solves that.

> > +	if (IRQ_KEYB_MASK & master_inb(INTERRUPT_REG))
> > +		if (q40kbd_port.dev)
> > +                         q40kbd_port.dev->interrupt(&q40kbd_port, master_inb(KEYCODE_REG), 0);
>                                              ^^^^^^^^^
> where is this defined?

The way it works with the new input code is that it modularized the
keyboard/mice from the controller chipsets. This file, q40kbd.c is the 
file to sets up the controller chip. For the Q40 we have this as for the
ix86 we have i8042.c. As for the mouse and keyboard driver themselves you
pick PS/2 mouse support and AT keyboard support. These drivers are the
same ones as the ix86 drivers for the mice and keyboard. In theory they
should work on both platforms. Note the check for dev. This field is
filled in when we register the keyboard if it is present.

> > +	/* allocate the IRQ */
> > +	request_irq(Q40_IRQ_KEYBOARD, keyboard_interrupt, 0, "q40kbd", NULL);
> 				      ^^^^^^^^^^^^^^^^^^
> should that be q40kbd_interrupt ?

Yes. Fixed. 

