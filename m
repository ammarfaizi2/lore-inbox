Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269702AbTGJX3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269703AbTGJX3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:29:02 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:54182 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S269702AbTGJX2t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:28:49 -0400
Date: Fri, 11 Jul 2003 01:43:06 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Steven Dake <sdake@mvista.com>
cc: Samuel Flory <sflory@rackable.com>,
       Chad Kitching <CKitching@powerlandcomputers.com>,
       <linux-kernel@vger.kernel.org>, <andre@linux-ide.org>
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21,
 patchattached to fix
In-Reply-To: <3F0DF5B8.9040304@mvista.com>
Message-ID: <Pine.SOL.4.30.0307110132220.7938-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Jul 2003, Steven Dake wrote:

> Samuel Flory wrote:
>
> > Steven Dake wrote:
> >
> >> Even with special fasttrack feature enabled, my disk devices on the
> >> PDC20276 is not found.  There is code in pci-setup.c which blocks
> >> other PDC controllers, why not the 20276?  Is that code for some
> >> other purpose, or orthagonal to the force option?
> >
> >
> >  The comments would seem to indicate that this is only needed if you
> > have a second controller.  Which leads me to wonder what if I have 3
> > or 4 pdc controllers.
>
> Hmm thats not how I read the code.  My system has a standard IDE device

Hmmm... read the code again :-).

> as part of the chipset, and then also has a fasttrack controller.  The
> fasttrack controller comes in 2nd, (hence making it the 2nd controller
> and making it marked disabled).  I think your right about the 3rd/4th
> controller though, what happens to those !
> -steve
>
> >
> >        for (port = 0; port <= 1; ++port) {
> >                ide_pci_enablebit_t *e = &(d->enablebits[port]);
> >
> >                /*
> >                 * If this is a Promise FakeRaid controller,
> >                 * the 2nd controller will be marked as
> >                 * disabled while it is actually there and enabled
> >                 * by the bios for raid purposes.
> >                 * Skip the normal "is it enabled" test for those.
> >                 */
> >                if (((d->vendor == PCI_VENDOR_ID_PROMISE) &&
> >                     ((d->device == PCI_DEVICE_ID_PROMISE_20262) ||
> >                      (d->device == PCI_DEVICE_ID_PROMISE_20265))) &&
> >                    (secondpdc++==1) && (port==1))
> >                        goto controller_ok;

I think this test in reality does something different then comment states.

For first port of PDC20262/65 this test increases secondpdc variable
(so it is 1 after test). For second port this test is true
(its PDC20262/65 && secondpdc == 1 && port == 1) so we don't test whether
2nd port (not controller!) of 1st controller is enabled.

Or I am reading it wrong?
--
Bartlomiej

