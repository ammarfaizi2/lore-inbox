Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUJISTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUJISTL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 14:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267283AbUJISTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 14:19:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62162 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267259AbUJISTC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 14:19:02 -0400
Date: Sat, 9 Oct 2004 19:18:59 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Scott Feldman <sfeldma@pobox.com>
Cc: Hanna Linder <hannal@us.ibm.com>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, ak@suse.de,
       lkml <linux-kernel@vger.kernel.org>, greg@kroah.com
Subject: Re: [KJ] [RFT 2.6] pci-gart.c replace pci_find_device with pci_get_device
Message-ID: <20041009181859.GW16153@parcelfarce.linux.theplanet.co.uk>
References: <87680000.1097276112@w-hlinder.beaverton.ibm.com> <1097342134.3903.14.camel@sfeldma-mobl2.dsl-verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097342134.3903.14.camel@sfeldma-mobl2.dsl-verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2004 at 10:15:34AM -0700, Scott Feldman wrote:
> On Fri, 2004-10-08 at 15:55, Hanna Linder wrote:
> > @@ -81,7 +81,7 @@ static u32 gart_unmapped_entry; 
> >  
> >  #define for_all_nb(dev) \
> >  	dev = NULL;	\
> > -	while ((dev = pci_find_device(PCI_VENDOR_ID_AMD, 0x1103, dev))!=NULL)\
> > +	while ((dev = pci_get_device(PCI_VENDOR_ID_AMD, 0x1103, dev))!=NULL)\
> >  	     if (dev->bus->number == 0 && 				     \
> >  		    (PCI_SLOT(dev->devfn) >= 24) && (PCI_SLOT(dev->devfn) <= 31))
> 
> for_each_pci_dev?

for_each_pci_dev() doesn't take a VENDOR/DEVICE ID pair.
I think this is a mistake.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
