Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754632AbWKHSBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbWKHSBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754634AbWKHSBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:01:03 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35280 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1754632AbWKHSBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:01:01 -0500
Subject: Re: VIA IRQ quirk missing PCI ids since 2.6.16.17
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>, akpm@osdl.org,
       Wilco Beekhuizen <wilcobeekhuizen@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061108202218.8f542fbf.vsu@altlinux.ru>
References: <6c4c86470611060338j7f216e26od93e35b4b061890e@mail.gmail.com>
	 <1162817254.5460.4.camel@localhost.localdomain>
	 <1162847625.10086.36.camel@localhost.localdomain>
	 <20061108202218.8f542fbf.vsu@altlinux.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Nov 2006 18:05:30 +0000
Message-Id: <1163009130.23956.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-11-08 am 20:22 +0300, ysgrifennodd Sergey Vlasov:
> Hmm, the old comment mentions 686A/B explicitly - seems that these old
> chips also use PCI_INTERRUPT_LINE to control interrupt routing.  Is it
> correct to ignore them here?  Yes, that chips used PCI and not VLink,
> but they also had an internal PIC (and even internal IO-APIC).
> 
> Unfortunately, I no longer have such hardware available.

I have enough docs to extend this approach to those chips if neccessary.
Anyone got an old 686 board to check.

> > +	/* May not be needed for the 8237 */
> > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8237), 15 },
> > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8237A), 15 },
> 
> 8237 definitely uses PCI_INTERRUPT_LINE to control interrupt routing in
> PIC mode - tested with the audio part by writing bogus values with
> setpci and checking whether interrupts are delivered.

Ok

> If there is no VIA ISA bridge in the system, this won't cache anything.

I no, thats noted in the comments when I posted the diff. If it works
I'll cache ->driver_data instead.

> > -int pci_dev_present(const struct pci_device_id *ids)
> > +struct pci_device_id *pci_find_present(const struct pci_device_id *ids)
> 
> New API without proper refcounting?  Ewww.

pci_device_id objects are not refcounted and don't vanish underneath us.
Devices may but we aren't dealing in devices. The function operates
under the list lock internally so should be safe.

Alan

