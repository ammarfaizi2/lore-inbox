Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTEVWjq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 18:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTEVWjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 18:39:46 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:27849 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263394AbTEVWjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 18:39:44 -0400
Date: Fri, 23 May 2003 00:52:27 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Ian Molton <spyro@f2s.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE 2.5.69 possible bogosity...
In-Reply-To: <20030522232448.21d7ee2f.spyro@f2s.com>
Message-ID: <Pine.SOL.4.30.0305230044080.27109-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 May 2003, Ian Molton wrote:

> Hi.
>
> Im wondering if this is correct. is the test for initializing in the
> second for loop correct?

Unfortunately, yes.

> Im building an IDE driver into my kernel that calls ide_register_hw()
> twice to register its primary and secondary ports, but only the
> secondary port is recognised. the first fails, since the test in the
> first for loop fails and so does the second, so it then 'unregisters'

Too little information, your MAX_HWIFS and default io ports?

> it, despite never having been registered. somehow, this puts my drive
> INTO the hwif array, so the secondary interface registers OK, passing
> the other tests.

Where is your driver?

> a hack that allowed the primary interface to register was to register it
> twice, but that sucks.
>
> int ide_register_hw (hw_regs_t *hw, ide_hwif_t **hwifp)
> {
>         int index, retry = 1;
>         ide_hwif_t *hwif;
>
>         do {
>                 for (index = 0; index < MAX_HWIFS; ++index) {
>                         hwif = &ide_hwifs[index];
>                         if (hwif->hw.io_ports[IDE_DATA_OFFSET] ==
> hw->io_ports[IDE_DATA_OFFSET])
>                                 goto found;
>                 }
>                 for (index = 0; index < MAX_HWIFS; ++index) {
>                         hwif = &ide_hwifs[index];
>
> *** is the test for initialising (not the !initialising one) here ok?
> ***
>
>                     if ((!hwif->present && !hwif->mate && !initializing)
> ||
>                         (!hwif->hw.io_ports[IDE_DATA_OFFSET] &&
> initializing))
>                                 goto found;
>                 }
>                 for (index = 0; index < MAX_HWIFS; index++)
>                         ide_unregister(index);
>         } while (retry--);


