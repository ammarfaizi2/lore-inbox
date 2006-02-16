Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWBPEg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWBPEg4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 23:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWBPEgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 23:36:53 -0500
Received: from c-66-31-106-233.hsd1.ma.comcast.net ([66.31.106.233]:63717 "EHLO
	nwo.kernelslacker.org") by vger.kernel.org with ESMTP
	id S932229AbWBPEgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 23:36:52 -0500
Date: Wed, 15 Feb 2006 23:36:42 -0500
From: Dave Jones <davej@redhat.com>
To: tomichm@bellsouth.net
Cc: linux-kernel@vger.kernel.org, jeremy@goop.org
Subject: Re: patch to speedstep-centrino.c
Message-ID: <20060216043642.GF31951@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, tomichm@bellsouth.net,
	linux-kernel@vger.kernel.org, jeremy@goop.org
References: <20060216042258.PODB2023.ibm65aec.bellsouth.net@mail.bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216042258.PODB2023.ibm65aec.bellsouth.net@mail.bellsouth.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 11:22:58PM -0500, tomichm@bellsouth.net wrote:
 > I guess I goofed by submitting this in HTML previously...sorry...
 > 
 > Below is a patch to the speedstep-centrino.c file.  It's needed to fix a missing symbol error (online_cpu_map) in the latest mm patch of the kernel.
 > 
 > --- linux-2.6.16-rc3-mm1/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c      2006-02-15 22:31:54.561277488 -0500
 > +++ linux-2.6.16-rc3-mm1-patched/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c      2006-02-15 22:05:15.964091566 -0500
 > @@ -654,8 +654,10 @@ static int centrino_target (struct cpufr
 >                 return -EINVAL;
 >         }
 > 
 > +#ifdef CONFIG_SMP
 >         /* cpufreq holds the hotplug lock, so we are safe from here on */
 >         cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
 > +#endif
 > 
 >         saved_mask = current->cpus_allowed;
 >         first_cpu = 1;

As this is an -mm specific problem right now, I've not merged
this into the cpufreq git tree.

I expect Andrew has it queued up for -mm2, and will submit it the same
time as the patches that cause the breakage.

		Dave

