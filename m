Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267438AbUI0XMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUI0XMp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 19:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267445AbUI0XMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 19:12:45 -0400
Received: from smtp08.auna.com ([62.81.186.18]:11745 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S267438AbUI0XMe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 19:12:34 -0400
Date: Mon, 27 Sep 2004 23:12:33 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Stack traces in 2.6.9-rc2-mm4
To: linux-kernel@vger.kernel.org
References: <6.1.2.0.2.20040927184123.019b48b8@tornado.reub.net>
	<20040927085744.GA32407@elte.hu>
In-Reply-To: <20040927085744.GA32407@elte.hu> (from mingo@elte.hu on Mon Sep
	27 10:57:44 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1096326753l.5222l.2l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.09.27, Ingo Molnar wrote:
> 
> * Reuben Farrelly <reuben-lkml@reub.net> wrote:
> 
> > Since upgrading from -mm3 to -mm4, I'm now getting messages like this 
> > logged every second or so:
> > 
> > Sep 27 18:28:06 tornado kernel: using smp_processor_id() in preemptible code: swapper/1
> > Sep 27 18:28:06 tornado kernel:  [<c0104dce>] dump_stack+0x17/0x19
> > Sep 27 18:28:06 tornado kernel:  [<c0117fc6>] smp_processor_id+0x80/0x86
> > Sep 27 18:28:06 tornado kernel:  [<c0282bf3>] make_request+0x174/0x2e7
> > Sep 27 18:28:06 tornado kernel:  [<c02073dd>] generic_make_request+0xda/0x190
> 
> this is the remove-bkl patch's debugging feature showing that there's
> more preempt-unsafe disk statistics code in the RAID code.
> 
> i've attached a patch that introduces preempt and non-preempt versions
> of the statistics code and updates the block code to use the appropriate
> ones - does this fix all the smp_processor_id() warnings you get?
> 

I got the same on another place...

Sep 28 00:48:51 werewolf xinetd[4228]: Reading included configuration file: /etc/xinetd.d/sshd-xinetd [file=/etc/xinetd.d/sshd-xinetd] [line=12]
Sep 28 00:48:51 werewolf kernel: using smp_processor_id() in preemptible code: X/4012
Sep 28 00:48:51 werewolf kernel:  [smp_processor_id+135/141] smp_processor_id+0x87/0x8d
Sep 28 00:48:51 werewolf kernel:  [add_timer_randomness+314/365] add_timer_randomness+0x13a/0x16d
Sep 28 00:48:51 werewolf kernel:  [<b0206733>] add_timer_randomness+0x13a/0x16d
Sep 28 00:48:51 werewolf kernel:  [input_event+85/999] input_event+0x55/0x3e7
Sep 28 00:48:51 werewolf kernel:  [<b027fff1>] input_event+0x55/0x3e7
Sep 28 00:48:51 werewolf kernel:  [kbd_rate+69/129] kbd_rate+0x45/0x81
Sep 28 00:48:51 werewolf kernel:  [<b0213258>] kbd_rate+0x45/0x81
Sep 28 00:48:51 werewolf kernel:  [vt_ioctl+1629/7101] vt_ioctl+0x65d/0x1bbd
Sep 28 00:48:51 werewolf kernel:  [<b020fb81>] vt_ioctl+0x65d/0x1bbd
Sep 28 00:48:51 werewolf kernel:  [handle_mm_fault+333/437] handle_mm_fault+0x14d/0x1b5
Sep 28 00:48:51 werewolf kernel:  [<b0149579>] handle_mm_fault+0x14d/0x1b5
Sep 28 00:48:51 werewolf kernel:  [do_page_fault+477/1427] do_page_fault+0x1dd/0x593
Sep 28 00:48:51 werewolf xinetd[4228]: Reading included configuration file: /etc/xinetd.d/talk [file=/etc/xinetd.d/talk] [line=16]
Sep 28 00:48:52 werewolf kernel:  [<b0117479>] do_page_fault+0x1dd/0x593
Sep 28 00:48:52 werewolf kernel:  [destroy_inode+53/55] destroy_inode+0x35/0x37
Sep 28 00:48:52 werewolf kernel:  [<b016d407>] destroy_inode+0x35/0x37
Sep 28 00:48:52 werewolf kernel:  [tty_ioctl+1224/1256] tty_ioctl+0x4c8/0x4e8
Sep 28 00:48:52 werewolf kernel:  [<b020adda>] tty_ioctl+0x4c8/0x4e8
Sep 28 00:48:52 werewolf kernel:  [sys_ioctl+489/581] sys_ioctl+0x1e9/0x245
Sep 28 00:48:52 werewolf kernel:  [<b0167410>] sys_ioctl+0x1e9/0x245
Sep 28 00:48:52 werewolf kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Sep 28 00:48:52 werewolf kernel:  [<b0103fd1>] sysenter_past_esp+0x52/0x71
Sep 28 00:48:52 werewolf kernel: using smp_processor_id() in preemptible code: X/4012
Sep 28 00:48:52 werewolf kernel:  [smp_processor_id+135/141] smp_processor_id+0x87/0x8d
Sep 28 00:48:52 werewolf kernel:  [<b011bc8f>] smp_processor_id+0x87/0x8d
Sep 28 00:48:52 werewolf kernel:  [add_timer_randomness+314/365] add_timer_randomness+0x13a/0x16d
Sep 28 00:48:52 werewolf kernel:  [<b0206733>] add_timer_randomness+0x13a/0x16d
Sep 28 00:48:52 werewolf kernel:  [input_event+85/999] input_event+0x55/0x3e7
Sep 28 00:48:52 werewolf kernel:  [<b027fff1>] input_event+0x55/0x3e7
Sep 28 00:48:52 werewolf kernel:  [kbd_rate+96/129] kbd_rate+0x60/0x81
Sep 28 00:48:52 werewolf kernel:  [<b0213273>] kbd_rate+0x60/0x81
Sep 28 00:48:52 werewolf kernel:  [vt_ioctl+1629/7101] vt_ioctl+0x65d/0x1bbd
Sep 28 00:48:52 werewolf kernel:  [<b020fb81>] vt_ioctl+0x65d/0x1bbd
Sep 28 00:48:52 werewolf kernel:  [handle_mm_fault+333/437] handle_mm_fault+0x14d/0x1b5
Sep 28 00:48:52 werewolf kernel:  [<b0149579>] handle_mm_fault+0x14d/0x1b5
Sep 28 00:48:52 werewolf kernel:  [do_page_fault+477/1427] do_page_fault+0x1dd/0x593
Sep 28 00:48:52 werewolf kernel:  [<b0117479>] do_page_fault+0x1dd/0x593
Sep 28 00:48:52 werewolf kernel:  [destroy_inode+53/55] destroy_inode+0x35/0x37
Sep 28 00:48:52 werewolf kernel:  [<b016d407>] destroy_inode+0x35/0x37
Sep 28 00:48:52 werewolf kernel:  [tty_ioctl+1224/1256] tty_ioctl+0x4c8/0x4e8
Sep 28 00:48:52 werewolf kernel:  [<b020adda>] tty_ioctl+0x4c8/0x4e8
Sep 28 00:48:52 werewolf kernel:  [sys_ioctl+489/581] sys_ioctl+0x1e9/0x245
Sep 28 00:48:52 werewolf kernel:  [<b0167410>] sys_ioctl+0x1e9/0x245
Sep 28 00:48:52 werewolf kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Sep 28 00:48:52 werewolf kernel:  [<b0103fd1>] sysenter_past_esp+0x52/0x71
Sep 28 00:48:52 werewolf xinetd[4228]: Reading included configuration file: /etc/xinetd.d/tftp [file=/etc/xinetd.d/tftp] [line=12]
....

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc2-mm4 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #2


