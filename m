Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbTEVUYX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 16:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbTEVUYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 16:24:23 -0400
Received: from mail.eskimo.com ([204.122.16.4]:10507 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id S263234AbTEVUYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 16:24:15 -0400
Date: Thu, 22 May 2003 13:37:10 -0700
To: Ming Lei <lei.ming@attbi.com>
Cc: linux-kernel@vger.kernel.org, Elladan <elladan@eskimo.com>, efault@gmx.de
Subject: Re: Linux 2.4 scheduler is RTOS-alike?
Message-ID: <20030522203710.GA4195@eskimo.com>
References: <200305142020.h4EKK9J01052@relax.cmf.nrl.navy.mil> <20030514205949.GA3945@kroah.com> <004601c3209c$f0739700$0305a8c0@arch.sel.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004601c3209c$f0739700$0305a8c0@arch.sel.sony.com>
User-Agent: Mutt/1.5.4i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The printfs could block, so B could run while A is blocked.

They might not ever block if you're always printing to the console, but
if they go over the network or into some sort of file or anything, they
could block.  

If you want to trace the operation without blocking, you might make your
own printf that outputs to a ring buffer, or use internal counters or
the like.

-J

On Thu, May 22, 2003 at 01:01:30PM -0700, Ming Lei wrote:
> 
> will it be the same behavior If thread A and thread B both have a lot of
> printf? Suppose A get first run, does B get run at all?
> 
> > this question is regarding linux kernel 2.4.7-2.4.20.
> > linux 2.4 kernel does support real time sheduler. If using FIFO real time
> > schedule policy, would the case that higher priority thread starve the
> lower
> > priority thread happen?  Similarly, let's say an example: if I have higher
> > prioority thread A and lower priority thread B, thread A is running
> without
> > any wait or blocking, is there a possiblity that 2.4 scheduler may want to
> > switch to thread B? Why?
> 
> Yes, FIFO threads that spin will block lower priority threads forever.
> 
> Sure, guaranteed if the high prio SCHED_FIFO task doesn't block at all.  If
> you have a pure cpu burner, it will starve all lower priority
> threads.
