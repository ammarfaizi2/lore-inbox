Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265648AbTGHKcs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 06:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267166AbTGHKcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 06:32:47 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:33420 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S265648AbTGHKbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 06:31:08 -0400
Date: Tue, 8 Jul 2003 12:45:41 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: 2.5.74-bk5 oops reports.
Message-ID: <Pine.LNX.4.51.0307081244590.7915@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.5.74-bk5 (74-mm[12] too) writes all these nasty messages in the kern
log.

This is just after booting:
11:41:31: Warning: kfree_skb on hard IRQ c02fa5fd
11:41:31: Warning: kfree_skb on hard IRQ c02fa5fd
11:41:31: Badness in __put_task_struct at kernel/fork.c:109
11:41:31: Call Trace:
11:41:31:  [__put_task_struct+110/201] __put_task_struct+0x6e/0xc9
11:41:31:  [do_exit+647/1096] do_exit+0x287/0x448
11:41:31:  [do_group_exit+58/172] do_group_exit+0x3a/0xac
11:41:31:  [syscall_call+7/11] syscall_call+0x7/0xb
11:41:31:
11:41:32: Badness in __put_task_struct at kernel/fork.c:109
11:41:32: Call Trace:
11:41:32:  [__put_task_struct+110/201] __put_task_struct+0x6e/0xc9
11:41:32:  [do_exit+647/1096] do_exit+0x287/0x448
11:41:32:  [do_group_exit+58/172] do_group_exit+0x3a/0xac
11:41:32:  [syscall_call+7/11] syscall_call+0x7/0xb
11:41:32:
11:41:33: Warning: kfree_skb on hard IRQ c02fa5fd
11:41:33: Warning: kfree_skb on hard IRQ c02fa5fd
11:41:36: Badness in __put_task_struct at kernel/fork.c:109
11:41:36: Call Trace:
11:41:36:  [__put_task_struct+110/201] __put_task_struct+0x6e/0xc9
11:41:36:  [do_exit+647/1096] do_exit+0x287/0x448
11:41:36:  [do_group_exit+58/172] do_group_exit+0x3a/0xac
11:41:36:  [syscall_call+7/11] syscall_call+0x7/0xb
11:41:36:
11:41:36: Badness in __put_task_struct at kernel/fork.c:109
11:41:36: Call Trace:
11:41:36:  [__put_task_struct+110/201] __put_task_struct+0x6e/0xc9
11:41:36:  [do_exit+647/1096] do_exit+0x287/0x448
11:41:36:  [do_group_exit+58/172] do_group_exit+0x3a/0xac
11:41:36:  [syscall_call+7/11] syscall_call+0x7/0xb
11:41:36:
11:41:37: Warning: kfree_skb on hard IRQ c02fa5fd
11:41:41 pysiak last message repeated 3 times

