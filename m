Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVASWS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVASWS0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 17:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVASWPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 17:15:54 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:40632 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261933AbVASWOY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 17:14:24 -0500
Subject: Re: 2.6.10-mm1 hang
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-os@analogic.com
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0501191658020.11665@chaos.analogic.com>
References: <1106153215.3577.134.camel@dyn318077bld.beaverton.ibm.com>
	 <20050119133136.7a1c0454.akpm@osdl.org>
	 <Pine.LNX.4.61.0501191658020.11665@chaos.analogic.com>
Content-Type: text/plain
Organization: 
Message-Id: <1106171094.3577.156.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Jan 2005 13:44:54 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 14:01, linux-os wrote:
> On Wed, 19 Jan 2005, Andrew Morton wrote:
> 
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >>
> >> I was playing with kexec+kdump and ran into this on 2.6.10-mm1.
> >>  I have seen similar behaviour on 2.6.10.
> >>
> >>  I am using a 4-way P-III machine. I have a module which tries
> >>  gets same spinlock twice. When I try to "insmod" this module,
> >>  my system hangs. All my windows froze, no more new logins,
> >>  console froze, doesn't respond to sysrq. I wasn't expecting
> >>  a system hang. Why ? Ideas ?
> >>
> >
> > Maybe all the other CPUs are stuck trying to send an IPI to this one?  An
> > NMI watchdog trace would tell.
> >
> >>  #include <linux/init.h>
> >>  #include <asm/uaccess.h>
> >>  #include <linux/spinlock.h>
> >>  spinlock_t mylock = SPIN_LOCK_UNLOCKED;
> >>  static int __init panic_init(void)
> >>  {
> >>          spin_lock_irq(&mylock);
> >>          spin_lock_irq(&mylock);
> >>         return 1;
> >>  }
> > -
> 
> What would you expect this to do? After the first lock is
> obtained, the second MUST fail forever or else the spin-lock
> doesn't work. The code, above, just proves that spin-locks
> work!
> 

I was expecting that one CPU will spin for the lock, while
3 other CPUs do real useful work (on 4-proc machine). Instead
my machine is hung - all my windows froze up, no more "ssh",
doesn't respond to sysrq to get traces. Only thing it does is,
respond to "ping".

Thanks,
Badari

