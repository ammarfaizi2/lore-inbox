Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbUADDt3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 22:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbUADDt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 22:49:29 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:47033 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265111AbUADDt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 22:49:27 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Davin McCall <davmac@ozonline.com.au>
Subject: Re: [PATCH] fix issues with loading PCI ide drivers as modules (linux 2.6.0)
Date: Sun, 4 Jan 2004 04:52:17 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au> <200401040256.57419.bzolnier@elka.pw.edu.pl> <20040104142141.2bf4f230.davmac@ozonline.com.au>
In-Reply-To: <20040104142141.2bf4f230.davmac@ozonline.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401040452.17659.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 of January 2004 04:21, Davin McCall wrote:
> However, there are still two genuine but easily solveable problems that I
> can see:
>
> 1) unless "idex=base,ctl,irq" is used, the hwif->chipset is left as
> "ide_unknown" (this means for that the hwif can get re-allocated in
> setup-pci.c - ide_match_hwif() - and clobbered)

Hmm.  What if hwif is freed by a driver?

> 2) if "idex=base,ctl,irq" IS used, the hwif structure will still get
> clobbered when a PCI chipset module is loaded.
>
> What about this is a solution to these problems:
>  - set hwif->chipset to "ide_generic" instead of leaving it as
> "ide_unknown" (ide-probe.c); - if ide_match_hwif() returns an already
> allocated hwif, do not clobber it in ide_hwif_configure() (setup-pci.c)

This brakes "idex=base..." parameters for PCI chipsets.
They shouldn't be needed in this case, but...

--bart

