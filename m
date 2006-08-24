Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWHXLBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWHXLBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWHXLBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:01:47 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:17839 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751095AbWHXLBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:01:46 -0400
Date: Thu, 24 Aug 2006 16:32:49 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Gautham R Shenoy <ego@in.ibm.com>, rusty@rustcorp.com.au,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       arjan@intel.linux.com, mingo@elte.hu, davej@redhat.com,
       vatsa@in.ibm.com, dipankar@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 2/4] Revert Changes to kernel/workqueue.c
Message-ID: <20060824110248.GF2395@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20060824103043.GC2395@in.ibm.com> <20060824105100.GA6868@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824105100.GA6868@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 12:51:00PM +0200, Heiko Carstens wrote:
> > @@ -510,13 +515,11 @@ int schedule_on_each_cpu(void (*func)(vo
> >  	if (!works)
> >  		return -ENOMEM;
> >  
> > -	mutex_lock(&workqueue_mutex);
> >  	for_each_online_cpu(cpu) {
> >  		INIT_WORK(per_cpu_ptr(works, cpu), func, info);
> >  		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
> >  				per_cpu_ptr(works, cpu));
> >  	}
> > -	mutex_unlock(&workqueue_mutex);
> >  	flush_workqueue(keventd_wq);
> >  	free_percpu(works);
> >  	return 0;
> 
> Removing this lock without adding a lock/unlock_cpu_hotplug seems wrong,
> since this function is walking the cpu_online_map.
I had thought of it. But later decided to retain the same code as 2.6.18-rc4,
where there was no lock_cpu_hotplug surrounding for_each_online_cpu.

Furthermore, it did not create any problems with the test run.
So I thought *may-be* we don't need it. 
But looks like I need to investigate further.
Thanks for pointing it out.

Regards
ego.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
