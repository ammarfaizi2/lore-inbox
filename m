Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbTEZWpI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTEZWpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:45:08 -0400
Received: from pop.gmx.net ([213.165.65.60]:33525 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262275AbTEZWoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:44:01 -0400
Message-ID: <3ED29BC3.104@gmx.net>
Date: Tue, 27 May 2003 00:57:07 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: drivers/ide/pci/pdc202xx_old.c
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello IDE gurus,

is the following #if 0 in drivers/ide/pci/pdc202xx_old.c intentional?
What makes me worried about the code is that it looks like somebody
wanted to clean up the code for splitoff of pdc202xx_new.c and confused
the two files.
Either the code is really not needed and can be ripped out or it is
needed and was overlooked.

drivers/ide/pci/pdc202xx_old.c:719
        /*
         * software reset -  this is required because the bios
         * will set UDMA timing on if the hdd supports it. The
         * user may want to turn udma off. A bug in the pdc20262
         * is that it cannot handle a downgrade in timing from
         * UDMA to DMA. Disk accesses after issuing a set
         * feature command will result in errors. A software
         * reset leaves the timing registers intact,
         * but resets the drives.
         */
#if 0
        if ((dev->device == PCI_DEVICE_ID_PROMISE_20267) ||
            (dev->device == PCI_DEVICE_ID_PROMISE_20265) ||
            (dev->device == PCI_DEVICE_ID_PROMISE_20263) ||
            (dev->device == PCI_DEVICE_ID_PROMISE_20262)) {
                unsigned long high_16   = pci_resource_start(dev, 4);
                byte udma_speed_flag    = inb(high_16 + 0x001f);
                outb(udma_speed_flag | 0x10, high_16 + 0x001f);
                mdelay(100);
                outb(udma_speed_flag & ~0x10, high_16 + 0x001f);
                mdelay(2000);   /* 2 seconds ?! */
        }

#endif


Thoughts? Comments?

Carl-Daniel

