Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbVKHDq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVKHDq1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVKHDq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:46:27 -0500
Received: from ozlabs.org ([203.10.76.45]:20627 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932459AbVKHDq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:46:26 -0500
Date: Tue, 8 Nov 2005 14:44:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Adam Litke <agl@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, hugh@veritas.com,
       rohit.seth@intel.com, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       akpm@osdl.org
Subject: Re: [RFC 2/2] Hugetlb COW
Message-ID: <20051108034442.GC14336@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Adam Litke <agl@us.ibm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hugh@veritas.com,
	rohit.seth@intel.com, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	akpm@osdl.org
References: <1131397841.25133.90.camel@localhost.localdomain> <1131399533.25133.104.camel@localhost.localdomain> <1131400076.25133.110.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131400076.25133.110.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 03:47:55PM -0600, Adam Litke wrote:
> On Mon, 2005-11-07 at 15:38 -0600, Adam Litke wrote:
> > [RFC] COW for hugepages
> > (Patch originally from David Gibson <dwg@au1.ibm.com>)
> > 
> > This patch implements copy-on-write for hugepages, hence allowing
> > MAP_PRIVATE mappings of hugetlbfs.
> > 
> > This is chiefly useful for cases where we want to use hugepages
> > "automatically" - that is to map hugepages without the knowledge of
> > the code in the final application (either via kernel hooks, or with
> > LD_PRELOAD).  We can use various heuristics to determine when
> > hugepages might be a good idea, but changing the semantics of
> > anonymous memory from MAP_PRIVATE to MAP_SHARED without the app's
> > knowledge is clearly wrong.
> 
> I forgot to mention in the original post that this patch is currently
> broken on ppc64 due to a problem with update_mmu_cache().  The proper
> fix is understood but backed up behind the powerpc merge activity.  

Now that the merge tree and 64k pages have been pulled into mainline I
updated this patch, and sent it off to paulus.  You'll fnid it under
the subject "ppc64: Make hash_preload() and update_mmu_cache() cope
with hugepages".

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
