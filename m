Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291809AbSBAP4D>; Fri, 1 Feb 2002 10:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291811AbSBAPzx>; Fri, 1 Feb 2002 10:55:53 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:24581 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291809AbSBAPzn>; Fri, 1 Feb 2002 10:55:43 -0500
Date: Fri, 1 Feb 2002 16:55:38 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
Cc: James Simmons <jsimmons@transvirtual.com>, linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Q40 input api support.
Message-ID: <20020201165538.A17286@suse.cz>
In-Reply-To: <Pine.LNX.4.10.10201311009140.23385-100000@www.transvirtual.com> <20020201011543.A476@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020201011543.A476@linux-m68k.org>; from Richard.Zidlicky@stud.informatik.uni-erlangen.de on Fri, Feb 01, 2002 at 01:15:43AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 01:15:43AM +0100, Richard Zidlicky wrote:
> On Thu, Jan 31, 2002 at 10:19:46AM -0800, James Simmons wrote:
> > 
> > This patch ports q40 PS/2 controller support over to the input api. Please
> > try it out. It is against the latest dave jones tree.
> 
> thanks, I will look at this over the weekend. Where do I get the DJ
> tree?
> 
> > +static inline void q40kbd_write(unsigned char val)
> > +{
> > +	/* FIXME! We need a way how to write to the keyboard! */
> > +}
> 
> absolutely no way to write to the keyboard.

Really? Too bad. So no way to set LEDs, no way to detect the keyboard,
no way to set it to "Scancode Set 3"?

We'll need to modify the atkbd driver then ... 

> > +static void q40kbd_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> > +{
> > +	unsigned long flags;
> > +
> > +	if (IRQ_KEYB_MASK & master_inb(INTERRUPT_REG))
> > +		if (q40kbd_port.dev)
> > +                         q40kbd_port.dev->interrupt(&q40kbd_port, master_inb(KEYCODE_REG), 0);
>                                              ^^^^^^^^^
> where is this defined?

include/linux/serio.h: struct serio_dev

> > +void __init q40kbd_init(void)
> > +{
> > +	int maxread = 100;
> > +
> > +	/* Get the keyboard controller registers (incomplete decode) */
> > +	request_region(0x60, 16, "q40kbd");
> > +
> > +	/* allocate the IRQ */
> > +	request_irq(Q40_IRQ_KEYBOARD, keyboard_interrupt, 0, "q40kbd", NULL);
> 				      ^^^^^^^^^^^^^^^^^^
> should that be q40kbd_interrupt ?

Yes, it should.

-- 
Vojtech Pavlik
SuSE Labs
