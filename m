Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbUKSKt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbUKSKt5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 05:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUKSKt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 05:49:57 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:1001 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S261346AbUKSKty
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 05:49:54 -0500
Message-ID: <419DCFE7.4030702@verizon.net>
Date: Fri, 19 Nov 2004 05:50:15 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS in 2.6.10-rc2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [209.158.220.243] at Fri, 19 Nov 2004 04:49:53 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Woke up and the system was unresponsive - couldn't cleanly shut down, couldn't log 
in from anywhere, had to hit the power button.

This was a nasty one - when I tried to reboot into my stable 2.6.8.1 kernel, it 
panicked due to an unknown ext3 option - I had to boot back into 2.6.10-rc2, fsck 
the filesystems, and boot back into 2.6.8.1.  Checking syslog, I found:


Nov 19 04:09:03 david kernel: Unable to handle kernel paging request at virtual 
address 30006fbc
Nov 19 04:09:03 david kernel:  printing eip:
Nov 19 04:09:03 david kernel: c01e7abc
Nov 19 04:09:03 david kernel: *pde = 00000000
Nov 19 04:09:03 david kernel: Oops: 0002 [#1]
Nov 19 04:09:03 david kernel: PREEMPT
Nov 19 04:09:03 david kernel: Modules linked in: floppy snd_mixer_oss snd_emu10k1 
snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc 
snd_util_mem snd_hwdep snd soundcore tun parport_pc lp parport autofs4 nfs lockd 
sunrpc e100 mii md5 ipv6 microcode sd_mod joydev uhci_hcd usb_storage scsi_mod 
ohci_hcd ehci_hcd button battery ac
Nov 19 04:09:03 david kernel: CPU:    0
Nov 19 04:09:03 david kernel: EIP:    0060:[<c01e7abc>]    Not tainted VLI
Nov 19 04:09:03 david kernel: EFLAGS: 00010206   (2.6.10-rc2david-1)
Nov 19 04:09:03 david kernel: EIP is at __journal_clean_checkpoint_list+0x56/0x96
Nov 19 04:09:03 david kernel: eax: 00000000   ebx: cf460b9c   ecx: f72ada00   edx: 
30006fbc
Nov 19 04:09:03 david kernel: esi: f7296000   edi: cf460a7c   ebp: f7296d7c   esp: 
f7296d5c
Nov 19 04:09:03 david kernel: ds: 007b   es: 007b   ss: 0068
Nov 19 04:09:03 david kernel: Process kjournald (pid: 1459, threadinfo=f7296000 
task=f7f33550)
Nov 19 04:09:03 david kernel: Stack: d7c84d1c 00000000 dc744f00 dc744d00 dc744d00 
f7296000 00000000 00000001
Nov 19 04:09:03 david kernel:        f7296f30 c01e3ab9 00000000 00000000 00000000 
00000000 00000000 00000000
Nov 19 04:09:03 david kernel:        00000000 00000000 f72adb74 f72adb74 f72adb74 
f7296000 00000000 00000000
Nov 19 04:09:03 david kernel: Call Trace:
Nov 19 04:09:03 david kernel:  [<c01048f9>] show_stack+0x7a/0x90
Nov 19 04:09:03 david kernel:  [<c0104a77>] show_registers+0x14d/0x1b1
Nov 19 04:09:03 david kernel:  [<c0104cbb>] die+0x151/0x2bd
Nov 19 04:09:03 david kernel:  [<c011a423>] do_page_fault+0x26b/0x643
Nov 19 04:09:03 david kernel:  [<c0104453>] error_code+0x2b/0x30
Nov 19 04:09:03 david kernel:  [<c01e3ab9>] journal_commit_transaction+0x59b/0x296a
Nov 19 04:09:03 david kernel:  [<c01e905c>] kjournald+0x19a/0x700
Nov 19 04:09:03 david kernel:  [<c0101285>] kernel_thread_helper+0x5/0xb
Nov 19 04:09:03 david kernel: Code: f0 8b 40 58 89 45 e8 8b 45 f0 8b 58 28 85 db 
74 34 8b 43 2c 89 df be 00 f0 ff ff 89 45 e0 21 e6 89 fb 8b 7f 28 8b 13 83 46 14 
01 <0f> ba 2a 13 19 c0 85 c0 74 2a 8b 46 08 83 6e 14 01 a8 08 75 18
Nov 19 04:09:03 david kernel:  <3>Debug: sleeping function called from invalid 
context at include/linux/rwsem.h:43
Nov 19 04:09:03 david kernel: in_atomic():1, irqs_disabled():0
Nov 19 04:09:03 david kernel:  [<c0104926>] dump_stack+0x17/0x1b
Nov 19 04:09:03 david kernel:  [<c011e665>] __might_sleep+0xb6/0xd7
Nov 19 04:09:03 david kernel:  [<c0123837>] profile_task_exit+0x23/0x56
Nov 19 04:09:03 david kernel:  [<c0125ef5>] do_exit+0x1c/0xa0b
Nov 19 04:09:03 david kernel:  [<c0104e27>] do_divide_error+0x0/0x102
Nov 19 04:09:03 david kernel:  [<c011a423>] do_page_fault+0x26b/0x643
Nov 19 04:09:03 david kernel:  [<c0104453>] error_code+0x2b/0x30
Nov 19 04:09:03 david kernel:  [<c01e3ab9>] journal_commit_transaction+0x59b/0x296a
Nov 19 04:09:03 david kernel:  [<c01e905c>] kjournald+0x19a/0x700
Nov 19 04:09:03 david kernel:  [<c0101285>] kernel_thread_helper+0x5/0xb
Nov 19 04:09:03 david kernel: note: kjournald[1459] exited with preempt_count 3
Nov 19 04:09:03 david kernel: fs/jbd/transaction.c:115: 
spin_lock(fs/jbd/journal.c:f72ada14) already locked by fs/jbd/commit.c/147
