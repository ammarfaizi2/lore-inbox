Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbTFQMkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 08:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbTFQMkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 08:40:24 -0400
Received: from dp.samba.org ([66.70.73.150]:40328 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264701AbTFQMkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 08:40:23 -0400
Date: Tue, 17 Jun 2003 22:49:50 +1000
From: Anton Blanchard <anton@samba.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matthew Wilcox <willy@debian.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030617124950.GF8639@krispykreme>
References: <1055341842.754.3.camel@gaston> <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk> <20030617044948.GA1172@krispykreme> <20030617134156.A2473@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030617134156.A2473@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 
> Err, this definitely breaks X on alpha. On small and mid-range
> machines we always have pci_domain_nr(bus) == bus->number.
> Practically, it's only Marvel where we could overflow an 8-bit
> bus number.

OK.
 
> How about this instead?
> 
> 	/* Backwards compatibility for first N PCI domains. */
> 	if (pci_domain_nr(dev->bus) > PCI_PROC_MAX_DOMAIN)
> 		return 0;
> 
> PCI_PROC_MAX_DOMAIN could be defined in asm/pci.h (255 on alpha), default 0.

A runtime test would be useful, at least for ppc64. That would allow our
older machines to work (multiple host bridges without overlapping
buses). What if we had pci_proc_max_domain and arch code could change its
value during pcibios_init?

Anton
