Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267402AbRGQVny>; Tue, 17 Jul 2001 17:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267425AbRGQVno>; Tue, 17 Jul 2001 17:43:44 -0400
Received: from adsl-207-241-136-214.mpl.michix.net ([207.241.136.214]:47627
	"HELO cobalt.deepthought.org") by vger.kernel.org with SMTP
	id <S267402AbRGQVnc>; Tue, 17 Jul 2001 17:43:32 -0400
Date: Tue, 17 Jul 2001 17:35:26 -0400 (EDT)
From: Martin Murray <mmurray@deepthought.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6
In-Reply-To: <Pine.LNX.4.33.0107171432020.1949-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0107171728160.31029-100000@cobalt.deepthought.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 17 Jul 2001, Martin Murray wrote:
> >
> > > And I bet you don't have a driver that knows about it.
> >
> > You know. 2.2.19 uses my cardbus controller on IRQ 11 without a
> > problem.
> 
> Does it actually _use_ the cardbus PCI interrupt at all? At least older
> versions of the external pcmcia package didn't use the PCI interrupt by
> default at all, and relied on polling the state and the old ISA interrupts
> instead.. 

 Near as I can tell, it's listed in /proc/interrupts, and
inserting/removing cards definately causes the counter to increment. I'm
using pcmcia-cs-3.1.27's i82365. Also, dmesg shows it requesting the PCI
IRQ. Ie, I get messages like:

...
Linux PCMCIA Card Services 3.1.27
  kernel build: 2.2.19 #2 Sat Jul 14 12:21:14 EDT 2001
  options:  [pci] [cardbus] [apm]
PCI routing table version 1.0 at 0xfdf60
  00:03.0 -> irq 11
  00:03.1 -> irq 11
Intl PCIC probe:
  TI 1251B rev 00 PCI-to-CardBus at slot 00:03, mem 0x6800000
...

I just inserted and removed my aironet card, and the value in
/proc/interrupts went from 9 to 14.. 

Could this be a problem in yenta_socket()'s initialization sequence?

Thanks, Martin

