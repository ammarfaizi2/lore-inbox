Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267895AbRGROe4>; Wed, 18 Jul 2001 10:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267894AbRGROeq>; Wed, 18 Jul 2001 10:34:46 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:13842 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S267892AbRGROea>; Wed, 18 Jul 2001 10:34:30 -0400
Reply-To: <frey@scs.ch>
From: "Martin Frey" <frey@scs.ch>
To: "'Alexander Ehlert'" <alexander.ehlert@uni-tuebingen.de>,
        "'Richard B. Johnson'" <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Right Semantics for ioremap, remap_page_range
Date: Wed, 18 Jul 2001 10:34:17 -0400
Message-ID: <011e01c10f96$bb014c20$1b876ace@SCHLEPPDOWN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
x-mimeole: Produced By Microsoft MimeOLE V5.00.2919.6700
In-Reply-To: <Pine.LNX.4.32.0107181445110.809-100000@frodo.sau98.de>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>What I now do is ioremap_nocache and do writel's, readl's on it.
>For the mmap stuff, I just call remap_page_range with the physical
>address that I get from pci_resource_start(). Is that alright?
>I mean it's working for me now, thats most important :)
>
That does not work on an Alpha. The Alpha (at leat my DS20 and
ES40) is happy with result of ioremap feeded into remap_page_range,
or the real CPU physical address (pci_resource_start + 0x80000000000
on Tsunami chipset).
There is an io_remap_page_range, which does a
remap_page_range(virt_to_phys(ioremap(pci_resource_start()))) on
Alpha, but this does not work either.

There must be a portable way to export PCI memory space to user space,
since e.g. the X servers are using that.

Any hints?

Thanks & regards,

Martin
