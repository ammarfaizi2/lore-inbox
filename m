Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264397AbUFGLYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbUFGLYL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 07:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbUFGLYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 07:24:11 -0400
Received: from gepard.lm.pl ([212.244.46.42]:54755 "EHLO gepard.lm.pl")
	by vger.kernel.org with ESMTP id S264397AbUFGLYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:24:06 -0400
Subject: 2.6.7-rc2-mm2 Unkillable process [TRACE]
From: Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: o2.pl Sp z o.o.
Message-Id: <1086603320.10873.16.camel@rakieeta>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 07 Jun 2004 12:15:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I came upon this BUG while testing one of the servers. It shows itself
after about 10 hours of moderate load on both 2.6.7-rc2 and
2.6.7-rc2-mm2 kernels. The process gets stuck in R state, eating 99% of
CPU and is unkillable. The machine won't reboot either. Needs hard
reset. It is usually postfix cleanup/qmgr process. The trace comes from
the 2.6.7-rc2-mm2 kernel. Hope that someone can resolve this.

Jun  7 13:00:37 r9 cleanup       R running     0 27478  29621        
27479 27477 (NOTLB)
Jun  7 13:00:37 r9 cleanup       D 00000001     0 27479  29621        
27480 27478 (NOTLB)
Jun  7 13:00:37 r9 e4307bf8 00000086 f0834ed4 00000001 e103e9ac c018988f
edb8c800 f5596800
Jun  7 13:00:37 r9 c902562c c6dede80 e103e9ac 00000000 e103e900 c0189ed8
c902562c 000012a1
Jun  7 13:00:37 r9 e9720d10 00007ec0 f3ca8b90 f3ca8d40 00000286 f7fb7a84
e4306000 f3ca8b90
Jun  7 13:00:37 r9 Call Trace:
Jun  7 13:00:37 r9 [<c018988f>] ext3_get_inode_loc+0x53/0x21b
Jun  7 13:00:37 r9 [<c0189ed8>] ext3_do_update_inode+0x162/0x357
Jun  7 13:00:37 r9 [<c02da13e>] __down+0x92/0x137
Jun  7 13:00:37 r9 [<c0116319>] default_wake_function+0x0/0xc
Jun  7 13:00:37 r9 [<c02da358>] __down_failed+0x8/0xc
Jun  7 13:00:37 r9 [<c0198af3>] .text.lock.checkpoint+0x5/0x16
Jun  7 13:00:37 r9 [<c0192e4a>] start_this_handle+0x143/0x46d
Jun  7 13:00:37 r9 [<c0193a8a>] do_get_write_access+0x2b5/0x6c9
Jun  7 13:00:37 r9 [<c0113d86>] recalc_task_prio+0x8f/0x183
Jun  7 13:00:37 r9 [<c0193261>] journal_start+0xa1/0xc3
Jun  7 13:00:37 r9 [<c018a3ff>] ext3_dirty_inode+0x2c/0x89
Jun  7 13:00:37 r9 [<c016cf40>] __mark_inode_dirty+0x1d8/0x1dd
Jun  7 13:00:37 r9 [<c0113f04>] activate_task+0x8a/0x99
Jun  7 13:00:37 r9 [<c0113f8d>] resched_task+0x4f/0x7b
Jun  7 13:00:37 r9 [<c0167459>] inode_update_time+0xbb/0xc0
Jun  7 13:00:37 r9 [<c01308ed>]
generic_file_aio_write_nolock+0x26a/0xab0
Jun  7 13:00:37 r9 [<c011635a>] __wake_up_common+0x35/0x55
Jun  7 13:00:37 r9 [<c02d70fc>] unix_stream_recvmsg+0x11a/0x435
Jun  7 13:00:37 r9 [<c0131224>] generic_file_aio_write+0x74/0x9e
Jun  7 13:00:37 r9 [<c0185aaa>] ext3_file_write+0x30/0xae
Jun  7 13:00:37 r9 [<c014deae>] do_sync_write+0x6f/0xa4
Jun  7 13:00:37 r9 [<c01601fa>] sys_select+0x236/0x4c0
Jun  7 13:00:37 r9 [<c014df8c>] vfs_write+0xa9/0xf5
Jun  7 13:00:37 r9 [<c014e069>] sys_write+0x38/0x59
Jun  7 13:00:37 r9 [<c0103e7b>] syscall_call+0x7/0xb

 2.6.7-rc2-mm2 #5 SMP Fri Jun 4 13:58:50 CEST 2004 i686 Intel(R)
Xeon(TM) CPU 3.06GHz GenuineIntel GNU/Linux

TIA,
Krzysztof Sierota

