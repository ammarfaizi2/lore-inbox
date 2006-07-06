Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWGFWeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWGFWeB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWGFWeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:34:01 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:38069 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1750966AbWGFWeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:34:00 -0400
Date: Thu, 6 Jul 2006 15:25:43 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: linux-kernel@vger.kernel.org, perfmon@napali.hpl.hp.com
Subject: Re: cpuinfo_x86 and apicid
Message-ID: <20060706222543.GC10760@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060706150118.GB10110@frankl.hpl.hp.com> <20060706091930.A13512@unix-os.sc.intel.com> <20060706200031.GA10685@frankl.hpl.hp.com> <20060706140613.B13512@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706140613.B13512@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh,

On Thu, Jul 06, 2006 at 02:06:13PM -0700, Siddha, Suresh B wrote:
> On Thu, Jul 06, 2006 at 01:00:31PM -0700, Stephane Eranian wrote:
> > On Thu, Jul 06, 2006 at 09:19:30AM -0700, Siddha, Suresh B wrote:
> > > On Thu, Jul 06, 2006 at 08:01:18AM -0700, Stephane Eranian wrote:
> > > > Hello,
> > > > 
> > > > 
> > > > In the context of the perfmon2 subsystem for processor with HyperThreading,
> > > > we need to know on which thread we are currently running. This comes from
> > > > the fact that the performance counters are shared between the two threads.
> > > > 
> > > > We use the thread id (smt_id) because we split the counters in half
> > > > between the two threads such that two threads on the same core can run
> > > > with monitoring on.  We are currently computing the smt_id from the
> > > > apicid as returned by a CPUID instruction. This is not very efficient.
> > > > 
> > > > I looked through the i386 code and could not find a function nor 
> > > > structure that would return this smt_id. In the cpuinfo_x86 structure
> > > > there is an apicid field that looks good, yet it does not seem to be
> > > > initialized nor used.
> > > > 
> > > > Is cpuinfo_x86->apicid field obsolete? 
> > > > If so, what is replacing it?
> > > 
> > > In i386, it is getting initialized in generic_identify() in common.c and
> > > it is getting used for example in intel_cacheinfo.c
> > > 
> > Well, yes this is exactly what I want, except that it is not compiled for x86_64
> > so on a HT Xeon in 64-bit I don't get it. Why is that?
> 
> on x86_64, it is getting initialized in identify_cpu() and further
> intel_cacheinfo.c gets linked in both i386 and x86_64.
> 
Ah, yes I missed that. It works there two. I had something wrong
about how I accessed cpu_data. I am used to the elegant way we
do it on IA-64 but on x86_64 you have to index the cpu_data[]
array with smp_processor_id(). I was pointing to cpu_data[0]
on all processors.

For what I need, I can do cpuinfo_x86->apicid & 0x3 to identify
which thread is running. I can now remove some more code in perfmon2.

Thanks for your help.

-- 
-Stephane
