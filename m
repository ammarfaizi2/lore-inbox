Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265837AbUEUOv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265837AbUEUOv2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 10:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265891AbUEUOv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 10:51:27 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:48796 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265837AbUEUOvS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 10:51:18 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: libata 2.6.5->2.6.6 regression -part II
Date: Fri, 21 May 2004 16:52:25 +0200
User-Agent: KMail/1.5.3
Cc: Brad Campbell <brad@wasp.net.au>, linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1040521102100.11411A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1040521102100.11411A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405211652.25368.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 of May 2004 16:35, Bill Davidsen wrote:
> On Fri, 21 May 2004, Bartlomiej Zolnierkiewicz wrote:
> > On Friday 21 of May 2004 14:06, Bill Davidsen wrote:
> > > Bartlomiej Zolnierkiewicz wrote:
> > > > On Monday 17 of May 2004 18:34, Brad Campbell wrote:
> > > >>G'day all,
> > > >>I caught the suggestion on my last post in the archives, but because
> > > >> I'm not subscribed and wasn't cc'd I can't keep it threaded.
> > > >>
> > > >>I tried backing out the suggested acpi patch (No difference at all),
> > > >> and I managed to get apic to work but it still hangs solid in the
> > > >> same place.
> > > >>
> > > >>dmesg attached.
> > > >>
> > > >>I managed to figure out that the VIA ATA driver captures my sata
> > > >> drives on the via ports, explaining why sata_via misses them, but
> > > >> writing data to those drives (hde & hdg) causes dma timeouts and
> > > >> locks the machine. No useful debug info produced. The machine
> > > >> becomes non-responsive, throws a couple of dma timeouts to the
> > > >> console and then loses all interactivity (keyboard, serial, network)
> > > >> forcing a reset push.
> > > >>
> > > >>Is there any way I can prevent the VIA ATA driver capturing this
> > > >> device? Unfortunately my boot drive is on hda on the on-board VIA
> > > >> ATA interface so I need it compiled in.
> > > >
> > > > Disable the fscking PCI IDE generic driver.
> > > > [ You are not the first one tricked by it. ]
> > > >
> > > > AFAIR support for VIA 8237 was added to it before sata_via.c was
> > > > ready. [ but my memory is... ]
> > >
> > > What would happen if the generic driver was initialized last? That
> > > would let other more specific drivers grab devices first. The model
> > > which comes to mind is a route table, smallest subnet (or in this case
> > > most specific) being used first. Or would that open a whole other nest
> > > of snakes?
> >
> > I think that you are confusing PCI IDE generic driver with IDE generic
> > driver (the latter is already called after the former).
> >
> > Brad's problem was IDE driver (pci/generic.c) vs libata driver
> > (sata_via.c).
>
> I was indeed doing just that, but I guess the sense of the question is
> still valid, what would the implications of doing the sata_via before the
> pci/generic be? Would it address the original problem, and if so what
> would break, if anything? You noted this is not the first time the
> problem has been seen.

It will address this problem but existing systems will break.
This problem is a user error (+unclear documentation).
What you are proposing creates even more problems.

