Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbVKDWni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVKDWni (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbVKDWni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:43:38 -0500
Received: from outbound01.telus.net ([199.185.220.220]:27526 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S1750935AbVKDWnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:43:37 -0500
From: Andi Kleen <ak@suse.de>
To: Gregory Maxwell <gmaxwell@gmail.com>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Fri, 4 Nov 2005 23:43:27 +0100
User-Agent: KMail/1.8
Cc: Andy Nelson <andy@thermo.lanl.gov>, mingo@elte.hu, akpm@osdl.org,
       arjan@infradead.org, arjanv@infradead.org, haveblue@us.ibm.com,
       kravetz@us.ibm.com, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mbligh@mbligh.org,
       mel@csn.ul.ie, nickpiggin@yahoo.com.au, torvalds@osdl.org
References: <20051104201248.GA14201@elte.hu> <20051104210418.BC56F184739@thermo.lanl.gov> <e692861c0511041331ge5dd1abq57b6c513540fa200@mail.gmail.com>
In-Reply-To: <e692861c0511041331ge5dd1abq57b6c513540fa200@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511042343.27832.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 November 2005 22:31, Gregory Maxwell wrote:
> On 11/4/05, Andy Nelson <andy@thermo.lanl.gov> wrote:
> > I am not enough of a kernel level person or sysadmin to know for certain,
> > but I have still big worries about consecutive jobs that run on the
> > same resources, but want extremely different page behavior. I
>
> Thats the idea. The 'hugetlb zone' will only be usable for allocations
> which are guaranteed reclaimable.  Reclaimable includes userspace
> usage (since at worst an in use userspace page can be swapped out then
> paged back into another physical location).

I don't like it very much. You have two choices if a workload runs
out of the kernel allocatable pages. Either you spill into the reclaimable
zone or you fail the allocation. The first means that the huge pages
thing is unreliable, the second would mean that all the many problems
of limited lowmem would be back.

None of this is very attractive.

-Andi
