Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVACWyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVACWyS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVACWwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:52:04 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:12978 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261896AbVACWsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:48:47 -0500
Subject: Re: [ide] clean up error path in do_ide_setup_pci_device()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <58cb370e050103142269e1f67f@mail.gmail.com>
References: <200412310343.iBV3hqvd015595@hera.kernel.org>
	 <1104773262.13302.3.camel@localhost.localdomain>
	 <58cb370e050103142269e1f67f@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104788671.13302.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 03 Jan 2005 21:44:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-03 at 22:22, Bartlomiej Zolnierkiewicz wrote:
> > Nothing in the IDE specification requires the PCI IDE controller be the
> > only use of that PCI function. The damage is probably minimal as it
> > deals with error paths but this change should be reverted (and will be
> > for -ac).
> 
> Different PCI functions should have different struct pci_dev instances
> so is this really a problem?

Different PCI functions are but nothing requires that the PCI function
that is the IDE controller is only the IDE controller. In some cases
other logic lives in the "spare" BAR register areas of the device.

One example where the weird design makes it obvious is the CS5520. Here
the 5520 bridge has the IDE in one BAR and all sorts of other logic
(including the xBUS virtual ISA environment) in the same PCI function.
On that chip a pci_disable_device on the IDE pci_dev turns off mundane
things like the timer chips keyboard and mouse 8).

Other vendors do equally evil things and providing the chip reports IDE
class and has the IDE BARs set up nobody else is any the wiser and
presumably gate count goes down.

Alan

