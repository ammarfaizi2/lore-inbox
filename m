Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVFHPrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVFHPrr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 11:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVFHPrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 11:47:47 -0400
Received: from webmail.topspin.com ([12.162.17.3]:10842 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261324AbVFHPri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:47:38 -0400
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Greg KH <gregkh@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi()
 for drivers - take 2
X-Message-Flag: Warning: May contain useful information
References: <20050607002045.GA12849@suse.de>
	<20050607202129.GB18039@kroah.com>
	<20050608050212.GD21060@colo.lackof.org>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 08 Jun 2005 08:47:38 -0700
In-Reply-To: <20050608050212.GD21060@colo.lackof.org> (Grant Grundler's
 message of "Tue, 7 Jun 2005 23:02:12 -0600")
Message-ID: <52slzsetph.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 08 Jun 2005 15:47:38.0191 (UTC) FILETIME=[65866DF0:01C56C41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> I've also seen some complaints that it is very arch specific
    Greg> (x86 based).  But as no other arches seem to want to support
    Greg> MSI, I don't really see any need to split it up.  Any
    Greg> comments about this?

    Grant> IA64 supports MSI/MSI-X. Roland, didn't PPC as well?

    Grant> I don't think it's *that* x86 specific.  The base address
    Grant> of the Processor interrupt Block (IIRC 0xfee0000) is
    Grant> implemented the same on several arches AFAIK. Even on some
    Grant> parisc chipsets.  I been constantly chasing other basic
    Grant> issues on parisc and just haven't had time to implement it
    Grant> in the past 3 years.

Some PPC does support MSI.  For example the PCI-X host bridge inside
the IBM (now AMCC) PPC 440GP supports MSI.  I don't know if any
non-embedded PPC or PPC64 supports MSI though -- for example do any
IBM POWER-based systems support MSI??

The current code isn't exactly x86-specific.  It's more Intel APIC
specific, which means that chipsets that for some reason or another
support the same address/message format will work.  So ia64 works as
well.  Following from that, HP parisc boxes that use the same chipset
as HP ia64 boxes have a chance at working.

But the PPC 440GP uses a different address and a different message
format.  So if anyone cared about supporting that, the current code
would have to be made more generic.

 - R.
