Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVFQNKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVFQNKT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVFQNKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:10:18 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:9188 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261953AbVFQNKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:10:09 -0400
Subject: Re: SCHED_RR/SCHED_FIFO and kernel threads?
From: Steven Rostedt <rostedt@goodmis.org>
To: Patrik =?ISO-8859-1?Q?H=E4gglund?= <patrik.hagglund@bredband.net>
Cc: linux-kernel@vger.kernel.org, Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <42B26FF8.6090505@bredband.net>
References: <42B199FF.5010705@bredband.net> <42B19F65.6000102@nortel.com>
	 <42B26FF8.6090505@bredband.net>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Kihon Technologies
Date: Fri, 17 Jun 2005 08:37:52 -0400
Message-Id: <1119011872.4846.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 08:38 +0200, Patrik Hägglund wrote:
> Don't you get the problem with priority inversion? I.e., if you have two 
> processes, P1 and P2, scheduled with SCHED_FIFO, where P1 has higer 
> priority than P2. Now, if P1 gets blocked and needs some kernel thread 
> to execute to get unblocked, then P2 is scheduled before the kernel 
> thread, and can execute without any time limit.

Yep, that could happen.

> That is, you should be much better off if the kernel threads has a 
> _high_ priority. Then the execution progress can only be blocked by 
> kernel threads, not by user space threads and processes. Or have I 
> missed something?

Still have that problem with priority inversion. Kernel threads share
date structures with user processes (when they are in kernel mode) and
that kernel thread that is needed may get blocked on a process that is
lower in priority than the two mentioned above.

> 
> (Besides that, as I see it, SCHED_RR/SCHED_FIFO are scheduling 
> abstractions on their own, not necessarily  connected to  "low latency " 
> or "realtime".)

Only in the vanilla kernel. See Ingo's RT work. It handles priority
inversion and SCHED_RR/SCHED_FIFO are actually connected to "low
latency" and "realtime".

http://people.redhat.com/mingo/realtime-preempt/

-- Steve


