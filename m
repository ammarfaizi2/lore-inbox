Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbVBKKi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbVBKKi4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 05:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVBKKi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 05:38:56 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:42408 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262243AbVBKKiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 05:38:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qEd1WRI+d0T7yEA+FmGGbeYUJQfJ85Vj7+wry7fjYq6baGYMdGVIXSo9Rk2821x4dpeMlpKgvZjCIIXNNw1mYBl9fbkJ2YWk0N3sLG1ga/y4/nKUbPqacRBzoUNjzPbHcLbN7244ZFsiK7j6k2xWOWl2riIK9rAixTz5+/oZR2U=
Message-ID: <25349aa40502110238484767bb@mail.gmail.com>
Date: Fri, 11 Feb 2005 03:38:01 -0700
From: Tipp Moseley <tipp.moseley@gmail.com>
Reply-To: Tipp Moseley <tipp.moseley@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Potential timer bug
In-Reply-To: <25349aa4050211010930333ae3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <25349aa4050211010930333ae3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Err.  I'm stupid.  This isn't a bug.




On Fri, 11 Feb 2005 02:09:10 -0700, Tipp Moseley <tipp.moseley@gmail.com> wrote:
> Hello,
> 
> I am running on a uniprocessor x86 with CONFIG_SMP disabled and
> CONFIG_PREEMPT enabled.
> 
> The problem I have encountered is when using a timer in a module.  The
> timer is set to execute every 3 ticks, and does nothing but increment
> a counter, and that works fine.  However, when the module is unloaded
> sometimes the system hangs on module exit and barfs something like:
> 
> Unable to handle kernel paging request at virtual address e18861bc
>  printing eip:
> c0122a88
> *pde = 015e5067
> *pte = 00000000
> Oops: 0002 [#1]
> PREEMPT
> Modules linked in: yenta socket, rsrc_nonstatic sonypi
> CPU: 0
> ...
> Call Trace:
>  __do_softirq+0x76/0x90
>  do_softirq+0x41/0x50
> ...
> <0>Kernel panic - not syncing: Fatal exception in interrupt
> 
> I am using del_timer_sync to delete the timer in the module_exit
> routine, and sometimes it works correctly.  My theory is that since
> with CONFIG_SMP disabled, del_timer_sync is the same as del_timer.
> This allows the timer to potentially execute after the module has
> unloaded, causing the invalid paging request.
> 
> My solution to the problem (which works, but is probably not optimal)
> is to change '#ifdef CONFIG_SMP' to '#if defined(CONFIG_SMP) ||
> defined(CONFIG_PREEMPT)' around the code defining timer_del_sync.  A
> patch is attached.  Let me know if there's any more information that I
> can provide.
> 
> Thanks,
> 
> Tipp Moseley
> 
> 
>
