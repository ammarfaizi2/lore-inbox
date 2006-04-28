Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWD1VJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWD1VJG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 17:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWD1VJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 17:09:06 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:5798 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750932AbWD1VJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 17:09:05 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: Ingo Molnar <mingo@elte.hu>
Subject: RT interrupt handling
Date: Fri, 28 Apr 2006 14:08:59 -0700
User-Agent: KMail/1.8.3
Cc: "lkml, " <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604281409.00287.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into a situation where binding a realtime testsuite to cpu 0 (on a 4 way 
opteron machine) locked the machine hard while binding it to cpu 2 worked 
fine.  Some investigation suggests that the interrupt handlers for eth0 and 
ioc0 (IRQ 24 and 26) had the smp_affinity mask set to only cpu 0.  With the 
test case running threads with rt prios in the 90s and the irqs running in 
the ~40s (don't recall, somewhere around there I think), it isn't surprising 
that the machine locked up.

I'd like to hear people's thoughts on the following:

o Why would those irqs be bound to just cpu 0?  Why not all cpus?

o Is it reasonable to extend the smp_affinity for all interrupts to all cpus 
to minimize this type of problem?

o Should a userspace RT task be able to take down the system?  Do we roll with 
the spiderman addage "With great power comes great responsibility" when 
discussing RT systems, or should we consider some kind of priority boosting 
mechanism for kernel services that must be run every so often to keep the 
system running?

Thanks!

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
