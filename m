Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbUKSURI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbUKSURI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 15:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbUKSUPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 15:15:41 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:36769 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261542AbUKSUNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 15:13:20 -0500
Date: Fri, 19 Nov 2004 21:12:03 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Dorn Hetzel <kernel@dorn.hetzel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: r8169.c
Message-ID: <20041119201203.GA13522@electric-eye.fr.zoreil.com>
References: <20041119162920.GA26836@lilah.hetzel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119162920.GA26836@lilah.hetzel.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dorn Hetzel <kernel@dorn.hetzel.org> :
[Abit AA8 experience]
> 2.6.9, however, was not making happy noises with the ICH6R/AHCI SATA
> controller, and after reviewing changelogs and finding encouraging
> notes, I gave 2.6.10-rc2 a try and I am happy to report that it
> seems to work very well with the AHCI SATA drives.
> 
> 2.6.10-rc2 still uses the 1.2 8169 driver, same as 2.6.9...
> 
> However, the r8169 2.2 driver would not build with 2.6.10-rc2,
> due to use of pci_dma_sync_single.
> 
> I've made a V2.3 of the 8169 driver which uses 
> pci_dma_sync_single_for_cpu instead, and it seems to work fine.
> 
> I was hoping to submit a patch to move the new driver into
> some appropriate release, but the 2.2/2.3 driver is so far
> changed from 1.2 that the diff -u is about the size of the
> original and new file combined :(
[...]
> With such a huge diff, should I send a diff, or the whole new file, or
> do something else entirely?

Do something else:
- take a look at the changes for the 8169 driver in Jeff Garzik's -netdev
  patchkit (included in -mm). It may be interesting to know how it behaves;
- less +/8169 MAINTAINERS;
- provide a more elaborate description of the issue with your computer
  (+ gcc version, lspci -vx, dmesg at boot, lsmod, /proc/interrupts, ifconfig);
- realize that the so called version number in 2.6.9 has no meaning.

Last time I looked at Realtek's driver (linux-8169(220).zip), it still
contained bugs which had been fixed in mainline (though it merges some
part of it) and I did not find anything which should do a difference
from a correctness POV. Intermediate versions of Realtek's code are
not available and the datasheet has disappeared from their website.
With due respect for Realtek's work (serious, really) it does not make
my life fun _at all_ (and I guess that "my" is also accurate for anyone
who tries to work with the 8169 driver on the long run).

Btw merging a 20 megaton patch is not the way network drivers changes
are submitted. People expect a serie of small changes whose effects
are clearly explained (see http://linux.yyz.us/patch-format.html for
the suggested format).

Imho your issue is not completely specific to the 8169 hardware. With
a wet finger in the wind, I'd suspect something related to timing or irq
(duration of locking or such).

Please Cc: netdev@oss.sgi.com on further messages. Cc: jgarzik@pobox.com
for network devices patches is also suggested.

--
Ueimor
