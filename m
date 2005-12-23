Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030580AbVLWQWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030580AbVLWQWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 11:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030572AbVLWQWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 11:22:55 -0500
Received: from [15.170.179.235] ([15.170.179.235]:46443 "EHLO exch02.APPIQ.COM")
	by vger.kernel.org with ESMTP id S1030569AbVLWQWy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 11:22:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: More info for DSM w/r/t sunffb on 2.6.15-rc6
Date: Fri, 23 Dec 2005 11:23:36 -0500
Message-ID: <DF925A10E7204748977502BECE3D11230100CD7C@exch02.appiq.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: More info for DSM w/r/t sunffb on 2.6.15-rc6
Thread-Index: AcYHbebly+a79x7zTN6gM+UqNlBSrgAbubVg
From: "Michael Bishop" <michael.bishop@APPIQ.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to provide some more information in regards to the recent
thread concerning sunffb driver trouble in current kernels.

There seems to be some confusion regarding the exact failure mode.  Let
me try and explain in more detail.

I'm running 2.6.15-rc6 on an ultra-60 (dual 450mhz blackbird).  I have a
ffb (creator3d series 3) and am using x.org 6.8.2-r6. Console
framebuffer mode works fine.  When running a startx and using fmccor's
2.6 kernel example xorg.conf the following happens:

1.  Screen clears and there is an underscore character in the top left
corner.
2.  Slight screen distortion like a handful of white scratches appears
for a split second.
3.  Screen is blank except for the underscore, but stable w/no
distortion.   Hard drive activity is heard.
4.  CTRL-ALT-BACKSPACE works and kills X, putting me back at my shell
prompt.
5.  The following is seen appended to normal dmesg output:

Bad pte = 1fa00600a88, process = X, vm_flags = 184473, vaddr = 7001e000
Call Trace:
 [000000000047e0f4] copy_page_range+0x174/0x1e0
 [0000000000447fac] copy_mm+0x1ec/0x340
 [000000000044898c] copy_process+0x34c/0xc40
 [0000000000449344] do_fork+0x44/0x1e0
 [00000000004071d4] linux_sparc_syscall32+0x34/0x40
 [00000000701da950] 0x701da950
Bad pte = 1fa00600a88, process = ???, vm_flags = 184473, vaddr =
7001e000
Call Trace:
 [000000000047e5f4] unmap_page_range+0x174/0x1a0
 [000000000047e714] unmap_vmas+0xf4/0x260
 [0000000000483c48] exit_mmap+0x88/0x160
 [0000000000447c30] mmput+0x30/0xe0
 [000000000049c59c] exec_mmap+0x19c/0x220
 [000000000049c774] flush_old_exec+0xd4/0x7a0
 [0000000000432d74] load_elf_binary+0x3b4/0xec0
 [000000000049d138] search_binary_handler+0x98/0x360
 [00000000004be6e4] compat_do_execve+0x124/0x1e0
 [0000000000429fc8] sparc32_execve+0x48/0xc0
 [00000000004071d4] linux_sparc_syscall32+0x34/0x40
 [00000000701daaac] 0x701daaac
Bad pte = 800001fa00600e88, process = X, vm_flags = 184473, vaddr =
7001e000
Call Trace:
 [000000000047e5f4] unmap_page_range+0x174/0x1a0
 [000000000047e714] unmap_vmas+0xf4/0x260
 [000000000048354c] unmap_region+0x8c/0x140
 [00000000004838f0] do_munmap+0x110/0x160
 [000000000048395c] sys_munmap+0x1c/0x40
 [00000000004071d4] linux_sparc_syscall32+0x34/0x40
 [0000000070871988] 0x70871988

For the heck of it, I had tried using PROM console output rather than
the console framebuffer driver, thinking perhaps I couldn't use the
console framebuffer support AND x.org at the same time.  running startx
in this instance just gave me a blank white screen until i hit
ctrl-alt-bksp.

Please CC me directly on any responses to this thread as I am not
currently subscribed to the linux kernel mailing list.

I'd like to thank David Miller in advance for all his work on the sparc
support.  Fantastic job.

I should also note that initial tests with 2.6.15-rc5+ show that a bug I
had where the system would completely lock up solid during heavy IO load
appears to be fixed.  Ran a script to generate IO on a 10-disk raid-5
overnight and it was still running this morning.  Previously (2.6.13 and
back and 2.4 kernels) the system would lock up after only a couple
minutes.

regards,

mpb
