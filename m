Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130151AbRALSNU>; Fri, 12 Jan 2001 13:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130159AbRALSNK>; Fri, 12 Jan 2001 13:13:10 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11539 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130151AbRALSM7>; Fri, 12 Jan 2001 13:12:59 -0500
Subject: Re: ide.2.4.1-p3.01112001.patch
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 12 Jan 2001 18:13:34 +0000 (GMT)
Cc: andre@linux-ide.org (Andre Hedrick), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101120949040.1858-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 12, 2001 09:51:03 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14H8hl-0004ji-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want to see the code to handle the apparent VIA DMA bug. At this point,
> preferably by just disabling DMA on VIA chipsets or something like that
> (if it has only gotten worse since 2.2.x, I'm not interested in seeing any
> experimental patches for it during early 2.4.x).

It hasnt gotten worse, its just its a very specific combination and its a 
well known problem (vendors dont enable auto dma for ide for this reason)
2.2.16 just covers the cases I know about (and slightly overdoes it for now)

> We've already had one major fs corruption due to this, I want that fixed
> _first_.

I've got other reports too. 

The PCI ids I kill autodma on for 2.2 to cover this are:

                /*
                 *      Don't try and tune a VIA 82C586 or 586A
                 */
                if (IDE_PCI_DEVID_EQ(devid, DEVID_VP_IDE))
                {
                        autodma_default = 0;
                        break;
                }
                if (IDE_PCI_DEVID_EQ(devid, DEVID_VP_OLDIDE))
                {
                        autodma_default = 0;
                        break;
                }


PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_82C586_0
PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_82C586_1



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
