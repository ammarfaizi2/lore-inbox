Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267310AbUHYD6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267310AbUHYD6a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 23:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267348AbUHYD6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 23:58:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:36054 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S267310AbUHYD6P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 23:58:15 -0400
Subject: Re: 2.6.8.1-mm4 - more cpu hotplug breakage
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <1093299523.5284.70.camel@pants.austin.ibm.com>
References: <20040822013402.5917b991.akpm@osdl.org>
	 <1093299523.5284.70.camel@pants.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1093406251.3128.102.camel@booger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 22:57:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-23 at 17:18, Nathan Lynch wrote: 
> Hi-
> 
> In both 2.6.8.1-mm3 and -mm4, a task which tries to offline a cpu
> becomes permanently hung, seemingly because the high-priority per-cpu
> kernel threads which __stop_machine_run starts never get to run.  I did
> a bisection search on the 2.6.8.1-mm4 patch series and narrowed it down
> to one of these three patches, listed below along with their behavior
> when trying to offline a cpu:
> 
> 191: sched-smt-fixes.patch     - panic
> 192: sched-smt-fixes-fix.patch - panic
> 193: nicksched.patch           - process hangs

In case anyone cares, commenting out the sys_sched_setscheduler() call
in stop_machine() allows the kstopmachine threads to run and the cpu
goes offline.  However, there's still something wrong as
__stop_machine_run never returns from wait_for_completion.

Any ideas here?  Zwane and I are kinda stuck using 2.6.8.1-mm2 for cpu
hotplug work until we get this sorted out.

Nathan

