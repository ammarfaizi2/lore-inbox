Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVFBSpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVFBSpD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 14:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVFBSpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 14:45:03 -0400
Received: from dvhart.com ([64.146.134.43]:3495 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261230AbVFBSmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 14:42:47 -0400
Date: Thu, 02 Jun 2005 11:42:39 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andi Kleen <ak@muc.de>
Cc: jschopp@austin.ibm.com, Mel Gorman <mel@csn.ul.ie>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version 12
Message-ID: <486490000.1117737759@flay>
In-Reply-To: <m14qcgwr3p.fsf@muc.de>
References: <20050531112048.D2511E57A@skynet.csn.ul.ie><429E20B6.2000907@austin.ibm.com> <429E4023.2010308@yahoo.com.au><423970000.1117668514@flay> <429E483D.8010106@yahoo.com.au><434510000.1117670555@flay> <m14qcgwr3p.fsf@muc.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It gets very messy when CIFS requires a large buffer to write back
>> to disk in order to free memory ...
> 
> How about just fixing CIFS to submit memory page by page? The network
> stack below it supports that just fine and the VFS above it does anyways, 
> so it doesnt make much sense that CIFS sitting below them uses
> larger buffers.

Might well be possible, but it's not just CIFS though. I don't see why
CIFS needs phys contig memory, but I think some of the drivers do (at
least they do at the moment). Large pages and hotplug definitely will.

>> There's one example ... we can probably work around it if we try hard
>> enough. However, the fundamental question becomes "do we support higher
>> order allocs, or not?". If not fine ... but we ought to quit pretending
>> we do. If so, then we need to make them more reliable.
> 
> My understanding was that the deal was that order 1 is supposed
> to work but somewhat slower, and bigger orders are supposed to work
> at boot up time.

If that's the decision we come to, I'm OK with it ... but lots of code 
needs fixing first. However, I don't think that's currently the stated 
intent, we try pretty hard for up to order 3 in __alloc_pages(). I think 
we'll have an inherent need for higher orders from what I've seen, and 
thus we'll have to be capable to some extent of reclaiming mem for those
allocs. We should probably put together a list of things that really 
need it, Joel had a start at one later down this thread.

M.

