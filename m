Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264768AbUEETFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264768AbUEETFW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 15:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbUEETFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 15:05:21 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:16028 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264768AbUEETFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 15:05:12 -0400
Date: Wed, 5 May 2004 21:05:10 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove dead drivers/ide/ppc/swarm.c
In-Reply-To: <200405051934.02630.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.55.0405052037430.17021@jurand.ds.pg.gda.pl>
References: <200405040134.22092.bzolnier@elka.pw.edu.pl>
 <Pine.LNX.4.55.0405041621370.32082@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.55.0405051555170.17257@jurand.ds.pg.gda.pl>
 <200405051934.02630.bzolnier@elka.pw.edu.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 May 2004, Bartlomiej Zolnierkiewicz wrote:

> > so barring the completely bogus addresses reported (the interface is
> > decoded at 0x100b0000 and that's MMIO, unrelated to the PCI I/O space -- I
> > guess fixing it would require a significant update to ide-probe.c and
> > elsewhere), it looks OK.  This is in a little-endian configuration -- I'll
> 
> I suppose these are the addresses after ioremap() so no problem here.

 Not even that -- the exact calculation leading to the base address
reported is:

ioremap_nocache(0x100b0000) - ioremap(0xdc000000) + (0x1f0 << 5)

and is really a workaround for no better way of expressing an address of
an MMIO IDE interface (0xdc000000 is the base address of the PCI I/O
space, unswapped).  I see no reason to use virtual addresses for report 
here.

> > recheck for big endianness once I have appropriate userland installed
> > (which is likely not very soon).  It shouldn't matter much, though -- I've
> > checked documentation and I've found out that while the generic bus (the
> > IDE connector is wired to) is big-endian externally, the internal logic
> > does swapping if the system is configured for little-endian operation.
> 
> IDE bus must be always LE independently of system being LE or BE.
> 
> If system is LE this is OK as the internal logic does swapping but in case
> when system is BE swapping is also needed.

 Well, I suppose they have simply swapped bytes at the connector. ;-)  
This is a guess, though, as I lack docs in this area.  The important bit
is the endiannes of the generic bus used here never changes.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
