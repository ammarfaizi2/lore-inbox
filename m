Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271807AbTHRNAT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 09:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271812AbTHRNAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 09:00:19 -0400
Received: from trained-monkey.org ([209.217.122.11]:37895 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S271807AbTHRNAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 09:00:11 -0400
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030817233705.0bea9736.davem@redhat.com>
	<m3r83jyw2k.fsf@defiant.pm.waw.pl>
From: Jes Sorensen <jes@wildopensource.com>
Date: 18 Aug 2003 09:00:01 -0400
In-Reply-To: <m3r83jyw2k.fsf@defiant.pm.waw.pl>
Message-ID: <m3y8xrglym.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Krzysztof" == Krzysztof Halasa <khc@pm.waw.pl> writes:

Krzysztof> "David S. Miller" <davem@redhat.com> writes:
>> ia64 does in fact need consistent_dma_mask.

Krzysztof> For what?  Perhaps a file name?

Because some ia64 boxen do not have physical memory in the lower 4GB
region and the PCI-X spec requires cards to support dual-address
cycles (aka 64 bit addressing) so some boxes do not have an MMU
operating when slots are in PCI-X mode. One can argue whether this is
a good idea or not, however it *is* spec compliant.

Krzysztof> No. This is only true if you set dma_mask =
Krzysztof> consistent_dma_mask.  If they aren't equal (and don't cover
Krzysztof> the entire RAM address space) the thing is broken.  If they
Krzysztof> have to be equal - why we need 2 masks in the first place?

Historically pci_alloc_consistent would always rely on the consistent
dma mask being <=32 bit. That is necessary because some adapters may
provide > 32bit addressing in their dynamic descriptors but only 32
bit in their consistent descriptors. This you are likely to find in
cases where the hardware vendor has added 'extended descriptors' to
their chips by sticking extra address bits into random places in their
control structures where there were a few bits free.

So yes, we *do* need both, having different masks for the two is in no
way broken.

We introduced pci_consistent_dma_mask for a reason, remember there are
computers out there that aren't PCs.

Jes
