Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265675AbUADOpQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 09:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265695AbUADOpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 09:45:16 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49902 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265675AbUADOpA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 09:45:00 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Davin McCall <davmac@ozonline.com.au>
Subject: Re: [PATCH] fix issues with loading PCI ide drivers as modules (linux 2.6.0)
Date: Sun, 4 Jan 2004 15:47:52 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au> <200401040452.17659.bzolnier@elka.pw.edu.pl> <20040104173129.60cde487.davmac@ozonline.com.au>
In-Reply-To: <20040104173129.60cde487.davmac@ozonline.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401041547.52615.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 of January 2004 07:31, Davin McCall wrote:
> > > What about this is a solution to these problems:
> > >  - set hwif->chipset to "ide_generic" instead of leaving it as
> > > "ide_unknown" (ide-probe.c); - if ide_match_hwif() returns an already
> > > allocated hwif, do not clobber it in ide_hwif_configure() (setup-pci.c)
> >
> > This brakes "idex=base..." parameters for PCI chipsets.
> > They shouldn't be needed in this case, but...
>
> As far as i can see "idex=base.." is broken for PCI chipsets anyway- if the
> detected PCI base doesn't match the forced one, the PCI will be allocated a
> seperate hwif (ie as a seperate ideX) anyway. So you can't force the base
> port of a PCI-chipset controller.

Yes, but you can force order.

> Do you mean that, if "idex=base..." is give, and the base is correct for
> the PCI device, then it should work ok? If so it seems the easiest way to

Yes.

> fix it is to introduce another dummy chipset type (lets say
> "ide_generic_forced") which is set (instead of ide_generic) when "idex=.."
> is parsed. Then check for this in ide_hwif_configure(). Would also need to
> modify ide_match_hwif() (so it returns a match for "ide_generic_forced" as
> well as for "ide_generic") and ide_probe_init() would have to change
> "ide_generic_force" to "ide_generic" (to handle the case that no PCI
> chipset took control).

Ehh, more hwif->chipset crap.

> So we handle these situations:
> - idex=... specified and no PCI chipset
> - idex=... specified and PCI chipset present
> - PCI chipset module loaded after ide initialization complete

Please explain me why to change current behavior.  "takeover" still want be
possible, so it will be only cosmetic change which complicates code.

--bart

