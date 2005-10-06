Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbVJFOg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbVJFOg5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbVJFOg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:36:57 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:33958 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751029AbVJFOg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:36:56 -0400
Subject: Re: 2.6.14-rc3-rt2
From: Lee Revell <rlrevell@joe-job.com>
To: tglx@linutronix.de
Cc: Mark Knecht <markknecht@gmail.com>, Steven Rostedt <rostedt@kihontech.com>,
       Ingo Molnar <mingo@elte.hu>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, david singleton <dsingleton@mvista.com>,
       Todd.Kneisel@bull.com, Felix Oxley <lkml@oxley.org>
In-Reply-To: <1128450029.13057.60.camel@tglx.tec.linutronix.de>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
	 <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
	 <1128450029.13057.60.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 10:31:46 -0400
Message-Id: <1128609107.14584.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-04 at 20:20 +0200, Thomas Gleixner wrote:
> On Tue, 2005-10-04 at 11:11 -0700, Mark Knecht wrote:
> 
> > I have now had one burst of xruns. As best I can tell I was
> > downloading some video files for mplayer to look at, or possibly
> > running one of them. I see this in qjackctl:
> > 
> 
> I guess its related to the priority leak I'm tracking down right now.
> Can you please set following config options and check if you get a bug
> similar to this ?
> 
> BUG: init/1: leaked RT prio 98 (116)?

Sorry if this is old news, but I am getting them with 2.6.13-rt12.
Unlike previous occurrences, it appears that X does *not* end up
SCHED_FIFO.

BUG: Xorg/4094: leaked RT prio 98 (116)?
 [<c0104919>] dump_stack+0x19/0x20 (20)
 [<c01397fe>] up_mutex+0xbe/0x110 (36)
 [<c02c2c29>] _spin_unlock_irqrestore+0x29/0x60 (12)
 [<c011ab24>] __wake_up+0x34/0x60 (44)
 [<c0130248>] __queue_work+0x48/0x60 (24)
 [<c013029f>] queue_work+0x3f/0x70 (24)
 [<c0130b64>] schedule_work+0x14/0x20 (8)
 [<c0225202>] schedule_console_callback+0x12/0x20 (8)
 [<c0225095>] kbd_event+0x45/0xe0 (16)
 [<c02527db>] input_event+0xdb/0x420 (36)
 [<c0223a6e>] kbd_rate+0x4e/0xb0 (40)
 [<c022020a>] vt_ioctl+0x64a/0x1820 (104)
 [<c021ae50>] tty_ioctl+0xc0/0x430 (40)
 [<c017aeab>] do_ioctl+0x6b/0x80 (36)
 [<c017b05f>] vfs_ioctl+0x5f/0x1f0 (40)
 [<c017b24f>] sys_ioctl+0x5f/0x90 (40)
 [<c01032d6>] syscall_call+0x7/0xb (-4020)

Lee

