Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSJAVCx>; Tue, 1 Oct 2002 17:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262499AbSJAVCx>; Tue, 1 Oct 2002 17:02:53 -0400
Received: from [198.149.18.6] ([198.149.18.6]:197 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262303AbSJAVCs>;
	Tue, 1 Oct 2002 17:02:48 -0400
Date: Wed, 2 Oct 2002 00:22:35 -0400
From: Christoph Hellwig <hch@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
Message-ID: <20021002002235.A3910@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210011653370.28821-102000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210011653370.28821-102000@localhost.localdomain>; from mingo@elte.hu on Tue, Oct 01, 2002 at 06:24:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 06:24:50PM +0200, Ingo Molnar wrote:
> 
> the attached (compressed) patch is the next iteration of the workqueue
> abstraction. There are two major categories of changes:

What about forcing a flush in destory_workqueue?

--- 1.1/kernel/workqueue.c	Tue Oct  1 21:17:25 2002
+++ edited/kernel/workqueue.c	Tue Oct  1 23:04:46 2002
@@ -317,6 +317,8 @@
 	struct cpu_workqueue_struct *cwq;
 	int cpu;
 
+	flush_workqueue(wq);
+
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;
