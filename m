Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274988AbTHLCjk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 22:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274990AbTHLCjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 22:39:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56967 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S274988AbTHLCjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 22:39:39 -0400
Date: Tue, 12 Aug 2003 03:39:36 +0100
From: Matthew Wilcox <willy@debian.org>
To: Robert Love <rml@tech9.net>
Cc: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk>
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060654733.684.267.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 07:18:53PM -0700, Robert Love wrote:
> Convert GNU-style to C99-style.  I think converting unnamed initializers
> to named initializers is a Good Thing, too.

By and large ... here's a counterexample:

static struct pci_device_id tg3_pci_tbl[] __devinitdata = {
        { PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5700,
          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
        { PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5701,
          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
...

I don't think anyone would appreciate you converting that to:

static struct pci_device_id tg3_pci_tbl[] __devinitdata = {
	{
		.vendor		= PCI_VENDOR_ID_BROADCOM,
		.device		= PCI_DEVICE_ID_TIGON3_5700,
		.subvendor	= PCI_ANY_ID,
		.subdevice	= PCI_ANY_ID,
		.class		= 0,
		.class_mask	= 0,
		.driver_data	= 0,
	},
	{
		.vendor		= PCI_VENDOR_ID_BROADCOM,
		.device		= PCI_DEVICE_ID_TIGON3_5701,
		.subvendor	= PCI_ANY_ID,
		.subdevice	= PCI_ANY_ID,
		.class		= 0,
		.class_mask	= 0,
		.driver_data	= 0,
	},
...

Not unless they're paid by the line ;-)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
