Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVAHQAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVAHQAi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 11:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVAHQAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 11:00:38 -0500
Received: from w240.dkm.cz ([62.24.88.240]:6154 "EHLO mail.spitalnik.net")
	by vger.kernel.org with ESMTP id S261198AbVAHQAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 11:00:30 -0500
From: Jan Spitalnik <lkml@spitalnik.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: oops in fib_get_next()
Date: Sat, 8 Jan 2005 17:00:24 +0100
User-Agent: KMail/1.7.91
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501081700.24616.lkml@spitalnik.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm getting an oops in fib_get_next(). I've tried 2.6.10-rc2, 2.6.10 
and 2.6.10-bk snapshot from today and they both exhibit this behviour. 
The oops below is from 2.6.10-bk. I'm not sure what in gkrellmd triggers
this oops. Usually it happens after 1-2 days of running of the system.

Thanks,
		jan

Jan  8 08:01:06 bratrk kernel: Unable to handle kernel paging request at virtual address 00100100
Jan  8 08:01:06 bratrk kernel:  printing eip:
Jan  8 08:01:06 bratrk kernel: c026b1cf
Jan  8 08:01:06 bratrk kernel: *pde = 00000000
Jan  8 08:01:06 bratrk kernel: Oops: 0000 [#1]
Jan  8 08:01:06 bratrk kernel: Modules linked in: cls_fw sch_ingress ipt_length ipt_tos sch_sfq sch_htb ipt_CLASSIFY ipt_mark ipt_CONNMARK iptable_mangle ipt_MARK ipt_REJECT ipt_LOG ipt_limit ipt_mac iptable_filter dummy hostap_pci hostap e100 mii 3c59x ip_nat_irc ip_conntrack_irc ip_nat_ftp iptable_nat ip_tables ip_conntrack_ftp ip_conntrack
Jan  8 08:01:06 bratrk kernel: CPU:    0
Jan  8 08:01:06 bratrk kernel: EIP:    0060:[fib_get_next+31/304]    Not tainted VLI
Jan  8 08:01:06 bratrk kernel: EFLAGS: 00010282   (2.6.10) 
Jan  8 08:01:06 bratrk kernel: EIP is at fib_get_next+0x1f/0x130
Jan  8 08:01:06 bratrk kernel: eax: c6f55360   ebx: 00100100   ecx: 00000001   edx: c75878e0
Jan  8 08:01:06 bratrk kernel: esi: c6e18160   edi: c73d7fac   ebp: 00000400   esp: c73d7f1c
Jan  8 08:01:06 bratrk kernel: ds: 007b   es: 007b   ss: 0068
Jan  8 08:01:06 bratrk kernel: Process gkrellmd (pid: 2522, threadinfo=c73d6000 task=c776c020)
Jan  8 08:01:06 bratrk kernel: Stack: 00000028 c6f55360 c73d7fac 00000400 c026b31d c6f55360 00000000 c016704e 
Jan  8 08:01:06 bratrk kernel:        c6f55360 c73d7f54 c46a1810 00000000 c73d7f74 c01107b8 00000028 00000000 
Jan  8 08:01:06 bratrk kernel:        00000000 c6ae0380 c73d7fac 00000400 c0149418 c6ae0380 b7e0f000 00000400 
Jan  8 08:01:06 bratrk kernel: Call Trace:
Jan  8 08:01:06 bratrk kernel:  [fib_seq_start+61/80] fib_seq_start+0x3d/0x50
Jan  8 08:01:06 bratrk kernel:  [seq_read+174/672] seq_read+0xae/0x2a0
Jan  8 08:01:06 bratrk kernel:  [recalc_task_prio+168/416] recalc_task_prio+0xa8/0x1a0
Jan  8 08:01:06 bratrk kernel:  [vfs_read+200/368] vfs_read+0xc8/0x170
Jan  8 08:01:06 bratrk kernel:  [sys_read+81/128] sys_read+0x51/0x80
Jan  8 08:01:06 bratrk kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan  8 08:01:06 bratrk kernel: Code: 4e 0c 89 5e 10 eb 85 90 8d 74 26 00 55 57 56 53 8b 44 24 14 8b 70 2c 8b 5e 10 8b 56 0c 85 db 74 21 85 d2 0f 84 fe 00 00 00 8b 1b <8b> 03 8d 74 26 00 8d 42 08 39 c3 74 0a 89 5e 10 89 d8 5b 5e 5f 
-- 
Jan Spitalnik
jan@spitalnik.net

Pain makes you beautiful.
