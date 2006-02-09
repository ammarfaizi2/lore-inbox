Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWBITAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWBITAd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 14:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWBITAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 14:00:33 -0500
Received: from fmr23.intel.com ([143.183.121.15]:28083 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750709AbWBITAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 14:00:32 -0500
Date: Thu, 9 Feb 2006 10:52:30 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, ntl@pobox.com, dada1@cosmosbay.com,
       riel@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       mingo@elte.hu, ak@muc.de, 76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, pj@sgi.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060209105230.A10147@unix-os.sc.intel.com>
References: <20060209160808.GL18730@localhost.localdomain> <20060209090321.A9380@unix-os.sc.intel.com> <20060209100429.03f0b1c3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060209100429.03f0b1c3.akpm@osdl.org>; from akpm@osdl.org on Thu, Feb 09, 2006 at 10:04:29AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 10:04:29AM -0800, Andrew Morton wrote:

> 
> We need to fix this asap - the performance penalty for HOTPLUG_CPU=y,
> NR_CPUS=lots will be appreciable.
> 
> Do any x86 platforms actually support CPU hotplug?

Hi Andrew,

logical cpu hotplug (i.e onlining and offlining) can be done on any
system. No hw or BIOS support is required. (this is what smp suspend/resume
folks use)

I remember Natalie from Unisys mentioned they have one system which is 
ACPI based and supports physical cpu hotplug, but the BIOS is old and 
didnt support the hotplug notify via ACPI.  They probably have some other 
sysmgmt way to interact and initiate the hotplug.

Iam aware of couple more that use ia64 NUMA type hw as well. 
(I dont think i can announce for them:-) ).

> 
> Does the ACPI problem which you describe occur with present-CPUs,
> or only with possible-but-not-present ones?

Describing present cpus is not problem.

Only knowing possible-but-not-present upfront is an issue.

logical-cpu-hotplug only: cpu_present_map == cpu_possible_map always
physical-cpu-hotplug: At boot, cpu_present_map is a subset of possible_map.

Think its best to NOT set cpu_present_map to MASK_ALL as its being proposed,
but let the arch/platform code figure out early enough to set possible_map 
accurately for that platform. If a platform has no way to determine it, 
then it could use cmdline like what x86_64 introduced (additional_cpus=)
to overcome that.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
