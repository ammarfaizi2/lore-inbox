Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSILTp1>; Thu, 12 Sep 2002 15:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSILTp1>; Thu, 12 Sep 2002 15:45:27 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:41950 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S317096AbSILTp1>; Thu, 12 Sep 2002 15:45:27 -0400
Subject: Re: 2.5.34-mm2 kernel BUG at sched.c:944! only with CONFIG_PREEMPT=y
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1031840041.1990.378.camel@spc9.esa.lanl.gov>
References: <1031840041.1990.378.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 12 Sep 2002 13:46:45 -0600
Message-Id: <1031860005.1990.394.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 08:14, Steven Cole wrote:
> I got the following BUG at sched.c:944! with 2.5.34-mm2 and PREEMPT on.
> This was repeatable. 
> 
> With no PREEMPT, 2.5.34-mm2 booted and is running fine.  Some other
> options used: SMP, HUGETLB_PAGE, HIGHPTE, HIGHMEM4G.

The above also occurred with no SMP. 

I backed out Changeset 1.606 which did this in kernel/sched.c:
 
-	if (unlikely(in_interrupt()))
+	if (unlikely(in_atomic()))

and 2.5.34-mm2 was able to boot with CONFIG_PREEMPT=y.

Obviously, this is not a fix of any kind, but shows that the scheduler
may be being called with a preemption lock.

Steven


