Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUHCCcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUHCCcL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 22:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUHCCcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 22:32:11 -0400
Received: from web14921.mail.yahoo.com ([216.136.225.5]:42608 "HELO
	web14921.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262382AbUHCCcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 22:32:07 -0400
Message-ID: <20040803023206.68123.qmail@web14921.mail.yahoo.com>
Date: Mon, 2 Aug 2004 19:32:06 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Jesse Barnes <jbarnes@engr.sgi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <200408021903.39273.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My original version have this in it:

/* assign the ROM an address if it doesn't have one */
if (r->parent == NULL)
   pci_assign_resource(dev->pdev, PCI_ROM_RESOURCE);
                                                                       
                  
if (r->parent) {
    release_resource(r);
    r->flags &= ~PCI_ROM_ADDRESS_ENABLE;
    r->end -= r->start;
    r->start = 0;
}

I was running this code on both 2.4/2.6 but I may have needed to do
this for 2.4. Is it consistent to have pci_assign_resource() and then
use release_resource()?

My i875P AGP controller has a ROM on it as well as my two video cards.


--- Jesse Barnes <jbarnes@engr.sgi.com> wrote:

> On Monday, August 2, 2004 4:30 pm, Alan Cox wrote:
> > What guarantees the ROM already has an assigned PCI address ?
> 
> Presumably the PCI core.  If that's a bad assumption, then clearly
> this code 
> won't work as is and will need additional checks/setup code.
> 
> Jesse
> 

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
