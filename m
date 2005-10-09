Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVJICNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVJICNz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 22:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVJICNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 22:13:55 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:7147 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S932203AbVJICNy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 22:13:54 -0400
Subject: Re: 2.6.14-rc3-rt10 build problem (now rt12)
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org
In-Reply-To: <20051007231126.GA17919@elte.hu>
References: <1128619072.4593.16.camel@cmn3.stanford.edu>
	 <20051007114126.GC857@elte.hu> <1128714933.23974.3.camel@cmn3.stanford.edu>
	 <20051007211654.GA14996@elte.hu>
	 <1128725801.23974.20.camel@cmn3.stanford.edu>
	 <20051007231126.GA17919@elte.hu>
Content-Type: text/plain
Date: Sat, 08 Oct 2005 19:13:35 -0700
Message-Id: <1128824015.5104.6.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-08 at 01:11 +0200, Ingo Molnar wrote: 
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > On Fri, 2005-10-07 at 23:16 +0200, Ingo Molnar wrote:
> > > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > > 
> > > > On Fri, 2005-10-07 at 13:41 +0200, Ingo Molnar wrote:
> > > > > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > > > > 
> > > > > > Maybe not related to rt10, but still can't build it, ".config" 
> > > > > > attached:
> > > > > 
> > > > > ok, i fixed this in -rt11, does it build for you now?
> > > > 
> > > > rt12 bombs here on the smp/i686 compile (smp config attached):
> > > 
> > > ok - i have fixed these and have released -rt13 - does it work for you?
> > 
> > The kernel finally builds but I'm getting these on a depmod -a, will
> > check further:
> > 
> > WARNING: /lib/modules/2.6.13-0.7.rdt.rhfc4.ccrma/kernel/drivers/input/gameport/gameport.ko needs unknown symbol local_irq_restore_nort
> > WARNING: /lib/modules/2.6.13-0.7.rdt.rhfc4.ccrma/kernel/drivers/input/gameport/gameport.ko needs unknown symbol local_irq_save_nort
> 
> should go away if you add this to drivers/input/gameport.c:
> 
> #include <linux/interrupt.h>

Thanks, that got it going. 

The problems I was seeing with Jack are still there but there's more
weird behavior. 

X will blank the screen randomly, sometimes it takes a while till I can
get it back, sometimes it is a blink, sometimes longer, and typing in a
terminal under X will repeat keys (that does not happen in a text
console terminal). This is on Fedora Core 4 with the latest updates
installed. 

This appears to be triggered from Freqtweak (a Jack application):
Oct  8 18:48:00 cmn3 kernel: freqtweak:4705 userspace BUG: scheduling in
user-atomic context!
Oct  8 18:48:00 cmn3 kernel:  [<c037c05b>] schedule+0xeb/0x100 (8)
Oct  8 18:48:00 cmn3 kernel:  [<c037d745>] rwsem_down_read_failed
+0xa5/0x1c0 (28)
Oct  8 18:48:00 cmn3 kernel:  [<c01467ee>] .text.lock.futex+0xa9/0x2db
(52)
Oct  8 18:48:00 cmn3 kernel:  [<c0130c46>] try_to_del_timer_sync
+0x46/0x50 (32)
Oct  8 18:48:00 cmn3 kernel:  [<c0130c71>] del_timer_sync+0x21/0x30 (16)
Oct  8 18:48:00 cmn3 kernel:  [<c0121330>] default_wake_function
+0x0/0x20 (32)
Oct  8 18:48:00 cmn3 kernel:  [<c0151b5c>] audit_syscall_exit+0x4c/0x400
(12)
Oct  8 18:48:00 cmn3 kernel:  [<c0146589>] do_futex+0x69/0xf0 (24)
Oct  8 18:48:00 cmn3 kernel:  [<c0146674>] sys_futex+0x64/0x120 (24)
Oct  8 18:48:00 cmn3 kernel:  [<c0103471>] syscall_call+0x7/0xb (60)

-- Fernando


