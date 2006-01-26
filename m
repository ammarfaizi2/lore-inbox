Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWAZFqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWAZFqW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 00:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWAZFqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 00:46:22 -0500
Received: from tayrelbas03.tay.hp.com ([161.114.80.246]:9198 "EHLO
	tayrelbas03.tay.hp.com") by vger.kernel.org with ESMTP
	id S1750763AbWAZFqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 00:46:21 -0500
Date: Wed, 25 Jan 2006 21:43:45 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Greg KH <greg@kroah.com>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] 2.6.16-rc1 perfmon2 patch for review
Message-ID: <20060126054345.GC10962@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200601201520.k0KFKEm2023128@frankl.hpl.hp.com> <1137775645.28944.61.camel@serpentine.pathscale.com> <20060124150912.GB7130@frankl.hpl.hp.com> <1138219693.15295.13.camel@serpentine.pathscale.com> <20060125235204.GB21195@kroah.com> <20060126045510.GA10962@frankl.hpl.hp.com> <20060126052419.GB12538@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126052419.GB12538@kroah.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

On Wed, Jan 25, 2006 at 09:24:19PM -0800, Greg KH wrote:
> On Wed, Jan 25, 2006 at 08:55:10PM -0800, Stephane Eranian wrote:
> > Greg,
> > 
> > On Wed, Jan 25, 2006 at 03:52:04PM -0800, Greg KH wrote:
> > > On Wed, Jan 25, 2006 at 12:08:13PM -0800, Bryan O'Sullivan wrote:
> > > > On Tue, 2006-01-24 at 07:09 -0800, Stephane Eranian wrote:
> > > > 
> > > > > Because I tried regrouping all the /proc AND related interface into a single
> > > > > C file.
> > > > 
> > > > sysctls seem to be every bit as deprecated as /proc for what you are
> > > > tring to do.
> > > > 
> > > > > Well, it is not clear to me what criteria is used for /sys vs /proc.
> > > > 
> > > > My understanding is that only process-related stuff belongs in /proc
> > > > now.  Other random cruft that has accumulated over the years is left
> > > > there for backwards compatibility, but /sys interfaces are the way
> > > > forward now.
> > > 
> > > Yes, that is exactly right.
> > > 
> > I don't have a problem moving the perfmon stuff to /sys, except for
> > /proc/perfmon which is already being used by a bunch of tools. Unless
> > we duplicate the information or use a simlink (if that's possible).
> 
> symlink will not work, sorry.
> 
> > Please indicate a location in the /sys tree where these would fit:
> > 
> > /proc/perfmon

This one contains statistics about perfmon such as PMU model, number of active
sessions, and also a bunch of per-cpu statistics (see attached file).

$ cat /proc/perfmon
perfmon version            : 2.2
PMU model                  : Intel Pentium M
PMU description version    : 1.0
counter width              : 31
loaded per-thread sessions : 0
loaded sys-wide   sessions : 0
current smpl buffer memory : 0
format                     : d1-39-b2-9e-62-e8-40-e4-b4-02-73-07-87-92-e9-37 default_format2
CPU0   total ovfl intrs    : 0
CPU0     spurious intrs    : 0
CPU0     replay   intrs    : 0
CPU0     regular  intrs    : 0
CPU0   overflow cycles     : 0
CPU0   overflow phase1     : 0
CPU0   overflow phase2     : 0
CPU0   overflow phase3     : 0
CPU0   smpl handler calls  : 0
CPU0   smpl handler cycles : 0
CPU0   set switch count    : 0
CPU0   set switch cycles   : 0
CPU0   handle timeout      : 0
CPU0   owner task          : -1
CPU0   owner context       : 00000000
CPU0   activations         : 0



> > /proc/perfmon_map

This one contains PMU register mapping information. On My laptop, it shows:
% cat /proc/perfmon_map
PMC0:0x100000:0xffcfffff:PERFSEL0
PMC1:0x100000:0xffcfffff:PERFSEL1
PMD0:0x0:0xffffffffffffffff:PERFCTR0
PMD1:0x0:0xffffffffffffffff:PERFCTR1

> 
> What are the contents of these files?
> 
> > These are currently sysctl():
> > 
> > /proc/sys/kernel/perfmon/arg_size_max
> > /proc/sys/kernel/perfmon/debug
> > /proc/sys/kernel/perfmon/debug_ovfl
> > /proc/sys/kernel/perfmon/expert_mode
> > /proc/sys/kernel/perfmon/reset_stats
> > /proc/sys/kernel/perfmon/smpl_buf_size_max
> > /proc/sys/kernel/perfmon/sys_group
> > /proc/sys/kernel/perfmon/task_group
> > 
> 
> What are the contents of these different files?

One integer value per file.

> 
> Remember that sysfs is one value per file, so sysctls translate usually
> very easily to sysfs files.
> 
Yes, that should be fairly easy.

> You can always just use /sys/kernel/perfmon/ if you like, as I don't
> think you are bound to anything that would be in the /sys/devices tree
> (you don't export per-cpu statistics, right?)
> 
Well, /proc/perfmon does expose per-cpu stats.

-- 

-Stephane
