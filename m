Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266550AbUHOI3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266550AbUHOI3A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 04:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266548AbUHOI3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 04:29:00 -0400
Received: from witte.sonytel.be ([80.88.33.193]:7813 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266547AbUHOI2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 04:28:55 -0400
Date: Sun, 15 Aug 2004 10:28:47 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] depends on PCI DMA API: Adaptec AIC7xxx_old
In-Reply-To: <Pine.GSO.4.58.0407202155260.24931@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.58.0408151024120.1799@waterleaf.sonytel.be>
References: <200407201839.i6KIdo2I015550@anakin.of.borg> <1090353229.1947.7.camel@mulgrave>
 <Pine.GSO.4.58.0407202155260.24931@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2004, Geert Uytterhoeven wrote:
> On Tue, 20 Jul 2004, James Bottomley wrote:
> > On Tue, 2004-07-20 at 13:39, Geert Uytterhoeven wrote:
> > > Adaptec AIC7xxx_old unconditionally depends on the PCI DMA API, so mark it
> > > broken if !PCI
> >
> > Are you sure this is valid?  I thought it used a NULL pci device for
> > EISA (which I hate, but which still apparently works at least on x86).
>
> Wel, I guess we can discuss about that :-)
>
> It uses pci_alloc_consistent() and friends, which are not necessarily defined
> if !PCI. A better solution may be to convert the driver to use the generic DMA
> API instead of the PCI DMA API when PCI is not selected.

In Ottawa you told me this driver really works on ia32 only, so a dependency on
X86 would probably be OK.

However, when grepping through the various defconfigs, it's enabled on ia64 and
ppc (common, pmac, and default), and not on ia32:

| anakin$ find -name "*defconfig*" -type f | xargs grep SCSI_AIC7XXX_OLD  | grep -v 'not set'
| ./arch/ia64/defconfig:CONFIG_SCSI_AIC7XXX_OLD=y
| ./arch/ppc/configs/common_defconfig:CONFIG_SCSI_AIC7XXX_OLD=m
| ./arch/ppc/configs/pmac_defconfig:CONFIG_SCSI_AIC7XXX_OLD=m
| ./arch/ppc/defconfig:CONFIG_SCSI_AIC7XXX_OLD=m

So should I make it depend on X86 || PPC || IA64 instead?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
