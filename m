Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262335AbSJ2Va5>; Tue, 29 Oct 2002 16:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262346AbSJ2Va5>; Tue, 29 Oct 2002 16:30:57 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:7296 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S262335AbSJ2Va5>;
	Tue, 29 Oct 2002 16:30:57 -0500
Date: Tue, 29 Oct 2002 15:37:19 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: linux-kernel@vger.kernel.org
Subject: poll-related "scheduling while atomic", 2.5.44-mm6
Message-Id: <20021029153719.4ebc4486.arashi@arashi.yi.org>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Debug: sleeping function called from illegal context at mm/slab.c:1304
Call Trace:
 [<c0113f98>] __might_sleep+0x54/0x5c
 [<c012e342>] kmem_flagcheck+0x1e/0x50
 [<c012ec4b>] kmalloc+0x4b/0x114
 [<c014c2cd>] sys_poll+0x91/0x284
 [<c0106eb3>] syscall_call+0x7/0xb

This one comes from calling kmalloc with GFP_KERNEL in sys_poll.

bad: scheduling while atomic!
Call Trace:
 [<c0112ba1>] do_schedule+0x3d/0x2c8
 [<c011d14e>] add_timer+0x36/0x124
 [<c011ddb0>] schedule_timeout+0x84/0xa4
 [<c011dd20>] process_timeout+0x0/0xc
 [<c014c216>] do_poll+0xc2/0xe8
 [<c014c3ca>] sys_poll+0x18e/0x284
 [<c0106eb3>] syscall_call+0x7/0xb

Another little tidbit. I was in X11 while this was happening, and I
happened to stop a process (nautilus) just before I looked in my logs
about this ... and caught a "Notice: process nautilus exited with
preempt_count 2". So my guess is somewhere between -mm5 and -mm6 we
screwed up the atomicity count. (Funny I didn't see that for more
processes, though.)

Matt
