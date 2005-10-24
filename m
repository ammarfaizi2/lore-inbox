Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVJXVCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVJXVCB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 17:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVJXVCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 17:02:01 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:58243 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751293AbVJXVB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 17:01:59 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Mark Knecht <markknecht@gmail.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU, William Weston <weston@lysdexia.org>
In-Reply-To: <1130186359.21118.2.camel@localhost.localdomain>
References: <1129599029.10429.1.camel@cmn3.stanford.edu>
	 <20051018072844.GB21915@elte.hu>
	 <1129669474.5929.8.camel@cmn3.stanford.edu>
	 <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org>
	 <20051019111943.GA31410@elte.hu>
	 <1129835571.14374.11.camel@cmn3.stanford.edu>
	 <20051020191620.GA21367@elte.hu>
	 <1129852531.5227.4.camel@cmn3.stanford.edu> <20051021080504.GA5088@elte.hu>
	 <1129937138.5001.4.camel@cmn3.stanford.edu>
	 <20051022035851.GC12751@elte.hu>
	 <1130182121.4983.7.camel@cmn3.stanford.edu>
	 <1130182717.4637.2.camel@cmn3.stanford.edu>
	 <1130186359.21118.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 17:00:56 -0400
Message-Id: <1130187657.23853.36.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 16:39 -0400, Steven Rostedt wrote:
> > And this when starting Hydrogen for the first time (the next startup is
> > fine):
> > 
> > hydrogen:4610 userspace BUG: scheduling in user-atomic context!
> >  [<c034fd9a>] schedule+0xea/0x100 (8)
> >  [<c034ff74>] wait_for_completion+0xa4/0xe0 (28)
> >  [<c011c150>] default_wake_function+0x0/0x20 (12)
> >  [<c0177951>] coredump_wait+0xa1/0x100 (28)
> >  [<c01ec60c>] copy_from_user+0x4c/0xc0 (8)
> >  [<c0177aaa>] do_coredump+0xfa/0x270 (108)
> >  [<c015456d>] kmem_cache_free+0x4d/0xb0 (40)
> >  [<c012aab5>] __dequeue_signal+0xf5/0x1c0 (24)
> >  [<c012aba3>] dequeue_signal+0x23/0xe0 (32)
> >  [<c012ca58>] get_signal_to_deliver+0x298/0x310 (20)
> >                [<c0351ee0>] do_page_fault+0x0/0x590 (24)
> >  [<c0102f80>] do_signal+0x70/0x180 (8)
> >  [<c014f495>] free_pages_bulk+0x225/0x2a0 (28)
> >  [<c0129493>] try_to_del_timer_sync+0x43/0x50 (12)
> >  [<c0147735>] audit_filter_syscall+0x45/0xe0 (4)
> >  [<c014834b>] audit_syscall_exit+0x4b/0x400 (36)
> >  [<c035219d>] do_page_fault+0x2bd/0x590 (40)
> >  [<c0351ee0>] do_page_fault+0x0/0x590 (48)
> >  [<c01030b5>] do_notify_resume+0x25/0x34 (8)
> >  [<c0103294>] work_notifysig+0x13/0x1b (8)
> > 
> > No other BUG messages that I can see.
> > -- Fernando
> 
> This part is new, I'll take a look into this.

Hydrogen segfaulted in the RT thread, and it was decided a while back
that an RT thread should lose RT priority when it coredumps - previously
we were seeing long latencies if the highest priority thread caught a
sig 11.  So this looks like a false positive in the userspace atomicity
debugger.

Lee

