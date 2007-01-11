Return-Path: <linux-kernel-owner+w=401wt.eu-S965302AbXAKGvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965302AbXAKGvo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 01:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965303AbXAKGvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 01:51:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50366 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965302AbXAKGvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 01:51:43 -0500
Message-ID: <45A5DE7C.3030108@redhat.com>
Date: Thu, 11 Jan 2007 01:51:40 -0500
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: yunfeng zhang <zyf.zeroos@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16.29 1/1] MM: enhance Linux swap subsystem
References: <4df04b840701101935i2083da21t26785bc6c00057a7@mail.gmail.com>
In-Reply-To: <4df04b840701101935i2083da21t26785bc6c00057a7@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yunfeng zhang wrote:
> My patch is based on my new idea to Linux swap subsystem, you can find 
> more in
> Documentation/vm_pps.txt which isn't only patch illustration but also file
> changelog. In brief, SwapDaemon should scan and reclaim pages on
> UserSpace::vmalist other than current zone::active/inactive. The change 
> will conspicuously enhance swap subsystem performance by

Have you actually measured this?

If your measurements saw any performance gains, with what kind
of workload did they happen, how big were they and how do you
explain those performance gains?

How do you balance scanning the private memory with taking
pages off the per-zone page lists?

How do you deal with systems where some zones are really
large and other zones are really small, eg. a 32 bit system
with one 880MB zone and one 15.1GB zone?

If the benefits come mostly from better IO clustering, would
it not be safer/less invasive to add swapout clustering of the
same style that the BSD kernels have?

For your reference, the BSD kernels do swapout clustering like this:
1) select a page off the end of the pageout list
2) then scan the page table the page is in, to find
    nearby pages that are also eligable for pageout
3) page them all out with one disk I/O operation

The same could also be done for files.

With peterz's dirty tracking (and possible dirty limiting)
code in the kernel, this can be done without the kind of
deadlocks that would have plagued earlier kernels, when
trying to do IO trickery from the pageout path...

-- 
Politics is the struggle between those who want to make their country
the best in the world, and those who believe it already is.  Each group
calls the other unpatriotic.
