Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266731AbUHCRIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266731AbUHCRIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 13:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUHCRIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 13:08:53 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:29579 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266731AbUHCRIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 13:08:51 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Tue, 3 Aug 2004 10:07:00 -0700
User-Agent: KMail/1.6.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
References: <20040803023206.68123.qmail@web14921.mail.yahoo.com>
In-Reply-To: <20040803023206.68123.qmail@web14921.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408031007.00924.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 2, 2004 7:32 pm, Jon Smirl wrote:
> My original version have this in it:
>
> /* assign the ROM an address if it doesn't have one */
> if (r->parent == NULL)
>    pci_assign_resource(dev->pdev, PCI_ROM_RESOURCE);
>
>
> if (r->parent) {
>     release_resource(r);
>     r->flags &= ~PCI_ROM_ADDRESS_ENABLE;
>     r->end -= r->start;
>     r->start = 0;
> }
>
> I was running this code on both 2.4/2.6 but I may have needed to do
> this for 2.4. Is it consistent to have pci_assign_resource() and then
> use release_resource()?
>
> My i875P AGP controller has a ROM on it as well as my two video cards.

So it seems there's some redundancy here--some platforms will map the ROMs at 
discovery time while on others we have to map them explicitly?  Which should 
we count on?  I was assuming the former in the last patch I posted, and would 
like to keep it that way unless there's some reason not to.

Thanks,
Jesse
