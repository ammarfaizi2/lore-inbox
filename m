Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030789AbWFOQ2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030789AbWFOQ2d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 12:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030794AbWFOQ2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 12:28:33 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:1976 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1030789AbWFOQ2d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 12:28:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 7/7] CCISS: run through Lindent
Date: Thu, 15 Jun 2006 11:28:29 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10C524B1D@cceexc23.americas.cpqcorp.net>
In-Reply-To: <200606150942.37627.bjorn.helgaas@hp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 7/7] CCISS: run through Lindent
Thread-Index: AcaQknG8mwhgbtQyRJeURe9MCBNArAAAHPCw
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Helgaas, Bjorn" <bjorn.helgaas@hp.com>
Cc: "ISS StorageDev" <iss_storagedev@hp.com>, <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 15 Jun 2006 16:28:30.0050 (UTC) FILETIME=[BC9D6C20:01C69098]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Helgaas, Bjorn 
> Sent: Thursday, June 15, 2006 10:43 AM
> To: Miller, Mike (OS Dev)
> Cc: ISS StorageDev; linux-kernel@vger.kernel.org; Andrew Morton
> Subject: Re: [PATCH 7/7] CCISS: run through Lindent
> 
> On Thursday 15 June 2006 08:49, Miller, Mike (OS Dev) wrote
> > > -----Original Message-----
> > > From: Helgaas, Bjorn
> > > Sent: Wednesday, June 14, 2006 6:14 PM
> > > To: Miller, Mike (OS Dev)
> > > Cc: ISS StorageDev; linux-kernel@vger.kernel.org; Andrew Morton
> > > Subject: [PATCH 7/7] CCISS: run through Lindent
> > > 
> > > cciss is full of inconsistent style ("for (" vs. "for(", 
> lines that 
> > > end with whitespace, lines beginning with a mix of spaces & tabs, 
> > > etc).
> > > 
> > > This patch changes only whitespace.
> > > 
> > > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > 
> > I agree that we had lots of whitespace garbage and 
> inconsistent styles 
> > in the driver but I'm not sure I like all the indentation being 
> > removed from the product table. It makes it a bit harder to 
> read, IMO.
> 
> If you are OK with the patch other than the product table, 
> how about if you apply the patch as-is, and I post a 
> follow-on patch to fix the indentation?
> 
> I'm contemplating more than just a white-space change, and 
> it'd probably be better to keep the "indent" patch to be 
> white-space changes only.

Yes, please submit a follow-on for the indentation.

> 
> The cciss_pci_device_id[] table lists a bunch of subvendor 
> and subdevice IDs.  Is there any reason to check those 
> sub-IDs explicitly?  In other words, we currently list:
> 
>         {PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISS,
>          0x0E11, 0x4070, 0, 0, 0},
> 
> Could we replace that with:
> 
>         {PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISS,
>          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> 
> This would potentially make the driver claim additional devices.
> But do COMPAQ/CISS devices with sub-IDs other than the listed 
> ones really exist anyway?

Please note that we have several pci ids: 

         {PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISS[ABCD],
          0x0E11, 0x4070, 0, 0, 0},

The pci id identifies the controller family such as 53xx, 64xx, etc. We
use the subsystem pci id to identify the particular controller like 641,
642, etc.

I had added this to the driver we release on hp.com:

       { PCI_VENDOR_ID_HP, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
                PCI_CLASS_STORAGE_RAID << 8, 0xffff << 8, 0},

to bind to Smart Array controllers for which I don't have an id. Seems
to work okay but then I need another method for displaying product name,
etc. There are also additional fields in the products struct on which we
rely. Things like number of s/g's and number of outstanding commands,
for instance. These are supposed to be in the firmware's config table
but we find they lie to us most of the time. :)

Lots of words, not much meaning.

mikem

> 
> Bjorn
> 
