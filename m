Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265313AbTLHC6x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 21:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbTLHC6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 21:58:53 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25285 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265309AbTLHC6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 21:58:43 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: Can't disable IDE DMA on 2.6.0-test9 (patch)
Date: Mon, 8 Dec 2003 04:00:40 +0100
User-Agent: KMail/1.5.4
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <16317.18623.912339.111750@wombat.disy.cse.unsw.edu.au> <200312080239.58602.bzolnier@elka.pw.edu.pl> <16339.58195.71921.425034@wombat.chubb.wattle.id.au>
In-Reply-To: <16339.58195.71921.425034@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312080400.40421.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 of December 2003 03:34, Peter Chubb wrote:
> >>>>> "Bartlomiej" == Bartlomiej Zolnierkiewicz
> >>>>> <B.Zolnierkiewicz@elka.pw.edu.pl> writes:
>
> Bartlomiej> On Friday 21 of November 2003 00:05, Peter Chubb wrote:
> >> Hi Folks,
>
> Bartlomiej> Hi,
>
> >> If you try to disable IDE DMA from Kconfig, you'll end up with an
> >> undefined symbol, ide_hwif_setup_dma().
> >>
> >> The attached rather ugly patch fixes the problem by defining a
> >> dummy function.
>
> Bartlomiej> Not exactly.  Disable IDE DMA and enable support for every
> Bartlomiej> PCI chipset.  Now try to compile... welcome to compile
> Bartlomiej> time hell :-).
>
> If you disable IDE_DMA, then the other chipset drivers cannot be
> enabled --- the config system won't let you.
> With IDE_DMA disabled and all chipsets disabled, I see:

They cannot be enabled because they don't compile (see below).

> drivers/built-in.o(.text+0x9f8bc): In function `ide_hwif_setup_dma':
> : undefined reference to `ide_setup_dma'
>
> And *that's* what my patch was supposed to fix.

Indeed it fixes it perfectly.

