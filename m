Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263853AbUDFOze (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 10:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbUDFOzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 10:55:25 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:61429 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263854AbUDFOzI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 10:55:08 -0400
Date: Tue, 6 Apr 2004 20:26:16 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rusty@au1.ibm.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to CPU_DEAD handling
Message-ID: <20040406145616.GB8516@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040405121824.GA8497@in.ibm.com> <4071F9C5.2030002@yahoo.com.au> <20040406083713.GB7362@in.ibm.com> <407277AE.2050403@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407277AE.2050403@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 07:26:06PM +1000, Nick Piggin wrote:
> Also in my patch, the offline check should probably be done below
> the check for if (cpu == this_cpu... because that should be a common
> route.

	Will this be true for wakeups which are triggered from 
expiring timers also? The timers on the dead CPU are migrated to other CPUs. 
When they fire, the timer fn runs on a different CPU and can try to wake up a
task 'n add it to dead cpu! So we probably need a unconditional cpu_is_offline
check in try_to_wake_up?



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
