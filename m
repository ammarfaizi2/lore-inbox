Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVBXFXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVBXFXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 00:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVBXFXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 00:23:40 -0500
Received: from calma.pair.com ([209.68.1.95]:7432 "HELO calma.pair.com")
	by vger.kernel.org with SMTP id S261799AbVBXFXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 00:23:31 -0500
Date: Thu, 24 Feb 2005 00:23:30 -0500
From: "Chad N. Tindel" <chad@tindel.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
Message-ID: <20050224052330.GA99006@calma.pair.com>
References: <20050223230639.GA33795@calma.pair.com> <20050223183634.31869fa6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223183634.31869fa6.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> `xterm' is waiting for the other CPU to schedule a kernel thread (which is
> bound to that CPU).  Once that kernel thread has done a little bit of work,
> `xterm' can terminate.
> 
> But kernel threads don't run with realtime policy, so your userspace app
> has permanently starved that kernel thread.
> 
> It's potentially quite a problem, really.  For example it could prevent
> various tty operations from completing, it will prevent kjournald from ever
> writing back anything (on uniprocessor, etc).  I've been waiting for
> someone to complain ;)
> 
> But the other side of the coin is that a SCHED_FIFO userspace task
> presumably has extreme latency requirements, so it doesn't *want* to be
> preempted by some routine kernel operation.  People would get irritated if
> we were to do that.
> 
> So what to do?

It shouldn't need to preempt the kernel operation.  Why is the design such that
the necessary kernel thread can't run on the other CPU?

Chad
