Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVBARIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVBARIH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 12:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVBARHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 12:07:47 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:9423 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262079AbVBARHh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 12:07:37 -0500
Date: Tue, 1 Feb 2005 18:00:48 +0100 (CET)
To: greg@kroah.com, aurelien@aurel32.net
Subject: Re: [PATCH 2.6] I2C: New chip driver: sis5595
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <UG87F3dV.1107277247.9606340.khali@localhost>
In-Reply-To: <20050201165434.GD23118@kroah.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Alexey Dobriyan" <adobriyan@mail.ru>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "LM Sensors" <sensors@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg & all,

> > +/* Locate SiS bridge and correct base address for SIS5595 */
> > +static int sis5595_find_sis(int *address)
> > +{
> > +	u16 val;
> > +	int *i;
> > +
> > +	if (!(s_bridge =
> > +	    pci_get_device(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503, NULL)))
> > +		return -ENODEV;
>
> You never free the reference you grabbed on the pci_dev here.  Please
> read the docs on how pci_get_device() is to be used, it isn't just a
> drop in replacement for pci_find_device(), sorry.
>
> > +	/* Look for imposters */
> > +	for(i = blacklist; *i != 0; i++) {
> > +		if (pci_get_device(PCI_VENDOR_ID_SI, *i, NULL)) {
>
> Same here, you are leaking a reference count.
>
> Why are you not using the pci driver interface instead?

Not sure it exactly answers your question, but the sis5595 much
ressembles the via686a in that respect, i.e. it isn't driving a PCI
device, merely grabbing the ISA I/O address data from PCI configuration
space, then driving that ISA device. I'd guess that whatever was done
in via686a (including the recent updates) should work equally well for
the sis5595.

Thanks,
--
Jean Delvare
