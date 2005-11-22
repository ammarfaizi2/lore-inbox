Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVKVXoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVKVXoH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbVKVXoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:44:07 -0500
Received: from fmr23.intel.com ([143.183.121.15]:2176 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030203AbVKVXoF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:44:05 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 5/5] Light fragmentation avoidance without usemap: 005_drainpercpu
Date: Tue, 22 Nov 2005 15:43:33 -0800
Message-ID: <01EF044AAEE12F4BAAD955CB75064943053DF65D@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 5/5] Light fragmentation avoidance without usemap: 005_drainpercpu
Thread-Index: AcXvmb+XKrCqqaaLTIOVzLszpa61zgAI0Isg
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "Mel Gorman" <mel@csn.ul.ie>, <linux-mm@kvack.org>
Cc: <nickpiggin@yahoo.com.au>, <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <lhms-devel@lists.sourceforge.net>, <mingo@elte.hu>
X-OriginalArrivalTime: 22 Nov 2005 23:43:34.0892 (UTC) FILETIME=[8DA172C0:01C5EFBE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Mel Gorman Sent: Tuesday, November 22, 2005 11:18 AM

>Per-cpu pages can accidentally cause fragmentation because they are
free, >but
>pinned pages in an otherwise contiguous block.  When this patch is
applied,
>the per-cpu caches are drained after the direct-reclaim is entered if
the

I don't think this is the right place to drain the pcp.  Since direct
reclaim is already done, so it is possible that allocator can service
the request without draining the pcps. 


>requested order is greater than 3. 

Why this order limit.  Most of the previous failures seen (because of my

earlier patches of bigger and more physical contiguous chunks for pcps) 
were with order 1 allocation.

>It simply reuses the code used by suspend
>and hotplug and only is triggered when anti-defragmentation is enabled.
>
That code has issues with pre-emptible kernel.

I will be shortly sending the patch to free pages from pcp when higher
order
allocation is not able to get serviced from global list.

-rohi
