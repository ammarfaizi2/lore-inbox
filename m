Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbUBYVKs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbUBYVKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:10:20 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:12049 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S261444AbUBYVHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:07:47 -0500
Date: Wed, 25 Feb 2004 22:11:46 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: George Anzinger <george@mvista.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: tasklets vs. workqueues
In-Reply-To: <403CEFDA.2020707@mvista.com>
Message-ID: <Pine.LNX.4.44.0402252205580.18112-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004, George Anzinger wrote:

> >>Being in process context, you can also change the priority and schedule policy 
> >>as needed to fit your application, while you are rather stuck with tasklets in 
> >>this regard.
> > 
> > 
> > How would one do that correctly? Something like
> 
> Depends on where you want to be when you do it.  From user land you would do 
> exactly what the attached program does.  In SMP you would, likely, want to do 
> all the tasks in the work queue (one per cpu).

Ok, thanks - primary concern was kernelthread anyway. Sorry if I wasn't 
clear enough.

>  From the kernel, again calling setscheduler() is the way to go.  I am not sure 
> what is in the community tree just now, but if I recall properly, the scheduler 
> itself does this so, one should be able to copy that code.
> 
> Ah, yes, there it is in  migration_thread().  It calls setscheduler().

Basically yes. Except that setscheduler is static in kernel/sched.c so one 
has to use sys_sched_setscheduler (and add some EXPORT_SYMBOL for it). And 
of course it needs the set_fs(KERNEL_DS) magic.

Thanks, I was hoping I've missed some simple "official" entry point there 
to create a SCHED_FIFO kernel thread from a module.

Martin

