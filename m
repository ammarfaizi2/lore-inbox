Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWCNQAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWCNQAT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWCNQAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:00:19 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:24236 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750802AbWCNQAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:00:16 -0500
Subject: Re: [PATCH] kexec for ia64
From: Khalid Aziz <khalid_aziz@hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Linux ia64 <linux-ia64@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <20060313224404.1133fc28.akpm@osdl.org>
References: <1142271576.10787.15.camel@lyra.fc.hp.com>
	 <20060313224404.1133fc28.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 09:00:15 -0700
Message-Id: <1142352015.18421.3.camel@lyra.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 22:44 -0800, Andrew Morton wrote:
> Khalid Aziz <khalid_aziz@hp.com> wrote:
> > +	int cpu;
> > +
> > +	for_each_online_cpu(cpu) {
> > +		if (cpu != smp_processor_id())
> > +			cpu_down(cpu);
> > +	}
> > +#else
> > +	smp_call_function(kexec_stop_this_cpu, (void *)image->start, 0, 0);
> > +#endif
> > +#endif
> 
> Why is different code needed for hotplug cpu?

Hi Andrew,

It is preferable to use cpu_down() to shoot down a cpu, but this
function is available only with CONFIG_HOTPLUG_CPU. If
CONFIG_HOTPLUG_CPU is not enabled, only other way to shut down slave
CPUs in a state where they would come back up when the new kernel boots
up and sends them IPI is to hold them in a fake rendezvous which is what
the function kexec_stop_this_cpu() does. So the choices are either to
keep both ways of shutting down CPUs or go with kexec_stop_this_cpu()
for all cases.

Thanks for the comments. I will move declarations to header files as you
suggested.

-- 
Khalid

====================================================================
Khalid Aziz                       Open Source and Linux Organization
(970)898-9214                                        Hewlett-Packard
khalid.aziz@hp.com                                  Fort Collins, CO

"The Linux kernel is subject to relentless development" 
                                - Alessandro Rubini


