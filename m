Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263729AbUDMUIf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 16:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbUDMUIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 16:08:35 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:11982 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S263726AbUDMUIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 16:08:30 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Subject: Re: [PATCH] PCI MSI Kconfig consolidation
Date: Tue, 13 Apr 2004 14:08:17 -0600
User-Agent: KMail/1.6.1
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       "Andi Kleen" <ak@suse.de>
References: <C7AB9DA4D0B1F344BF2489FA165E502404058232@orsmsx404.jf.intel.com>
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E502404058232@orsmsx404.jf.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404131408.17248.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 April 2004 1:16 pm, Nguyen, Tom L wrote:
> On Tuesday, April 13, Bjorn Helgaas wrote:
> 
> > This consolidates the PCI MSI configuration into drivers/pci/Kconfig,
> > removing it from the i386, x86_64, and ia64 Kconfig.
> >
> > It also changes the default for ia64 from "y" to "n".  The default on
> > i386 is "n" already, and I'm not sure why ia64 should be different.
> 
> It looks good; however, it may create a confusion on ia64 because ia64 
> is already vector-based indexing. 

No.  This is one reason why I think the MSI configuration symbol
should be CONFIG_PCI_MSI, not CONFIG_PCI_USE_VECTOR.

The fact that external interrupts in the ia64 architecture include a
number, and that we happen to call that number a "vector", has
nothing to do with PCI MSI.

In fact, I think there's a whole lot more architecture-specific
knowledge that has leaked across into drivers/pci/msi.[ch].  For
example, the MSI capability basically defines just a message address
register and a message data register.  It does not define anything
about the interpretation of either address or data.  So all the stuff
in struct msg_data and struct msg_address (vector, delivery_mode,
level, trigger, dest_id, dest_mode, redirection_hint) looks to me
like Intel-specific knowledge that should be encapsulated in the
arch code.
