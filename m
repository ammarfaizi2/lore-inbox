Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269424AbUJFT7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269424AbUJFT7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269409AbUJFT46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:56:58 -0400
Received: from palrel12.hp.com ([156.153.255.237]:50356 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S269438AbUJFTzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:55:12 -0400
Date: Wed, 6 Oct 2004 12:54:24 -0700
From: Grant Grundler <iod00d@hp.com>
To: Colin Ngam <cngam@sgi.com>
Cc: Grant Grundler <iod00d@hp.com>, Patrick Gefre <pfg@sgi.com>,
       "Luck, Tony" <tony.luck@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
Message-ID: <20041006195424.GF25773@cup.hp.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C989@scsmsx401.amr.corp.intel.com> <41641007.5020702@sgi.com> <20041006185739.GA25773@cup.hp.com> <41644301.9EC028B3@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41644301.9EC028B3@sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin,
thanks for ACKing the feedback.
I think there is still some confusion...

On Wed, Oct 06, 2004 at 02:09:54PM -0500, Colin Ngam wrote:
...
> > Mathew explained replacing the raw_pci_ops pointer is the Right Thing
> > and I suspect it's easier to properly implement.
> 
> I believe we did just that.  We did not touch pci_root_ops.

Correct. The patch ignores/overides pci_root_ops with sn_pci_root_ops
(which is what I originally suggested).

Mathew's point was only raw_pci_ops needs to point at a different
set of struct pci_raw_ops (see include/linux/pci.h).

> >   I realize that's not easy to add/maintain in the arch/ia64 port though
> >   since pcibios_fixup_bus() is common code for multiple platforms.
> 
> Yes, would anybody allow us to make a platform specific callout
> from within generic pcibios_fixup_bus()???

If it can be avoided, preferably not. But that's up to Jesse/Tony I think.

...
> >   It means we are telling PCI subsystem to walk root busses that don't
> >   exist in all configurations. I hope there are no nasty side effects
> >   from that.
> 
> Not at all.  If you look at the loop, sn_pci_fixup_bus(0 gets called for 0 -
> PCI_BUSES_TO_SCAN but if the bus does not exist,

Can you quote the bit of the patch which implements "if the bus does not
exist" check?
I can't find it.

> One favour.  Would you agree to letting this patch be included by Tony
> and we will come up with another patch to fix the 2 obvious items listed
> above?  It will be great to avoid spinning this big patch.

I think that's up to Jesse/Tony.
I don't "own" any of the code in question.
Just trying to undo the confusion I caused.

grant
