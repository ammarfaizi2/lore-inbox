Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbTAEVvq>; Sun, 5 Jan 2003 16:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbTAEVvq>; Sun, 5 Jan 2003 16:51:46 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:37326 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265230AbTAEVvp>; Sun, 5 Jan 2003 16:51:45 -0500
Subject: Re: [RFC] irq handling code consolidation, second try (ppc part)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, pazke@orbita1.ru, anton@samba.org
In-Reply-To: <Pine.LNX.4.44.0301051103030.11848-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0301051103030.11848-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1041804200.552.4.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 05 Jan 2003 23:03:20 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-05 at 20:05, Linus Torvalds wrote:
> On 5 Jan 2003, Benjamin Herrenschmidt wrote:
> > 
> > Note that if we go the full way abstracting interrupts, then the
> > interrupt "tree" should be separate from the device tree. The interrupt
> > "parent" of a device may not be (and is not in a whole lot of cases I
> > have to deal with on pmacs and embedded) the "bus" parent of a given
> > device.
> 
> I disagree. The pmac braindamage is a pmac problem, and not worth 
> uglifying the generic device layer over. Besides, as far as I know, it is 
> trivially solved by just making the pmac irq controller be a root 
> controller, and that's it. There are no other irq controllers there that 
> are worth worrying about.

Right, though some other machines (CHRP for example) with cascaded
legacy 8259 on top or below OpenPIC may also want more flexibility
regarding interrupt routing.

It seems quite common (at least it is in embedded world) to actually
wire interrupt sources rather randomly to the closest device than can
act as an interrupt controller regardless of the actual bus layout ;)

But I agree this can be solved by defining the "main" PIC as root
controller regardless of it's actual bus location.

> > Do you think this is still 2.5 work ?
> 
> No.

Makes sense. Though the simple tweak of allocating more irq_descs in the
existing array (by slightly extending the array) may be worth trying for
fixing some of the pcmcia problems now. I need to experient more, it
might actually be enough to just disable IRQ routing on the pcmcia
bridge when the slot is shut down.

Ben.


