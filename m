Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVEPMlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVEPMlI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 08:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVEPMlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 08:41:08 -0400
Received: from heisenberg.zen.co.uk ([212.23.3.141]:59872 "EHLO
	heisenberg.zen.co.uk") by vger.kernel.org with ESMTP
	id S261573AbVEPMlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 08:41:03 -0400
Message-Id: <200505161241.j4GCf2ql001963@StraightRunning.com>
From: "Colin Harrison" <colin.harrison@virgin.net>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.6.12-rc4 with realtime-preempt-2.6.12-rc4-V0.7.47-03 patch breaks running mplayer
Date: Mon, 16 May 2005 13:41:07 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Copyright: Copyright (c) 2005 Colin Harrison
X-Domain: StraightRunning.com
X-Admin: colin@straightrunning.com
X-Originating-Heisenberg-IP: [62.3.107.196]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

As an experiment I built a 2.6.12-rc4 kernel with the
realtime-preempt-2.6.12-rc4-V0.7.47-03 patch.
Runs fine until I play mplayer (cvs), then I get the following in
/var/log/messages.

May 16 12:02:00 chamonix kernel: BUG: mplayer/1659, active lock
[d554d49c(d554d480-d554d580)] freed!
May 16 12:02:00 chamonix kernel:  [check_no_locks_freed+323/466]
check_no_locks_freed+0x143/0x1d2 (8)
May 16 12:02:00 chamonix kernel:  [<c012a376>]
check_no_locks_freed+0x143/0x1d2 (8)
May 16 12:02:00 chamonix kernel:  [kfree+86/368] kfree+0x56/0x170 (60)
May 16 12:02:00 chamonix kernel:  [<c013c2ea>] kfree+0x56/0x170 (60)
May 16 12:02:00 chamonix kernel:  [rt_up+204/226] rt_up+0xcc/0xe2 (8)
May 16 12:02:00 chamonix kernel:  [<c012ca50>] rt_up+0xcc/0xe2 (8)
May 16 12:02:00 chamonix kernel:  [pg0+576581227/1069986816]
fusion_entry_destroy+0xd2/0x11e [fusion] (36)
May 16 12:02:00 chamonix kernel:  [<e2971e6b>]
fusion_entry_destroy+0xd2/0x11e [fusion] (36)
May 16 12:02:00 chamonix kernel:  [pg0+576585565/1069986816]
skirmish_ioctl+0x39/0xde [fusion] (36)
May 16 12:02:00 chamonix kernel:  [<e2972f5d>] skirmish_ioctl+0x39/0xde
[fusion] (36)
May 16 12:02:00 chamonix kernel:  [do_ioctl+101/150] do_ioctl+0x65/0x96 (16)
May 16 12:02:00 chamonix kernel:  [<c0161c3d>] do_ioctl+0x65/0x96 (16)
May 16 12:02:00 chamonix kernel:  [vfs_ioctl+104/474] vfs_ioctl+0x68/0x1da
(28)
May 16 12:02:00 chamonix kernel:  [<c0161df7>] vfs_ioctl+0x68/0x1da (28)
May 16 12:02:00 chamonix kernel:  [fget_light+131/133] fget_light+0x83/0x85
(8)
May 16 12:02:00 chamonix kernel:  [<c0151603>] fget_light+0x83/0x85 (8)
May 16 12:02:00 chamonix kernel:  [sys_ioctl+61/99] sys_ioctl+0x3d/0x63 (20)
May 16 12:02:00 chamonix kernel:  [<c0161fa6>] sys_ioctl+0x3d/0x63 (20)
May 16 12:02:00 chamonix kernel:  [sysenter_past_esp+84/117]
sysenter_past_esp+0x54/0x75 (24)
May 16 12:02:00 chamonix kernel:  [<c0102743>] sysenter_past_esp+0x54/0x75
(24)
May 16 12:02:00 chamonix kernel:  [d554d49c] {(struct semaphore
*)(&entry->lock)}
May 16 12:02:00 chamonix kernel: .. held by:           mplayer: 1659
[d6bccd90, 101]
May 16 12:02:00 chamonix kernel: ... acquired at:
fusion_entry_destroy+0x95/0x11e [fusion]
May 16 12:02:00 chamonix kernel: slab size-256[c14d3680] (256), obj:
d554d480
May 16 12:02:00 chamonix kernel: `IRQ 8'[12] is being piggy. need_resched=0,
cpu=0
May 16 12:02:00 chamonix kernel: Read missed before next interrupt
May 16 12:02:00 chamonix kernel: wow!  That was a 23 millisec bump
May 16 12:02:00 chamonix kernel: bug in rtc_read(): called in state S_IDLE!
May 16 12:02:00 chamonix kernel: `IRQ 8'[12] is being piggy. need_resched=0,
cpu=0
May 16 12:02:00 chamonix kernel: Read missed before next interrupt
May 16 12:02:01 chamonix kernel: wow!  That was a 20 millisec bump
etc with last 'piggy?' messages repeating.

More information/testing can be supplied/performed, if anyone is interested?
Perhaps this is more an mplayer or fusion problem, and I'm reporting on the
wrong list!
I am experimenting with mplayer, matroxfb, freevo and fusion, compiling the
2.6.12-rc4 kernel CONFIG_PREEMPT=y. This combination usually runs reliably
and gives spectacularly beautiful results.

Thanks
Colin Harrison

