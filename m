Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264304AbUFCOiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbUFCOiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265554AbUFCOiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:38:05 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28382 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264306AbUFCOcR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:32:17 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Frediano Ziglio <freddyz77@tin.it>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>
Subject: Re: 2.6.x partition breakage and dual booting
Date: Thu, 3 Jun 2004 16:35:38 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <40BA2213.1090209@pobox.com> <20040603103907.GV23408@apps.cwi.nl> <1086265833.3988.13.camel@freddy>
In-Reply-To: <1086265833.3988.13.camel@freddy>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406031635.38718.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ please at least cc: linux-ide@ on IDE related mails ]

On Thursday 03 of June 2004 14:30, Frediano Ziglio wrote:
> Il gio, 2004-06-03 alle 12:39, Andries Brouwer ha scritto:
> > On Thu, Jun 03, 2004 at 08:51:35AM +0200, Frediano Ziglio wrote:
> > > Actually I'm writing two patch:
> > >  - extending EDD code to provide DPTE informations and signature for
> > > all drives
> > >  - modify IDE code to match BIOS disks.
> >
> > That second part is undesirable.
> > The Linux IDE code is not interested in getting a conjecture about
> > how other operating systems would name or number the disks.

Exactly.

> > > How to match BIOS with Linux?
> >
> > It is impossible. But you can easily do a 95% job.
> >
> > > I think it's important to know BIOS point of view. Linux provide these
> > > information so we have two choices to solve the problem:
> > > - correct the informations we return
> > > - do not return anything and let user space programs do the job!
> >
> > Yes, leave it to user space. That is what we do today.
>
> Yes and not... HDIO_GETGEO still exists and report inconsistent
> informations. IMHO should be removed. I know this breaks some existing
> programs however these programs do not actually works correctly.

Hm, you are right - HDIO_GETGEO returns different information in 2.4 and 2.6.

Andries, what is your opinion?

> > > - EDD 2.0. I don't understand why Linux code int 41h/46h and ignore
> > > these informations.
> >
> > Long ago, long before EDD, disks actually had a geometry, and it was
> > necessary to find it in order to do I/O to e.g. MFM disks.
> > Today disk geometry is not related to the disk, but to the BIOS.
> > The kernel has no need to know it.
>
> EDD 2.0 information consists of
> - base port
> - control port
> - flags (slave or not)
> - others (DMA, etc)
> In order to be able (for user space programs) to match these
> informations user space programs should be able to read at last base
> port of hdX disks.

You can export needed information through /proc/ide/.

Cheers,
Bartlomiej

