Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269774AbUHZWy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269774AbUHZWy0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269752AbUHZWuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:50:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:42118 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269750AbUHZWrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:47:33 -0400
Date: Thu, 26 Aug 2004 15:50:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1
Message-Id: <20040826155048.71e28a34.akpm@osdl.org>
In-Reply-To: <200408270046.36419.rjw@sisk.pl>
References: <20040826014745.225d7a2c.akpm@osdl.org>
	<200408270046.36419.rjw@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Thursday 26 of August 2004 10:47, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6
> >.9-rc1-mm1/
> >
> >
> > - nicksched is still here.  There has been very little feedback, except
> > that it seems to slow some workloads on NUMA.
> >
> 
> It has the problem that I have reported for 2.6.8.1-mm4, that after issuing:
> 
> # rmmod snd_seq_oss
> 
> the kernel goes into a strange state:

Rusty sent out a couple of patches which should fix this up.  They'll be in
next -mm.

Probably the below patch:

--- .13565-linux-2.6.8.1-mm4/kernel/stop_machine.c	2004-05-10 15:13:59.000000000 +1000
+++ .13565-linux-2.6.8.1-mm4.updated/kernel/stop_machine.c	2004-08-26 16:24:56.000000000 +1000
@@ -82,7 +86,7 @@ static int stop_machine(void)
 	int i, ret = 0;
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
 
 	/* One high-prio thread per cpu.  We'll do this one. */
-	sys_sched_setscheduler(current->pid, SCHED_FIFO, &param);
+	sys_sched_setscheduler(current->pid, SCHED_RR, &param);
 
 	atomic_set(&stopmachine_thread_ack, 0);

