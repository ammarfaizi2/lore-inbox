Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbVIUQHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVIUQHj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVIUQHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:07:39 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:29378 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751110AbVIUQHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:07:39 -0400
Message-ID: <43318540.5020105@nortel.com>
Date: Wed, 21 Sep 2005 10:07:28 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: help interpreting oom-killer output
References: <43308131.5040104@nortel.com> <20050921133701.GB5532@dmt.cnet>
In-Reply-To: <20050921133701.GB5532@dmt.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2005 16:07:31.0606 (UTC) FILETIME=[923ADB60:01C5BEC6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> See that the DMA zone free count is equal to the "min" watermark. Normal
> and Highmem are both above the "high" watermark.
> 
> So this must be a DMA allocation (see gfp_mask). Stick a "dump_stack()" 
> to find out who is the allocator.

The final trigger may be a DMA allocation, but the initial cause is 
whatever is chewing up all the NORMAL memory.

I can repeatably trigger the fault by running LTP.  When it hits the 
"rename14" test, the oom killer kicks in.  Before running this test, I 
had over 3GB of memory free, including over 800MB of normal memory.

To track it down, I started dumping /proc/slabinfo every second while 
running this test.  It appears the culprit is the dentry_cache, which 
consumed at least 817MB of memory (and probably peaked higher than 
that).  As soon as the test program died, all the memory was freed.

Anyone have any ideas what's going on?

Chris
