Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVA1Pl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVA1Pl5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 10:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVA1Pl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 10:41:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52181 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261316AbVA1Ply (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 10:41:54 -0500
Date: Fri, 28 Jan 2005 10:41:33 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Hugh Dickins <hugh@veritas.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
In-Reply-To: <Pine.LNX.4.61.0501281348110.6922@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0501281036240.28137@chimarrao.boston.redhat.com>
References: <20050127050927.GR10843@holomorphy.com>    
 <16888.46184.52179.812873@alkaid.it.uu.se>     <20050127125254.GZ10843@holomorphy.com>
     <20050127142500.A775@flint.arm.linux.org.uk>     <20050127151211.GB10843@holomorphy.com>
     <Pine.LNX.4.61.0501271420070.13927@chimarrao.boston.redhat.com>    
 <20050127204455.GM10843@holomorphy.com>    
 <Pine.LNX.4.61.0501271557300.13927@chimarrao.boston.redhat.com>    
 <20050127211319.GN10843@holomorphy.com>    
 <Pine.LNX.4.61.0501271626460.13927@chimarrao.boston.redhat.com>    
 <20050128053036.GO10843@holomorphy.com>    
 <Pine.LNX.4.61.0501280801070.24304@chimarrao.boston.redhat.com>
 <Pine.LNX.4.61.0501281348110.6922@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005, Hugh Dickins wrote:

> Perhaps you're coming from experience of various buggy apps
> that get into difficulties if mmaps are found below mm->brk?
> I'm not sure that we should be cutting others' address space to
> make life easier for those, they should be ADDR_COMPAT_LAYOUT.

The main thing I would really like to preserve is the
space used for "near-NULL" pointer detection. That is,
detection of trying to access a large index in a NULL
pointer array, etc.

I'd be happy to have some arbitrary value for the lower
boundary...

> arch/ppc64/mm/hugetlbpage.c (odd place to find it) has its own
> arch_get_unmapped_area_topdown, should be given a similar fix.

Good point, though a 64 bit architecture is, umm, less
likely to run all the way down to zero within our lifetime.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
