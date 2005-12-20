Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVLTOjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVLTOjf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 09:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVLTOjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 09:39:35 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:61830 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751087AbVLTOje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 09:39:34 -0500
Date: Tue, 20 Dec 2005 15:38:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
       Daniel Walker <dwalker@mvista.com>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [PATCH rc5-rt2 0/3] plist: alternative implementation
Message-ID: <20051220143848.GA2053@elte.hu>
References: <43A5A7B5.21A4CAAE@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A5A7B5.21A4CAAE@tv-sign.ru>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> Rediff against patch-2.6.15-rc5-rt2.
> 
> Nothing was changed except s/plist_next_entry/plist_first_entry/ to 
> match the current naming.

thanks Oleg, your patches look good to me, and it's a worthwile cleanup 
to make plist.h ops behave more like normal list.h ops. The new ops 
should be documented, but otherwise it looks OK.

(the resulting kernel doesnt build in PREEMPT_RT mode though, it's 
lib/plist.c not being converted yet?)

> These patches were only compile tested. This is beacuse I can't even 
> compile 2.6.15-rc5-rt2, I had to comment out this line
> 
> 	lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
> 
> in lib/Makefile. I think CONFIG_RWSEM_GENERIC_SPINLOCK means that 
> lib/rwsem.c should be ignored.
> 
> After that the kernel panics at boot time, the call trace shows
> 
> 	set_workqueue_thread_prio
> 	wake_up_process
> 	set_workqueue_prio
> 	init_workqueues
> 
> will try to look further on Tuesday.
> 
> Just to make it clear, these problems were _without_ these patches.

please try the -rt3 kernel, does it work any better?

	Ingo
