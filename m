Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311418AbSCSQ3S>; Tue, 19 Mar 2002 11:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311419AbSCSQ3H>; Tue, 19 Mar 2002 11:29:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1299 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S311418AbSCSQ2s>; Tue, 19 Mar 2002 11:28:48 -0500
Date: Tue, 19 Mar 2002 16:28:40 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4 and 2.5: remove Alt-Sysrq-L
Message-ID: <20020319162840.F11739@flint.arm.linux.org.uk>
In-Reply-To: <sc91c4ce.020@mail-01.med.umich.edu> <20020315150241.H24984@flint.arm.linux.org.uk> <3C96F015.24BDC9FF@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 09:00:21AM +0100, Kasper Dupont wrote:
> Russell King wrote:
> > 
> > With all recent kernels, init exiting causes the last of these to trigger:
> > 
> > NORET_TYPE void do_exit(long code)
> > {
> >         struct task_struct *tsk = current;
> > 
> >         if (in_interrupt())
> >                 panic("Aiee, killing interrupt handler!");
> >         if (!tsk->pid)
> >                 panic("Attempted to kill the idle task!");
> >         if (tsk->pid == 1)
> >                 panic("Attempted to kill init!");
> 
> Why actually panic because of an attempt to kill init?
> 
> Of course a message should be printed, but after that
> couldn't do_exit enter a loop where it just handles
> signals and zombies?

Examine the LKML archive around 23rd December 2001, where Alan Cox wrote:

| pid1 ends up trying to kill pid1 and it goes deeply down the toilet from
| that point onwards. The Unix traditional world reboots when pid 1 dies.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

