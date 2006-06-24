Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932826AbWFXFZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932826AbWFXFZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 01:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932828AbWFXFZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 01:25:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34770 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932826AbWFXFZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 01:25:55 -0400
Date: Fri, 23 Jun 2006 22:25:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@openvz.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [PATCH] sched: CPU hotplug race vs. set_cpus_allowed()
Message-Id: <20060623222543.73bf727a.akpm@osdl.org>
In-Reply-To: <449BA349.6040901@openvz.org>
References: <449BA349.6040901@openvz.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 12:16:09 +0400
Kirill Korotaev <dev@openvz.org> wrote:

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
> 

That's not against 2.6.17-mm1.


>  static void move_task_off_dead_cpu(int dead_cpu, struct task_struct *tsk)
>  {
> -	int dest_cpu;
> +	runqueue_t *rq;
> +	unsigned long flags;
> +	int dest_cpu, res;
>  	cpumask_t mask;
>  	int force = 0;
> 

Your kernel has extra goodies: the `force' stuff.

Please check that the patch which I merged is correct.
