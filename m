Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbUDFPEj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263856AbUDFPEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:04:39 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:40306 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263848AbUDFPE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:04:28 -0400
Message-ID: <4072C6EA.1070803@yahoo.com.au>
Date: Wed, 07 Apr 2004 01:04:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: rusty@au1.ibm.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to
 CPU_DEAD handling
References: <20040405121824.GA8497@in.ibm.com> <4071F9C5.2030002@yahoo.com.au> <20040406083713.GB7362@in.ibm.com> <407277AE.2050403@yahoo.com.au> <20040406145616.GB8516@in.ibm.com>
In-Reply-To: <20040406145616.GB8516@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Tue, Apr 06, 2004 at 07:26:06PM +1000, Nick Piggin wrote:
> 
>>Also in my patch, the offline check should probably be done below
>>the check for if (cpu == this_cpu... because that should be a common
>>route.
> 
> 
> 	Will this be true for wakeups which are triggered from 
> expiring timers also? The timers on the dead CPU are migrated to other CPUs. 
> When they fire, the timer fn runs on a different CPU and can try to wake up a
> task 'n add it to dead cpu! So we probably need a unconditional cpu_is_offline
> check in try_to_wake_up?
> 

AFAIKS, no.

If this happens before migrate_all_tasks, there shouldn't be a
problem because migrate_all_tasks will move the woken task anyway.

It can't happen after migrate_all_tasks, because there is nothing
on the offline CPU to be woken up.

If you do need the check there, then my lazy migrate method is
unquestionably better, because this is the only thing it would
otherwise have to add to a fastpath. Right?
