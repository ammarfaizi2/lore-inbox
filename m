Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268334AbUJDRUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268334AbUJDRUo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 13:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268335AbUJDRUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 13:20:44 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:18605 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268334AbUJDRUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 13:20:39 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20041004101711.GA21029@elte.hu>
References: <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>
	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>
	 <20040928000516.GA3096@elte.hu> <1096785457.1837.0.camel@krustophenia.net>
	 <1096786248.1837.4.camel@krustophenia.net>
	 <1096787179.1837.8.camel@krustophenia.net> <20041003195725.GA31882@elte.hu>
	 <1096851180.16648.2.camel@krustophenia.net>
	 <20041004101711.GA21029@elte.hu>
Content-Type: text/plain
Message-Id: <1096910438.16648.15.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 04 Oct 2004 13:20:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-04 at 06:17, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Here is an almost identical one (it's even exactly 507 usecs!).  This
> > and the one I sent previously were apparently caused by switching from
> > X to a text console and back. 
> 
> ah, it's the VGA console:
> 
> > Sep  2 16:13:49 krustophenia kernel:  [_mmx_memcpy+314/384] _mmx_memcpy+0x13a/0x180
> > Sep  2 16:13:49 krustophenia kernel:  [vgacon_save_screen+120/128] vgacon_save_screen+0x78/0x80
> > Sep  2 16:13:49 krustophenia kernel:  [redraw_screen+411/560] redraw_screen+0x19b/0x230
> 
> now i'm wondering why that's running with preemption disabled - i
> thought we fixed that.
> 

Same here.  But, here's the actual trace from S7 (that one was Q
something).  It is indeed the VGA console.

Oct  3 02:58:08 krustophenia kernel: (events/0/3): new 507 us maximum-latency critical section.
Oct  3 02:58:08 krustophenia kernel:  => started at: <kernel_fpu_begin+0x15/0x70>
Oct  3 02:58:08 krustophenia kernel:  => ended at:   <_mmx_memcpy+0x13a/0x180>
Oct  3 02:58:08 krustophenia kernel:  [check_preempt_timing+330/480] check_preempt_timing+0x14a/0x1e0
Oct  3 02:58:08 krustophenia kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Oct  3 02:58:08 krustophenia kernel:  [sub_preempt_count+74/112] sub_preempt_count+0x4a/0x70
Oct  3 02:58:08 krustophenia kernel:  [_mmx_memcpy+314/384] _mmx_memcpy+0x13a/0x180
Oct  3 02:58:08 krustophenia kernel:  [_mmx_memcpy+314/384] _mmx_memcpy+0x13a/0x180
Oct  3 02:58:08 krustophenia kernel:  [vgacon_save_screen+120/128] vgacon_save_screen+0x78/0x80
Oct  3 02:58:08 krustophenia kernel:  [redraw_screen+411/560] redraw_screen+0x19b/0x230
Oct  3 02:58:08 krustophenia kernel:  [complete_change_console+44/224] complete_change_console+0x2c/0xe0
Oct  3 02:58:08 krustophenia kernel:  [console_callback+258/272] console_callback+0x102/0x110
Oct  3 02:58:08 krustophenia kernel:  [worker_thread+559/1088] worker_thread+0x22f/0x440
Oct  3 02:58:08 krustophenia kernel:  [console_callback+0/272] console_callback+0x0/0x110
Oct  3 02:58:08 krustophenia kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Oct  3 02:58:08 krustophenia kernel:  [schedule+829/1712] schedule+0x33d/0x6b0
Oct  3 02:58:08 krustophenia kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Oct  3 02:58:08 krustophenia kernel:  [mcount+20/24] mcount+0x14/0x18
Oct  3 02:58:08 krustophenia kernel:  [kthread+180/192] kthread+0xb4/0xc0
Oct  3 02:58:08 krustophenia kernel:  [worker_thread+0/1088] worker_thread+0x0/0x440
Oct  3 02:58:08 krustophenia kernel:  [kthread+0/192] kthread+0x0/0xc0
Oct  3 02:58:08 krustophenia kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10

Lee

