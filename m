Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264911AbUGZDvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbUGZDvm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 23:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbUGZDvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 23:51:42 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:55230 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264911AbUGZDvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 23:51:37 -0400
Subject: preempt timing violations
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu
Content-Type: text/plain
Message-Id: <1090813907.6936.56.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 25 Jul 2004 23:51:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Latency with 2.6.8-rc2 + voluntary-preempt-I4 is the best so far.  After
extended testing there only seem to be a few hot spots.  In several
minutes I saw an 11ms violation, a 14ms violation, and several 2ms
violations.

get_user_pages() is much better in 2.6.8-rc1-mm1 than 2.6.8-rc2.  Is
there any chance of getting the fix into mainline?

In each of these case you can see a preempt timing violation followed by
an XRUN trace.

Jul 25 23:09:27 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D2c
Jul 25 23:09:27 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 25 23:09:27 mindpipe kernel:  [__crc_totalram_pages+1165/3197748] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 25 23:09:27 mindpipe kernel:  [__crc_totalram_pages+65879/3197748] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 25 23:09:27 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 25 23:09:27 mindpipe kernel:  [do_IRQ+167/368] do_IRQ+0xa7/0x170
Jul 25 23:09:27 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 25 23:09:27 mindpipe kernel:  [unix_stream_recvmsg+505/1056] unix_stream_recvmsg+0x1f9/0x420
Jul 25 23:09:27 mindpipe kernel:  [sock_aio_read+221/256] sock_aio_read+0xdd/0x100
Jul 25 23:09:27 mindpipe kernel:  [do_sync_read+106/160] do_sync_read+0x6a/0xa0
Jul 25 23:09:27 mindpipe kernel:  [vfs_read+227/272] vfs_read+0xe3/0x110
Jul 25 23:09:27 mindpipe kernel:  [sys_read+46/80] sys_read+0x2e/0x50
Jul 25 23:09:27 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 25 23:09:27 mindpipe kernel: 2ms non-preemptible critical section violated 1 ms preempt threshold starting at unmap_vmas+0x1ff/0x210 and ending at unmap_vmas+0x1f5/0x210
Jul 25 23:09:27 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 25 23:09:27 mindpipe kernel:  [dec_preempt_count+270/288] dec_preempt_count+0x10e/0x120
Jul 25 23:09:27 mindpipe kernel:  [unmap_vmas+501/528] unmap_vmas+0x1f5/0x210
Jul 25 23:09:27 mindpipe kernel:  [exit_mmap+94/336] exit_mmap+0x5e/0x150
Jul 25 23:09:27 mindpipe kernel:  [mmput+114/160] mmput+0x72/0xa0
Jul 25 23:09:27 mindpipe kernel:  [do_exit+251/1072] do_exit+0xfb/0x430
Jul 25 23:09:27 mindpipe kernel:  [do_group_exit+50/192] do_group_exit+0x32/0xc0
Jul 25 23:09:27 mindpipe kernel:  [get_signal_to_deliver+605/880] get_signal_to_deliver+0x25d/0x370
Jul 25 23:09:27 mindpipe kernel:  [do_signal+86/208] do_signal+0x56/0xd0
Jul 25 23:09:27 mindpipe kernel:  [do_notify_resume+71/80] do_notify_resume+0x47/0x50
Jul 25 23:09:27 mindpipe kernel:  [work_notifysig+19/21] work_notifysig+0x13/0x15
Jul 25 23:09:27 mindpipe kernel: 2ms non-preemptible critical section violated 1 ms preempt threshold starting at unmap_vmas+0x1ff/0x210 and ending at unmap_vmas+0x1f5/0x210
Jul 25 23:09:27 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 25 23:09:27 mindpipe kernel:  [dec_preempt_count+270/288] dec_preempt_count+0x10e/0x120
Jul 25 23:09:27 mindpipe kernel:  [unmap_vmas+501/528] unmap_vmas+0x1f5/0x210
Jul 25 23:09:27 mindpipe kernel:  [exit_mmap+94/336] exit_mmap+0x5e/0x150
Jul 25 23:09:27 mindpipe kernel:  [mmput+114/160] mmput+0x72/0xa0
Jul 25 23:09:27 mindpipe kernel:  [do_exit+251/1072] do_exit+0xfb/0x430
Jul 25 23:09:27 mindpipe kernel:  [do_group_exit+50/192] do_group_exit+0x32/0xc0
Jul 25 23:09:27 mindpipe kernel:  [get_signal_to_deliver+605/880] get_signal_to_deliver+0x25d/0x370
Jul 25 23:09:27 mindpipe kernel:  [do_signal+86/208] do_signal+0x56/0xd0
Jul 25 23:09:27 mindpipe kernel:  [work_notifysig+19/21] work_notifysig+0x13/0x15
Jul 25 23:09:27 mindpipe kernel: 2ms non-preemptible critical section violated 1 ms preempt threshold starting at unmap_vmas+0x1ff/0x210 and ending at unmap_vmas+0x1f5/0x210
Jul 25 23:09:27 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 25 23:09:27 mindpipe kernel:  [dec_preempt_count+270/288] dec_preempt_count+0x10e/0x120
Jul 25 23:09:27 mindpipe kernel:  [unmap_vmas+501/528] unmap_vmas+0x1f5/0x210
Jul 25 23:09:27 mindpipe kernel:  [exit_mmap+94/336] exit_mmap+0x5e/0x150
Jul 25 23:09:27 mindpipe kernel:  [mmput+114/160] mmput+0x72/0xa0
Jul 25 23:09:27 mindpipe kernel:  [do_exit+251/1072] do_exit+0xfb/0x430
Jul 25 23:09:27 mindpipe kernel:  [do_group_exit+50/192] do_group_exit+0x32/0xc0
Jul 25 23:09:27 mindpipe kernel:  [get_signal_to_deliver+605/880] get_signal_to_deliver+0x25d/0x370
Jul 25 23:09:27 mindpipe kernel:  [do_signal+86/208] do_signal+0x56/0xd0
Jul 25 23:09:27 mindpipe kernel:  [do_notify_resume+71/80] do_notify_resume+0x47/0x50
Jul 25 23:09:27 mindpipe kernel:  [work_notifysig+19/21] work_notifysig+0x13/0x15
Jul 25 23:09:31 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D2c
Jul 25 23:09:31 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 25 23:09:31 mindpipe kernel:  [__crc_totalram_pages+1165/3197748] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 25 23:09:31 mindpipe kernel:  [__crc_totalram_pages+65879/3197748] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 25 23:09:31 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 25 23:09:31 mindpipe kernel:  [do_IRQ+167/368] do_IRQ+0xa7/0x170
Jul 25 23:09:31 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 25 23:09:31 mindpipe kernel:  [do_anonymous_page+126/400] do_anonymous_page+0x7e/0x190
Jul 25 23:09:31 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
Jul 25 23:09:31 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
Jul 25 23:09:31 mindpipe kernel:  [get_user_pages+272/880] get_user_pages+0x110/0x370
Jul 25 23:09:31 mindpipe kernel:  [make_pages_present+104/144] make_pages_present+0x68/0x90
Jul 25 23:09:31 mindpipe kernel:  [do_mmap_pgoff+998/1568] do_mmap_pgoff+0x3e6/0x620
Jul 25 23:09:31 mindpipe kernel:  [sys_mmap2+118/176] sys_mmap2+0x76/0xb0
Jul 25 23:09:31 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 25 23:09:31 mindpipe kernel: 11ms non-preemptible critical section violated 1 ms preempt threshold starting at kmap_atomic+0x10/0x60 and ending at kunmap_atomic+0x8/0x20
Jul 25 23:09:31 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 25 23:09:31 mindpipe kernel:  [dec_preempt_count+270/288] dec_preempt_count+0x10e/0x120
Jul 25 23:09:31 mindpipe kernel:  [kunmap_atomic+8/32] kunmap_atomic+0x8/0x20
Jul 25 23:09:31 mindpipe kernel:  [do_anonymous_page+139/400] do_anonymous_page+0x8b/0x190
Jul 25 23:09:31 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
Jul 25 23:09:31 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
Jul 25 23:09:31 mindpipe kernel:  [get_user_pages+272/880] get_user_pages+0x110/0x370
Jul 25 23:09:31 mindpipe kernel:  [make_pages_present+104/144] make_pages_present+0x68/0x90
Jul 25 23:09:31 mindpipe kernel:  [do_mmap_pgoff+998/1568] do_mmap_pgoff+0x3e6/0x620
Jul 25 23:09:31 mindpipe kernel:  [sys_mmap2+118/176] sys_mmap2+0x76/0xb0
Jul 25 23:09:31 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 25 23:27:51 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D2c
Jul 25 23:27:51 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 25 23:27:51 mindpipe kernel:  [__crc_totalram_pages+1165/3197748] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 25 23:27:51 mindpipe kernel:  [__crc_totalram_pages+65879/3197748] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 25 23:27:51 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 25 23:27:51 mindpipe kernel:  [do_IRQ+167/368] do_IRQ+0xa7/0x170
Jul 25 23:27:51 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 25 23:27:51 mindpipe kernel:  [write_chan+382/528] write_chan+0x17e/0x210
Jul 25 23:27:51 mindpipe kernel:  [tty_write+459/656] tty_write+0x1cb/0x290
Jul 25 23:27:51 mindpipe kernel:  [vfs_write+188/272] vfs_write+0xbc/0x110
Jul 25 23:27:51 mindpipe kernel:  [sys_write+46/80] sys_write+0x2e/0x50
Jul 25 23:27:51 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 25 23:27:51 mindpipe kernel: 14ms non-preemptible critical section violated 1 ms preempt threshold starting at tty_write+0x1b6/0x290 and ending at schedule+0x2fd/0x5b0
Jul 25 23:27:51 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 25 23:27:51 mindpipe kernel:  [dec_preempt_count+270/288] dec_preempt_count+0x10e/0x120
Jul 25 23:27:51 mindpipe kernel:  [schedule+765/1456] schedule+0x2fd/0x5b0
Jul 25 23:27:51 mindpipe kernel:  [schedule_timeout+87/160] schedule_timeout+0x57/0xa0
Jul 25 23:27:51 mindpipe kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Jul 25 23:27:51 mindpipe kernel:  [sys_poll+305/544] sys_poll+0x131/0x220
Jul 25 23:27:51 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb


