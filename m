Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263641AbUJ3BXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbUJ3BXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263649AbUJ3BTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 21:19:20 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:8917 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263608AbUJ3BPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 21:15:38 -0400
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20041029212545.GA13199@elte.hu>
References: <20041029163155.GA9005@elte.hu>
	 <20041029191652.1e480e2d@mango.fruits.de> <20041029170237.GA12374@elte.hu>
	 <20041029170948.GA13727@elte.hu> <20041029193303.7d3990b4@mango.fruits.de>
	 <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu>
	 <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu>
	 <20041029233117.6d29c383@mango.fruits.de>  <20041029212545.GA13199@elte.hu>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 21:15:36 -0400
Message-Id: <1099098937.1482.6.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 23:25 +0200, Ingo Molnar wrote:
> this particular one (atomicity-checking) is always-enabled if you have
> the -RT patch applied (it's a really cheap check).

I get these as well.  Basically I think these are the exact same results
Florian had.

jackd:1646 userspace BUG: scheduling in user-atomic context!
 [<c02733eb>] schedule+0x6b/0xf0 (8)
 [<c027431d>] _down_write+0xcd/0x130 (24)
 [<c0111e1e>] lock_kernel+0x1e/0x30 (32)
 [<c01e7ad9>] tty_write+0x189/0x240 (16)
 [<c01ecf20>] write_chan+0x0/0x210 (28)
 [<c014ea4a>] vfs_write+0xba/0x100 (32)
 [<c014eb3d>] sys_write+0x3d/0x70 (36)
 [<c0105d07>] syscall_call+0x7/0xb (40)
jackd:1646 userspace BUG: scheduling in user-atomic context!
 [<c02733eb>] schedule+0x6b/0xf0 (8)
 [<c027431d>] _down_write+0xcd/0x130 (24)
 [<c0111e1e>] lock_kernel+0x1e/0x30 (32)
 [<c01e7ad9>] tty_write+0x189/0x240 (16)
 [<c01ecf20>] write_chan+0x0/0x210 (28)
 [<c014ea4a>] vfs_write+0xba/0x100 (32)
 [<c014eb3d>] sys_write+0x3d/0x70 (36)
 [<c0105d07>] syscall_call+0x7/0xb (40)

A known issue with JACK is that it prints from the realtime thread.  I
think someone might have posted a fix for this recently.

Lee

