Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030707AbWFOPn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030707AbWFOPn2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 11:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030672AbWFOPn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 11:43:28 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:19091 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1030707AbWFOPn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 11:43:27 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Subject: Re: [PATCH 7/7] CCISS: run through Lindent
Date: Thu, 15 Jun 2006 09:42:37 -0600
User-Agent: KMail/1.8.3
Cc: "ISS StorageDev" <iss_storagedev@hp.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
References: <D4CFB69C345C394284E4B78B876C1CF10C524A07@cceexc23.americas.cpqcorp.net>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF10C524A07@cceexc23.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606150942.37627.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 June 2006 08:49, Miller, Mike (OS Dev) wrote
> > -----Original Message-----
> > From: Helgaas, Bjorn 
> > Sent: Wednesday, June 14, 2006 6:14 PM
> > To: Miller, Mike (OS Dev)
> > Cc: ISS StorageDev; linux-kernel@vger.kernel.org; Andrew Morton
> > Subject: [PATCH 7/7] CCISS: run through Lindent
> > 
> > cciss is full of inconsistent style ("for (" vs. "for(", lines that
> > end with whitespace, lines beginning with a mix of spaces & 
> > tabs, etc).
> > 
> > This patch changes only whitespace.
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> I agree that we had lots of whitespace garbage and inconsistent styles
> in the driver but I'm not sure I like all the indentation being removed
> from the product table. It makes it a bit harder to read, IMO.

If you are OK with the patch other than the product table, how about
if you apply the patch as-is, and I post a follow-on patch to fix the
indentation?

I'm contemplating more than just a white-space change, and it'd
probably be better to keep the "indent" patch to be white-space
changes only.

The cciss_pci_device_id[] table lists a bunch of subvendor and
subdevice IDs.  Is there any reason to check those sub-IDs
explicitly?  In other words, we currently list:

        {PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISS,
         0x0E11, 0x4070, 0, 0, 0},

Could we replace that with:

        {PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISS,
         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},

This would potentially make the driver claim additional devices.
But do COMPAQ/CISS devices with sub-IDs other than the listed ones
really exist anyway?

Bjorn
