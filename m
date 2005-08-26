Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbVHZKpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbVHZKpG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 06:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbVHZKpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 06:45:06 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:17935 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1751514AbVHZKpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 06:45:05 -0400
Date: Fri, 26 Aug 2005 11:37:00 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: Andy Isaacson <adi@hexapodia.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: question on memory barrier
In-Reply-To: <20050826072129.71855.qmail@web25802.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.61L.0508261125160.9561@blysk.ds.pg.gda.pl>
References: <20050826072129.71855.qmail@web25802.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2005, moreau francis wrote:

> I don't think that MIPS cpu reorder memory access, but gcc can ! And I
> don't think that the use of 'volatile' can prevent it to do that.

 Well, certain MIPS implementations may merge multiple uncached writes in 
the writeback buffer, e.g. writes to different bytes within a single 
aligned word.  This is true for consecutive writes; I'm not sure this 
permits jumping the writeback queue, though.

> > To return to the point directly at hand - on MIPS architectures to date,
> > simply doing your memory access through a "volatile u32 *" is sufficient
> > to ensure that the IO hits the bus (assuming that your pointer points to
> > kseg1, not kseg0, or is otherwise uncached), because 'volatile' forces
> > gcc to generate a "sw" for each store, and all MIPS so far have been
> > designed so that multiple uncached writes to mmio locations do generate
> > multiple bus transactions.

 Unfortunately this is not true -- see above.  This is why even wmb() 
isn't a no-op on MIPS.

  Maciej
