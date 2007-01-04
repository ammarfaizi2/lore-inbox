Return-Path: <linux-kernel-owner+w=401wt.eu-S932188AbXADArM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbXADArM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 19:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbXADArL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 19:47:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:30241 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932188AbXADArK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 19:47:10 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,234,1165219200"; 
   d="scan'208"; a="184289361:sNHT26502112"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Date: Wed, 3 Jan 2007 16:46:37 -0800
Message-ID: <9D2C22909C6E774EBFB8B5583AE5291C01A4FBBA@fmsmsx414.amr.corp.intel.com>
In-Reply-To: <20070104002909.GA31682@gnuppy.monkey.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Thread-Index: Accvl1+OuAt7ghucQCmP2k7PVqY0zQAAM0uA
From: "Chen, Tim C" <tim.c.chen@intel.com>
To: "Bill Huey \(hui\)" <billh@gnuppy.monkey.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Steven Rostedt" <rostedt@goodmis.org>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Daniel Walker" <dwalker@mvista.com>
X-OriginalArrivalTime: 04 Jan 2007 00:46:38.0373 (UTC) FILETIME=[CAE31550:01C72F99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> Can you sort the output ("sort -n" what ever..) and post it without
> the zeroed entries ?
> 
> I'm curious about how that statistical spike compares to the rest of
> the system activity. I'm sure that'll get the attention of Peter as
> well and maybe he'll do something about it ? :)
> 

Here's the lockstat trace.  You can cross reference it with my
earlier post.  
http://marc.theaimsgroup.com/?l=linux-kernel&m=116743637422465&w=2

The contention happened on mm->mmap_sem shared
by the java threads during futex_wake's invocation of _rt_down_read.

Tim

@contention events = 247149
@failure_events = 146
@lookup_failed_scope = 175
@lookup_failed_static = 43
@static_found = 16
[1, 113, 77 -- 32768, 0]            {tcp_init, net/ipv4/tcp.c, 2426}
[2, 759, 182 -- 1, 0]           	{lock_kernel, -, 0}
[13, 0, 7 -- 4, 0]              	{kmem_cache_free, -, 0}
[25, 3564, 9278 -- 1, 0]            {lock_timer_base, -, 0}
[56, 9528, 24552 -- 3, 0]           {init_timers_cpu, kernel/timer.c,
1842}
[471, 52845, 17682 -- 10448, 0]     {sock_lock_init, net/core/sock.c,
817}
[32251, 9024, 242 -- 256, 0]        {init, kernel/futex.c, 2781}
[173724, 11899638, 9886960 -- 11194, 0]         {mm_init, kernel/fork.c,
369}
