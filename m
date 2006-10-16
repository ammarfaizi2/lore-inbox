Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWJPRXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWJPRXp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 13:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWJPRXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 13:23:45 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:21723 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750769AbWJPRXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 13:23:44 -0400
Date: Mon, 16 Oct 2006 19:23:41 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: x86-32/64 switch to pci_get API
Message-ID: <20061016172341.GB5385@rhun.haifa.ibm.com>
References: <1161013892.24237.100.camel@localhost.localdomain> <20061016160759.GA14354@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061016160759.GA14354@muc.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 06:07:59PM +0200, Andi Kleen wrote:
> > --- linux.vanilla-2.6.19-rc1-mm1/arch/x86_64/kernel/pci-calgary.c	2006-10-13 15:10:06.000000000 +0100
> > +++ linux-2.6.19-rc1-mm1/arch/x86_64/kernel/pci-calgary.c	2006-10-13 17:14:40.000000000 +0100
> > @@ -879,7 +879,7 @@
> >  
> >  error:
> >  	do {
> > -		dev = pci_find_device_reverse(PCI_VENDOR_ID_IBM,
> > +		dev = pci_get_device_reverse(PCI_VENDOR_ID_IBM,
> >  					      PCI_DEVICE_ID_IBM_CALGARY,
> >  					      dev);
> 
> No put call anywhere?

The put is implicit in the call, since for each dev returned from
pci_get_device_reverse() we then call it with the same dev as the last
('from') parameter. We take a reference to dev elsewhere, just before
we start using it.

In any case these bridges can't be hot-plugged, so as long as the ref
count remains positive, we're fine.

Cheers,
Muli
