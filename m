Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVJSQwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVJSQwj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 12:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVJSQwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 12:52:39 -0400
Received: from fmr19.intel.com ([134.134.136.18]:29843 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751136AbVJSQwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 12:52:38 -0400
Subject: Re: [ACPI] Re: [Pcihpd-discuss] RE: [patch 2/2] acpi: add ability
	to derive irq when doing a surpriseremoval of an adapter
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: acpi-devel@lists.sourceforge.net, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       "Brown, Len" <len.brown@intel.com>
In-Reply-To: <200510190929.06728.bjorn.helgaas@hp.com>
References: <59D45D057E9702469E5775CBB56411F190A57F@pdsmsx406>
	 <1129053267.15526.9.camel@whizzy> <1129679877.30588.5.camel@whizzy>
	 <200510190929.06728.bjorn.helgaas@hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Oct 2005 09:51:51 -0700
Message-Id: <1129740711.31966.21.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
X-OriginalArrivalTime: 19 Oct 2005 16:52:24.0468 (UTC) FILETIME=[7ADDFD40:01C5D4CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 09:29 -0600, Bjorn Helgaas wrote:
> On Tuesday 18 October 2005 5:57 pm, Kristen Accardi wrote:
> > For surprise hotplug removal, the interrupt pin must be guessed, as any
> > attempts to read it would obviously be invalid.  This patch adds a new
> > function to cycle through all possible pin values, and tries to either
> > lookup or derive the right irq to disable.
> 
> I don't really like this because it adds a new path that's only
> used for "surprise" removals.  So we have acpi_pci_irq_disable(),
> which is used for normal removals, and acpi_pci_irq_disable_nodev()
> for the surprise path.  That feels like a maintenance problem.
> 
> Other, non-ACPI, IRQ routing schemes should have the same problem
> (needing to know the interrupt pin after the device has been removed),
> so maybe the pin needs to be cached in the pci_dev?

This seems like a good idea to me, if nobody objects to adding another
field to pci_dev, I can change the patch to do this and resubmit. 

