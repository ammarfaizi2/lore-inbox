Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265839AbUBJMbC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 07:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265849AbUBJMbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 07:31:02 -0500
Received: from smtp05.web.de ([217.72.192.209]:41993 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S265839AbUBJMbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 07:31:00 -0500
Subject: Problems getting dma working with the sc1200.c ide driver
From: Axel Waggershauser <awagger@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1076416255.1676.6.camel@strand.wg>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 10 Feb 2004 13:30:56 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have the <subject> problem and tried to contact Mark Lord, which seems
to be the author of the driver. There is no response yet, so I decided to
post it here...

I have a peace of hardware called "X-board" in front of me (if your are
interested: http://www.jumptec.de/product/data/xboard/xb-861.html). It is
based on the Geode SC1200 cpu. This module is plugged into a development
board which I connected a standard IDE drive to.

I tried to get dma access working with a 2.4 and the 2.6.2 kernel without
success. The 2.6.2 kernel compiled with CONFIG_IDEDMA_PCI_AUTO=y hangs at
boot with the last line on the screen containing
"sc1200_set_xfer_mode(UDMA2)". Both kernel versions compiled without
CONFIG_IDEDMA_PCI_AUTO=y boot fine, but trying to enable dma with hdparm
after boot fails with "SC1200: set xfer mode failure". I took a look at the
2.6.2 driver code and found that if IDEDMA_PCI_AUTO is not configured every
attempt to enable dma later on fails because sc1200_autoselect_dma_mode()
returns 0 since hwif->autodma is false. So without the IDEDMA_PCI_AUTO option
(which locks my machine) there seems to be no way to enable dma, or is there?

I did not further try to track down the lockup, yet. I could start debugging
this on the level of "inserting printks". I have no knowledge of the IDE
part of the kernel, though.

I have seen lines like:

	if (!((d->device == PCI_DEVICE_ID_CYRIX_5530_IDE && d->vendor == PCI_VENDOR_ID_CYRIX)
	     ||(d->device == PCI_DEVICE_ID_NS_SCx200_IDE && d->vendor == PCI_VENDOR_ID_NS)))
	{
	    hwif->autodma = 0;
	}

which I do not understand in their context but made me suspect that
dma is not really expected to work on this setup.


I would appreciate any help or hints to a solution.


Thanks,
Axel.

