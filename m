Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVFBXmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVFBXmm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 19:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVFBXm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 19:42:29 -0400
Received: from fsmlabs.com ([168.103.115.128]:46779 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261443AbVFBXmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 19:42:04 -0400
Date: Thu, 2 Jun 2005 17:45:14 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ashok Raj <ashok.raj@intel.com>
cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Rusty Russell <rusty@rustycorp.com.au>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [patch 2/5] x86_64: CPU hotplug support.
In-Reply-To: <20050602163307.C16913@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.61.0506021742390.3157@montezuma.fsmlabs.com>
References: <20050602125754.993470000@araj-em64t> <20050602130111.816070000@araj-em64t>
 <Pine.LNX.4.61.0506021416490.3157@montezuma.fsmlabs.com>
 <20050602163307.C16913@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2005, Ashok Raj wrote:

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

The lock being held in smp_call_function whilst we access cpu_online_map 
should prevent another processor coming online within that operation 
shouldn't it? So There shouldn't be any processors coming online except 
for right after or before an smp_call_function.


