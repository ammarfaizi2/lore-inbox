Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSFQW2Y>; Mon, 17 Jun 2002 18:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSFQW2X>; Mon, 17 Jun 2002 18:28:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:56315 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317101AbSFQW2W>;
	Mon, 17 Jun 2002 18:28:22 -0400
Message-ID: <3D0E6267.F5CE4E74@mvista.com>
Date: Mon, 17 Jun 2002 15:27:51 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "X.Xiao" <joyhaa@yahoo.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dynamic Timer
References: <20020617204127.62122.qmail@web13203.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"X.Xiao" wrote:
> 
> I have two questions about dynamic timer in Linux:
> 1. Kernel space: After add_timer is used, where is the
> code used to poll the global 'struct timer_list' to
> activate the related functions on time? It's not in
> sched.c, is it in tasklet/bh?

The "code" is in timer.c (same place you found "add_timer())
and is called run_timer_list().  It is called by timer_bh()
also in timer.c, which is scheduled by do_timer() (also in
timer.c) which is called each timer interrupt by code in the
arch/kernel/ area (in i386 it is time.c) which, in turn is
called by the interrupt code.

> 2. User space: is there a way to set a dynamic timer
> in userspace as well, such as create_timer(posix, not
> in Linux)?

The tried and true way is the setitimer() call.  The POSIX
calls are also available as a patch from the high-res-timers
project (see signature).


-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
