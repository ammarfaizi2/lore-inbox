Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVDDBcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVDDBcD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 21:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVDDBcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 21:32:03 -0400
Received: from fmr22.intel.com ([143.183.121.14]:48312 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261962AbVDDBb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 21:31:59 -0400
Message-Id: <200504040131.j341Vlg31981@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>, "Paul Jackson" <pj@engr.sgi.com>
Cc: <torvalds@osdl.org>, <nickpiggin@yahoo.com.au>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [patch] sched: auto-tune migration costs [was: Re: Industry db benchmark result on recent 2.6 kernels]
Date: Sun, 3 Apr 2005 18:31:47 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU4Wba2GNeD7aldQD+gwzEpRw1+qwAWh/RQ
In-Reply-To: <20050403142959.GB22798@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Sunday, April 03, 2005 7:30 AM
> how close are these numbers to the real worst-case migration costs on
> that box?

I booted your latest patch on a 4-way SMP box (1.5 GHz, 9MB ia64). This
is what it produces.  I think the estimate is excellent.

[00]:     -    10.4(0) 10.4(0) 10.4(0)
[01]:  10.4(0)    -    10.4(0) 10.4(0)
[02]:  10.4(0) 10.4(0)    -    10.4(0)
[03]:  10.4(0) 10.4(0) 10.4(0)    -
---------------------
cacheflush times [1]: 10.4 (10448800)


One other minor thing: when booting a numa kernel on smp box, there is
a numa scheduler domain at the top level and cache_hot_time will be set
to 0 in that case on smp box.  Though this will be a mutt point with
recent patch from Suresh Siddha for removing the extra bogus scheduler
domains.  http://marc.theaimsgroup.com/?t=111240208000001&r=1&w=2


