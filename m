Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVERQ6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVERQ6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVERQ5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:57:04 -0400
Received: from colin.muc.de ([193.149.48.1]:24836 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262312AbVERQyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 12:54:00 -0400
Date: 18 May 2005 18:53:58 +0200
Date: Wed, 18 May 2005 18:53:58 +0200
From: Andi Kleen <ak@muc.de>
To: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Cc: akpm@osdl.org, apw@shadowen.org, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 2/4] add x86-64 Kconfig options for sparsemem
Message-ID: <20050518165358.GF88141@muc.de>
References: <200505181643.j4IGhm7S026977@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505181643.j4IGhm7S026977@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 09:43:48AM -0700, Matt Tolentino wrote:
> >From: Andi Kleen <ak@muc.de>
> >On Wed, May 18, 2005 at 08:24:41AM -0700, Matt Tolentino wrote:
> >> 
> >> Add the requisite arch specific Kconfig options to enable 
> >> the use of the sparsemem implementation for NUMA kernels
> >> on x86-64.
> >
> >How much did you test sparsemem on x86-64 NUMA ? 
> >
> >There are various cases that probably need to be checked,
> >AMD with SRAT, AMD without SRAT, AMD with more than 4GB RAM, 
> >Summit(?), NUMA EMULATION etc.
> >
> >If all that works I would have no problem with removing the
> >old code.
> 
> As my disclaimer said, this has only been tested using
> the NUMA EMULATION config option.  That's a big part of
> the reason for sending this out  - to get further testing 
> on real x86-64 NUMA systems, but without breaking the
> current discontigmem code.  

Hmm, I would have assumed IBM tested it, since Dave Hansen signed off - 
they have a range of Opteron machines.   If not I can test it
on a few boxes later.

A single box is not enough, there are various special cases. 
e.g. one area I've been fighting with is that
with SRAT and 3+GB memory the nodes don't span the PCI memory
hole anymore, and when there is a virt_to_page() or similar for these
addresses things go wrong because they do a uninitialized hash
table lookup. If it's not that hard and doesn't cause code bloat
I would recommend to harden sparsemem against this case, at least for 
upto 4GB.

-Andi

