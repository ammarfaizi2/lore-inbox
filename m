Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVBCWZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVBCWZe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 17:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbVBCWZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 17:25:33 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:65529 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S261275AbVBCWZL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 17:25:11 -0500
Message-Id: <200502032224.j13MOExF013592@localhost.localdomain>
To: Ingo Molnar <mingo@elte.hu>
cc: Con Kolivas <kernel@kolivas.org>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       "Jack O'Quin" <joq@io.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature 
In-reply-to: Your message of "Thu, 03 Feb 2005 22:59:27 +0100."
             <20050203215927.GA28634@elte.hu> 
Date: Thu, 03 Feb 2005 17:24:14 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.197.43.196] at Thu, 3 Feb 2005 16:25:09 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>that might be all well and good, but i believe you still dont understand
>my point: for yield_to() to work the target task _needs to be running_. 

correct, i did not understand. perhaps Con didn't either. my idea was
related to:

>in theory it would be possible to add two new syscalls: sys_suspend()
>and sys_wakeup(tid), where suspend would just enter TASK_INTERRUPTIBLE

but more like:

    sys_suspend_and_wake (tid)

where current enters TASK_INTERRUPTIBLE, and process_wakeup() is
called on tid.

>having this API on 2.4 kernels. But it would have one big advantage: it
>would be evidently and trivially RT-safe :-)

no small advantage.

it has another big advantage from the user space perspective: no other
information is required apart from <tid>. no state needs to be
maintained by the system that uses this. thats a huge win over the
baroque collection of FIFOs (or futexes) that we have to look after now.

--p
