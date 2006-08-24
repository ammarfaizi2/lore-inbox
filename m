Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWHXLC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWHXLC7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWHXLC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:02:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:49794 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751097AbWHXLC6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:02:58 -0400
Date: Thu, 24 Aug 2006 16:33:06 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Gautham R Shenoy <ego@in.ibm.com>, rusty@rustcorp.com.au,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       arjan@intel.linux.com, mingo@elte.hu, davej@redhat.com,
       vatsa@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 2/4] Revert Changes to kernel/workqueue.c
Message-ID: <20060824110306.GB3651@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060824103043.GC2395@in.ibm.com> <20060824105100.GA6868@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824105100.GA6868@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.11
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

As long as you disable preemption and don't block the critical
section should be safe from cpu hotplug. There is no need to 
lock/unlock cpu hotplug.

Thanks
Dipankar
