Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTDWVqA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbTDWVqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:46:00 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:26356 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264257AbTDWVpz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:45:55 -0400
Date: Wed, 23 Apr 2003 14:47:32 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm2
Message-ID: <1565150000.1051134452@flay>
In-Reply-To: <20030423144648.5ce68d11.akpm@digeo.com>
References: <20030423012046.0535e4fd.akpm@digeo.com><18400000.1051109459@[10.10.2.4]> <20030423144648.5ce68d11.akpm@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > . I got tired of the objrmap code going BUG under stress, so it is now in
>> >   disgrace in the experimental/ directory.
>> 
>> Any chance of some more info on that? BUG at what point in the code,
>> and with what test to reproduce?
> 
> A bash-shared-mapping (from ext3 CVS) will quickly knock it over.  It gets
> its PageAnon/page->mapping state tangled up.

OK, will try to reproduce that.
 
> - nasty, nasty problems with remap_file_pages().  I'd rather not have to
>   nobble remap_file_pages() functionality for this reason.

I don't see having to predeclare the thing as non-linear as a serious 
imposition .... I don't think memlocking them is necessary, AFAICS if
we have that.
 
> and what do we gain from it all?  The small fork/exec boost isn't very
> significant.  What we gain is more lowmem space on
> going-away-real-soon-now-we-sincerely-hope highmem boxes.

They're not going away soon (unfortunately) - even if Intel stopped producing
the chips today, the machines based on them are still in the marketplace for
years.

The performance improvement was about 25% of systime according to my 
measurements - I don't call that insignificant.

> Ingo-rmap seems a better solution to me.  It would be a fairly large change
> though - we'd have to hold the four atomic kmaps across an entire pte page
> in copy_page_range(), for example.  But it will then have good locality of
> reference between adjacent pages and may well be quicker than pte_chains.

If there was an existing implementation we could actually measure, I'd
be more impressed. From what I can see currently, it'll just introduce
masses of kmap thrashing crap with no obvious way to fix it. And it 
triples the PTE overhead. Maybe it'd work better in conjunction with 
shared pagetables.

M.



