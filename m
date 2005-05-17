Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVEQJZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVEQJZj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 05:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVEQJZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 05:25:39 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:9633 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261344AbVEQJZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 05:25:31 -0400
Date: Tue, 17 May 2005 15:05:48 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/3] Dynamic sched domains (v0.6)
Message-ID: <20050517093548.GA5068@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050517041031.GA4596@in.ibm.com> <20050517041219.GB4596@in.ibm.com> <42898E61.3060304@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42898E61.3060304@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 04:25:37PM +1000, Nick Piggin wrote:
> >+
> >+	lock_cpu_hotplug();
> >+	partition_sched_domains(&pspan, &cspan);
> >+	unlock_cpu_hotplug();
> >+}
> >+
> 
> I don't think the cpu hotplug lock isn't supposed to provide
> synchronisation between readers (for example, it may be turned
> into an rwsem), but only between the thread and the cpu hotplug
> callbacks.

That should be ok

> 
> In that case, can you move this locking into kernel/sched.c, and
> add the comment in partition_sched_domains that the callers must
> take care of synchronisation (which without reading the code, I
> assume you're doing with the cpuset sem?).

I didnt want to do this as my next patch, which introduces
hotplug support for dynamic sched domains, also calls 
partition_sched_domains. That code is called with the hotplug lock
already held. (I am still testing that code, it should be out by 
this weekend)

However I will add a comment about the synchronization and yes
currently it is taken care of by the cpuset sem

	-Dinakar
