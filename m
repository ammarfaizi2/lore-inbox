Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVEGQyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVEGQyL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 12:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVEGQyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 12:54:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48027 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262614AbVEGQyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 12:54:06 -0400
Date: Sat, 7 May 2005 12:53:57 -0400
From: Dave Jones <davej@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Andrew Morton <akpm@osdl.org>, Ricky Beam <jfbeam@bluetronic.net>,
       nico-kernel@schottelius.org, linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050507165357.GA19601@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Willy Tarreau <willy@w.ods.org>, Andrew Morton <akpm@osdl.org>,
	Ricky Beam <jfbeam@bluetronic.net>, nico-kernel@schottelius.org,
	linux-kernel@vger.kernel.org
References: <20050419121530.GB23282@schottelius.org> <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net> <20050506211455.3d2b3f29.akpm@osdl.org> <20050507075828.GF777@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050507075828.GF777@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 09:58:29AM +0200, Willy Tarreau wrote:

 > I personally think that what would be useful is not "the number of CPUs"
 > (which does not make any sense), but an enumeration of :
 > 
 >     - the physical nodes (for NUMA)
 >     - the physical CPUs
 >     - each CPU's cores (for multi-core)
 >     - each core's siblings (for HT/SMT)
 > 
 > each of which would report their respective id for {set,get}_affinity().
 > This way, the application would be able to choose how it needs to spread
 > over available CPUs depending on its workload.

Typically, the application shouldn't care. The scheduler should be
deciding where processes would be best run.

 > > Probably these things can be worked out via the get/set_affinity() syscalls
 > > and/or via the cpuset sysfs interfaces, but it isn't as simple as you're
 > > assuming.
 > 
 > At least it would be simpler with some layout info like above.

There's nothing stopping a process from parsing /dev/cpu/x/cpuid
to find out anything it wants about the layout of cores/siblings,
but I'll bet you'd be hard pressed to find a single application
that would benefit from knowing about the layout.
Processes know nothing about what the kernel has scheduled on
other threads/cores, and they shouldn't. Trying to do the same
cpu arbitration in userspace is madness.

What /could/ be useful would be a way to tell sched_setaffinity
and co "I have two threads, I'd like them both to run on different cores,
avoiding HT pairs, and never be migrated off them" without having to care
about the layout of the cpus in each application.

		Dave

