Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbTEERua (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 13:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbTEERua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 13:50:30 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:27034 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261162AbTEERuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 13:50:25 -0400
Date: Mon, 5 May 2003 20:02:50 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: Ext3 problems with 2.5.69
Message-ID: <Pine.LNX.4.51.0305051957060.29666@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

having opened in mc one panel with an ext3 filesystem and a vfat fs
on a usb flash memory device, mc froze and this is what i got in the
kern.log:

May  5 19:51:50 pysiak kernel: Assertion failure in __journal_drop_transaction() at fs/jbd/checkpoint.c:584: "transaction->t_shadow_list == NULL"
May  5 19:51:50 pysiak kernel: ------------[ cut here ]------------
May  5 19:51:50 pysiak kernel: kernel BUG at fs/jbd/checkpoint.c:584!
May  5 19:51:50 pysiak kernel: invalid operand: 0000 [#1]
May  5 19:51:50 pysiak kernel: CPU:    0
May  5 19:51:50 pysiak kernel: EIP:    0060:[__journal_drop_transaction+490/806]    Tainted: PF
May  5 19:51:50 pysiak kernel: EFLAGS: 00010286
May  5 19:51:50 pysiak kernel: EIP is at __journal_drop_transaction+0x1ea/0x326
May  5 19:51:50 pysiak kernel: eax: 00000076   ebx: d9f8d180   ecx: dbd2e180   edx: c034e038
May  5 19:51:50 pysiak kernel: esi: db8dcd80   edi: 00000000   ebp: 00000000   esp: db829e34
May  5 19:51:50 pysiak kernel: ds: 007b   es: 007b   ss: 0068
May  5 19:51:50 pysiak kernel: Process kjournald (pid: 70, threadinfo=db828000 task=dbd2e180)
May  5 19:51:50 pysiak kernel: Stack: c03039a0 c02ed273 c02ff71c 00000248 c0306900 d9f8d180 c0185e67 db8dcd80
May  5 19:51:50 pysiak kernel:        d9f8d180 db2eb420 00000000 c0184475 db2eb420 db29fd80 00000003 00010204
May  5 19:51:50 pysiak kernel:        00000000 db828000 db8dce40 db8dcdf4 00000000 00000fdc d0bc6024 00000000
May  5 19:51:50 pysiak kernel: Call Trace:
May  5 19:51:50 pysiak kernel:  [__journal_remove_checkpoint+74/136] __journal_remove_checkpoint+0x4a/0x88
May  5 19:51:50 pysiak kernel:  [journal_commit_transaction+1612/4187] journal_commit_transaction+0x64c/0x105b
May  5 19:51:50 pysiak kernel:  [scrup+303/313] scrup+0x12f/0x139
May  5 19:51:50 pysiak kernel:  [poke_blanked_console+83/102] poke_blanked_console+0x53/0x66
May  5 19:51:50 pysiak kernel:  [vt_console_print+531/769] vt_console_print+0x213/0x301
May  5 19:51:50 pysiak kernel:  [__call_console_drivers+87/89] __call_console_drivers+0x57/0x59
May  5 19:51:51 pysiak kernel:  [schedule+406/816] schedule+0x196/0x330
May  5 19:51:51 pysiak kernel:  [default_wake_function+0/18] default_wake_function+0x0/0x12
May  5 19:51:51 pysiak kernel:  [kjournald+278/395] kjournald+0x116/0x18b
May  5 19:51:51 pysiak kernel:  [commit_timeout+0/9] commit_timeout+0x0/0x9
May  5 19:51:51 pysiak kernel:  [kjournald+0/395] kjournald+0x0/0x18b
May  5 19:51:51 pysiak kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
May  5 19:51:51 pysiak kernel:
May  5 19:51:51 pysiak kernel: Code: 0f 0b 48 02 1c f7 2f c0 e9 73 fe ff ff c7 44 24 10 40 69 30


I can't kill mc that caused it, and i can't unmount the fs to check it, so
i will reboot and try to fix it and see if there were any errors on the
fs, although the fs is clean as tune2fs -l says:
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal dir_index filetype needs_recovery sparse_super
Default mount options:    (none)
Filesystem state:         clean

Regards,
Maciej

