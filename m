Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129256AbRBJHNU>; Sat, 10 Feb 2001 02:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129261AbRBJHNJ>; Sat, 10 Feb 2001 02:13:09 -0500
Received: from omecihuatl.rz.Uni-Osnabrueck.DE ([131.173.17.35]:24850 "EHLO
	omecihuatl.rz.uni-osnabrueck.de") by vger.kernel.org with ESMTP
	id <S129256AbRBJHMx> convert rfc822-to-8bit; Sat, 10 Feb 2001 02:12:53 -0500
Date: Sat, 10 Feb 2001 08:09:45 +0100 (MET)
From: ARND BERGMANN <std7652@et.FH-Osnabrueck.DE>
To: Francois Romieu <romieu@cogenit.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: epic100 in current -ac kernels
In-Reply-To: <20010209124728.A28045@se1.cogenit.fr>
Message-ID: <Pine.GSO.4.21.0102100755080.16343-100000@gamma10>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2001, Francois Romieu wrote:

> ARND BERGMANN <std7652@et.FH-Osnabrueck.DE> écrit :
> > On Thu, 8 Feb 2001, Francois Romieu wrote:
> > 
> > > > 
> > > > Working epic100 drivers:
> > > >  - 2.4.0
> > > >  - 2.4.0-ac9
> > > 
> > > Could you give a look at ac12 (fine here) ?
> > > 
> > No, does not work, same problem.
> 
> The modifications between ac9 and ac12 come from the new DMA 
> mapping.
What about 2.4.0-ac5? That had the same problem as -ac12. Did it also have
the new DMA mapping?

> They added a bug for the (already buggy ?) big-endian
> machines. I would be surprised that something has *always* been 
> missing in the driver and your hardware triggers it*. IMHO the culprit 
> is to be found elsewhere.
Yes, I'm pretty sure the problem is not only the epic100 driver, now that
I have done some more investigation. With the broken drivers (I tried
2.4.0-ac12 and 2.4.1-ac5), something generates an enourmous amount of
interrupts as soon as I run 'ifconfig eth0 up'. Within 10 seconds, I got
roughly 950000 interrupts on IRQ11, instead of 30!
After disabling the usb-uhci (I was using the JE driver) in the BIOS
setup, the system reproducibly locked up hard a few seconds after
'ifconfig eth0 up' instead of just getting slow.
Unfortunately, I have no way to also disable the sound card, but at least
it does not make a change if the sound driver is loaded or not.

> I'd like to know what it's worth to share an irq with a pio audio card.
On Monday I can ask the system administrator for the keys so I can open
the machine and put the card into another slot. Right now, USB, sound and
network are hardwired to the same IRQ, that's how the system arrived here.

Arnd <><

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
