Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVFBB0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVFBB0U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 21:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVFBB0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 21:26:19 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:32653 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261549AbVFBBXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 21:23:10 -0400
Date: Thu, 2 Jun 2005 03:23:09 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Pavel Machek <pavel@ucw.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Mark Lord <lkml@rtr.ca>,
       David Brownell <dbrownell@users.sourceforge.net>
Subject: Re: External USB2 HDD affects speed hda
In-Reply-To: <200506011643.42073.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.58.0506020316240.28167@artax.karlin.mff.cuni.cz>
References: <429BA001.2030405@keyaccess.nl> <429E3338.9000401@keyaccess.nl>
 <429E37BA.7090502@keyaccess.nl> <200506011643.42073.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Jun 2005, David Brownell wrote:

> On Wednesday 01 June 2005 3:33 pm, Rene Herman wrote:
> > Rene Herman wrote:
> >
> > > David Brownell wrote:
> >
> > >> The experiment: verify that only the RUN bit is set on your machine
> > >> too. If "Periodic" and/or "Async" bits are set, then the controller
> > >> is _supposed_ to be issuing DMA transfers over PCI, so less bandwidth
> > >> will be available. Otherwise, not.
> >
> > [ snip ]
> >
> > > and one after switching on the USB2 HDD, when the hdparm result for hda
> > > has dropped to 42 MB/s:
> > >
> > > ===
> > > bus pci, device 0000:00:09.2 (driver 10 Dec 2004)
> > > EHCI 1.00, hcd state 1
> > > structural params 0x00002204
> > > capability params 0x00006872
> > > status a008 Async Recl FLR
> >
> > Only see that "Async" now while rereading. Did you mean that one? If so,
> > I'm right now catting the registers file and that "Async" is toggling on
> > and off continuously. 4 cats in a row:
> >
> > status 0008 FLR
> > status 8008 Async FLR
> > status a008 Async Recl FLR
> > status 0008 FLR
>
> Tbat's strange ... shouldn't do that unless someone's issuing
> requests to the bus.  Which shouldn't happen if no devices are
> hooked up to that bus.  If the "command" register isn't turning
> on async requests, that's particularly strange.
>
> - Dave

Hi

Didn't you just forget to set H-bit in exactly one queue head? If there's
no entry with H-bit set, controller will loop over list of empty heads
again and again.

Mikulas
