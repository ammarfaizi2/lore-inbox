Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVCKEZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVCKEZs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVCKEWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:22:01 -0500
Received: from fire.osdl.org ([65.172.181.4]:7648 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261712AbVCKEIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:08:40 -0500
Date: Thu, 10 Mar 2005 20:08:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Microstate Accounting for 2.6.11
Message-Id: <20050310200808.306caf98.akpm@osdl.org>
In-Reply-To: <16945.5058.251259.828855@berry.gelato.unsw.EDU.AU>
References: <16945.5058.251259.828855@berry.gelato.unsw.EDU.AU>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb <peterc@gelato.unsw.edu.au> wrote:
>
>  Timing data on threads at present is pretty crude:  when the timer
>  interrupt occurs, a tick is added to either system time or user time
>  for the currently running thread.  Thus in an unpacthed kernel one can
>  distinguish three timed states:  On-cpu in userspace, on-cpu in system
>  space, and not running.
> 
>  The actual number of states is much larger.  A thread can be on a
>  runqueue or  the expired queue (i.e., ready to run but not running),
>  sleeping on a semaphore or on a futex, having its time stolen to
>  service an interrupt, etc., etc.
> 
>  This patch adds timers per-state to each struct task_struct, so that
>  time in all these states can be tracked.  This patch contains the core
>  code do the timing, and to initialise the timers.  Subsequent patches
>  enable the code (by adding Kconfig options) and add hooks to track
>  state changes.

Why does the kernel need this feature?

Have you any numbers on the overhead?

The preempt_disable() in sys_msa() seems odd.
