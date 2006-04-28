Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbWD1OvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbWD1OvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 10:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbWD1OvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 10:51:03 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:18306 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965216AbWD1OvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 10:51:01 -0400
Date: Fri, 28 Apr 2006 10:50:41 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net, vgoyal@in.ibm.com,
       ebiederm@xmission.com, nanhai.zou@intel.com
Subject: Re: [Lhms-devel] Re: [PATCH] register hot-added memory to iomem resource
Message-ID: <20060428145041.GB7061@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060427204904.5037f6ea.kamezawa.hiroyu@jp.fujitsu.com> <20060427160130.6149550f.akpm@osdl.org> <20060428092754.cf382d03.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060428092754.cf382d03.kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 09:27:54AM +0900, KAMEZAWA Hiroyuki wrote:
> On Thu, 27 Apr 2006 16:01:30 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> > >
> > > This patch registers hot-added memory to iomem_resource.
> > > By this, /proc/iomem can show hot-added memory.
> > > This patch is against 2.6.17-rc2-mm1.
> > > 
> > > Note: kdump uses /proc/iomem to catch memory range when it is installed.
> > >       So, kdump should be re-installed after /proc/iomem change.
> > > 
> > 
> > What do you mean by "kdump should be reinstalled"?  The kdump userspace
> > tools need to re-run kexec_load()?
> > 
> yes. I heard an admin has to re-run kexec_load.
> - http://www.uwsg.indiana.edu/hypermail/linux/kernel/0604.0/0821.html
> - http://www.uwsg.indiana.edu/hypermail/linux/kernel/0604.0/0829.html
> Added CC to ebiederm@xmission.com, nanhai.zou@intel.com
> 
> > If so, why?
> > 
> It reads physical memory list from /proc/iomem now.
> The physical memory list is read and saved at kdump kernel loading time
> instead of crashing time. 
> 

True. If some meory is added, kdump kernel has to be re-loaded.

> > And how is kdump to know that memory was hot-added?  Do we generate a
> > hotplug event?
> > 
> A user program has to make memory section online from sysfs , anyway.
> 
> The hotplug script for memory hotplug will run at memory hotplug event 
> from ACPI. If a user uses /probe interface (powerpc, x86_64),
> he knows what he does. 
> 
> hot-add -> online memory -> kexec_load() is a scenario I think of.
> 

I will look into it.

Thanks
Vivek
