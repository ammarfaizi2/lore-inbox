Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbVIAH5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbVIAH5P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 03:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbVIAH5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 03:57:15 -0400
Received: from fmr17.intel.com ([134.134.136.16]:2736 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S965078AbVIAH5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 03:57:15 -0400
Subject: Re: [patch 1/1] Hot plug CPU to support physical add of new
	processors (i386)
From: Shaohua Li <shaohua.li@intel.com>
To: Natalie.Protasevich@unisys.com
Cc: zwane@arm.linux.org.uk, "Raj, Ashok" <ashok.raj@intel.com>, akpm@osdl.org,
       ak@suse.de, lhcs-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hotplug_sig@lists.osdl.org
In-Reply-To: <20050831121311.5FC7C57D99@linux.site>
References: <20050831121311.5FC7C57D99@linux.site>
Content-Type: text/plain
Date: Thu, 01 Sep 2005 16:00:58 +0800
Message-Id: <1125561658.4005.6.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, 2005-08-31 at 20:13 +0800, Natalie.Protasevich@unisys.com wrote:
> Current IA32 CPU hotplug code doesn't allow bringing up processors
> that were not present in the boot configuration.  
> To make existing hot plug facility more practical for physical hot
> plug, possible processors should be encountered  
> during boot for potentual hot add/replace/remove. On ES7000, ACPI
> marks all the sockets that are empty or not assigned 
> to the partitionas as "disabled". The patch allows arrays/masks with
> APIC info for disabled processors to be  
> initialized. Then the OS can bring up a processor that was inserted in
> the socked and brought into configuration  
> during runtime.  
> To test the code, one can boot the system with maxcpu=1 and then bring
> the rest of the processors up, which was not  
> possible so far (only maxcpus number of nodes were created). 
> The patch also makes proc entry for interrupts dynamically change to
> only show current onlined processors.
Could we clean up the cpu_present_map a bit, like IA64 does? Eg, if a
new CPU is inserted, we allocated cpu id for it and set cpu_present_map.
Current alloc_cpu_id is just a workaround for suspend/resume use, but
isn't ok for physical cpu hotplug to me.

Thanks,
Shaohua

