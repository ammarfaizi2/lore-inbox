Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265281AbTFZBCl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 21:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbTFZBAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 21:00:30 -0400
Received: from dp.samba.org ([66.70.73.150]:2755 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265247AbTFZA73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:59:29 -0400
Date: Thu, 26 Jun 2003 11:09:32 +1000
From: Anton Blanchard <anton@samba.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] pci_name()
Message-ID: <20030626010932.GA674@krispykreme>
References: <20030625233525.GB451@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030625233525.GB451@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'd kind of like to get rid of pci_dev->slot_name.  It's redundant with
> pci_dev->dev.bus_id, but that's one hell of a search and replace job.
> So let me propose pci_name(pci_dev) as a replacement.  That has the
> benefit of being shorter than either of the others and lets us do fun
> & interesting things later (maybe construct it on the fly for systems
> that want to save 20 bytes per device?).  We can transition it in over
> 2.5/2.6/2.7 and kill pci_dev->slot_name for 2.8.
> 
> Oh, and without killing slot_name immediately, we can save 4 bytes on
> 32-bit platforms by turning it into a pointer to the dev.bus_id.

Works for me, I wanted to hijack pci_dev->slot_name (or the equivalent) so
we print both domain:bus:devfn as well as the system location on ppc64.
The system location makes it easier to work out which slot the card is in.

I dont necessarily need pci_name() since I could do what I want if
pci_dev->slot_name becomes a pointer.

Anton
