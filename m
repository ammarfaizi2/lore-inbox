Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVFCBzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVFCBzx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 21:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVFCBzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 21:55:53 -0400
Received: from fmr17.intel.com ([134.134.136.16]:32138 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261481AbVFCBzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 21:55:46 -0400
Subject: Re: [patch 2/5] x86_64: CPU hotplug support.
From: Shaohua Li <shaohua.li@intel.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, ak <ak@muc.de>,
       akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       x86-64 <discuss@x86-64.org>, Rusty Russell <rusty@rustycorp.com.au>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>
In-Reply-To: <20050602163307.C16913@unix-os.sc.intel.com>
References: <20050602125754.993470000@araj-em64t>
	 <20050602130111.816070000@araj-em64t>
	 <Pine.LNX.4.61.0506021416490.3157@montezuma.fsmlabs.com>
	 <20050602163307.C16913@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Fri, 03 Jun 2005 10:01:55 +0800
Message-Id: <1117764115.3826.5.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-02 at 16:33 -0700, Ashok Raj wrote:
> On Thu, Jun 02, 2005 at 02:19:55PM -0600, Zwane Mwaikambo wrote:
> > On Thu, 2 Jun 2005, Ashok Raj wrote:
> > 
> > > @@ -445,8 +477,10 @@ void __cpuinit start_secondary(void)
> > >  	/*
> > >  	 * Allow the master to continue.
> > >  	 */
> > > +	lock_ipi_call_lock();
> > >  	cpu_set(smp_processor_id(), cpu_online_map);
> > >  	mb();
> > > +	unlock_ipi_call_lock();
> > 
> > What's that? Is this another smp_call_function race workaround? I thought 
> > there was an additional patch to avoid the broadcast.
> 
> The other patch avoids sending to offline cpu's, but we read cpu_online_map
> and clear self bit in smp_call_function. If a cpu comes online, dont we 
> want this cpu to take part in smp_call_function?
> 
> if we dont care about this new CPU participating, and if cpu_set() is atomic
> (for all NR_CPUS) we dont need to hold call_lock, otherwise we need to hold
> this as well.
If a CPU isn't online, why should it participates it? If it should
participate it, it also might do the similar thing before set cpu
online.
Some places which really care about it such as smp_send_stop should hold
cpucontrol semaphore to me.

Thanks,
Shaohua

