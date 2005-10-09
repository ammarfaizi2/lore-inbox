Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVJISjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVJISjF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 14:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVJISjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 14:39:04 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:17833 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S932204AbVJISjD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 14:39:03 -0400
Subject: Re: 2.6.14-rc3-rt10 build problem (now rt12)
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org
In-Reply-To: <20051009043341.GA30878@elte.hu>
References: <1128619072.4593.16.camel@cmn3.stanford.edu>
	 <20051007114126.GC857@elte.hu> <1128714933.23974.3.camel@cmn3.stanford.edu>
	 <20051007211654.GA14996@elte.hu>
	 <1128725801.23974.20.camel@cmn3.stanford.edu>
	 <20051007231126.GA17919@elte.hu>
	 <1128824015.5104.6.camel@cmn3.stanford.edu>
	 <20051009043341.GA30878@elte.hu>
Content-Type: text/plain
Date: Sun, 09 Oct 2005 11:38:44 -0700
Message-Id: <1128883124.12370.13.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-09 at 06:33 +0200, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > This appears to be triggered from Freqtweak (a Jack application):
> > Oct  8 18:48:00 cmn3 kernel: freqtweak:4705 userspace BUG: scheduling in
> > user-atomic context!
> > Oct  8 18:48:00 cmn3 kernel:  [<c037c05b>] schedule+0xeb/0x100 (8)
> > Oct  8 18:48:00 cmn3 kernel:  [<c037d745>] rwsem_down_read_failed
> > +0xa5/0x1c0 (28)
> > Oct  8 18:48:00 cmn3 kernel:  [<c01467ee>] .text.lock.futex+0xa9/0x2db
> > (52)
> > Oct  8 18:48:00 cmn3 kernel:  [<c0130c46>] try_to_del_timer_sync
> > +0x46/0x50 (32)
> > Oct  8 18:48:00 cmn3 kernel:  [<c0130c71>] del_timer_sync+0x21/0x30 (16)
> > Oct  8 18:48:00 cmn3 kernel:  [<c0121330>] default_wake_function
> > +0x0/0x20 (32)
> > Oct  8 18:48:00 cmn3 kernel:  [<c0151b5c>] audit_syscall_exit+0x4c/0x400
> > (12)
> > Oct  8 18:48:00 cmn3 kernel:  [<c0146589>] do_futex+0x69/0xf0 (24)
> > Oct  8 18:48:00 cmn3 kernel:  [<c0146674>] sys_futex+0x64/0x120 (24)
> > Oct  8 18:48:00 cmn3 kernel:  [<c0103471>] syscall_call+0x7/0xb (60)
> 
> could you enable CONFIG_DEBUG_PREEMPT and send me the same assert (which 
> will hopefully include a critical section list too).

I will try to do that tomorrow. 

I forgot to mention, all this is with the SMP kernel running on a dual
core Athlon, PREEMPT_DESKTOP and HZ=1000. 

The symptoms would seem to indicate some basic problem with timing and
what is reported to userspace (ie: wrong warnings about delayed
interrupts in Jack - I hear no audible problems and the time difference
reported by Jack keeps growing no matter what I do, seems to only be
realted to the time the kernel has been up, key repeat on X speeds up,
apparently the screensaver kicks in randomly, etc). 

-- Fernando


