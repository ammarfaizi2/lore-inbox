Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbUCWQhA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 11:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbUCWQhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 11:37:00 -0500
Received: from mail.cyclades.com ([64.186.161.6]:62879 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262673AbUCWQg5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 11:36:57 -0500
Date: Tue, 23 Mar 2004 14:18:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 070] NCR53C9x unused SCp.have_data_in
In-Reply-To: <Pine.GSO.4.58.0403231634241.8977@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.58L.0403231415310.2896@logos.cnet>
References: <200403221000.i2MA0DJ1004102@callisto.of.borg>
 <Pine.LNX.4.58L.0403231212300.2368@logos.cnet>
 <Pine.GSO.4.58.0403231634241.8977@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Mar 2004, Geert Uytterhoeven wrote:

> On Tue, 23 Mar 2004, Marcelo Tosatti wrote:
> > On Mon, 22 Mar 2004, Geert Uytterhoeven wrote:
> > > NCR53C9x: Remove unused initialization of SCp.have_data_in (from Maciej W.
> > > Rozycki). This affects the following drivers:
> > >   - Amiga Oktagon SCSI
> > >   - DECstation SCSI
> > >
> > > The change for DECstation SCSI sneaked in through a MIPS update.
> > >
> > > --- linux-2.4.26-pre5/drivers/scsi/NCR53C9x.c	Sat Aug 17 14:10:41 2002
> > > +++ linux-m68k-2.4.26-pre5/drivers/scsi/NCR53C9x.c	Wed Jan 22 12:07:13 2003
> > > @@ -917,7 +917,7 @@
> > >  		if (esp->dma_mmu_get_scsi_one)
> > >  			esp->dma_mmu_get_scsi_one(esp, sp);
> > >  		else
> > > -			sp->SCp.have_data_in = (int) sp->SCp.ptr =
> > > +			sp->SCp.ptr =
> > >  				(char *) virt_to_phys(sp->request_buffer);
> > >  	} else {
> > >  		sp->SCp.buffer = (struct scatterlist *) sp->buffer;
> > > --- linux-2.4.26-pre5/drivers/scsi/oktagon_esp.c	Mon Apr  1 13:02:02 2002
> > > +++ linux-m68k-2.4.26-pre5/drivers/scsi/oktagon_esp.c	Wed Jan 22 12:07:17 2003
> > > @@ -548,7 +548,7 @@
> > >
> > >  void dma_mmu_get_scsi_one(struct NCR_ESP *esp, Scsi_Cmnd *sp)
> > >  {
> > > -        sp->SCp.have_data_in = (int) sp->SCp.ptr =
> > > +        sp->SCp.ptr =
> > >                  sp->request_buffer;
> > >  }
> >
> > Can't we live with this?
>
> Yes.
>
> > Is removing it fixing any problem?
>
> No, it's just a cleanup.
>
> > Yes, I'm being picky.
>
> In that case, you can drop it.
>
> (BTW, picky for 2.4.26-rc*, or for 2.4 in general?)

Picky in general for 2.4. In this case specifically I feel the cleanup
can possibly, "remotely" cause some issues. Better to be off.

