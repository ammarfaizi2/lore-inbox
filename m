Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbUC1KWi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 05:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbUC1KWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 05:22:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:7296 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262266AbUC1KWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 05:22:37 -0500
Date: Sun, 28 Mar 2004 02:21:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: <shai@ftcon.com>
Cc: ricklind@us.ibm.com, mbligh@aracnet.com, lse-tech@lists.sourceforge.net,
       erikj@subway.americas.sgi.com, efocht@hpce.nec.com, pj@sgi.com,
       xavier.bru@bull.net, linux-kernel@vger.kernel.org
Subject: Re: FW: [Lse-tech] Re: NUMA scheduler issue
Message-Id: <20040328022148.167a46ab.akpm@osdl.org>
In-Reply-To: <200403281007.BHM58439@ms6.netsolmail.com>
References: <200403281007.BHM58439@ms6.netsolmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<shai@ftcon.com> wrote:
>
> Hi,
> 
> Very nice patch.
> Andrew, would you consider adding this one? 

Not really.

--- 2.6.0-test1-ia64-0/include/linux/sched.h	2003-07-14 05:30:40.000000000 +0200
 +++ 2.6.0-test1-ia64-na/include/linux/sched.h	2003-07-18 13:38:02.000000000 +0200
@@ -390,6 +390,9 @@
 	struct list_head posix_timers; /* POSIX.1b Interval Timers */
 	unsigned long utime, stime, cutime, cstime;
 	u64 start_time;
+#ifdef CONFIG_SMP
+	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
+#endif

On 512p 64-bit that's 8 kilobytes added to the task_struct.

