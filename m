Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWFWKyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWFWKyD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWFWKyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:54:03 -0400
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:8673 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751269AbWFWKyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:54:01 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Kirill Korotaev <dev@openvz.org>
Subject: Re: [PATCH] sched: CPU hotplug race vs. set_cpus_allowed()
Date: Fri, 23 Jun 2006 20:53:22 +1000
User-Agent: KMail/1.9.3
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <449BA349.6040901@openvz.org>
In-Reply-To: <449BA349.6040901@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606232053.23526.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 June 2006 18:16, Kirill Korotaev wrote:
> Looks like there is a race between set_cpus_allowed()
> and move_task_off_dead_cpu().
> __migrate_task() doesn't report any err code, so
> task can be left on its runqueue if its cpus_allowed mask
> changed so that dest_cpu is not longer a possible target.
> Also, chaning cpus_allowed mask requires rq->lock being held.
>
> Signed-Off-By: Kirill Korotaev <dev@openvz.org>
>
> Kirill
> P.S. against 2.6.17-mm1

Hi!

Since you've got

-static void __migrate_task(struct task_struct *p, int src_cpu, int dest_cpu)
+static int __migrate_task(struct task_struct *p, int src_cpu, int dest_cpu)
 {
        runqueue_t *rq_dest, *rq_src;
+       int res = 0;
 
        if (unlikely(cpu_is_offline(dest_cpu)))
-               return;
+               return 0;

why not return res here?

oh and ret is a more commonly used name than res (your choice of course).

and an addition to the comment such as "returns non-zero only when it fails to 
migrate the task" would be nice.

thanks!

--
-ck

-- 
-ck
