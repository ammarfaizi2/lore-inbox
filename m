Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbUEAPGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUEAPGP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 11:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUEAPGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 11:06:15 -0400
Received: from A427c.a.pppool.de ([213.6.66.124]:64903 "EHLO sexmachine")
	by vger.kernel.org with ESMTP id S262176AbUEAPGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 11:06:10 -0400
Date: Sat, 1 May 2004 17:03:08 +0200
From: Konstantin Kletschke <lkml@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at include/linux/list.h:164!
Message-ID: <20040501150308.GB8709@ku-gbr.de>
Reply-To: Konstantin Kletschke <konsti@ku-gbr.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Kletschke & Uhlig GbR
X-PGP-Key: http://www.ludenkalle.de/konsti/pubkey.asc
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks :)

I have a server at my hosting ISP, which got a new Kernel with
devmapper patches in it to use LVM2 with 2.6.x.

I test these patches at home, no error, but my Server crashes after a
couple of days, second time now.

May  1 12:03:02 kermit spamd[3861]: checking message
<200405011002.i41A2SpU008667@mx10.sjc.ebay.com> for nobody:1005.
May  1 12:03:07 kermit kernel: ------------[ cut here ]------------
May  1 12:03:07 kermit kernel: kernel BUG at include/linux/list.h:164!
May  1 12:03:07 kermit kernel: invalid operand: 0000 [#1]
May  1 12:03:07 kermit kernel: PREEMPT
May  1 12:03:07 kermit kernel: CPU:    0
May  1 12:03:07 kermit kernel: EIP:    0060:[exit_rmap+237/272] Not tainted VLI
May  1 12:03:07 kermit kernel: EFLAGS: 00010283   (2.6.6-rc2-mm1)
May  1 12:03:07 kermit kernel: EIP is at exit_rmap+0xed/0x110
May  1 12:03:07 kermit kernel: eax: c600c001   ebx: ccb35e8c   ecx: ccb35e0c   edx: ccb35e80
May  1 12:03:07 kermit kernel: esi: c13bd2e0   edi: c19c5700   ebp: c2fdf8c0   esp: c600dc54
May  1 12:03:07 kermit kernel: ds: 007b   es: 007b   ss: 0068
May  1 12:03:07 kermit kernel: Process spamd (pid: 3862, threadinfo=c600c000 task=c0ad6030)
May  1 12:03:07 kermit kernel: Stack: 000015c4 c2fdf8c0 c2fdf8c0 c2fdf8c0 c0116d15 c2fdf8c0 c03b818c c0ad6030
May  1 12:03:07 kermit kernel:        c015791b c2fdf8c0 c2fdf8c0 00000000 c600c000 c0b1d900 c600de44 c0157aea
May  1 12:03:07 kermit kernel:        c19c5700 cffe4740 c600dcbc c600c000 c0000000 c02d5295 c600de44 c0157850
May  1 12:03:07 kermit kernel: Call Trace:
May  1 12:03:07 kermit kernel:  [mmput+117/192] mmput+0x75/0xc0
May  1 12:03:07 kermit kernel:  [exec_mmap+187/320] exec_mmap+0xbb/0x140
May  1 12:03:07 kermit kernel:  [flush_old_exec+330/2288] flush_old_exec+0x14a/0x8f0
May  1 12:03:07 kermit kernel:  [kernel_read+80/96] kernel_read+0x50/0x60
May  1 12:03:07 kermit kernel:  [load_elf_binary+835/3296] load_elf_binary+0x343/0xce0
May  1 12:03:07 kermit kernel:  [load_elf_binary+0/3296] load_elf_binary+0x0/0xce0
May  1 12:03:07 kermit kernel:  [search_binary_handler+396/704] search_binary_handler+0x18c/0x2c0
May  1 12:03:07 kermit kernel:  [do_execve+482/640] do_execve+0x1e2/0x280
May  1 12:03:07 kermit kernel:  [sys_rt_sigaction+168/192] sys_rt_sigaction+0xa8/0xc0
May  1 12:03:07 kermit kernel:  [sys_execve+66/128] sys_execve+0x42/0x80
May  1 12:03:07 kermit kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  1 12:03:07 kermit kernel:
May  1 12:03:07 kermit kernel: Code: ff eb d8 0f 0b 78 00 9b 3f 2d c0
eb e3 0f 0b 77 00 9b 3f 2d c0 eb d1 e8 12 5a 17 00 eb b8
0f 0b a5 00 11 02 2d c0 e9 65 ff ff ff <0f> 0b a4 00 11 02 2d c0 e9
4c ff ff ff 0f 0b 6f 00 9b 3f 2d c0
May  1 12:03:07 kermit kernel:  <6>note: spamd[3862] exited with preempt_count 1
May  1 16:32:35 kermit syslogd 1.4.1#14: restart.

2.6.6-rc2-mm1 with devmapper udm1 patch

Is this dump due to udma1 or not and the error is fixed now?

Regards, Konsti

-- 
2.6.5-mm1
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 4:01, 15 users
