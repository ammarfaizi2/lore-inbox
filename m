Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263898AbUDVI7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUDVI7c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 04:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263901AbUDVI7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 04:59:31 -0400
Received: from mtagate7.de.ibm.com ([195.212.29.156]:48546 "EHLO
	mtagate7.de.ibm.com") by vger.kernel.org with ESMTP id S263898AbUDVI5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 04:57:25 -0400
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
To: dipankar@in.ibm.com
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OFF90CC598.06FA99DE-ONC1256E7E.00306297-C1256E7E.003104C1@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 22 Apr 2004 10:55:24 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 22/04/2004 10:55:25
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> Defining idle_cpu_mask in the middle of RCU code is really not a good
idea.
> A cleaner solution would be to define idle_cpu_mask in sched.c
> and initialize it to CPU_MASK_NONE there. You could put it in
> sched.h, but then there is the likelyhood of people using
> idle_cpu_mask for things other than initialization in which
> case NR_CPUS > 64 compilation will fail.

Yes, the best solution would be to introduce idle_cpu_mask for all
architectures and to add the cpu_set/cpu_clear calls to the timer
code of these architectures. The problem is that it isn't easy to
find the correct place for the cpu_clear call. If a cpu gets woken
by an irq the cpu_clear has to be done first and then the irq
function may be executed. On s390 we use the monitor call (mc)
instruction to reenable to HZ timer and to clear the cpu bit in
idle_cpu_mask. Dunno if there is something similar for other
architectures.

blue skies,
   Martin

