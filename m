Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131526AbRCMVm1>; Tue, 13 Mar 2001 16:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131482AbRCMVl6>; Tue, 13 Mar 2001 16:41:58 -0500
Received: from bart.one-2-one.net ([195.94.80.12]:34828 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S131260AbRCMVkf>; Tue, 13 Mar 2001 16:40:35 -0500
Date: Tue, 13 Mar 2001 22:41:15 +0100 (CET)
From: Martin Diehl <home@mdiehl.de>
To: Steven Walter <srwalter@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE on 2.4.2
In-Reply-To: <20010312154312.A459@hapablap.dyn.dhs.org>
Message-ID: <Pine.LNX.4.21.0103132126070.2695-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2001, Steven Walter wrote:

> The big man himself, Andre Hedrick, has stated that the SiS5513 should
> work in UDMA/66 mode, as is evidenced by my setup.

right, but depending on the chipset that provides the SiS5513 function

> SIS5513: chipset revision 208
> SIS5513: not 100% native mode: will probe irqs later
> SiS530

So you have a SiS530 northbridge which does provide UDMA66 support. The
SiS5591 and SiS5597 however are not specified for ATA66 and sis5513.c
does not support UDMA66 for them. What makes me somewhat wondering
is that all these chipsets apparently report the same SiS5513 rev. d0. The
datasheet for the SiS5591 however only talks about UDMA33 and marks the
UDMA66 related bits reserved. Look like there were different flavours of
the same PCI vendor/device/revision combination for the IDE controler
function included in the different chipsets.
Anyway, the problem is not to get UDMA66 running on chipsets for which it
might work although not specified, but to solve the "hang during cd-drive
initialisation when sis5513-autotuning enabled" issue.

> And, as you've requested, here is the lspci output from my system, which
> is working and in UDMA66.
[..]

well, it shows some differences wrt. non-ATA66 related bits that are
marked "reserved" in the SiS5591 datasheet. But including some fixup code
into the pci_init_sis5513() doesn't help. So chances are this is a silicon
related issue or similar. My feeling is it's not worth the effort to go
any further because there is a simple workaround: either not including
CONFIG_BLK_DEV_SIS5513 or disabling the autotune on cdrom-drives prevents
the hang (at least for me). Using hdparm provides reasonable ATA33
performance AFAICS.

Martin