However this problem (undefined reference to `ide_setup_dma') was created by
your previous patch allowing selection of PCI chipsets if IDE DMA is not set
;-).

I can't apply these patches because they create more problems that they fix.

Here is compile time hell I was talking about (result of both your patches
applied, IDE DMA disabled and all PCI chipset drivers enabled):

drivers/ide/pci/aec62xx.c: In function `init_dma_aec62xx':
drivers/ide/pci/aec62xx.c:490: warning: implicit declaration of function `ide_setup_dma'
drivers/ide/pci/alim15x3.c: In function `ali15x3_dma_write':
drivers/ide/pci/alim15x3.c:565: warning: implicit declaration of function `__ide_dma_write'
drivers/ide/pci/alim15x3.c: In function `init_dma_ali15x3':
drivers/ide/pci/alim15x3.c:846: warning: implicit declaration of function `ide_setup_dma'
drivers/ide/pci/cmd64x.c: In function `cmd64x_ide_dma_end':
drivers/ide/pci/cmd64x.c:535: warning: implicit declaration of function `ide_destroy_dmatable'
drivers/ide/pci/cs5520.c: In function `cs5520_init_setup_dma':
drivers/ide/pci/cs5520.c:214: warning: implicit declaration of function `ide_setup_dma'
drivers/ide/pci/sc1200.c: In function `sc1200_ide_dma_end':
drivers/ide/pci/sc1200.c:333: warning: implicit declaration of function `ide_destroy_dmatable'
drivers/ide/pci/cy82c693.c: In function `cy82c693_ide_dma_on':
drivers/ide/pci/cy82c693.c:213: warning: implicit declaration of function `__ide_dma_on'
drivers/ide/pci/hpt366.c: In function `hpt366_ide_dma_lostirq':
drivers/ide/pci/hpt366.c:577: warning: implicit declaration of function `__ide_dma_lostirq'
drivers/ide/pci/hpt366.c: In function `hpt370_ide_dma_begin':
drivers/ide/pci/hpt366.c:592: warning: implicit declaration of function `__ide_dma_begin'
drivers/ide/pci/hpt366.c: In function `hpt370_ide_dma_end':
drivers/ide/pci/hpt366.c:609: warning: implicit declaration of function `__ide_dma_end'
drivers/ide/pci/hpt366.c: In function `hpt370_ide_dma_timeout':
drivers/ide/pci/hpt366.c:634: warning: implicit declaration of function `__ide_dma_timeout'
drivers/ide/pci/hpt366.c: In function `init_dma_hpt366':
drivers/ide/pci/hpt366.c:1124: warning: implicit declaration of function `ide_setup_dma'
drivers/ide/pci/ns87415.c: In function `ns87415_ide_dma_end':
drivers/ide/pci/ns87415.c:101: warning: implicit declaration of function `ide_destroy_dmatable'
drivers/ide/pci/ns87415.c: In function `ns87415_ide_dma_read':
drivers/ide/pci/ns87415.c:110: warning: implicit declaration of function `__ide_dma_read'
drivers/ide/pci/ns87415.c: In function `ns87415_ide_dma_write':
drivers/ide/pci/ns87415.c:121: warning: implicit declaration of function `__ide_dma_write'
drivers/ide/pci/ns87415.c: In function `ns87415_ide_dma_check':
drivers/ide/pci/ns87415.c:132: warning: implicit declaration of function `__ide_dma_check'
drivers/ide/pci/pdc202xx_old.c: In function `pdc202xx_old_ide_dma_begin':
drivers/ide/pci/pdc202xx_old.c:556: warning: implicit declaration of function `__ide_dma_begin'
drivers/ide/pci/pdc202xx_old.c: In function `pdc202xx_old_ide_dma_end':
drivers/ide/pci/pdc202xx_old.c:572: warning: implicit declaration of function `__ide_dma_end'
drivers/ide/pci/pdc202xx_old.c: In function `pdc202xx_ide_dma_lostirq':
drivers/ide/pci/pdc202xx_old.c:603: warning: implicit declaration of function `__ide_dma_lostirq'
drivers/ide/pci/pdc202xx_old.c: In function `pdc202xx_ide_dma_timeout':
drivers/ide/pci/pdc202xx_old.c:610: warning: implicit declaration of function `__ide_dma_timeout'
drivers/ide/pci/pdc202xx_old.c: In function `init_dma_pdc202xx':
drivers/ide/pci/pdc202xx_old.c:795: warning: implicit declaration of function `ide_setup_dma'
drivers/ide/pci/pdc202xx_new.c: In function `pdcnew_ide_dma_lostirq':
drivers/ide/pci/pdc202xx_new.c:437: warning: implicit declaration of function `__ide_dma_lostirq'
drivers/ide/pci/pdc202xx_new.c: In function `pdcnew_ide_dma_timeout':
drivers/ide/pci/pdc202xx_new.c:444: warning: implicit declaration of function `__ide_dma_timeout'
drivers/ide/pci/serverworks.c: In function `svwks_ide_dma_end':
drivers/ide/pci/serverworks.c:508: warning: implicit declaration of function `__ide_dma_end'
drivers/ide/pci/serverworks.c: In function `init_dma_svwks':
drivers/ide/pci/serverworks.c:754: warning: implicit declaration of function `ide_setup_dma'
drivers/ide/pci/siimage.c: In function `siimage_mmio_ide_dma_count':
drivers/ide/pci/siimage.c:573: warning: implicit declaration of function `__ide_dma_count'
drivers/ide/pci/siimage.c: In function `siimage_mmio_ide_dma_verbose':
drivers/ide/pci/siimage.c:626: warning: implicit declaration of function `__ide_dma_verbose'
drivers/ide/pci/slc90e66.c: In function `init_hwif_slc90e66':
drivers/ide/pci/slc90e66.c:331: warning: unused variable `mask'
drivers/ide/pci/trm290.c: In function `init_hwif_trm290':
drivers/ide/pci/trm290.c:345: warning: implicit declaration of function `ide_setup_dma'
drivers/ide/setup-pci.c:176: warning: `ide_get_or_set_dma_base' defined but not used
drivers/built-in.o(.text+0x54e92): In function `ali15x3_dma_write':
: undefined reference to `__ide_dma_write'
drivers/built-in.o(.text+0x572ef): In function `cmd64x_ide_dma_end':
: undefined reference to `ide_destroy_dmatable'
drivers/built-in.o(.text+0x573e9): In function `cmd646_1_ide_dma_end':
: undefined reference to `ide_destroy_dmatable'
drivers/built-in.o(.text+0x5833f): In function `sc1200_ide_dma_end':
: undefined reference to `ide_destroy_dmatable'
drivers/built-in.o(.text+0x589f5): In function `cy82c693_ide_dma_on':
: undefined reference to `__ide_dma_on'
drivers/built-in.o(.text+0x59d55): In function `hpt366_ide_dma_lostirq':
: undefined reference to `__ide_dma_lostirq'
drivers/built-in.o(.text+0x59dbf): In function `hpt370_ide_dma_begin':
: undefined reference to `__ide_dma_begin'
drivers/built-in.o(.text+0x59e25): In function `hpt370_ide_dma_end':
: undefined reference to `__ide_dma_end'
drivers/built-in.o(.text+0x59f05): In function `hpt370_ide_dma_timeout':
: undefined reference to `__ide_dma_timeout'
drivers/built-in.o(.text+0x59f25): In function `hpt370_ide_dma_lostirq':
: undefined reference to `__ide_dma_lostirq'
drivers/built-in.o(.text+0x59fc5): In function `hpt374_ide_dma_end':
: undefined reference to `__ide_dma_end'
drivers/built-in.o(.text+0x5a458): In function `ns87415_ide_dma_end':
: undefined reference to `ide_destroy_dmatable'
drivers/built-in.o(.text+0x5a491): In function `ns87415_ide_dma_read':
: undefined reference to `__ide_dma_read'
drivers/built-in.o(.text+0x5a4d1): In function `ns87415_ide_dma_write':
: undefined reference to `__ide_dma_write'
drivers/built-in.o(.text+0x5a511): In function `ns87415_ide_dma_check':
: undefined reference to `__ide_dma_check'
drivers/built-in.o(.text+0x5b9ff): In function `pdc202xx_old_ide_dma_begin':
: undefined reference to `__ide_dma_begin'
drivers/built-in.o(.text+0x5ba79): In function `pdc202xx_old_ide_dma_end':
: undefined reference to `__ide_dma_end'
drivers/built-in.o(.text+0x5bb11): In function `pdc202xx_ide_dma_lostirq':
: undefined reference to `__ide_dma_lostirq'
drivers/built-in.o(.text+0x5bb41): In function `pdc202xx_ide_dma_timeout':
: undefined reference to `__ide_dma_timeout'
drivers/built-in.o(.text+0x5cc01): In function `pdcnew_ide_dma_lostirq':
: undefined reference to `__ide_dma_lostirq'
drivers/built-in.o(.text+0x5cc31): In function `pdcnew_ide_dma_timeout':
: undefined reference to `__ide_dma_timeout'
drivers/built-in.o(.text+0x5eb88): In function `svwks_ide_dma_end':
: undefined reference to `__ide_dma_end'
drivers/built-in.o(.text+0x5f7b8): In function `siimage_mmio_ide_dma_count':
: undefined reference to `__ide_dma_count'
drivers/built-in.o(.text+0x5f8d8): In function `siimage_mmio_ide_dma_verbose':
: undefined reference to `__ide_dma_verbose'
drivers/built-in.o(.init.text+0x6c27): In function `init_dma_aec62xx':
: undefined reference to `ide_setup_dma'
drivers/built-in.o(.init.text+0x7201): In function `init_dma_ali15x3':
: undefined reference to `ide_setup_dma'
drivers/built-in.o(.init.text+0x7b69): In function `cs5520_init_setup_dma':
: undefined reference to `ide_setup_dma'
drivers/built-in.o(.init.text+0x8fee): In function `init_dma_hpt366':
: undefined reference to `ide_setup_dma'
drivers/built-in.o(.init.text+0x963d): In function `init_dma_pdc202xx':
: undefined reference to `ide_setup_dma'
drivers/built-in.o(.init.text+0x9731): more undefined references to `ide_setup_dma' follow
make: *** [.tmp_vmlinux1] Error 1

Please correct all chipset drivers and then I will apply all patches happily.

thanks,
--bart