This is after i tried to compile nvidia driver:
11:48:19: ------------[ cut here ]------------
11:48:19: kernel BUG at kernel/exit.c:727!
11:48:19: invalid operand: 0000 [#1]
11:48:19: CPU:    0
11:48:19: EIP:    0060:[do_exit+622/1096]    Not tainted
11:48:19: EFLAGS: 00010282
11:48:19: EIP is at do_exit+0x26e/0x448
11:48:19: eax: 00000000   ebx: dbfeea80   ecx: c0490dbc   edx: d75ba000
11:48:19: esi: 00000000   edi: 00000000   ebp: d8b00180   esp: d75bbf90
11:48:19: ds: 007b   es: 007b   ss: 0068
11:48:19: Process objdump (pid: 800, threadinfo=d75ba000 task=d8b00180)
11:48:19: Stack: d8b00180 dbcdee40 c17bd500 c17bd520 d75ba000 00000000 00000000 d75ba000
11:48:19:        c011e2ab 00000000 00000000 401d7804 c0108edb 00000000 00001000 401d5c40
11:48:19:        401d7804 00000000 bffff6d8 000000fc 0000007b 0000007b 000000fc 40165f2f
11:48:19: Call Trace:
11:48:19:  [do_group_exit+58/172] do_group_exit+0x3a/0xac
11:48:19:  [syscall_call+7/11] syscall_call+0x7/0xb
11:48:19:
11:48:19: Code: 0f 0b d7 02 a6 f7 35 c0 eb fe 8b 75 10 85 f6 75 ea 89 2c 24
11:48:19:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
11:48:19:  printing eip:
11:48:19: c01188aa
11:48:19: *pde = 00000000
11:48:19: Oops: 0002 [#2]
11:48:19: CPU:    0
11:48:19: EIP:    0060:[schedule+143/947]    Not tainted
11:48:19: EFLAGS: 00010006
11:48:19: EIP is at schedule+0x8f/0x3b3
11:48:19: eax: 00000008   ebx: d8b00180   ecx: d8b001a0   edx: ffffffff
11:48:19: esi: 00000000   edi: c0490920   ebp: d75bbe74   esp: d75bbe4c
11:48:19: ds: 007b   es: 007b   ss: 0068
11:48:19: Process objdump (pid: 800, threadinfo=d75ba000 task=d8b00180)
11:48:19: Stack: 00000000 00000000 d8b001cc 0000000b d8b0021c d8b00180 c0131d2c 00000000
11:48:19:        00000000 00000000 d8b00180 c011e04a d8b00180 00000000 00000001 d75b007b
11:48:19:        d75bbf5c d75ba000 c010a21b d8b00180 c0109f4d 0000000b c0359835 00000000
11:48:19: Call Trace:
11:48:19:  [acct_process+79/132] acct_process+0x4f/0x84
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_invalid_op+0/203] do_invalid_op+0x0/0xcb
11:48:19:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:48:19:  [do_invalid_op+201/203] do_invalid_op+0xc9/0xcb
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [kill_fasync+48/82] kill_fasync+0x30/0x52
11:48:19:  [pipe_release+153/203] pipe_release+0x99/0xcb
11:48:19:  [dput+34/511] dput+0x22/0x1ff
11:48:19:  [__fput+183/276] __fput+0xb7/0x114
11:48:19:  [error_code+45/56] error_code+0x2d/0x38
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_group_exit+58/172] do_group_exit+0x3a/0xac
11:48:19:  [syscall_call+7/11] syscall_call+0x7/0xb
11:48:19:
11:48:19: Code: 83 2e 01 8b 51 04 8b 43 20 89 50 04 89 02 c7 41 04 00 02 20
11:48:19:  <6>note: objdump[800] exited with preempt_count 2
11:48:19: bad: scheduling while atomic!
11:48:19: Call Trace:
11:48:19:  [schedule+942/947] schedule+0x3ae/0x3b3
11:48:19:  [ext3_journal_dirty_data+0/93] ext3_journal_dirty_data+0x0/0x5d
11:48:19:  [generic_file_aio_write_nolock+1423/2722] generic_file_aio_write_nolock+0x58f/0xaa2
11:48:19:  [scrup+286/306] scrup+0x11e/0x132
11:48:19:  [__call_console_drivers+81/83] __call_console_drivers+0x51/0x53
11:48:19:  [i8042_interrupt+528/533] i8042_interrupt+0x210/0x215
11:48:19:  [call_console_drivers+93/275] call_console_drivers+0x5d/0x113
11:48:19:  [generic_file_aio_write+113/142] generic_file_aio_write+0x71/0x8e
11:48:19:  [ext3_file_write+68/194] ext3_file_write+0x44/0xc2
11:48:19:  [do_sync_write+139/183] do_sync_write+0x8b/0xb7
11:48:19:  [scrup+286/306] scrup+0x11e/0x132
11:48:19:  [check_free_space+225/364] check_free_space+0xe1/0x16c
11:48:19:  [poke_blanked_console+92/111] poke_blanked_console+0x5c/0x6f
11:48:19:  [vt_console_print+521/747] vt_console_print+0x209/0x2eb
11:48:19:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:48:19:  [do_acct_process+637/653] do_acct_process+0x27d/0x28d
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [acct_process+72/132] acct_process+0x48/0x84
11:48:19:  [do_exit+132/1096] do_exit+0x84/0x448
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:48:19:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [error_code+45/56] error_code+0x2d/0x38
11:48:19:  [schedule+143/947] schedule+0x8f/0x3b3
11:48:19:  [acct_process+79/132] acct_process+0x4f/0x84
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_invalid_op+0/203] do_invalid_op+0x0/0xcb
11:48:19:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:48:19:  [do_invalid_op+201/203] do_invalid_op+0xc9/0xcb
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [kill_fasync+48/82] kill_fasync+0x30/0x52
11:48:19:  [pipe_release+153/203] pipe_release+0x99/0xcb
11:48:19:  [dput+34/511] dput+0x22/0x1ff
11:48:19:  [__fput+183/276] __fput+0xb7/0x114
11:48:19:  [error_code+45/56] error_code+0x2d/0x38
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_group_exit+58/172] do_group_exit+0x3a/0xac
11:48:19:  [syscall_call+7/11] syscall_call+0x7/0xb
11:48:19:
11:48:19: Unable to handle kernel NULL pointer dereference at virtual address 00000000
11:48:19:  printing eip:
11:48:19: c01188aa
11:48:19: *pde = 00000000
11:48:19: Oops: 0002 [#3]
11:48:19: CPU:    0
11:48:19: EIP:    0060:[schedule+143/947]    Not tainted
11:48:19: EFLAGS: 00010006
11:48:19: EIP is at schedule+0x8f/0x3b3
11:48:19: eax: 00000008   ebx: d8b00180   ecx: d8b001a0   edx: ffffffff
11:48:19: esi: 00000000   edi: c0490920   ebp: d75bbd1c   esp: d75bbcf4
11:48:19: ds: 007b   es: 007b   ss: 0068
11:48:19: Process objdump (pid: 800, threadinfo=d75ba000 task=d8b00180)
11:48:19: Stack: 00000000 00000000 d8b001cc 0000000b d8b0021c d8b00180 c0131d2c 00000000
11:48:19:        00000002 00000000 d8b00180 c011e04a d8b00180 00000000 00000320 00000002
11:48:19:        d75bbe18 d75ba000 c0116960 d8b00180 c0109f4d 0000000b c035f1c1 00000002
11:48:19: Call Trace:
11:48:19:  [acct_process+79/132] acct_process+0x4f/0x84
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:48:19:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [error_code+45/56] error_code+0x2d/0x38
11:48:19:  [schedule+143/947] schedule+0x8f/0x3b3
11:48:19:  [acct_process+79/132] acct_process+0x4f/0x84
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_invalid_op+0/203] do_invalid_op+0x0/0xcb
11:48:19:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:48:19:  [do_invalid_op+201/203] do_invalid_op+0xc9/0xcb
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [kill_fasync+48/82] kill_fasync+0x30/0x52
11:48:19:  [pipe_release+153/203] pipe_release+0x99/0xcb
11:48:19:  [dput+34/511] dput+0x22/0x1ff
11:48:19:  [__fput+183/276] __fput+0xb7/0x114
11:48:19:  [error_code+45/56] error_code+0x2d/0x38
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_group_exit+58/172] do_group_exit+0x3a/0xac
11:48:19:  [syscall_call+7/11] syscall_call+0x7/0xb
11:48:19:
11:48:19: Code: 83 2e 01 8b 51 04 8b 43 20 89 50 04 89 02 c7 41 04 00 02 20
11:48:19:  <6>note: objdump[800] exited with preempt_count 4
11:48:19: bad: scheduling while atomic!
11:48:19: Call Trace:
11:48:19:  [schedule+942/947] schedule+0x3ae/0x3b3
11:48:19:  [ext3_journal_dirty_data+0/93] ext3_journal_dirty_data+0x0/0x5d
11:48:19:  [generic_file_aio_write_nolock+1423/2722] generic_file_aio_write_nolock+0x58f/0xaa2
11:48:19:  [scrup+286/306] scrup+0x11e/0x132
11:48:19:  [__call_console_drivers+81/83] __call_console_drivers+0x51/0x53
11:48:19:  [call_console_drivers+93/275] call_console_drivers+0x5d/0x113
11:48:19:  [generic_file_aio_write+113/142] generic_file_aio_write+0x71/0x8e
11:48:19:  [ext3_file_write+68/194] ext3_file_write+0x44/0xc2
11:48:19:  [do_sync_write+139/183] do_sync_write+0x8b/0xb7
11:48:19:  [scrup+286/306] scrup+0x11e/0x132
11:48:19:  [check_free_space+225/364] check_free_space+0xe1/0x16c
11:48:19:  [poke_blanked_console+92/111] poke_blanked_console+0x5c/0x6f
11:48:19:  [vt_console_print+521/747] vt_console_print+0x209/0x2eb
11:48:19:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:48:19:  [do_acct_process+637/653] do_acct_process+0x27d/0x28d
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [acct_process+72/132] acct_process+0x48/0x84
11:48:19:  [do_exit+132/1096] do_exit+0x84/0x448
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:48:19:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:48:19:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [error_code+45/56] error_code+0x2d/0x38
11:48:19:  [schedule+143/947] schedule+0x8f/0x3b3
11:48:19:  [acct_process+79/132] acct_process+0x4f/0x84
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:48:19:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [error_code+45/56] error_code+0x2d/0x38
11:48:19:  [schedule+143/947] schedule+0x8f/0x3b3
11:48:19:  [acct_process+79/132] acct_process+0x4f/0x84
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_invalid_op+0/203] do_invalid_op+0x0/0xcb
11:48:19:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:48:19:  [do_invalid_op+201/203] do_invalid_op+0xc9/0xcb
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [kill_fasync+48/82] kill_fasync+0x30/0x52
11:48:19:  [pipe_release+153/203] pipe_release+0x99/0xcb
11:48:19:  [dput+34/511] dput+0x22/0x1ff
11:48:19:  [__fput+183/276] __fput+0xb7/0x114
11:48:19:  [error_code+45/56] error_code+0x2d/0x38
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_group_exit+58/172] do_group_exit+0x3a/0xac
11:48:19:  [syscall_call+7/11] syscall_call+0x7/0xb
11:48:19:
11:48:19: Unable to handle kernel NULL pointer dereference at virtual address 00000000
11:48:19:  printing eip:
11:48:19: c01188aa
11:48:19: *pde = 00000000
11:48:19: Oops: 0002 [#4]
11:48:19: CPU:    0
11:48:19: EIP:    0060:[schedule+143/947]    Not tainted
11:48:19: EFLAGS: 00010006
11:48:19: EIP is at schedule+0x8f/0x3b3
11:48:19: eax: 00000008   ebx: d8b00180   ecx: d8b001a0   edx: ffffffff
11:48:19: esi: 00000000   edi: c0490920   ebp: d75bbbc4   esp: d75bbb9c
11:48:19: ds: 007b   es: 007b   ss: 0068
11:48:19: Process objdump (pid: 800, threadinfo=d75ba000 task=d8b00180)
11:48:19: Stack: 00000000 00000000 d8b001cc 0000000b d8b0021c d8b00180 c0131d2c 00000000
11:48:19:        00000004 00000000 d8b00180 c011e04a d8b00180 00000000 00000320 00000004
11:48:19:        d75bbcc0 d75ba000 c0116960 d8b00180 c0109f4d 0000000b c035f1c1 00000002
11:48:19: Call Trace:
11:48:19:  [acct_process+79/132] acct_process+0x4f/0x84
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:48:19:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:48:19:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [error_code+45/56] error_code+0x2d/0x38
11:48:19:  [schedule+143/947] schedule+0x8f/0x3b3
11:48:19:  [acct_process+79/132] acct_process+0x4f/0x84
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:48:19:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [error_code+45/56] error_code+0x2d/0x38
11:48:19:  [schedule+143/947] schedule+0x8f/0x3b3
11:48:19:  [acct_process+79/132] acct_process+0x4f/0x84
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_invalid_op+0/203] do_invalid_op+0x0/0xcb
11:48:19:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:48:19:  [do_invalid_op+201/203] do_invalid_op+0xc9/0xcb
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [kill_fasync+48/82] kill_fasync+0x30/0x52
11:48:19:  [pipe_release+153/203] pipe_release+0x99/0xcb
11:48:19:  [dput+34/511] dput+0x22/0x1ff
11:48:19:  [__fput+183/276] __fput+0xb7/0x114
11:48:19:  [error_code+45/56] error_code+0x2d/0x38
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_group_exit+58/172] do_group_exit+0x3a/0xac
11:48:19:  [syscall_call+7/11] syscall_call+0x7/0xb
11:48:19:
11:48:19: Code: 83 2e 01 8b 51 04 8b 43 20 89 50 04 89 02 c7 41 04 00 02 20
11:48:19:  <6>note: objdump[800] exited with preempt_count 6
11:48:19: bad: scheduling while atomic!
11:48:19: Call Trace:
11:48:19:  [schedule+942/947] schedule+0x3ae/0x3b3
11:48:19:  [ext3_journal_dirty_data+0/93] ext3_journal_dirty_data+0x0/0x5d
11:48:19:  [generic_file_aio_write_nolock+1423/2722] generic_file_aio_write_nolock+0x58f/0xaa2
11:48:19:  [scrup+286/306] scrup+0x11e/0x132
11:48:19:  [__call_console_drivers+81/83] __call_console_drivers+0x51/0x53
11:48:19:  [call_console_drivers+93/275] call_console_drivers+0x5d/0x113
11:48:19:  [generic_file_aio_write+113/142] generic_file_aio_write+0x71/0x8e
11:48:19:  [ext3_file_write+68/194] ext3_file_write+0x44/0xc2
11:48:19:  [do_sync_write+139/183] do_sync_write+0x8b/0xb7
11:48:19:  [scrup+286/306] scrup+0x11e/0x132
11:48:19:  [check_free_space+225/364] check_free_space+0xe1/0x16c
11:48:19:  [poke_blanked_console+92/111] poke_blanked_console+0x5c/0x6f
11:48:19:  [vt_console_print+521/747] vt_console_print+0x209/0x2eb
11:48:19:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:48:19:  [do_acct_process+637/653] do_acct_process+0x27d/0x28d
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [acct_process+72/132] acct_process+0x48/0x84
11:48:19:  [do_exit+132/1096] do_exit+0x84/0x448
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:48:19:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:48:19:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [error_code+45/56] error_code+0x2d/0x38
11:48:19:  [schedule+143/947] schedule+0x8f/0x3b3
11:48:19:  [acct_process+79/132] acct_process+0x4f/0x84
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:48:19:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:48:19:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [error_code+45/56] error_code+0x2d/0x38
11:48:19:  [schedule+143/947] schedule+0x8f/0x3b3
11:48:19:  [acct_process+79/132] acct_process+0x4f/0x84
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:48:19:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:48:19:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:48:19:  [error_code+45/56] error_code+0x2d/0x38
11:48:19:  [schedule+143/947] schedule+0x8f/0x3b3
11:48:19:  [acct_process+79/132] acct_process+0x4f/0x84
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_invalid_op+0/203] do_invalid_op+0x0/0xcb
11:48:19:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:48:19:  [do_invalid_op+201/203] do_invalid_op+0xc9/0xcb
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [kill_fasync+48/82] kill_fasync+0x30/0x52
11:48:19:  [pipe_release+153/203] pipe_release+0x99/0xcb
11:48:19:  [dput+34/511] dput+0x22/0x1ff
11:48:19:  [__fput+183/276] __fput+0xb7/0x114
11:48:19:  [error_code+45/56] error_code+0x2d/0x38
11:48:19:  [do_exit+622/1096] do_exit+0x26e/0x448
11:48:19:  [do_group_exit+58/172] do_group_exit+0x3a/0xac
11:48:19:  [syscall_call+7/11] syscall_call+0x7/0xb
11:48:19:
11:49:48: Unable to handle kernel NULL pointer dereference at virtual address 00000000
11:49:48:  printing eip:
11:49:48: c01188aa
11:49:48: *pde = 00000000
11:49:48: Oops: 0002 [#5]
11:49:48: CPU:    0
11:49:48: EIP:    0060:[schedule+143/947]    Not tainted
11:49:48: EFLAGS: 00010006
11:49:48: EIP is at schedule+0x8f/0x3b3
11:49:48: eax: 00000008   ebx: d8b00180   ecx: d8b001a0   edx: ffffffff
11:49:48: esi: 00000000   edi: c0490920   ebp: d75bba6c   esp: d75bba44
11:49:48: ds: 007b   es: 007b   ss: 0068
11:49:48: Process objdump (pid: 800, threadinfo=d75ba000 task=d8b00180)
11:49:48: Stack: 00000000 00000000 d8b001cc 0000000b d8b0021c d8b00180 c0131d2c 00000000
11:49:48:        00000006 00000000 d8b00180 c011e04a d8b00180 00000000 00000320 00000006
11:49:48:        d75bbb68 d75ba000 c0116960 d8b00180 c0109f4d 0000000b c035f1c1 00000002
11:49:48: Call Trace:
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:49:48:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [schedule+143/947] schedule+0x8f/0x3b3
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:49:48:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [schedule+143/947] schedule+0x8f/0x3b3
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [schedule+143/947] schedule+0x8f/0x3b3
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_invalid_op+0/203] do_invalid_op+0x0/0xcb
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_invalid_op+201/203] do_invalid_op+0xc9/0xcb
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [kill_fasync+48/82] kill_fasync+0x30/0x52
11:49:48:  [pipe_release+153/203] pipe_release+0x99/0xcb
11:49:48:  [dput+34/511] dput+0x22/0x1ff
11:49:48:  [__fput+183/276] __fput+0xb7/0x114
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_group_exit+58/172] do_group_exit+0x3a/0xac
11:49:48:  [syscall_call+7/11] syscall_call+0x7/0xb
11:49:48:
11:49:48: Code: 83 2e 01 8b 51 04 8b 43 20 89 50 04 89 02 c7 41 04 00 02 20
11:49:48:  <6>note: objdump[800] exited with preempt_count 8
11:49:48: bad: scheduling while atomic!
11:49:48: Call Trace:
11:49:48:  [schedule+942/947] schedule+0x3ae/0x3b3
11:49:48:  [ext3_journal_dirty_data+0/93] ext3_journal_dirty_data+0x0/0x5d
11:49:48:  [generic_file_aio_write_nolock+1423/2722] generic_file_aio_write_nolock+0x58f/0xaa2
11:49:48:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:49:48:  [__down+251/253] __down+0xfb/0xfd
11:49:48:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
11:49:48:  [i8042_interrupt+528/533] i8042_interrupt+0x210/0x215
11:49:48:  [generic_file_aio_write+113/142] generic_file_aio_write+0x71/0x8e
11:49:48:  [ext3_file_write+68/194] ext3_file_write+0x44/0xc2
11:49:48:  [do_sync_write+139/183] do_sync_write+0x8b/0xb7
11:49:48:  [scrup+286/306] scrup+0x11e/0x132
11:49:48:  [check_free_space+225/364] check_free_space+0xe1/0x16c
11:49:48:  [poke_blanked_console+92/111] poke_blanked_console+0x5c/0x6f
11:49:48:  [vt_console_print+521/747] vt_console_print+0x209/0x2eb
11:49:48:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:49:48:  [do_acct_process+637/653] do_acct_process+0x27d/0x28d
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [acct_process+72/132] acct_process+0x48/0x84
11:49:48:  [do_exit+132/1096] do_exit+0x84/0x448
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:49:48:  [do_notify_parent+326/1276] do_notify_parent+0x146/0x4fc
11:49:48:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [schedule+143/947] schedule+0x8f/0x3b3
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:49:48:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [schedule+143/947] schedule+0x8f/0x3b3
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:49:48:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [schedule+143/947] schedule+0x8f/0x3b3
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [schedule+143/947] schedule+0x8f/0x3b3
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_invalid_op+0/203] do_invalid_op+0x0/0xcb
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_invalid_op+201/203] do_invalid_op+0xc9/0xcb
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [kill_fasync+48/82] kill_fasync+0x30/0x52
11:49:48:  [pipe_release+153/203] pipe_release+0x99/0xcb
11:49:48:  [dput+34/511] dput+0x22/0x1ff
11:49:48:  [__fput+183/276] __fput+0xb7/0x114
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_group_exit+58/172] do_group_exit+0x3a/0xac
11:49:48:  [syscall_call+7/11] syscall_call+0x7/0xb
11:49:48:
11:49:48: Unable to handle kernel NULL pointer dereference at virtual address 00000000
11:49:48:  printing eip:
11:49:48: c01188aa
11:49:48: *pde = 00000000
11:49:48: Oops: 0002 [#6]
11:49:48: CPU:    0
11:49:48: EIP:    0060:[schedule+143/947]    Not tainted
11:49:48: EFLAGS: 00010006
11:49:48: EIP is at schedule+0x8f/0x3b3
11:49:48: eax: 00000008   ebx: d8b00180   ecx: d8b001a0   edx: ffffffff
11:49:48: esi: 00000000   edi: c0490920   ebp: d75bb914   esp: d75bb8ec
11:49:48: ds: 007b   es: 007b   ss: 0068
11:49:48: Process objdump (pid: 800, threadinfo=d75ba000 task=d8b00180)
11:49:48: Stack: 00000000 00000000 d8b001cc 0000000b d8b0021c d8b00180 c0131d2c 00000000
11:49:48:        00000008 00000000 d8b00180 c011e04a d8b00180 00000000 00000320 00000008
11:49:48:        d75bba10 d75ba000 c0116960 d8b00180 c0109f4d 0000000b c035f1c1 00000002
11:49:48: Call Trace:
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:49:48:  [do_notify_parent+326/1276] do_notify_parent+0x146/0x4fc
11:49:48:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [schedule+143/947] schedule+0x8f/0x3b3
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:49:48:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [schedule+143/947] schedule+0x8f/0x3b3
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:49:48:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [schedule+143/947] schedule+0x8f/0x3b3
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [schedule+143/947] schedule+0x8f/0x3b3
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_invalid_op+0/203] do_invalid_op+0x0/0xcb
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_invalid_op+201/203] do_invalid_op+0xc9/0xcb
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [kill_fasync+48/82] kill_fasync+0x30/0x52
11:49:48:  [pipe_release+153/203] pipe_release+0x99/0xcb
11:49:48:  [dput+34/511] dput+0x22/0x1ff
11:49:48:  [__fput+183/276] __fput+0xb7/0x114
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_group_exit+58/172] do_group_exit+0x3a/0xac
11:49:48:  [syscall_call+7/11] syscall_call+0x7/0xb
11:49:48:
11:49:48: Code: 83 2e 01 8b 51 04 8b 43 20 89 50 04 89 02 c7 41 04 00 02 20
11:49:48:  <6>note: objdump[800] exited with preempt_count 10
11:49:48: bad: scheduling while atomic!
11:49:48: Call Trace:
11:49:48:  [schedule+942/947] schedule+0x3ae/0x3b3
11:49:48:  [ext3_journal_dirty_data+0/93] ext3_journal_dirty_data+0x0/0x5d
11:49:48:  [generic_file_aio_write_nolock+1423/2722] generic_file_aio_write_nolock+0x58f/0xaa2
11:49:48:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:49:48:  [scrup+286/306] scrup+0x11e/0x132
11:49:48:  [__down+251/253] __down+0xfb/0xfd
11:49:48:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
11:49:48:  [i8042_interrupt+528/533] i8042_interrupt+0x210/0x215
11:49:48:  [generic_file_aio_write+113/142] generic_file_aio_write+0x71/0x8e
11:49:48:  [ext3_file_write+68/194] ext3_file_write+0x44/0xc2
11:49:48:  [do_sync_write+139/183] do_sync_write+0x8b/0xb7
11:49:48:  [scrup+286/306] scrup+0x11e/0x132
11:49:48:  [check_free_space+225/364] check_free_space+0xe1/0x16c
11:49:48:  [poke_blanked_console+92/111] poke_blanked_console+0x5c/0x6f
11:49:48:  [vt_console_print+521/747] vt_console_print+0x209/0x2eb
11:49:48:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:49:48:  [do_acct_process+637/653] do_acct_process+0x27d/0x28d
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [acct_process+72/132] acct_process+0x48/0x84
11:49:48:  [do_exit+132/1096] do_exit+0x84/0x448
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:49:48:  [do_notify_parent+326/1276] do_notify_parent+0x146/0x4fc
11:49:48:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [schedule+143/947] schedule+0x8f/0x3b3
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:49:48:  [do_notify_parent+326/1276] do_notify_parent+0x146/0x4fc
11:49:48:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [schedule+143/947] schedule+0x8f/0x3b3
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:49:48:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [schedule+143/947] schedule+0x8f/0x3b3
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:49:48:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [schedule+143/947] schedule+0x8f/0x3b3
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_page_fault+300/1110] do_page_fault+0x12c/0x456
11:49:48:  [do_page_fault+0/1110] do_page_fault+0x0/0x456
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [schedule+143/947] schedule+0x8f/0x3b3
11:49:48:  [acct_process+79/132] acct_process+0x4f/0x84
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_invalid_op+0/203] do_invalid_op+0x0/0xcb
11:49:48:  [do_divide_error+0/250] do_divide_error+0x0/0xfa
11:49:48:  [do_invalid_op+201/203] do_invalid_op+0xc9/0xcb
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [kill_fasync+48/82] kill_fasync+0x30/0x52
11:49:48:  [pipe_release+153/203] pipe_release+0x99/0xcb
11:49:48:  [dput+34/511] dput+0x22/0x1ff
11:49:48:  [__fput+183/276] __fput+0xb7/0x114
11:49:48:  [error_code+45/56] error_code+0x2d/0x38
11:49:48:  [do_exit+622/1096] do_exit+0x26e/0x448
11:49:48:  [do_group_exit+58/172] do_group_exit+0x3a/0xac
11:49:48:  [syscall_call+7/11] syscall_call+0x7/0xb
11:49:48:


