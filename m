Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWAWUYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWAWUYH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWAWUYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:24:07 -0500
Received: from kanga.kvack.org ([66.96.29.28]:3980 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932334AbWAWUYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:24:05 -0500
Date: Mon, 23 Jan 2006 15:19:50 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
Message-ID: <20060123201950.GI1008@kvack.org>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]> <Pine.LNX.4.61.0601202020001.8821@goblin.wat.veritas.com> <6F40FCDC9FFDE7B6ACD294F5@[10.1.1.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6F40FCDC9FFDE7B6ACD294F5@[10.1.1.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 11:39:07AM -0600, Dave McCracken wrote:
> The pmd level is important for ppc because it works in segments, which are
> 256M in size and consist of a full pmd page.  The current implementation of
> the way ppc loads its tlb doesn't allow sharing at smaller than segment
> size.  I currently also enable pmd sharing for x86_64, but I'm not sure how
> much of a win it is.  I use it to share pmd pages for hugetlb, as well.

For EM64T at least, pmd sharing is definately worthwhile.  pud sharing is 
a bit more out there, but would still help database workloads.  In the case 
of a thousand connections (which is not unreasonable for some users) you 
save 4MB of memory and reduce the cache footprint of those saved 4MB of 
pages to 4KB.  Ideally the code can be structured to compile out to nothing 
if not needed.

Of course, once we have shared page tables it makes great sense to try to 
get userland to align code segments and data segments to seperate puds so 
that we could share all the page tables for common system libraries amongst 
processes...

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
