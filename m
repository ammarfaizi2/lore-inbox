Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291451AbSBAAXr>; Thu, 31 Jan 2002 19:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291450AbSBAAXb>; Thu, 31 Jan 2002 19:23:31 -0500
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:51855 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S291451AbSBAAXN>; Thu, 31 Jan 2002 19:23:13 -0500
Date: Fri, 1 Feb 2002 01:15:43 +0100
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: James Simmons <jsimmons@transvirtual.com>
Cc: linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Q40 input api support.
Message-ID: <20020201011543.A476@linux-m68k.org>
In-Reply-To: <Pine.LNX.4.10.10201311009140.23385-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10201311009140.23385-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Thu, Jan 31, 2002 at 10:19:46AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 10:19:46AM -0800, James Simmons wrote:
> 
> This patch ports q40 PS/2 controller support over to the input api. Please
> try it out. It is against the latest dave jones tree.

thanks, I will look at this over the weekend. Where do I get the DJ
tree?

> +static inline void q40kbd_write(unsigned char val)
> +{
> +	/* FIXME! We need a way how to write to the keyboard! */
> +}

absolutely no way to write to the keyboard.

> +
> +static struct serio q40kbd_port =
> +{
> +	type:   SERIO_8042,
> +	write:  q40kbd_write,
> +	name:	"Q40 PS/2 kbd port",
> +	phys:	"isa0060/serio0",
> +};
> +
> +static void q40kbd_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	unsigned long flags;
> +
> +	if (IRQ_KEYB_MASK & master_inb(INTERRUPT_REG))
> +		if (q40kbd_port.dev)
> +                         q40kbd_port.dev->interrupt(&q40kbd_port, master_inb(KEYCODE_REG), 0);
                                             ^^^^^^^^^
where is this defined?

> +void __init q40kbd_init(void)
> +{
> +	int maxread = 100;
> +
> +	/* Get the keyboard controller registers (incomplete decode) */
> +	request_region(0x60, 16, "q40kbd");
> +
> +	/* allocate the IRQ */
> +	request_irq(Q40_IRQ_KEYBOARD, keyboard_interrupt, 0, "q40kbd", NULL);
				      ^^^^^^^^^^^^^^^^^^
should that be q40kbd_interrupt ?

Bye
Richard
