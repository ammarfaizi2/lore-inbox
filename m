Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWA0ARQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWA0ARQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWA0ARQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:17:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:63365 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932293AbWA0ARP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:17:15 -0500
Date: Thu, 26 Jan 2006 16:14:49 -0800
From: Greg KH <greg@kroah.com>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] 2.6.16-rc1 perfmon2 patch for review
Message-ID: <20060127001449.GA16516@kroah.com>
References: <200601201520.k0KFKEm2023128@frankl.hpl.hp.com> <1137775645.28944.61.camel@serpentine.pathscale.com> <20060124150912.GB7130@frankl.hpl.hp.com> <1138219693.15295.13.camel@serpentine.pathscale.com> <20060125235204.GB21195@kroah.com> <20060126045510.GA10962@frankl.hpl.hp.com> <20060126052419.GB12538@kroah.com> <20060126054345.GC10962@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126054345.GC10962@frankl.hpl.hp.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 09:43:45PM -0800, Stephane Eranian wrote:
> > > /proc/perfmon
> 
> This one contains statistics about perfmon such as PMU model, number of active
> sessions, and also a bunch of per-cpu statistics (see attached file).
> 
> $ cat /proc/perfmon
> perfmon version            : 2.2
> PMU model                  : Intel Pentium M
> PMU description version    : 1.0
> counter width              : 31
> loaded per-thread sessions : 0
> loaded sys-wide   sessions : 0
> current smpl buffer memory : 0

These can all be individual files, one value per file in sysfs.

> format                     : d1-39-b2-9e-62-e8-40-e4-b4-02-73-07-87-92-e9-37 default_format2

What does this mean?

> CPU0   total ovfl intrs    : 0
> CPU0     spurious intrs    : 0
> CPU0     replay   intrs    : 0
> CPU0     regular  intrs    : 0
> CPU0   overflow cycles     : 0
> CPU0   overflow phase1     : 0
> CPU0   overflow phase2     : 0
> CPU0   overflow phase3     : 0
> CPU0   smpl handler calls  : 0
> CPU0   smpl handler cycles : 0
> CPU0   set switch count    : 0
> CPU0   set switch cycles   : 0
> CPU0   handle timeout      : 0
> CPU0   owner task          : -1
> CPU0   owner context       : 00000000
> CPU0   activations         : 0

These should all be individual files, under the specific cpu in
questions in sysfs (/sys/devices/system/cpu/cpuX)

> > > /proc/perfmon_map
> 
> This one contains PMU register mapping information. On My laptop, it shows:
> % cat /proc/perfmon_map
> PMC0:0x100000:0xffcfffff:PERFSEL0
> PMC1:0x100000:0xffcfffff:PERFSEL1
> PMD0:0x0:0xffffffffffffffff:PERFCTR0
> PMD1:0x0:0xffffffffffffffff:PERFCTR1

Hm, can you split this up into individual files like:
	/sys/kernel/perfmon/map_PMC0
	/sys/kernel/perfmon/map_PMC1
	/sys/kernel/perfmon/map_PMD0
	/sys/kernel/perfmon/map_PMD1
that contain a single line?

"0x100000:0xffcfffff:PERFSEL0" for example for the map_PMC0 file.

> > What are the contents of these files?
> > 
> > > These are currently sysctl():
> > > 
> > > /proc/sys/kernel/perfmon/arg_size_max
> > > /proc/sys/kernel/perfmon/debug
> > > /proc/sys/kernel/perfmon/debug_ovfl
> > > /proc/sys/kernel/perfmon/expert_mode
> > > /proc/sys/kernel/perfmon/reset_stats
> > > /proc/sys/kernel/perfmon/smpl_buf_size_max
> > > /proc/sys/kernel/perfmon/sys_group
> > > /proc/sys/kernel/perfmon/task_group
> > > 
> > 
> > What are the contents of these different files?
> 
> One integer value per file.

Great, that maps to sysfs just fine.

> > Remember that sysfs is one value per file, so sysctls translate usually
> > very easily to sysfs files.
> > 
> Yes, that should be fairly easy.
> 
> > You can always just use /sys/kernel/perfmon/ if you like, as I don't
> > think you are bound to anything that would be in the /sys/devices tree
> > (you don't export per-cpu statistics, right?)
> > 
> Well, /proc/perfmon does expose per-cpu stats.

Then it should go in the above mentioned sysfs cpu directory.

thanks,

greg k-h
