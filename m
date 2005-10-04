Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbVJDQFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVJDQFO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbVJDQFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:05:14 -0400
Received: from amdext4.amd.com ([163.181.251.6]:1744 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S964839AbVJDQFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:05:11 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH]: Clean up of __alloc_pages
Date: Tue, 4 Oct 2005 11:26:52 -0500
User-Agent: KMail/1.8
cc: "Rohit Seth" <rohit.seth@intel.com>, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
References: <20051001120023.A10250@unix-os.sc.intel.com>
 <1128361714.8472.44.camel@akash.sc.intel.com>
 <p733bnh1kgj.fsf@verdi.suse.de>
In-Reply-To: <p733bnh1kgj.fsf@verdi.suse.de>
MIME-Version: 1.0
Message-ID: <200510041126.53247.raybry@mpdtxmail.amd.com>
X-WSS-ID: 6F5C77852RW1613985-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 October 2005 08:27, Andi Kleen wrote:
> Rohit Seth <rohit.seth@intel.com> writes:
> > I think conceptually this ask for a new flag __GFP_NODEONLY that
> > indicate allocations to come from current node only.
> >
> > This definitely though means I will need to separate out the allocation
> > from pcp patch (as Nick suggested earlier).
>
> This reminds me - the current logic is currently a bit suboptimal on
> many NUMA systems. Often it would be better to be a bit more
> aggressive at freeing memory (maybe do a very low overhead light try to
> free pages) in the first node before falling back to other nodes. What
> right now happens is that when you have even minor memory pressure
> because e.g. you node is filled up with disk cache the local memory
> affinity doesn't work too well anymore.
>
> -Andi
>
That's exactly what Martin Hick's additions to __alloc_pages() were trying to 
achieve.   However, we've never figured out how to make the "very low 
overhead light try to free pages" thing work with low enough overhead that it 
can be left on all of the time.    As soon as we make this the least bit more 
expensive, then this hurts those workloads (file servers being one example) 
who don't care about local, but who need the fastest possible allocations. 

This problem is often a showstopper on larger NUMA systems, at least for HPC 
type applications, where the inability to guarantee local storage allocation 
when it is requested can make the application run significantly slower.
-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

