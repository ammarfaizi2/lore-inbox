Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUHYXMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUHYXMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266474AbUHYXIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:08:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:34955 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266175AbUHYXEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:04:24 -0400
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
Message-Id: <1093475339.7056.6.camel@pants.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 25 Aug 2004 18:09:00 -0500
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

My apologies if this is getting annoying, but it occurred to me that any
user of stop_machine_run is broken similarly... which means that
unloading a module will also hang your machine.  I have verified this on
2.6.8.1-mm4 on ppc64.

Nathan


