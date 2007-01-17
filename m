Return-Path: <linux-kernel-owner+w=401wt.eu-S1751680AbXAQECT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbXAQECT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 23:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbXAQECT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 23:02:19 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:40102 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751680AbXAQECT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 23:02:19 -0500
Date: Tue, 16 Jan 2007 20:02:00 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, menage@google.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, linux-mm@kvack.org, ak@suse.de, dgc@sgi.com
Subject: Re: [RFC 0/8] Cpuset aware writeback
Message-Id: <20070116200200.5e1ade9c.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0701161920480.4677@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	<20070116135325.3441f62b.akpm@osdl.org>
	<Pine.LNX.4.64.0701161407530.3545@schroedinger.engr.sgi.com>
	<20070116154054.e655f75c.akpm@osdl.org>
	<Pine.LNX.4.64.0701161602480.4263@schroedinger.engr.sgi.com>
	<20070116170734.947264f2.akpm@osdl.org>
	<Pine.LNX.4.64.0701161709490.4455@schroedinger.engr.sgi.com>
	<20070116183406.ed777440.akpm@osdl.org>
	<Pine.LNX.4.64.0701161920480.4677@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes this is the result of the hierachical nature of cpusets which already 
> causes issues with the scheduler. It is rather typical that cpusets are 
> used to partition the memory and cpus. Overlappig cpusets seem to have 
> mainly an administrative function. Paul?

The heavy weight tasks, which are expected to be applying serious memory
pressure (whether for data pages or dirty file pages), are usually in
non-overlapping cpusets, or sharing the same cpuset, but not partially
overlapping with, or a proper superset of, some other cpuset holding an
active job.

The higher level cpusets, such as the top cpuset, or the one deeded over
to the Batch Scheduler, are proper supersets of many other cpusets.  We
avoid putting anything heavy weight in those cpusets.

Sometimes of course a task turns out to be unexpectedly heavy weight.
But in that case, we're mostly interested in function (system keeps
running), not performance.

That is, if someone setup what Andrew described, with a job in a large
cpuset sucking up all available memory from one in a smaller, contained
cpuset, I don't think I'm tuning for optimum performance anymore.
Rather I'm just trying to keep the system running and keep unrelated
jobs unaffected while we dig our way out of the hole.  If the smaller
job OOM's, that's tough nuggies.  They asked for it.  Jobs in
-unrelated- (non-overlapping) cpusets should ride out the storm with
little or no impact on their performance.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
