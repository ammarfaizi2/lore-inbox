Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131330AbRBJKs6>; Sat, 10 Feb 2001 05:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131363AbRBJKss>; Sat, 10 Feb 2001 05:48:48 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:14340 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S131330AbRBJKsg>;
	Sat, 10 Feb 2001 05:48:36 -0500
Date: Sat, 10 Feb 2001 11:47:32 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: ARND BERGMANN <std7652@et.FH-Osnabrueck.DE>
Cc: linux-kernel@vger.kernel.org
Subject: IRQ (routing ?) problem [was Re: epic100 in current -ac kernels]
Message-ID: <20010210114732.A6314@se1.cogenit.fr>
In-Reply-To: <20010209124728.A28045@se1.cogenit.fr> <Pine.GSO.4.21.0102100755080.16343-100000@gamma10>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.GSO.4.21.0102100755080.16343-100000@gamma10>
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ARND BERGMANN <std7652@et.FH-Osnabrueck.DE> écrit :
[...]
> > > > > Working epic100 drivers:
> > > > >  - 2.4.0
> > > > >  - 2.4.0-ac9
> > > > 
> > > > Could you give a look at ac12 (fine here) ?
> > > > 
> > > No, does not work, same problem.
> > 
> > The modifications between ac9 and ac12 come from the new DMA 
> > mapping.
> What about 2.4.0-ac5? That had the same problem as -ac12. Did it also have
> the new DMA mapping?

Yes. For completness (though irrelevant):
2.4.0-ac2 -> ac6 : DMA mapping + rev9 fixes from Andreas Steinmetz
2.4.0-ac7 -> ac10: Merge becker version 1.11 + pci_enable. No DMA mapping
2.4.0-ac11       : Merge becker version 1.11 + pci_enable + DMA mapping

[...]
> > They added a bug for the (already buggy ?) big-endian
> > machines. I would be surprised that something has *always* been 
> > missing in the driver and your hardware triggers it*. IMHO the culprit 
> > is to be found elsewhere.
> Yes, I'm pretty sure the problem is not only the epic100 driver, now that
> I have done some more investigation. With the broken drivers (I tried
> 2.4.0-ac12 and 2.4.1-ac5), something generates an enourmous amount of
> interrupts as soon as I run 'ifconfig eth0 up'. Within 10 seconds, I got
> roughly 950000 interrupts on IRQ11, instead of 30!
          ^^^^^^
No wonder the system feels sluggish.

> After disabling the usb-uhci (I was using the JE driver) in the BIOS
> setup, the system reproducibly locked up hard a few seconds after
> 'ifconfig eth0 up' instead of just getting slow.

The following informations may help:
- motherboard type
- bios revision
- lspci -x 
- 2.4.2pre3 + whatever recent ac epic100 = ?

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
