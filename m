Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280690AbRKFXkS>; Tue, 6 Nov 2001 18:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280691AbRKFXkJ>; Tue, 6 Nov 2001 18:40:09 -0500
Received: from d-dialin-345.addcom.de ([62.96.160.105]:49134 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S280690AbRKFXj5>; Tue, 6 Nov 2001 18:39:57 -0500
Date: Wed, 7 Nov 2001 00:40:05 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PCI like interface for ISAPnP
Message-ID: <Pine.LNX.4.33.0111070025470.9978-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I wrote a driver for some ISDN cards.

For the PCI cards, init is pretty easy:

static struct pci_driver fcpci_driver = {
	name: "fcpci",
	probe: fcpci_probe,
	remove: fcpcipnp_remove,
	id_table: fcpci_ids,
};

[...]

	retval = pci_register_driver(&fcpci_driver);
	if (retval < 0)
		goto out;


As the driver also works with an ISAPnP card, I wanted to be able to
handle this part in the same way:

static struct isapnp_driver fcpnp_driver = {
	name: "fcpnp",
	probe: fcpnp_probe,
	remove: fcpcipnp_remove,
	id_table: fcpnp_ids,
};

[...]

	retval = isapnp_register_driver(&fcpnp_driver);
	if (retval < 0)
		goto out_unregister_pci;

For the time being, I implemented isapnp_{,un}register_driver privately in 
my driver, but I think this is functionality that other people may want to 
use as well. Of course, within the new device framework in 2.5 will change 
again, so this will most likely become obsolete then.

So the question is: Should I provide a generic isapnp_{,un}register_driver 
framework (it's pretty simple anyway), or keep things private to my 
driver?

--Kai



