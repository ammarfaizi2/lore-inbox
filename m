Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVCAAiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVCAAiP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 19:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVCAAgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 19:36:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:16331 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261163AbVCAAf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 19:35:29 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Adam Belay <abelay@novell.com>
Subject: Re: [RFC] PCI bridge driver rewrite
Date: Mon, 28 Feb 2005 16:34:04 -0800
User-Agent: KMail/1.7.2
Cc: Jon Smirl <jonsmirl@gmail.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org
References: <1109226122.28403.44.camel@localhost.localdomain> <200502281538.18881.jbarnes@sgi.com> <1109635997.28403.123.camel@localhost.localdomain>
In-Reply-To: <1109635997.28403.123.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502281634.05197.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 28, 2005 4:13 pm, Adam Belay wrote:
> On Mon, 2005-02-28 at 15:38 -0800, Jesse Barnes wrote:
> > On Monday, February 28, 2005 3:27 pm, Adam Belay wrote:
> > > How can we specify which bus to target?
> >
> > Maybe we could have a list of legacy (ISA?) devices for drivers like
> > vgacon to attach to?  The bus info could be stuffed into the legacy
> > device structure itself so that the platform code would know what to do.
>
> Are these devices actually legacy, or PCI with compatibility interfaces?

So far I've only tried VGA cards, like radeons and r128s.

> I think a "struct isa_device" would be be useful.  Would a pointer to
> the "struct pci_bus" do the trick?

Yeah, that would work for me.

> I was just wondering if we have to reserve a memory range for this?

Sure, each bus can have that address range reserved.  The ia64 specific 
HAVE_PCI_LEGACY code (in arch/ia64/sn/pci/pci_dma.c I think) might illuminate 
things a bit.  Basically, each bus has legacy base addresses, we could 
reserve 64k for port space and 1M for memory.

Jesse
