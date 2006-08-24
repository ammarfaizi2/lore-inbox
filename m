Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWHXL0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWHXL0z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWHXL0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:26:55 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:36797 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751131AbWHXL0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:26:54 -0400
Date: Thu, 24 Aug 2006 16:57:49 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gautham R Shenoy <ego@in.ibm.com>, rusty@rustcorp.com.au,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       arjan@linux.intel.com, davej@redhat.com, vatsa@in.ibm.com,
       dipankar@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-ID: <20060824112749.GG2395@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20060824102618.GA2395@in.ibm.com> <20060824103412.GA14002@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824103412.GA14002@elte.hu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 12:34:12PM +0200, Ingo Molnar wrote:
> Please add the appropriate lock_acquire()/lock_release() calls into the 
> new sleeping semaphore type. Just use the parameters that rwlocks use:
> 
> #define rwlock_acquire(l, s, t, i)            lock_acquire(l, s, t, 0, 2, i)
> #define rwlock_acquire_read(l, s, t, i)       lock_acquire(l, s, t, 2, 2, i)
 
> and lockdep will allow recursive read-locking. You'll also need a 
> lockdep_init_map() call to register the lock with lockdep. Then your 
> locking scheme will be fully checked by lockdep too. (with your current 
> code the new lock type is not added to the lock dependency graph(s))

I'm on it. :)

Thanks
ego
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
