Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWGFVNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWGFVNf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 17:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWGFVNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 17:13:35 -0400
Received: from mga05.intel.com ([192.55.52.89]:16904 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750867AbWGFVNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 17:13:33 -0400
X-IronPort-AV: i="4.06,214,1149490800"; 
   d="scan'208"; a="94285378:sNHT38340316"
Date: Thu, 6 Jul 2006 14:06:13 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, perfmon@napali.hpl.hp.com
Subject: Re: cpuinfo_x86 and apicid
Message-ID: <20060706140613.B13512@unix-os.sc.intel.com>
References: <20060706150118.GB10110@frankl.hpl.hp.com> <20060706091930.A13512@unix-os.sc.intel.com> <20060706200031.GA10685@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060706200031.GA10685@frankl.hpl.hp.com>; from eranian@hpl.hp.com on Thu, Jul 06, 2006 at 01:00:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 01:00:31PM -0700, Stephane Eranian wrote:
> On Thu, Jul 06, 2006 at 09:19:30AM -0700, Siddha, Suresh B wrote:
> > On Thu, Jul 06, 2006 at 08:01:18AM -0700, Stephane Eranian wrote:
> > > Hello,
> > > 
> > > 
> > > In the context of the perfmon2 subsystem for processor with HyperThreading,
> > > we need to know on which thread we are currently running. This comes from
> > > the fact that the performance counters are shared between the two threads.
> > > 
> > > We use the thread id (smt_id) because we split the counters in half
> > > between the two threads such that two threads on the same core can run
> > > with monitoring on.  We are currently computing the smt_id from the
> > > apicid as returned by a CPUID instruction. This is not very efficient.
> > > 
> > > I looked through the i386 code and could not find a function nor 
> > > structure that would return this smt_id. In the cpuinfo_x86 structure
> > > there is an apicid field that looks good, yet it does not seem to be
> > > initialized nor used.
> > > 
> > > Is cpuinfo_x86->apicid field obsolete? 
> > > If so, what is replacing it?
> > 
> > In i386, it is getting initialized in generic_identify() in common.c and
> > it is getting used for example in intel_cacheinfo.c
> > 
> Well, yes this is exactly what I want, except that it is not compiled for x86_64
> so on a HT Xeon in 64-bit I don't get it. Why is that?

on x86_64, it is getting initialized in identify_cpu() and further
intel_cacheinfo.c gets linked in both i386 and x86_64.

thanks,
suresh
