Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268326AbUIWJKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268326AbUIWJKG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 05:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268339AbUIWJKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 05:10:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:36015 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268326AbUIWJKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 05:10:00 -0400
Date: Thu, 23 Sep 2004 11:09:58 +0200
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@austin.rr.com>
Cc: Andi Kleen <ak@suse.de>, William Lee Irwin III <wli@holomorphy.com>,
       linux-mm <linux-mm@kvack.org>, Jesse Barnes <jbarnes@sgi.com>,
       Dan Higgins <djh@sgi.com>, lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>, Nick Piggin <piggin@cyberone.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ray Bryant <raybry@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Paul Jackson <pj@sgi.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH 0/2] mm: memory policy for page cache allocation
Message-ID: <20040923090957.GB6146@wotan.suse.de>
References: <20040923043236.2132.2385.23158@raybryhome.rayhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923043236.2132.2385.23158@raybryhome.rayhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (1)  We dropped the MPOL_ROUNDROBIN patch.  Instead, we
>      use MPOL_INTERLEAVE to spread pages across nodes.
>      However, rather than use the file offset etc to 
>      calculate the node to allocate the page on, I used
>      the same mechanism you used in alloc_pages_current()
>      to calculate the node number (interleave_node()).
>      That eliminates the need to generate an offset etc
>      in the routines that call page_cache_alloc() and to
>      me appears to be a simpler change that still fits
>      within your design.


Hmm, that may lead to uneven balancing because the counter is 
per thread. But if it works for you it's ok I guess.

I still think changing the callers and use the offset for
static interleaving would be better. Maybe that could be
done as a followon patch. 
> 
> (2)  I implemented the sys_set_mempolicy() changes as
>      suggested -- higher order bits in the mode (first)
>      argument specify whether or not this request is for
>      the page allocation policy (your existing policy)
>      or for the page cache allocation policy.  Similarly,
>      a bit there indicates whether or not we want to set
>      the process level policy or the system level policy.
> 
>      These bits are to be set in the flags argument of
>      sys_mbind().

Ok.  If that gets in I would suggest you also document it 
in the manpages and send me a patch. 

Comments to the patches in other mail.

-Andi


