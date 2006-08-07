Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWHGDGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWHGDGM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 23:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWHGDGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 23:06:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60837 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750965AbWHGDGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 23:06:12 -0400
Subject: Re: PATCH 2 of 4] cpumask: export cpu_online_map and
	cpu_possible_map consistently
From: Greg Banks <gnb@melbourne.sgi.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@suse.de>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608040730430.16814@montezuma.fsmlabs.com>
References: <1154669759.21040.2353.camel@hole.melbourne.sgi.com>
	 <Pine.LNX.4.64.0608040730430.16814@montezuma.fsmlabs.com>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1154919940.29877.73.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 07 Aug 2006 13:05:40 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-05 at 00:32, Zwane Mwaikambo wrote:
> On Fri, 4 Aug 2006, Greg Banks wrote:
> 
> > cpumask: ensure that the cpu_online_map and cpu_possible_map bitmasks,
> > and hence all the macros in <linux/cpumask.h> that require them, are
> > available to modules for all supported combinations of architecture
> > and CONFIG_SMP.
> > 
> > Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
> > ---
> > 
> >  arch/arm/kernel/smp.c           |    2 ++
> >  arch/cris/arch-v32/kernel/smp.c |    1 +
> >  arch/sh/kernel/smp.c            |    1 +
> >  kernel/sched.c                  |    3 +++
> >  4 files changed, 7 insertions(+)
> > 
> > Index: linux-2.6.18-rc2/kernel/sched.c
> > ===================================================================
> > --- linux-2.6.18-rc2.orig/kernel/sched.c	2006-08-01 17:53:25.000000000 +1000
> > +++ linux-2.6.18-rc2/kernel/sched.c	2006-08-02 23:01:20.535457863 +1000
> > @@ -4348,7 +4348,10 @@ EXPORT_SYMBOL(cpu_present_map);
> >  
> >  #ifndef CONFIG_SMP
> >  cpumask_t cpu_online_map __read_mostly = CPU_MASK_ALL;
> > +EXPORT_SYMBOL_GPL(cpu_online_map);
> 
> >  cpumask_t cpu_possible_map;
> > +EXPORT_SYMBOL(cpu_possible_map);
> >  cpumask_t cpu_online_map;
> > +EXPORT_SYMBOL(cpu_online_map);
> 
> How come these are of different export types?

Because I screwed up.  Fix coming later.  I presume _GPL
is the favoured form?

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


