Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVHEX5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVHEX5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 19:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVHEX5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 19:57:18 -0400
Received: from palrel10.hp.com ([156.153.255.245]:28649 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262165AbVHEX4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 19:56:16 -0400
Date: Fri, 5 Aug 2005 16:59:37 -0700
From: Grant Grundler <iod00d@hp.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, linville@tuxdriver.com,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       yhlu <yhlu.kernel@gmail.com>
Subject: Re: [openib-general] Re: mthca and LinuxBIOS
Message-ID: <20050805235937.GK25121@esmail.cup.hp.com>
References: <86802c440508051103500f6942@mail.gmail.com> <86802c4405080511079d01532@mail.gmail.com> <52psss5k1x.fsf@cisco.com> <86802c44050805112661d889aa@mail.gmail.com> <86802c4405080512254b9cd496@mail.gmail.com> <86802c4405080512451cdcae48@mail.gmail.com> <86802c44050805132853070f1@mail.gmail.com> <Pine.LNX.4.58.0508051335440.3258@g5.osdl.org> <20050805220015.GA3524@suse.de> <Pine.LNX.4.58.0508051602350.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508051602350.3258@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 04:06:06PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 5 Aug 2005, Greg KH wrote:
> > On Fri, Aug 05, 2005 at 01:38:37PM -0700, Linus Torvalds wrote:
> > 
> > But what's the real problem we are trying to fix here?
> 
> We're screwing up the top 32 bits of the BAR when you resume it. Look at
> the patch, you'll see the fix (the other part of the patch looks fine, but
> then in order to not overwrite the upper bits with zero again when doing
> the _next_ - nonexistent - BAR update, we need to have something that 
> avoids writing the next BAR).

ISTR making comments before about the offending patch on linux-pci mailing
list.  Is this the same patch that assumes pci_dev->resource[i] == BAR[i] ?
That's not true for 64-bit bars.

> Remember: a 64-bit BAR puts the upper 32 bits in what would otherwise be 
> the low 32 bits of the next BAR. Which is why we need to mark the next BAR 
> resource as _not_ being valid some way - so that we don't try to 
> (incorrectly) "restore" it and overwrite the high bits of the previous 
> BAR.

> Of course, this only hits the (very few) people who not only have 64-bit 
> PCI devices, but literally have them mapped in the 4GB+ region.

*lots* of PCI device now have 64-bit BAR.
The first I'm aware of was LSI 53c896 card (Ultra 2 SCSI).

> Quite uncommon.

Assigning 4GB+ regions is uncommon because too often
either the HW, the OS, or the driver would break.
firmware keeps having to worry about legacy OSs.

grant
