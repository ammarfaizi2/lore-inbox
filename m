Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270066AbTHLL1c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 07:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270081AbTHLL1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 07:27:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33694 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270066AbTHLL1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 07:27:31 -0400
Date: Tue, 12 Aug 2003 12:27:29 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <willy@debian.org>, Robert Love <rml@tech9.net>,
       CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk>
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost> <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk> <20030812053826.GA1488@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812053826.GA1488@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 10:38:27PM -0700, Greg KH wrote:
> On Tue, Aug 12, 2003 at 03:39:36AM +0100, Matthew Wilcox wrote:
> > I don't think anyone would appreciate you converting that to:
> > 
> > static struct pci_device_id tg3_pci_tbl[] __devinitdata = {
> > 	{
> > 		.vendor		= PCI_VENDOR_ID_BROADCOM,
> > 		.device		= PCI_DEVICE_ID_TIGON3_5700,
> > 		.subvendor	= PCI_ANY_ID,
> > 		.subdevice	= PCI_ANY_ID,
> > 		.class		= 0,
> > 		.class_mask	= 0,
> > 		.driver_data	= 0,
> > 	},
> 
> I sure would.  Oh, you can drop the .class, .class_mask, and
> .driver_data lines, and then it even looks cleaner.
> 
> I would love to see that kind of change made for pci drivers.

I really strongly disagree.  For a struct that's as well-known as
pci_device_id, the argument of making it clearer doesn't make sense.
It's also not subject to change, unlike say file_operations, so the
argument of adding new elements without breaking anything is also not
relevant.

In tg3, the table definition is already 32 lines long with 2 lines per
device_id.  In the scheme you favour so much, that becomes 92 lines, for
no real gain that I can see.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
