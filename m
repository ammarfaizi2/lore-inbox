Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbTEOSO5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 14:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264152AbTEOSO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 14:14:57 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:9486 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262032AbTEOSOy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 14:14:54 -0400
Date: Thu, 15 May 2003 14:21:10 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
Subject: Re: 2.5 kernels fail to start second CPU
In-Reply-To: <20030515101103.GP8978@holomorphy.com>
Message-ID: <Pine.LNX.3.96.1030515141540.30631I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003, William Lee Irwin III wrote:

> On Thu, May 15, 2003 at 02:48:34AM -0700, William Lee Irwin III wrote:
> > Sparse physical APIC ID's are not handled properly. This should correct
> > them.
> 
> I forgot to count the BSP in the initial count of the number of kicked
> cpus. This patch does it correctly.
> 
> To handle sparse physical APIC ID's properly the phys_cpu_present_map
> must be scanned beyond bit NR_CPUS while ensuring no more than NR_CPUS
> are woken in order not to attempt to wake non-addressible cpus.
> 
> The following patch adds that logic to smp_boot_cpus() and corrects the
> failure to wake secondaries reported by dhowells, with successful
> wakeup, runtime, reboot, and halting reported after it was applied.

While you are (somewhat) on the topic of starting processors, I want to
benchmark and application on a dual Xeon system. I want to try these
configurations, preferably without opening the box, since it's in
another time zone.

  2 cpu w/ ht		normal boot
  2 cpu w/o ht		noht
  1 cpu w/o ht		nosmp noht
  1 cpu w/ ht		???

It looks as if maxcpus=2 counts physical units? I can't try it until Monday.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

