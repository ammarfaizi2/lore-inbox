Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbUL0PhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUL0PhY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbUL0PhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:37:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:44955 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261909AbUL0PhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:37:14 -0500
Subject: Re: Linux 2.6.10-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e04122616577e1bd33@mail.gmail.com>
References: <1104103881.16545.2.camel@localhost.localdomain>
	 <58cb370e04122616577e1bd33@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104157999.20952.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Dec 2004 14:33:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-27 at 00:57, Bartlomiej Zolnierkiewicz wrote:
> Most of these options are pure braindamage (they were obsoleted to
> verify what is what) and they paper over real bugs in core or host drivers.
> 
> What do you need 'serialize' option for?

A whole range of quirky systems, probably in most cases buggy hardware,
BIOS firmware setup bugs and the like but they are there and end users
use them. Its __init code so it is free.

As to real bugs there is probably a good three to six months fixing
needed for the DMA timeout paths having been debugging them, along with
timer/irq races all over the place. I'd rather worry about the fact the
IDE eh code is totally hosed first and realistically needs an ide_eh
thread for error handling akin to the SCSI approach.

> 
> > o       Fix bogus dma_ naming in the 2.6.10 patch       (Alan Cox)
> 
> It is on purpose, we really don't need 'ide_' prefix in ide_hwif_t.
> The rest of ide_dma_* functions will lose ide_* prefix over time.

The current code uses

dma_ for DMA variables
ide_dma_ for functions

Its nice clean and logical. I'll consider moving my IDE code over to
your naming when the naming is consistent again (with or without the
ide_).

Alan

