Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129500AbRBGTsn>; Wed, 7 Feb 2001 14:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbRBGTsd>; Wed, 7 Feb 2001 14:48:33 -0500
Received: from palrel3.hp.com ([156.153.255.226]:53002 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S129500AbRBGTs0>;
	Wed, 7 Feb 2001 14:48:26 -0500
Date: Wed, 7 Feb 2001 11:50:52 -0800 (PST)
From: Grant Grundler <grundler@cup.hp.com>
Message-Id: <200102071950.LAA05408@milano.cup.hp.com>
To: ink@jurassic.park.msu.ru
Subject: 2.4.0 pdev_enable_device() call in setup-bus.c
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,
Can you explain why pci_assign_unassigned_resources()
calls pdev_enable_device() for every PCI device instead
of having each PCI *driver* call pci_enable_device()
as part of driver initialization?

I'm thinking I missed something that a comment in the code
should have explained.

After having written the bulk of PCI support for parisc port, 
I was clearly under the impression the PCI driver was
supposed to call pci_enable_device().  IMHO, it's a *bad* idea
to enable a device when it's driver might not be present.

thanks,
grant

Code from drivers/pci/setup-bus.c:
void __init
pci_assign_unassigned_resources(void)
{
...
	pci_for_each_dev(dev) {
		pdev_enable_device(dev);
	}
}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
