Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVFJRxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVFJRxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 13:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVFJRxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 13:53:32 -0400
Received: from [63.81.117.10] ([63.81.117.10]:17361 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261159AbVFJRx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 13:53:26 -0400
Message-ID: <42A9D393.6010701@xfs.org>
Date: Fri, 10 Jun 2005 12:53:23 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Mel Gorman <mel@csn.ul.ie>,
       Nick Piggin <nickpiggin@yahoo.com.au>, jschopp@austin.ibm.com,
       linux-mm@kvack.org, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Avoiding external fragmentation with a placement policy Version
 12
References: <20050531112048.D2511E57A@skynet.csn.ul.ie> <429E20B6.2000907@austin.ibm.com><429E4023.2010308@yahoo.com.au> <423970000.1117668514@flay><429E483D.8010106@yahoo.com.au> <434510000.1117670555@flay><429E50B8.1060405@yahoo.com.au> <429F2B26.9070509@austin.ibm.com><1117770488.5084.25.camel@npiggin-nld.site><Pine.LNX.4.58.0506031349280.10779@skynet> <370550000.1117807258@[10.10.2.4]> <Pine.LNX.4.58.0506081734480.10706@skynet> <537960000.1118251081@[10.10.2.4]> <Pine.LNX.4.62.0506100918460.10707@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0506100918460.10707@graphe.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2005 17:53:24.0724 (UTC) FILETIME=[4C6F7B40:01C56DE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 8 Jun 2005, Martin J. Bligh wrote:
> 
> 
>>Right. I agree that large allocs should be reliable. Whether we care so
>>much about if they're performant or not, I don't know ... is an interesting
>>question. I think the answer is maybe not, within reason. The cost of
>>fishing in the allocator might well be irrelevant compared to the cost
>>of freeing the necessary memory area?
> 
> 
> Large consecutive page allocation is important for I/O. Lots of drivers 
> are able to issue transfer requests spanning multiple pages which is only 
> possible if the pages are in sequence. If memory is fragmented then this 
> is no longer possible.

Which I think is one of the reasons Mel set off down this path
in the first place. Scatter gather only gets you so far, and
it makes the DMA engine work harder. We have seen cases where
Windows can get more bandwidth out of fiber channel raids than
can Linux, Windows was using fewer and larger size scsi commands
too. Keep a Linux box busy for a few days and its memory map gets
very fragmented, requests to the scsi layer which could have been
larger tend to get limited by the maximum number of scatter gather
elements a device can handle. Some less powerful raids (Apple Xraids
for example) can become cpu bound when you do this rather than I/O bound.

In this case what tends to help is if processes get given their
address space in large physically contiguous chunks of pages.

Steve

