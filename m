Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbVKGVYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbVKGVYp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbVKGVYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:24:45 -0500
Received: from fmr21.intel.com ([143.183.121.13]:49806 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S965089AbVKGVYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:24:43 -0500
Subject: RE: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Rohit Seth <rohit.seth@intel.com>
To: Adam Litke <agl@us.ibm.com>
Cc: Andy Nelson <andy@thermo.lanl.gov>, ak@suse.de, nickpiggin@yahoo.com.au,
       akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       gmaxwell@gmail.com, haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie, mingo@elte.hu,
       torvalds@osdl.org
In-Reply-To: <1131397867.25133.92.camel@localhost.localdomain>
References: <20051107003452.3A0B41855A0@thermo.lanl.gov>
	 <1131389934.25133.69.camel@localhost.localdomain>
	 <1131396662.18176.41.camel@akash.sc.intel.com>
	 <1131397867.25133.92.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel 
Date: Mon, 07 Nov 2005 13:31:11 -0800
Message-Id: <1131399071.18176.59.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2005 21:24:05.0705 (UTC) FILETIME=[95029B90:01C5E3E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 15:11 -0600, Adam Litke wrote:
> On Mon, 2005-11-07 at 12:51 -0800, Rohit Seth wrote:
>  
> > Isn't it true that most of the times we'll need to be worrying about
> > run-time allocation of memory (using malloc or such) as compared to
> > static.
> 
> It really depends on the workload.  I've run HPC apps with 10+GB data
> segments.  I've also worked with applications that would benefit from a
> hugetlb-enabled morecore (glibc malloc/sbrk).  I'd like to see one
> standard hugetlb preload library that handles every different "memory
> object" we care about (static and dynamic).  That's what I'm working on
> now.
> 

As said below, we will need this functionality even for code pages.  I
would rather have the changes absorbed in run-time loader rather than
having a preload library. Makes it easy to manage.

malloc/sbrks are the interesting part that does pose some challenges (as
in some archs different address space is reserved hugetlb).  Moreover,
it will also be critical that existing semantics of normal pages is
maintained even when the application ends up using hugepages.
 
> > We'll need a similar flag for even code pages to start using hugetlb
> > pages. In this case to keep the kernel changes to minimum, RTLD will
> > need to modified.
> 
> Yes, I foresee the functionality currently in my preload lib to exist in
> RTLD at some point way down the road.
> 

It will be much sooner...

-rohit