Config:
#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_EMBEDDED is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HUGETLB_PAGE=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Generic Driver Options
#
CONFIG_FW_LOADER=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDE_TCQ=y
# CONFIG_BLK_DEV_IDE_TCQ_DEFAULT is not set
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=32
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_RZ1000=y
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=y

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=y

#
# Device Drivers
#

#
# Texas Instruments PCILynx requires I2C bit-banging
#
CONFIG_IEEE1394_OHCI1394=y

#
# Protocol Drivers
#
# CONFIG_IEEE1394_VIDEO1394 is not set
# CONFIG_IEEE1394_SBP2 is not set
CONFIG_IEEE1394_ETH1394=y
# CONFIG_IEEE1394_DV1394 is not set
CONFIG_IEEE1394_RAWIO=y
# CONFIG_IEEE1394_CMP is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPV6=y
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
CONFIG_INET6_IPCOMP=y
# CONFIG_IPV6_TUNNEL is not set

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_XFRM_USER=y

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
CONFIG_IP_SCTP=y
# CONFIG_SCTP_ADLER32 is not set
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_LLC=y
# CONFIG_LLC_UI is not set
CONFIG_IPX=y
# CONFIG_IPX_INTERN is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
# CONFIG_NET_SCH_CSZ is not set
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
# CONFIG_TYPHOON is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_NET_PCI is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Hardware Sensors Mainboard support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_I810_TCO=y
# CONFIG_MIXCOMWD is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_AMD7XX_TCO is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=y

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp852"
CONFIG_CIFS=y
CONFIG_NCP_FS=y
CONFIG_NCPFS_PACKET_SIGNING=y
# CONFIG_NCPFS_IOCTL_LOCKING is not set
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
# CONFIG_NCPFS_SMALLDOS is not set
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-2"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_AX8817X is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_KALLSYMS=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y
