Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVCDAbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVCDAbW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262809AbVCDA3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:29:03 -0500
Received: from news.cistron.nl ([62.216.30.38]:45279 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261299AbVCDAYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:24:10 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: 2.6.11: iostat values broken, or IDE siimage driver ?
Date: Fri, 4 Mar 2005 00:24:07 +0000 (UTC)
Organization: Cistron
Message-ID: <d089r7$iuq$1@news.cistron.nl>
References: <d053g8$6et$1@news.cistron.nl> <d05513$8fr$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1109895847 19418 194.109.0.112 (4 Mar 2005 00:24:07 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <d05513$8fr$1@news.cistron.nl>,
Miquel van Smoorenburg <miquels@cistron.nl> wrote:
>In article <d053g8$6et$1@news.cistron.nl>,
>Miquel van Smoorenburg <miquels@cistron.nl> wrote:
>>I just upgrades one of our newsservers from 2.6.9 to 2.6.11. I
>>use "iostat -k -x 2" to see live how busy the disks are. But
>>I don't believe that Linux optimizes things so much that a disk
>>can be 1849.55% busy :)
>
>Perhaps this is the cause:
>
>Mar  2 19:55:25 hdg: sata_error = 0x00000000, watchdog = 0,
>siimage_mmio_ide_dma_test_irq
>Mar  2 19:55:26 quantum last message repeated 12 times
>hdg: sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq

I just recompiled and reconfigured with libata sata_sil.c instead
of ide siimage.c, and now everything just works fine.

I just noticed this in dmesg:

** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.

.. so perhaps that might causing siimage.c to break, but this
being a production server now catching up with a backlog I can't
try it right away.

Mike.

