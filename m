Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVBYA6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVBYA6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbVBYAzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 19:55:14 -0500
Received: from relay.axxeo.de ([213.239.199.237]:31649 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S262583AbVBYAvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 19:51:55 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: "Chad N. Tindel" <chad@tindel.net>
Subject: Re: Xterm Hangs - Possible scheduler defect?
Date: Fri, 25 Feb 2005 01:51:41 +0100
User-Agent: KMail/1.7.1
Cc: Chris Friesen <cfriesen@nortel.com>, Paulo Marques <pmarques@grupopie.com>,
       Mike Galbraith <EFAULT@gmx.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20050224075756.GA18639@calma.pair.com> <421E2EF9.9010209@nortel.com> <20050224200802.GA39590@calma.pair.com>
In-Reply-To: <20050224200802.GA39590@calma.pair.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502250151.41793.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chad N. Tindel wrote:
> I think what we have are the need for two levels of applications:
>
> 1.  That which wishes to be the highest priority userspace application, and
> wishes to preempt all other userspace applications.  Such an application is
> OK being preempted by the kernel when the kernel needs to do work.  IMHO,
> this should be the default behavior for any SCHED_FIFO application.  If one
> of these has a bug and goes CPU-bound, the worst it can do is prevent other
> apps from ever using the CPU it is on.

That is basically, what you do with SCHED_RR.
(Be preempted after maximum quantum, even if having work to do)

> 2.  Applications which actually want to be the highest priority thing on
> the system, including being higher than the kernel.  These applications are
> OK with the fact that they may cause system hangs and deadlocks, and are
> careful not to shoot themselves in the foot.

This is SCHED_FIFO.
(Strict priority scheduling, allowed to starve anything below)

So just try to use the right scheduler for your application right now, ok?

If your system is busy with top priority task, why should the kernel disturb 
it?

Things will stop anyway, if your high priority task is needing a resource,
which is blocked. Than it becomes unrunnable and other tasks have
chances to continue. Kernel threads are likely to execute then, because they
are likely runnable then. Your task could even migrate, if a lot of kernel 
tasks 
are waiting in one CPU and your task is NOT bound to a specific CPU.

So the system is not brought down, but just busy in a infortunate way.
Stupid applications can starve other applications for a while, but not
forever, because the kernel is still running and deciding.


Regards

Ingo Oeser


