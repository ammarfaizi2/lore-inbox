Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbVIARxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbVIARxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 13:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbVIARxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 13:53:43 -0400
Received: from fmr22.intel.com ([143.183.121.14]:36787 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030263AbVIARxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 13:53:42 -0400
Date: Thu, 1 Sep 2005 10:53:01 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Natalie.Protasevich@unisys.com, shaohua.li@intel.com,
       zwane@arm.linux.org.uk, ashok.raj@intel.com, akpm@osdl.org,
       lhcs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       hotplug_sig@lists.osdl.org
Subject: Re: [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Message-ID: <20050901105301.C26312@unix-os.sc.intel.com>
References: <20050831121311.5FC7C57D99@linux.site> <200509011045.11142.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200509011045.11142.ak@suse.de>; from ak@suse.de on Thu, Sep 01, 2005 at 10:45:10AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 10:45:10AM +0200, Andi Kleen wrote:
> Hallo Natalie,
> 
> On Wednesday 31 August 2005 14:13, Natalie.Protasevich@unisys.com wrote:
> > Current IA32 CPU hotplug code doesn't allow bringing up processors that
> > were not present in the boot configuration. To make existing hot plug
> > facility more practical for physical hot plug, possible processors should
> > be encountered during boot for potentual hot add/replace/remove. On ES7000,
> > ACPI marks all the sockets that are empty or not assigned to the
> > partitionas as "disabled". 
> 
> Good idea. In fact I always hated the behaviour of the existing
> hotplug code that assumes all possible CPUs can be hotplugged.
> It would be much nicer to be told be the firmware what CPUs
> are hotpluggable. It would be great if all ia32/x86-64 hotplug capable 
> BIOS behaved like your.
> 

Andi, you are getting mixed up with software only ability to offline with 
hardware eject capability. ACPI indicates ability to hotplug by the presence
of _EJD in the appropriate scope of the object. So ACPI does have ability to 
do what you mention above precicely, but the entire namespace is not known 
upfront since some could be dynamically loaded. Which is why we need to show 
the entire NR_CPUS as hotpluggable. 

Possibly we can keep cpu_possible_map as NR_CPUS only when support for 
PHYSICAL_CPU_HOTPLUG is present, otherwise we can keep it
cloned as cpu_present_map. (we dont have a generic PHYSICAL hotplug CONFIG
option today)

What CONFIG_HOTPLUG_CPU=y indicates is ability to offline a processor from the
kernel. It DOES NOT indicate physical hotpluggablity.  So we dont need any
hardware support (apart arch/kernel support) for this to work. Support
for physical hotplug is indicated via CONFIG_ACPI_HOTPLUG_CPU.

Be aware that suspend/resume folks using CPU hotplug to offline CPUS except
BSP need just the kernel support to offline. BIOS has nothing to do with 
being able to offline a CPU (preferably called as soft-removal).

Cheers,
ashok

