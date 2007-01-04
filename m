Return-Path: <linux-kernel-owner+w=401wt.eu-S1751088AbXADEab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbXADEab (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 23:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbXADEab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 23:30:31 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:38360 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbXADEaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 23:30:30 -0500
Date: Thu, 4 Jan 2007 10:00:46 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Gautham R Shenoy <ego@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, vatsa@in.ibm.com
Subject: Re: [PATCH 3/2] fix flush_workqueue() vs CPU_DEAD race
Message-ID: <20070104043046.GA15162@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061230161031.GA101@tv-sign.ru> <20070102162727.9ce2ae2b.akpm@osdl.org> <20070103140459.GA12620@in.ibm.com> <20070103151704.GA28195@in.ibm.com> <20070103172657.GA1597@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103172657.GA1597@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 08:26:57PM +0300, Oleg Nesterov wrote:
> 
> I thought that these patches don't depend on each other, flush_work/workueue
> don't care where cpu-hotplug takes workqueue_mutex, in CPU_LOCK_ACQUIRE or in
> CPU_UP_PREPARE case (or CPU_DEAD/CPU_LOCK_RELEASE for unlock).
> 
> Could you clarify? Just curious.

You are right. They don't depend on each other. 

The intention behind introducing CPU_LOCK_ACQUIRE and CPU_LOCK_RELEASE
was to have a standard place where the subsystems could acquire/release
the "cpu hotplug protection" mutex in the cpu_hotplug callback function.

The same can be acheived by acquiring these mutexes in
CPU_UP_PREPARE/CPU_DOWN_PREPARE etc. 

This is true for every subsystem that is cpu-hotplug aware.

> Oleg.
> 

Thanks and Regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
