Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbVJ1RIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbVJ1RIQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 13:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbVJ1RIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 13:08:16 -0400
Received: from mail.linicks.net ([217.204.244.146]:9738 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1030407AbVJ1RIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 13:08:12 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Release callback - trying to fix vicam.c 2.6.14
Date: Fri, 28 Oct 2005 18:07:59 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510281807.59733.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Warning:  N00b mail...

I am trying to fix the vicam.c code (last updated on sourceforge page 3 years 
ago!) to use callback release correctly as reported in syslog when loading 
this module for my cam.

After too many hours and too many reboots today, I finally got somewhere with 
a one line addition to the device structure.  All works well, until I rmmod 
vicam.  Hotplug then crashes - the oops at end of the mail.

The module unloads though - and I can then reload it and use the cam 
everytime.  It must be bloody obvious, as the address is alway 0x0b.

Reading up, I think hotplug still has a handle in this somewhere, but I am now 
lost on what to look for.  Looking at similar code in other cam models 
doesn't enlighten me (but, I don't know if these work or not?).

Any guidance appreciated.

Thanks,

Nick

Oct 28 16:35:20 linuxamd kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 0000000b
Oct 28 16:35:20 linuxamd kernel:  printing eip:
Oct 28 16:35:20 linuxamd kernel: c016b292
Oct 28 16:35:20 linuxamd kernel: *pde = 00000000
Oct 28 16:35:20 linuxamd kernel: Oops: 0000 [#1]
Oct 28 16:35:20 linuxamd kernel: PREEMPT
Oct 28 16:35:20 linuxamd kernel: Modules linked in: vicam
Oct 28 16:35:20 linuxamd kernel: CPU:    0
Oct 28 16:35:20 linuxamd kernel: EIP:    0060:[<c016b292>]    Not tainted VLI
Oct 28 16:35:20 linuxamd kernel: EFLAGS: 00010086   (2.6.14)
Oct 28 16:35:20 linuxamd kernel: EIP is at fasync_helper+0x32/0xf0
Oct 28 16:35:20 linuxamd kernel: eax: ee43e000   ebx: 00000000   ecx: f7b2f730   
edx: ffffffff
Oct 28 16:35:20 linuxamd kernel: esi: f7fd0960   edi: f7b2f730   ebp: 00000000   
esp: ee43ff24
Oct 28 16:35:20 linuxamd kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 16:35:20 linuxamd kernel: Process default.hotplug (pid: 1922, 
threadinfo=ee43e000 task=ee82e560)
Oct 28 16:35:20 linuxamd kernel: Stack: c2098b7c b7f1a9e0 00000000 f7b0aea0 
c1baa200 c1ae1480 f7b0aea0 c01654de
Oct 28 16:35:20 linuxamd kernel:        ffffffff f7fd0960 00000000 f7b2f730 
f7fd0960 c01655ff ffffffff f7fd0960
Oct 28 16:35:20 linuxamd kernel:        00000000 c01581aa f7b0aea0 f7fd0960 
eebde228 f7fd0960 c1baa200 00000000
Oct 28 16:35:20 linuxamd kernel: Call Trace:
Oct 28 16:35:20 linuxamd kernel:  [<c01654de>] pipe_write_fasync+0x3e/0x60
Oct 28 16:35:20 linuxamd kernel:  [<c01655ff>] pipe_write_release+0x1f/0x40
Oct 28 16:35:20 linuxamd kernel:  [<c01581aa>] __fput+0x11a/0x160
Oct 28 16:35:20 linuxamd kernel:  [<c01566a6>] filp_close+0x46/0x90
Oct 28 16:35:20 linuxamd kernel:  [<c015675a>] sys_close+0x6a/0xd0
Oct 28 16:35:20 linuxamd kernel:  [<c0102f35>] syscall_call+0x7/0xb
Oct 28 16:35:20 linuxamd kernel: Code: ec 0c 8b 6c 24 28 8b 74 24 24 8b 7c 24 
2c c7 44 24 08 00 00 00 00 85 ed 75 61 fa b8 00 e0 ff ff 21 e0$
Oct 28 16:35:20 linuxamd kernel:  <6>note: default.hotplug[1922] exited with 
preempt_count 1
Oct 28 16:35:20 linuxamd kernel: scheduling while atomic: 
default.hotplug/0x00000001/1922
Oct 28 16:35:20 linuxamd kernel:  [<c039b2d7>] schedule+0x587/0x660
Oct 28 16:35:20 linuxamd kernel:  [<c039c3c9>] __down+0x79/0x100
Oct 28 16:35:20 linuxamd kernel:  [<c0111f90>] default_wake_function+0x0/0x20
Oct 28 16:35:20 linuxamd kernel:  [<c039ad1f>] __down_failed+0x7/0xc
Oct 28 16:35:20 linuxamd kernel:  [<c0165b87>] .text.lock.pipe+0x8a/0x123
Oct 28 16:35:20 linuxamd kernel:  [<c01655bf>] pipe_read_release+0x1f/0x40
Oct 28 16:35:20 linuxamd kernel:  [<c01581aa>] __fput+0x11a/0x160
Oct 28 16:35:20 linuxamd kernel:  [<c01566a6>] filp_close+0x46/0x90
Oct 28 16:35:20 linuxamd kernel:  [<c011738a>] put_files_struct+0x6a/0xa0
Oct 28 16:35:20 linuxamd kernel:  [<c0118117>] do_exit+0x107/0x440
Oct 28 16:35:20 linuxamd kernel:  [<c039cb20>] do_page_fault+0x0/0x5cb
Oct 28 16:35:20 linuxamd kernel:  [<c01038d5>] die+0x185/0x190
Oct 28 16:35:20 linuxamd kernel:  [<c039cb20>] do_page_fault+0x0/0x5cb
Oct 28 16:35:20 linuxamd kernel:  [<c0115dd7>] printk+0x17/0x20
Oct 28 16:35:20 linuxamd kernel:  [<c039cebd>] do_page_fault+0x39d/0x5cb
Oct 28 16:35:20 linuxamd kernel:  [<c012c1f6>] 
posix_cpu_timers_exit_group+0x56/0x60
Oct 28 16:35:20 linuxamd kernel:  [<c0116c5f>] release_task+0x11f/0x170
Oct 28 16:35:20 linuxamd kernel:  [<c039cb20>] do_page_fault+0x0/0x5cb
Oct 28 16:35:20 linuxamd kernel:  [<c010315f>] error_code+0x4f/0x54
Oct 28 16:35:20 linuxamd kernel:  [<c016b292>] fasync_helper+0x32/0xf0
Oct 28 16:35:20 linuxamd kernel:  [<c01654de>] pipe_write_fasync+0x3e/0x60
Oct 28 16:35:20 linuxamd kernel:  [<c01655ff>] pipe_write_release+0x1f/0x40
Oct 28 16:35:20 linuxamd kernel:  [<c01581aa>] __fput+0x11a/0x160
Oct 28 16:35:20 linuxamd kernel:  [<c01566a6>] filp_close+0x46/0x90
Oct 28 16:35:20 linuxamd kernel:  [<c015675a>] sys_close+0x6a/0xd0
Oct 28 16:35:20 linuxamd kernel:  [<c0102f35>] syscall_call+0x7/0xb

-- 
http://sourceforge.net/projects/quake2plus

"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

