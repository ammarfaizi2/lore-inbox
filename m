Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbVJLWTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVJLWTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 18:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVJLWTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 18:19:37 -0400
Received: from fmr21.intel.com ([143.183.121.13]:6854 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932484AbVJLWTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 18:19:36 -0400
Date: Wed, 12 Oct 2005 15:19:27 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [discuss] [Patch 1/2] x86, x86_64: Intel HT, Multi core detection fixes
Message-ID: <20051012151926.E29292@unix-os.sc.intel.com>
References: <20051005161706.B30098@unix-os.sc.intel.com> <200510081228.39492.ak@suse.de> <20051012143641.B29292@unix-os.sc.intel.com> <200510122349.05312.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200510122349.05312.ak@suse.de>; from ak@suse.de on Wed, Oct 12, 2005 at 11:49:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 11:49:04PM +0200, Andi Kleen wrote:
> On Wednesday 12 October 2005 23:36, Siddha, Suresh B wrote:
> 
> > Fields obtained through cpuid vector 0x1(ebx[16:23]) and
> > vector 0x4(eax[14:25], eax[26:31]) indicate the maximum values and might not
> > always be the same as what is available and what OS sees.  So make sure
> > "siblings" and "cpu cores" values in /proc/cpuinfo reflect the values as seen
> > by OS instead of what cpuid instruction says. This will also fix the buggy BIOS
> > cases (for example where cpuid on a single core cpu says there are "2" siblings,
> > even when HT is disabled in the BIOS. 
> > http://bugzilla.kernel.org/show_bug.cgi?id=4359)
> 
> I'm not too fond of this new booted_core variable. How about
> you just put the true number of cores into x86_num_cores? 
> What should x86_num_cores be in your setup anyways if not
> "booted cores"? 

x86_num_cores (cpuid returned value) is required while right shifting the 
apicid to get the core-id and the package-id. booted_cores will indicate 
how many cores actually cameup. x86_num_cores can differ from "booted cores" 
in these scenarios

a) x86_num_cores may not be '1' when multi-core is disabled in the BIOS
b) "maxcpus=" kernel boot param
c) logical hotplug

> Also I must admit the number of different variables to keep
> track of multicore and siblingness starts to become mindboggling,
> so I would recommend you add a fat overview comment somewhere
> that describes their definition and relationship. Or better put
> something into Documentation, it is probably as confusing for 
> user space /proc/cpuinfo consumer too.

I will send a new documentation patch.

thanks,
suresh
