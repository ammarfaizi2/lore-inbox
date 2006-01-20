Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161399AbWATAOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161399AbWATAOa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 19:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161416AbWATAOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 19:14:30 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:38089 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161399AbWATAO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 19:14:29 -0500
Message-ID: <43D02B3E.5030603@jp.fujitsu.com>
Date: Fri, 20 Jan 2006 09:13:50 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Joel Schopp <jschopp@austin.ibm.com>
CC: Mel Gorman <mel@csn.ul.ie>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] Re: [PATCH 0/5] Reducing fragmentation using zones
References: <20060119190846.16909.14133.sendpatchset@skynet.csn.ul.ie> <43CFE77B.3090708@austin.ibm.com>
In-Reply-To: <43CFE77B.3090708@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Schopp wrote:
>> Benchmark comparison between -mm+NoOOM tree and with the new zones
> 
> I know you had also previously posted a very simplified version of your 
> real fragmentation avoidance patches.  I was curious if you could repost 
> those with the other benchmarks for a 3 way comparison.  The simplified 
> version got rid of a lot of the complexity people were complaining about 
> and in my mind still seems like preferable direction.
> 
I agree. I think you should try with simplified version again.
Then, we can discuss.

  I don't like using bitmap which I removed (T.T

> Zone based approaches are runtime inflexible and require boot time 
> tuning by the sysadmin.  There are lots of workloads that "reasonable" 
> defaults for a zone based approach would cause the system to regress 
> terribly.
> 
IMHO, I don't like automatic runtime tuning, you say 'flexible' here.
I think flexibility allows 2^(MAX_ORDER - 1) size fragmentaion.
When SECTION_SIZE > MAX_ORDER, this is terrible.

I love certainty that sysadmin can grap his system at boot-time.
And, for people who want to remove range of memory, list-based approach will
need some other hook and its flexibility is of no use.
(If list-based approach goes, I or someone will do.)

I know zone->zone_start_pfn can be removed very easily.
This means there is possiblity to reconfigure zone on demand and
zone-based approach can be a bit more fliexible.


- Kame

> -Joel
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log 
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> _______________________________________________
> Lhms-devel mailing list
> Lhms-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lhms-devel
> 


