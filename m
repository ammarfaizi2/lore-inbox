Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbVKHCxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbVKHCxi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbVKHCxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:53:38 -0500
Received: from ozlabs.org ([203.10.76.45]:8335 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965179AbVKHCxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:53:37 -0500
Date: Tue, 8 Nov 2005 13:53:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Adam Litke <agl@us.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, hugh@veritas.com, rohit.seth@intel.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org
Subject: Re: [RFC 2/2] Hugetlb COW
Message-ID: <20051108025325.GC10769@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	William Lee Irwin III <wli@holomorphy.com>,
	Adam Litke <agl@us.ibm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hugh@veritas.com,
	rohit.seth@intel.com, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	akpm@osdl.org
References: <1131397841.25133.90.camel@localhost.localdomain> <1131399533.25133.104.camel@localhost.localdomain> <20051107233538.GH29402@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107233538.GH29402@holomorphy.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 03:35:38PM -0800, William Lee Irwin wrote:
> On Mon, Nov 07, 2005 at 03:38:53PM -0600, Adam Litke wrote:
> > [RFC] COW for hugepages
> > (Patch originally from David Gibson <dwg@au1.ibm.com>)
> > This patch implements copy-on-write for hugepages, hence allowing
> > MAP_PRIVATE mappings of hugetlbfs.
> > This is chiefly useful for cases where we want to use hugepages
> > "automatically" - that is to map hugepages without the knowledge of
> > the code in the final application (either via kernel hooks, or with
> > LD_PRELOAD).  We can use various heuristics to determine when
> > hugepages might be a good idea, but changing the semantics of
> > anonymous memory from MAP_PRIVATE to MAP_SHARED without the app's
> > knowledge is clearly wrong.
> 
> I'll go check for architectures where page protections may be encoded
> differently depending on the size of the translation, or whose code is
> otherwise unprepared to cope with protection bits.
> 
> If you've done such checking already, I'd be much obliged to hear of it
> (in fact, I'd much prefer you to have done so).

I can't see how the COW catch could be any more broken in this regard
than we are already:  make_huge_pte() in mm/hugetlb.c already assumes
that pte_mkwrite() and pte_wrprotect() will work properly on hugepage
PTEs.  COW doesn't use anything more.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
