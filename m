Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267993AbUHXP1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267993AbUHXP1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267941AbUHXP1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:27:15 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:40890 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S268031AbUHXP06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:26:58 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Terence Ripperda <tripperda@nvidia.com>
Subject: Re: 2.6.8.1-mm2 (nvidia breakage)
Date: Tue, 24 Aug 2004 09:26:42 -0600
User-Agent: KMail/1.6.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Michael Geithe <warpy@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mastergoon@gmail.com
References: <20040819092654.27bb9adf.akpm@osdl.org> <200408230930.18659.bjorn.helgaas@hp.com> <20040823190131.GC1303@hygelac>
In-Reply-To: <20040823190131.GC1303@hygelac>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408240926.42665.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 August 2004 1:01 pm, Terence Ripperda wrote:
> On Mon, Aug 23, 2004 at 09:30:18AM -0600, bjorn.helgaas@hp.com wrote:
> > Of course, the nvidia driver still won't work
> > because it's looking at pci_dev->irq before calling pci_enable_device(),
> > but that's a separate issue.
> 
> as Alan pointed out, the video device is bios configured, so may not
> be hit by this. nonetheless, we've applied a patch along these lines
> to our internal codebase.

To be pedantically clear about this, looking at pci_dev->irq before
calling pci_enable_device() is *guaranteed* to fail, regardless of
what the BIOS does.  So nvidia users will have to use "pci=routeirq"
until there's a new version of the nvidia driver.

Alan was specifically referring to the BAR configuration that may
be done by the BIOS.

I'm assuming your patch makes the driver call pci_enable_device()
before using either irq or BAR information.  That's the best way
to future-proof the driver.
