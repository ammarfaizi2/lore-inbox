Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269719AbTGKAEu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 20:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269725AbTGKAEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 20:04:49 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:61868 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S269719AbTGKAEg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 20:04:36 -0400
Date: Fri, 11 Jul 2003 02:18:54 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Samuel Flory <sflory@rackable.com>
cc: Steven Dake <sdake@mvista.com>,
       Chad Kitching <CKitching@powerlandcomputers.com>,
       <linux-kernel@vger.kernel.org>, <andre@linux-ide.org>
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21,
 patchattached to fix
In-Reply-To: <3F0DFCC6.3000609@rackable.com>
Message-ID: <Pine.SOL.4.30.0307110215560.7938-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Jul 2003, Samuel Flory wrote:

> Bartlomiej Zolnierkiewicz wrote:
>
> >>>       for (port = 0; port <= 1; ++port) {
> >>>               ide_pci_enablebit_t *e = &(d->enablebits[port]);
> >>>
> >>>               /*
> >>>                * If this is a Promise FakeRaid controller,
> >>>                * the 2nd controller will be marked as
> >>>                * disabled while it is actually there and enabled
> >>>                * by the bios for raid purposes.
> >>>                * Skip the normal "is it enabled" test for those.
> >>>                */
> >>>               if (((d->vendor == PCI_VENDOR_ID_PROMISE) &&
> >>>                    ((d->device == PCI_DEVICE_ID_PROMISE_20262) ||
> >>>                     (d->device == PCI_DEVICE_ID_PROMISE_20265))) &&
> >>>                   (secondpdc++==1) && (port==1))
> >>>                       goto controller_ok;
> >>>
> >>>
> >
> >I think this test in reality does something different then comment states.
>
>   This seems to be a theme with the pdc comments in general.

:-)

> >For first port of PDC20262/65 this test increases secondpdc variable
> >(so it is 1 after test). For second port this test is true
> >(its PDC20262/65 && secondpdc == 1 && port == 1) so we don't test whether
> >2nd port (not controller!) of 1st controller is enabled.
> >
> >Or I am reading it wrong?
> >
>   Don't look at me.  I come to a different conclusion every time I read
> it.  Rereading it a couple of times would seem support your theroy.
> Which makes me wonder why Steven's patch works at all.  Unless for some
> reason the second port needs to be enabled for things to work.  Which

Steven, can you put printks for secondpdc and port into
ide_pci_setup_ports() and get some output for your patch
(without "Special FastTrak Feature")?

--
Bartlomiej

> begs the question why they didn't just test for an odd numbered channel.

