Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAIHTc>; Tue, 9 Jan 2001 02:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAIHTW>; Tue, 9 Jan 2001 02:19:22 -0500
Received: from slc110.modem.xmission.com ([166.70.9.110]:38922 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129267AbRAIHTM>; Tue, 9 Jan 2001 02:19:12 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Albert Cranford <ac9410@bellsouth.net>, linux-kernel@vger.kernel.org
Subject: Re: Related VIA PCI crazyness?
In-Reply-To: <Pine.LNX.4.10.10101071915400.28661-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Jan 2001 23:06:08 -0700
In-Reply-To: Linus Torvalds's message of "Sun, 7 Jan 2001 19:18:17 -0800 (PST)"
Message-ID: <m13deti7jj.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Sun, 7 Jan 2001, Albert Cranford wrote:
> > > Could anybody with a VIA chip who has the energy please do something for
> > > me:
> > >  - enable DEBUG in arch/i386/kernel/pci-i386.h
> > >  - do a "/sbin/lspci -xxvvv" on the interrupt routing chip (it's the
> > >    "ISA bridge" chip - the VIA numbers are 82c586, 82c596, the PCI
> > >    numbers for them are 1106:0586 and 1106:0596, I think)
> > >  - do a cat /proc/pci
> > > 
> > 
> > Does this help.
> 
> Ahh, no.
> 
> A SMP kernel (or one with UP IO-APIC) is not going to be helpful for this,
> actually. SMP will take the irq data from the MP block, not the pirq table
> (that can be considered something of a misfeature right now, but getting
> the mixture of PCI irq redirection from the MP tables and the pirq irq
> routing information right together is probably not worth it - especially
> as I don't think any MS OS has ever done that either, so the BIOS writers
> have never experienced that combination - so it's almost guaranteed to
> result in strange results).

pirq is specific to they legacy i8259 interrupt handler.
MP is specific to some kind of IO-APIC.

Right now when we enable the IO-APIC we disable the legacy i8259
controller.  And I'm not even certain you can have them both enabled
at the same time.

So except for not having an option to disable use of the IO-APIC
I don't see what we could do better.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
