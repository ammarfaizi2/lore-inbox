Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbRGFRtd>; Fri, 6 Jul 2001 13:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbRGFRtX>; Fri, 6 Jul 2001 13:49:23 -0400
Received: from fire.osdlab.org ([65.201.151.4]:14217 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S266771AbRGFRtI>;
	Fri, 6 Jul 2001 13:49:08 -0400
Date: Fri, 6 Jul 2001 10:48:58 -0700
From: Zach Brown <zab@osdlab.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.7-pre3 kernel_stat -> cpu_stat[NR_CPUS]
Message-ID: <20010706104858.A20375@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does the following:

- creates a cacheline aligned/padded struct cpu_stat[NR_CPUS].  
- moves the [NR_CPUS] members of kernel_stat into cpu_stat

This moves the stat data that a cpu will update into a contiguous region.
Previous users of kernel_stat would compete for an array's cacheline
with other cpus.

- creates /proc/cpu/[0-9]+/ and fs/proc/proc_cpu.c with code for managing
  files in the cpu's directories.

This should be useful for rusty's */active and arjan/rmk's */frequency.
I have no strong feelings about where this lives or what it should be
named.

- adds collection of fault statistics and adds 'context migration'
  recording, per cpu.
- updates users of kernel_stat in proc, reports shouldn't change
- updates every friggin' user of kstat.irqs[] in arch/ with a macro so
  that we never have to do this again.

The patch is rather large, due to that last bit.  It can be found at

	http://www.osdlab.org/sw_resources/cpustat/cpustat-2.4.7.pre3-1.diff

with a tool for summarizing /proc/cpu/*/stat at:

	http://www.osdlab.org/sw_resources/cpustat/index.shtml

I'd like to get this sent to Linus soon, but wanted to run the
/proc/cpu/* stuff by l-k one last time.

- z
