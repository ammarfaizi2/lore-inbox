Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTDFOsI (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 10:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbTDFOsI (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 10:48:08 -0400
Received: from franka.aracnet.com ([216.99.193.44]:32235 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262984AbTDFOsF (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 10:48:05 -0400
Date: Sun, 06 Apr 2003 07:59:33 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 544] New: bad: scheduling while atomic! warning on modprobe airo_cs
Message-ID: <76540000.1049641173@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=544

           Summary: bad: scheduling while atomic! warning on modprobe
                    airo_cs
    Kernel Version: 2.5.66
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: gj@pointblue.com.pl


Distribution: Debian woody
Hardware Environment: sony vaio picture book pcg-c1ve
Software Environment: 
gcc-3.2.2
nalesnik:~# cardmgr -V    
cardmgr version 3.2.2
00:0c.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)

Problem Description:
i got this warning:
bad: scheduling while atomic!

Given trace:
 
Apr  6 13:44:42 nalesnik kernel: Call Trace:
Apr  6 13:44:42 nalesnik kernel:  [schedule+1299/1312] schedule+0x513/0x520
Apr  6 13:44:42 nalesnik kernel:  [__getblk+55/112] __getblk+0x37/0x70
Apr  6 13:44:42 nalesnik kernel:  [<c7a91b00>] sendcommand+0xa0/0xe0 [airo]
Apr  6 13:44:42 nalesnik kernel:  [<c7a91a30>] issuecommand+0x60/0x90 [airo]
Apr  6 13:44:42 nalesnik kernel:  [<c7a92008>] PC4500_accessrid+0x48/0x80 [airo]
Apr  6 13:44:42 nalesnik kernel:  [<c7a920b1>] PC4500_readrid+0x71/0x150 [airo]
Apr  6 13:44:42 nalesnik kernel:  [<c7a8f629>] readStatsRid+0x29/0x50 [airo]
Apr  6 13:44:42 nalesnik kernel:  [<c7a8fc49>] airo_get_stats+0x29/0xe0 [airo]
Apr  6 13:44:42 nalesnik kernel:  [rcu_process_callbacks+358/416] rcu_process_ca
llbacks+0x166/0x1a0
Apr  6 13:44:42 nalesnik kernel:  [tasklet_action+119/192] tasklet_action+0x77/0
xc0
Apr  6 13:44:42 nalesnik kernel:  [scheduler_tick+927/944] scheduler_tick+0x39f/
0x3b0
Apr  6 13:44:42 nalesnik kernel:  [rcu_process_callbacks+358/416] rcu_process_ca
llbacks+0x166/0x1a0
Apr  6 13:44:42 nalesnik kernel:  [update_process_times+69/96] update_process_ti
mes+0x45/0x60
Apr  6 13:44:42 nalesnik kernel:  [tasklet_action+119/192] tasklet_action+0x77/0
xc0
Apr  6 13:44:42 nalesnik kernel:  [do_IRQ+309/384] do_IRQ+0x135/0x180
Apr  6 13:44:42 nalesnik kernel:  [common_interrupt+24/32] common_interrupt+0x18
/0x20
Apr  6 13:44:42 nalesnik kernel:  [vsnprintf+532/1136] vsnprintf+0x214/0x470
Apr  6 13:44:42 nalesnik kernel:  [seq_printf+71/96] seq_printf+0x47/0x60
Apr  6 13:44:42 nalesnik kernel:  [dev_seq_printf_stats+235/256] dev_seq_printf_
stats+0xeb/0x100
Apr  6 13:44:42 nalesnik kernel:  [dev_seq_show+28/64] dev_seq_show+0x1c/0x40
Apr  6 13:44:42 nalesnik kernel:  [seq_read+467/768] seq_read+0x1d3/0x300
Apr  6 13:44:42 nalesnik kernel:  [vfs_read+225/480] vfs_read+0xe1/0x1e0
Apr  6 13:44:42 nalesnik kernel:  [sys_read+62/96] sys_read+0x3e/0x60
Apr  6 13:44:42 nalesnik kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

And second one:

Apr  6 13:44:42 nalesnik kernel: bad: scheduling while atomic!
Apr  6 13:44:42 nalesnik kernel: Call Trace:
Apr  6 13:44:42 nalesnik kernel:  [schedule+1299/1312] schedule+0x513/0x520
Apr  6 13:44:42 nalesnik kernel:  [__getblk+55/112] __getblk+0x37/0x70
Apr  6 13:44:42 nalesnik kernel:  [<c7a91b00>] sendcommand+0xa0/0xe0 [airo]
Apr  6 13:44:42 nalesnik kernel:  [<c7a91a30>] issuecommand+0x60/0x90 [airo]
Apr  6 13:44:42 nalesnik kernel:  [<c7a92008>] PC4500_accessrid+0x48/0x80 [airo]
Apr  6 13:44:42 nalesnik kernel:  [<c7a920b1>] PC4500_readrid+0x71/0x150 [airo]
Apr  6 13:44:42 nalesnik kernel:  [get_cnode+27/160] get_cnode+0x1b/0xa0
Apr  6 13:44:42 nalesnik kernel:  [<c7a8f629>] readStatsRid+0x29/0x50 [airo]
Apr  6 13:44:42 nalesnik kernel:  [<c7a8fc49>] airo_get_stats+0x29/0xe0 [airo]
Apr  6 13:44:42 nalesnik kernel:  [check_journal_end+392/688] check_journal_end+
0x188/0x2b0
Apr  6 13:44:42 nalesnik kernel:  [do_journal_end+211/3168] do_journal_end+0xd3/
0xc60
Apr  6 13:44:42 nalesnik kernel:  [update_process_times+69/96] update_process_ti
mes+0x45/0x60
Apr  6 13:44:42 nalesnik kernel:  [do_IRQ+309/384] do_IRQ+0x135/0x180
Apr  6 13:44:42 nalesnik kernel:  [common_interrupt+24/32] common_interrupt+0x18
/0x20
Apr  6 13:44:42 nalesnik kernel:  [vsnprintf+532/1136] vsnprintf+0x214/0x470
Apr  6 13:44:42 nalesnik kernel:  [seq_printf+71/96] seq_printf+0x47/0x60
Apr  6 13:44:42 nalesnik kernel:  [dev_seq_printf_stats+235/256] dev_seq_printf_
stats+0xeb/0x100
Apr  6 13:44:42 nalesnik kernel:  [dev_seq_show+28/64] dev_seq_show+0x1c/0x40
Apr  6 13:44:42 nalesnik kernel:  [seq_read+467/768] seq_read+0x1d3/0x300
Apr  6 13:44:42 nalesnik kernel:  [vfs_read+225/480] vfs_read+0xe1/0x1e0
Apr  6 13:44:42 nalesnik kernel:  [sys_read+62/96] sys_read+0x3e/0x60
Apr  6 13:44:42 nalesnik kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Apr  6 13:44:42 nalesnik kernel: 
:44:42 nalesnik kernel: 


Steps to reproduce:
just insert cisco aironet card and let cardmgr do modprob adding two modules:
airo_cs                 6592  0 
airo                   54568  2 airo_cs
and that is it.
System is stable after, and card is working fine.
But i guess warning is not just for information :-)


