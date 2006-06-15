Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030745AbWFOQFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030745AbWFOQFA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 12:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030749AbWFOQFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 12:05:00 -0400
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:2253 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S1030745AbWFOQE7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 12:04:59 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 7/7] CCISS: run through Lindent
Date: Thu, 15 Jun 2006 11:01:59 -0500
Message-ID: <5CCF5F0F2514664CBE20FD24BCE17614044D44@cceexc17.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 7/7] CCISS: run through Lindent
thread-index: AcaQknI4aNTDGT+dRAeog8nefcWNmgAApaCC
References: <D4CFB69C345C394284E4B78B876C1CF10C524A07@cceexc23.americas.cpqcorp.net> <200606150942.37627.bjorn.helgaas@hp.com>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Helgaas, Bjorn" <bjorn.helgaas@hp.com>,
       "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: "ISS StorageDev" <iss_storagedev@hp.com>, <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 15 Jun 2006 16:04:51.0910 (UTC) FILETIME=[6F566E60:01C69095]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sometimes there are new devices that need device specific
handling (e.g. max number of commands, no. of SG elements, etc
are bigger or smaller) and an old driver on a new board
might do bad things.  Currently, you can run an old driver
on a new board by explictly telling it to make the attempt
via a command line option, iirc, but having it do it always 
and without user prodding it to do so is less safe.

-- steve


-----Original Message-----
From: Helgaas, Bjorn
Sent: Thu 6/15/2006 10:42 AM
To: Miller, Mike (OS Dev)
Cc: ISS StorageDev; linux-kernel@vger.kernel.org; Andrew Morton
Subject: Re: [PATCH 7/7] CCISS: run through Lindent
 
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

