Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWHWTAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWHWTAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 15:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWHWTAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 15:00:36 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:41647 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750749AbWHWTAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 15:00:35 -0400
Date: Wed, 23 Aug 2006 11:59:59 -0700
From: Paul Jackson <pj@sgi.com>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, simon.derr@bull.net, nathanl@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-Id: <20060823115959.0309eab3.pj@sgi.com>
In-Reply-To: <20060823145817.GA28175@krispykreme>
References: <20060821132709.GB8499@krispykreme>
	<20060821104334.2faad899.pj@sgi.com>
	<20060821192133.GC8499@krispykreme>
	<20060821140148.435d15f3.pj@sgi.com>
	<20060821215120.244f1f6f.akpm@osdl.org>
	<20060821220625.36abd1d9.pj@sgi.com>
	<20060821221433.2bc18198.akpm@osdl.org>
	<20060823145817.GA28175@krispykreme>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton wrote:
> Im struggling to understand why we have this problem at all. If a task
> has not been touched by cpuset calls it should be allowed to use any
> cpu.

Cpusets are not like sched_setaffinity.  It's not something that is
optional for a task.

Rather, if your kernel config has CPUSETS enabled, then every task is
in a cpuset, always,   By default, every task is in the top_cpuset.

Today, the top_cpuset has a static copy of the online cpus as of the
the system boot.

We need to make the cpus in the top_cpuset become a dynamic copy of the
online cpus and nodes, not a static copy.

I'm confident udev can do this.

Right now I'm working through some local problems testing this, and
unraveling some complexities with multiple versions of the udev user
code, including at least:
 1) one version uses the kernel default /sbin/hotplug to callback,
 2) another version uses a udevd daemon and /etc/dev.d, and
 3) a third version uses udevd, but no /etc/dev.d.

The cpuset side of coding this is easy enough for me; the udev side
more difficult.

Any suggestions on the best place for me to go with more detailed udev
questions?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
