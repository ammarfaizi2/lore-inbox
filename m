Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266426AbUAIHlf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 02:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266428AbUAIHlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 02:41:35 -0500
Received: from mail.scram.de ([195.226.127.117]:17917 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id S266426AbUAIHld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 02:41:33 -0500
Date: Fri, 9 Jan 2004 08:39:28 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@localhost
To: Jesse Barnes <jbarnes@sgi.com>
cc: Grant Grundler <grundler@parisc-linux.org>, linux-kernel@vger.kernel.org,
       jeremy@sgi.com, Matthew Wilcox <willy@debian.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Jame.Bottomley@steeleye.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
In-Reply-To: <20040108173655.GA11168@sgi.com>
Message-ID: <Pine.LNX.4.58.0401090833480.4454@localhost>
References: <20040107175801.GA4642@sgi.com> <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk>
 <20040107222142.GB14951@colo.lackof.org> <20040107230712.GB6837@sgi.com>
 <20040108063829.GC22317@colo.lackof.org> <20040108173655.GA11168@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

> > BTW, Jesse, did you look at part II of Documentation/DMA-ABI.txt?
>
> I remember seeing discussion of the new API, but haven't read that doc
> yet.  Since most drivers still use the pci_* API, we'd have to add a
> call there, but we may as well make the two APIs as similar as possible
> right?

And there are reasons for drivers still using the pci_* API. In tms380tr,
i support both PCI and ISA cards. The pci_* API supports mapping ISA cards
for bus master DMA by passing a NULL for pdev. The new API still fails
because of the BUG_ON(dev->bus != &pci_bus_type). Unfortunately, on 64 bit
platforms like Alpha, the mapping is required to set up the IOMMU.

--jochen
