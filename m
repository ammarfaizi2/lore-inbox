Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280537AbRLQPo3>; Mon, 17 Dec 2001 10:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280583AbRLQPoS>; Mon, 17 Dec 2001 10:44:18 -0500
Received: from copper.ftech.net ([212.32.16.118]:7684 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id <S280537AbRLQPoF>;
	Mon, 17 Dec 2001 10:44:05 -0500
Message-ID: <7C078C66B7752B438B88E11E5E20E72E41A1@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: linux-kernel@vger.kernel.org
Subject: pci_enable_device reports IRQ routing conflict
Date: Mon, 17 Dec 2001 15:41:25 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I am updating a driver for a pci card that has two variants (a long
established and working variant and one with updated hardware), but both are
handled by the same driver.  They are identified with the same vendor id but
a different device id.  During driver initialisation I probe for the cards,
and set them up in terms of getting irq's, io and memory etc.  

The first card has irq5 returned from pci_find_device, the second has irq9
returned.

However when I call pci_enable_device for the second card I get the
following kernel log message:

Dec 17 15:06:37 minion kernel: IRQ routing conflict for 00:0b.0, have irq 9,
want irq 5

The call didn't return an error, so I assume this was a non-fatal.  

I can't see anything wrong with the pci_dev structures, and even when I
probe for the cards in the reverse order I still get the same error message.

When I only have one of the cards present in the system when I load the
driver, then there aren't any problems, it's only when both are physically
installed that the error message is produced.

Has anyone got any ideas where to look to debug this?

I am using RH 7.2 with Kernel 2.4.16

The card
Kevin Curtis
