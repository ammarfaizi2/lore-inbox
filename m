Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTGFTOl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 15:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbTGFTOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 15:14:41 -0400
Received: from AMarseille-201-1-2-189.w193-253.abo.wanadoo.fr ([193.253.217.189]:37671
	"EHLO gaston") by vger.kernel.org with ESMTP id S263298AbTGFTOk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 15:14:40 -0400
Subject: Re: [PATCH][2.5.74] fix IDE init oops on PowerMac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Mackerras <paulus@samba.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200307040016.h640GV7o018321@harpo.it.uu.se>
References: <200307040016.h640GV7o018321@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057519727.503.72.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 06 Jul 2003 21:28:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-04 at 02:16, Mikael Pettersson wrote:
> Booting kernel 2.5.74 on a PowerMac with CONFIG_BLK_DEV_IDE_PMAC=y
> results in an oops during IDE init, and the box then reboots.
> .../...

>The patch below updates drivers/ide/ppc/pmac.c to also set up the
> hwif->ide_dma_queued_off and hwif->ide_dma_queued_on function
> pointers, which fixes the oops. Tested on my ancient PM4400.

Patch is fine, actually, it's already in my tree though my version
of this driver isn't merged yet as it depends on the other changes
to the "macio" driver model that I haven't pushed upstream so far.

Linus, can you apply please ?

Thanks,
Ben.

diff -ruN linux-2.5.74/drivers/ide/ppc/pmac.c
linux-2.5.74.ide-pmac-fixes/drivers/ide/ppc/pmac.c
--- linux-2.5.74/drivers/ide/ppc/pmac.c	2003-05-28 22:16:00.000000000
+0200
+++ linux-2.5.74.ide-pmac-fixes/drivers/ide/ppc/pmac.c	2003-07-04
00:45:05.000000000 +0200
@@ -1514,6 +1514,8 @@
 	ide_hwifs[ix].ide_dma_timeout = &__ide_dma_timeout;
 	ide_hwifs[ix].ide_dma_retune = &__ide_dma_retune;
 	ide_hwifs[ix].ide_dma_lostirq = &pmac_ide_dma_lostirq;
+	ide_hwifs[ix].ide_dma_queued_on = &__ide_dma_queued_on;
+	ide_hwifs[ix].ide_dma_queued_off = &__ide_dma_queued_off;
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
 	if (!noautodma)

