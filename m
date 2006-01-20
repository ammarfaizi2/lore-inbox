Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWATBLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWATBLA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 20:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWATBLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 20:11:00 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:51921 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1030406AbWATBK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 20:10:59 -0500
Date: Fri, 20 Jan 2006 01:09:49 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Joel Schopp <jschopp@austin.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] Re: [PATCH 0/5] Reducing fragmentation using zones
In-Reply-To: <43D02B3E.5030603@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.58.0601200102040.15823@skynet>
References: <20060119190846.16909.14133.sendpatchset@skynet.csn.ul.ie>
 <43CFE77B.3090708@austin.ibm.com> <43D02B3E.5030603@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2006, KAMEZAWA Hiroyuki wrote:

> Joel Schopp wrote:
> > > Benchmark comparison between -mm+NoOOM tree and with the new zones
> >
> > I know you had also previously posted a very simplified version of your real
> > fragmentation avoidance patches.  I was curious if you could repost those
> > with the other benchmarks for a 3 way comparison.  The simplified version
> > got rid of a lot of the complexity people were complaining about and in my
> > mind still seems like preferable direction.
> >
> I agree. I think you should try with simplified version again.
> Then, we can discuss.
>

Results from list-based have been posted. The actual patches will be
posted tomorrow (in local time, that is in about 12 hours time)

>  I don't like using bitmap which I removed (T.T
>
> > Zone based approaches are runtime inflexible and require boot time tuning by
> > the sysadmin.  There are lots of workloads that "reasonable" defaults for a
> > zone based approach would cause the system to regress terribly.
> >
> IMHO, I don't like automatic runtime tuning, you say 'flexible' here.
> I think flexibility allows 2^(MAX_ORDER - 1) size fragmentaion.
> When SECTION_SIZE > MAX_ORDER, this is terrible.
>

In an ideal world, we would have both. Zone-based would give guarantees on
the availability of reclaimed pages and list-based would give best-effort
everywhere.

> I love certainty that sysadmin can grap his system at boot-time.

It requires careful tuning. For suddenly different workloads, things may
go wrong. As with everything else, testing is required from workloads
defined by multiple people.

> And, for people who want to remove range of memory, list-based approach will
> need some other hook and its flexibility is of no use.
> (If list-based approach goes, I or someone will do.)
>

Will do what?

> I know zone->zone_start_pfn can be removed very easily.
> This means there is possiblity to reconfigure zone on demand and
> zone-based approach can be a bit more fliexible.
>

The obvious concern is that it is very easy to grow ZONE_NORMAL or
ZONE_HIGHMEM into the ZONE_EASYRCLM zone but it is hard to do the opposite
because you must be able to reclaim the pages at the end of the "awkward"
zone.

Linus has also stated that he does not mind the zone the kernel is using
(be it normal or highmem) growing, but he takes a dim view to it being
shrunk again. Either way, to shrink it again, it is likely that a page
migration mechanism is a requirement because there is no way to be sure
that easily reclaimed are at the end of the zone.

>
> - Kame
>
> > -Joel
> >
> >
> > -------------------------------------------------------
> > This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> > for problems?  Stop!  Download the new AJAX search engine that makes
> > searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> > _______________________________________________
> > Lhms-devel mailing list
> > Lhms-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/lhms-devel
> >
>
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
