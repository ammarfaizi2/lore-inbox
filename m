Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264021AbUCZLoe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 06:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbUCZLoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 06:44:34 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:37597 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264021AbUCZLo2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 06:44:28 -0500
Date: Fri, 26 Mar 2004 22:45:05 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andrew Morton <akpm@osdl.org>, apw@shadowen.org, anton@samba.org,
       sds@epoch.ncsc.mil, ak@suse.de, raybry@sgi.com,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [Lse-tech] Re: [PATCH] [0/6] HUGETLB memory commitment
Message-ID: <20040326171505.GA4390@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20040326085826.GA3332@in.ibm.com> <5310.1080272349@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5310.1080272349@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 02:39:09PM +1100, Keith Owens wrote:
> On Fri, 26 Mar 2004 14:28:26 +0530, 
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >On Thu, Mar 25, 2004 at 04:22:32PM -0800, Andrew Morton wrote:
> >> Keith Owens <kaos@sgi.com> wrote:
> >> >
> >> > FWIW, lkcd (crash dump) treats hugetlb pages as normal kernel pages and
> >> > dumps them, which is pointless and wastes a lot of time.  To avoid
> >> > dumping these pages in lkcd, I had to add a PG_hugetlb flag.  lkcd runs
> >
> >This should already be fixed in recent versions of lkcd. It uses a
> >little bit of trickery to avoid an extra page flag -- hugetlb pages are 
> >detected as "in use" as well as reserved, unlike other reserved pages 
> >which helps identify them.
> 
> Are you sure that this works for hugetlb pages that have been
> preallocated but not yet mapped?  AFAICT the hugetlb pages start off as
> reserved with a zero usecount.
> 

I just realised that hugetlb pages are no longer marked as reserved in
the current trees, and since they are allocated as compound pages 
they would show up as being in use and not LRU. So, we do have a problem,
without PG_hugetlb.

Regards
Suparna

> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

