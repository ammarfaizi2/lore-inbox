Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbTIIMrX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 08:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTIIMrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 08:47:23 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:29417 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264080AbTIIMrV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 08:47:21 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Phil Dibowitz <phil@ipom.com>
Subject: Re: Linux IDE bug in 2.4.21 and 2.4.22 ?
Date: Tue, 9 Sep 2003 14:48:36 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20030908225107.GE17108@earthlink.net>
In-Reply-To: <20030908225107.GE17108@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309091448.36231.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 of September 2003 00:51, Phil Dibowitz wrote:
> Hey folks,
>
> I think I may have found a bug in the Linux IDE subsystem
> introduced in 2.4.21 and still present in 2.4.22.

Nope, user error :-).

> SHORT SYNOPSIS: I played with various combinations of drivers, and no
> matter what I do I can only get ONE of the IDE controllers in my machine
> recognized at a time. I find this in both 2.4.21 and 2.4.22.
> Howerver, 2.4.20 and prior were NOT affected.

<...>

> Up until (and including) 2.4.20, my kernel IDE configuration has always
> looked like
>
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECD=m
> CONFIG_BLK_DEV_IDEFLOPPY=m
> CONFIG_BLK_DEV_IDESCSI=m
> CONFIG_BLK_DEV_CMD640=y
> CONFIG_BLK_DEV_CMD640_ENHANCED=y
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_BLK_DEV_ADMA=y
> CONFIG_BLK_DEV_PIIX=y
> CONFIG_PIIX_TUNING=y
> CONFIG_IDEDMA_AUTO=y
> CONFIG_BLK_DEV_IDE_MODES=y
>
> The noteworthy thing about the above is that I'm NOT enabling CMD64X -- the
> CMD640 has always handled the CMD649 PCI IDE controller just fine.

Nope, your CMD649 was handled by generic PCI IDE driver.

> As of 2.4.21, this configuration no longer works -- which is not
> necessarily a bug. I'm almost there, stay with me. =)

Assumption that current .config will work with future kernel versions is *false*.

Just add these two lines to your .config:
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_CMD64X=y

> So the PCI IDE card isn't recognized with the above configuration. So I decided
> to enable the CMD64X driver. This caused my PCI IDE card to be recognized BUT 
> as a side effect, my onboard controller was *NOT* recognized!! At this point
> I had built the CMD64X driver into the kernel.

Your VIA IDE controller was handled by generic IDE chipset driver which
did probe devices *after* PCI controllers are probed, so CMD649 took
ide0 and ide1 first.

--bartlomiej

