Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268293AbUJDAxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268293AbUJDAxG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 20:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268294AbUJDAxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 20:53:06 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:56756 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268293AbUJDAxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 20:53:02 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20041003195725.GA31882@elte.hu>
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>
	 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>
	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>
	 <20040928000516.GA3096@elte.hu> <1096785457.1837.0.camel@krustophenia.net>
	 <1096786248.1837.4.camel@krustophenia.net>
	 <1096787179.1837.8.camel@krustophenia.net> <20041003195725.GA31882@elte.hu>
Content-Type: text/plain
Message-Id: <1096851180.16648.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 03 Oct 2004 20:53:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-03 at 15:57, Ingo Molnar wrote:
> do you still have the stacktrace too that went to the syslog? What
> codepath called _mmx_memcpy()?
> 

Here is an almost identical one (it's even exactly 507 usecs!).  This
and the one I sent previously were apparently caused by switching from X
to a text console and back. 

Sep  2 16:13:49 krustophenia kernel: (events/0/3): new 507 us maximum-latency critical section.
Sep  2 16:13:49 krustophenia kernel:  => started at: <kernel_fpu_begin+0x15/0x70>
Sep  2 16:13:49 krustophenia kernel:  => ended at:   <_mmx_memcpy+0x13a/0x180>
Sep  2 16:13:49 krustophenia kernel:  [check_preempt_timing+259/464] check_preempt_timing+0x103/0x1d0
Sep  2 16:13:49 krustophenia kernel:  [_mmx_memcpy+314/384] _mmx_memcpy+0x13a/0x180
Sep  2 16:13:49 krustophenia kernel:  [sub_preempt_count+70/96] sub_preempt_count+0x46/0x60
Sep  2 16:13:49 krustophenia kernel:  [sub_preempt_count+70/96] sub_preempt_count+0x46/0x60
Sep  2 16:13:49 krustophenia kernel:  [_mmx_memcpy+314/384] _mmx_memcpy+0x13a/0x180
Sep  2 16:13:49 krustophenia kernel:  [vgacon_save_screen+120/128] vgacon_save_screen+0x78/0x80
Sep  2 16:13:49 krustophenia kernel:  [redraw_screen+411/560] redraw_screen+0x19b/0x230
Sep  2 16:13:49 krustophenia kernel:  [complete_change_console+44/224] complete_change_console+0x2c/0xe0
Sep  2 16:13:49 krustophenia kernel:  [console_callback+258/272] console_callback+0x102/0x110
Sep  2 16:13:49 krustophenia kernel:  [worker_thread+422/624] worker_thread+0x1a6/0x270
Sep  2 16:13:49 krustophenia kernel:  [console_callback+0/272] console_callback+0x0/0x110
Sep  2 16:13:49 krustophenia kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Sep  2 16:13:49 krustophenia kernel:  [schedule+718/1360] schedule+0x2ce/0x550
Sep  2 16:13:49 krustophenia kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Sep  2 16:13:49 krustophenia kernel:  [schedule+718/1360] schedule+0x2ce/0x550
Sep  2 16:13:49 krustophenia kernel:  [kthread+180/192] kthread+0xb4/0xc0
Sep  2 16:13:49 krustophenia kernel:  [worker_thread+0/624] worker_thread+0x0/0x270
Sep  2 16:13:49 krustophenia kernel:  [kthread+0/192] kthread+0x0/0xc0
Sep  2 16:13:49 krustophenia kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10

Lee

