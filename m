Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266261AbUFPMWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266261AbUFPMWY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 08:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266260AbUFPMWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 08:22:24 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:1474 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S266261AbUFPMVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:21:10 -0400
Subject: Re: PROBLEM: Heavy iowait on 2.6 kernels
From: Guy Van Sanden <n.b@myrealbox.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40CFFAAF.7070905@yahoo.com.au>
References: <1086942905.10540.69.camel@cronos.home.vsb>
	 <1087366549.1190.6.camel@lancelot>
	 <1087369893.11205.36.camel@cronos.home.vsb> <40CFFAAF.7070905@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1087380543.11829.2.camel@cronos.home.vsb>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Jun 2004 14:21:06 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a trace for my workstation during an rsync from the server to
the station (the station is Gentoo-rsync mirror).

060e7>] syscall_call+0x7/0xb

netstat       Z C0486120     0 11825  11683         11826       (L-TLB)
d27bbf88 00200046 df0974b0 c0486120 df0974b0 00000011 00200296 d15a4180 
       df097508 00000000 df097548 00003eee cb7eee89 0000004b df097658 dffeea60 
       00000000 df0974b0 00000000 c011fa86 df0974b0 dfde9f80 df997880 df9978a0 
Call Trace:
 [<c011fa86>] do_exit+0x276/0x400
 [<c011fcaa>] do_group_exit+0x3a/0xb0
 [<c01060e7>] syscall_call+0x7/0xb

evolution     S C0486120     0 11826  11683 11827         11825 (NOTLB)
d2dabf10 00200086 d8521130 c0486120 00000010 c03ced0c 00000000 000000d0 
       62170b66 00000000 d2dabf24 000005f6 508846fc 0000009a d85212d8 000535f3 
       d2dabf24 d2dabf68 000007d1 c036a463 d2dabf24 000535f3 d15b1580 c048bee0 
Call Trace:
 [<c036a463>] schedule_timeout+0x63/0xc0
 [<c0125570>] process_timeout+0x0/0x10
 [<c01648ea>] do_poll+0xaa/0xd0
 [<c0164a92>] sys_poll+0x182/0x270
 [<c0163e30>] __pollwait+0x0/0xd0
 [<c01060e7>] syscall_call+0x7/0xb

evolution     S C0486150     0 11827  11826         11828       (NOTLB)
d90f9f94 00200086 d4fd8030 c0486150 00000091 d90f9f6c 00000001 d137b260 
       e35b4864 00000091 d4fd8030 0002f316 e35ba32a 00000091 d2dacd98 d90f8000 
       d90f9fc4 427368f8 d90f8000 c0105235 d90f9fb0 427368f8 00000008 80000000 
Call Trace:
 [<c0105235>] sys_rt_sigsuspend+0xa5/0xd0
 [<c01060e7>] syscall_call+0x7/0xb

evolution     S C0486150     0 11828  11826         11829 11827 (NOTLB)
d571df94 00200086 d4fd8030 c0486150 00000091 d571df6c 00000001 d137b260 
       e83b46cb 00000091 d4fd8030 00021098 e83bcfe0 00000091 d981c798 d571c000 
       d571dfc4 42f368f8 d571c000 c0105235 d571dfb0 42f368f8 00000008 80000000 
Call Trace:
 [<c0105235>] sys_rt_sigsuspend+0xa5/0xd0
 [<c01060e7>] syscall_call+0x7/0xb

evolution     S C0486150     0 11829  11826         11830 11828 (NOTLB)
d1e39f94 00200086 cdd647b0 c0486150 00000091 d1e39f6c 00000001 d137b260 
       e7221296 00000091 cdd647b0 0004cf22 e72ae555 00000091 d8520258 d1e38000 
       d1e39fc4 437688f8 d1e38000 c0105235 d1e39fb0 437688f8 00000008 80000000 
Call Trace:
 [<c0105235>] sys_rt_sigsuspend+0xa5/0xd0
 [<c01060e7>] syscall_call+0x7/0xb

evolution     S C0486120     0 11830  11826         11831 11829 (NOTLB)
d4f53f94 00200086 d981cb70 c0486120 d0b9cc00 c15daec0 c15daec0 c0167fe2 
       c15daec0 00000000 00000000 0000a626 1015bcc3 0000004c d981cd18 d4f52000 
       d4f53fc4 440ff908 d4f52000 c0105235 d4f53fb0 440ff908 00000008 80000000 
Call Trace:
 [<c0167fe2>] dput+0x22/0x270
 [<c0105235>] sys_rt_sigsuspend+0xa5/0xd0
 [<c01060e7>] syscall_call+0x7/0xb

evolution     S C0486120     0 11831  11826         11832 11830 (NOTLB)
d7cb3f94 00200086 d981c070 c0486120 d034fe40 d7cb3f6c 00000001 d034fe60 
       00000001 00000000 d981c5f0 00011d11 21a230b3 0000004c d981c218 d7cb2000 
       d7cb3fc4 448ff908 d7cb2000 c0105235 d7cb3fb0 448ff908 00000008 80000000 
Call Trace:
 [<c0105235>] sys_rt_sigsuspend+0xa5/0xd0
 [<c01060e7>] syscall_call+0x7/0xb

evolution     S C0486120     0 11832  11826         11838 11831 (NOTLB)
d02d9f94 00200086 d2dac0f0 c0486120 f41098f5 4898f7fd 80a4b6d0 b6ec3f14 
       00000000 00000000 d8521130 00005fb1 0fb81cb9 0000004c d2dac298 d02d8000 
       d02d9fc4 450ff908 d02d8000 c0105235 d02d9fb0 450ff908 00000008 80000000 
Call Trace:
 [<c0105235>] sys_rt_sigsuspend+0xa5/0xd0
 [<c01060e7>] syscall_call+0x7/0xb

evolution     S C04865C8     0 11838  11826               11832 (NOTLB)
cfe4ff94 00200086 da737370 c04865c8 0000006a 00000001 d395b000 cfe4ff64 
       4c3caa2c 0000006a da737370 001fa233 4c531bb6 0000006a d2b918d8 cfe4e000 
       cfe4ffc4 459538f8 cfe4e000 c0105235 cfe4ffb0 459538f8 00000008 80000000 
Call Trace:
 [<c0105235>] sys_rt_sigsuspend+0xa5/0xd0
 [<c01060e7>] syscall_call+0x7/0xb

kdeinit       S C0486150     0 14479  11599 14834   17789 11645 (NOTLB)
cd40deb4 00200086 d4fd8b30 c0486150 0000009a 00000001 cd585930 00000010 
       b7a9f8bc 0000009a d4fd8b30 00001daf b7a9f8bc 0000009a cd585ad8 0005350f 
       cd40dec8 0000000e 0000000e c036a463 cd40dec8 0005350f d581891c cee87f64 
Call Trace:
 [<c036a463>] schedule_timeout+0x63/0xc0
 [<c0125570>] process_timeout+0x0/0x10
 [<c016416f>] do_select+0x18f/0x2d0
 [<c0163e30>] __pollwait+0x0/0xd0
 [<c016459f>] sys_select+0x2bf/0x4d0
 [<c01060e7>] syscall_call+0x7/0xb

ssh           S C0486120     0 14834  14479         18109       (NOTLB)
cd3ebeb4 00200086 cd5848b0 c0486120 0000009a c03ced0c 00000000 000000d0 
       b0a5dbd8 0000009a cd585930 000000a2 b0a6da5f 0000009a cd584a58 00000000 
       7fffffff 00000005 00000005 c036a4b5 c026ee1c d581f000 d581f91c cd3ebf44 
Call Trace:
 [<c036a4b5>] schedule_timeout+0xb5/0xc0
 [<c026ee1c>] normal_poll+0x10c/0x150
 [<c026a9e5>] tty_poll+0x65/0x80
 [<c016416f>] do_select+0x18f/0x2d0
 [<c0163e30>] __pollwait+0x0/0xd0
 [<c016459f>] sys_select+0x2bf/0x4d0
 [<c0151be1>] vfs_write+0xd1/0x130
 [<c01060e7>] syscall_call+0x7/0xb

xmms          S C0486150     0 17789  11599 17790   18369 14479 (NOTLB)
ce703f10 00200086 cdd647b0 c0486150 0000009a 000000d0 d224b980 ce703fa0 
       b977b106 0000009a cdd647b0 000024b7 b978a5f6 0000009a d2b902d8 0005350d 
       ce703f24 ce703f68 0000000a c036a463 ce703f24 0005350d ced44600 c048b7b0 
Call Trace:
 [<c036a463>] schedule_timeout+0x63/0xc0
 [<c0125570>] process_timeout+0x0/0x10
 [<c01648ea>] do_poll+0xaa/0xd0
 [<c0164a92>] sys_poll+0x182/0x270
 [<c0163e30>] __pollwait+0x0/0xd0
 [<c01060e7>] syscall_call+0x7/0xb

xmms          S C0486150     0 17790  17789 17791               (NOTLB)
cee8df10 00200086 d2b90130 c0486150 0000009a c03ced0c 00000000 000000d0 
       ac137123 0000009a d2b90130 0000244d ac13b2c1 0000009a d2b91358 00053bf3 
       cee8df24 cee8df68 000007d1 c036a463 cee8df24 00053bf3 cfab2500 c048c120 
Call Trace:
 [<c036a463>] schedule_timeout+0x63/0xc0
 [<c0125570>] process_timeout+0x0/0x10
 [<c01648ea>] do_poll+0xaa/0xd0
 [<c0164a92>] sys_poll+0x182/0x270
 [<c0163e30>] __pollwait+0x0/0xd0
 [<c01060e7>] syscall_call+0x7/0xb

xmms          S C0486120     0 17791  17790         17792       (NOTLB)
ce90feb4 00200086 d2b906b0 c0486120 cd311b00 00000001 d2b906b0 00000010 
       c03ced0c 00000000 cdd64d30 000007d6 b960190b 0000009a d2b90858 00053565 
       ce90fec8 00000005 00000005 c036a463 ce90fec8 00053565 00000004 c048ba70 
Call Trace:
 [<c036a463>] schedule_timeout+0x63/0xc0
 [<c0125570>] process_timeout+0x0/0x10
 [<c016416f>] do_select+0x18f/0x2d0
 [<c0163e30>] __pollwait+0x0/0xd0
 [<c016459f>] sys_select+0x2bf/0x4d0
 [<c01529fb>] __fput+0xbb/0x120
 [<c01511f1>] sys_close+0x61/0xa0
 [<c01060e7>] syscall_call+0x7/0xb

xmms          S C04865C8     0 17792  17790         17793 17791 (NOTLB)
cd3dfeb4 00200086 cd585930 c04865c8 00000082 00000001 cdd65830 00000010 
       8a6587cc 00000082 cd585930 000001f2 8a67a067 00000082 cdd659d8 00000000 
       7fffffff 0000000b 0000000b c036a4b5 d084d500 00000400 0000000a c034fa8b 
Call Trace:
 [<c036a4b5>] schedule_timeout+0xb5/0xc0
 [<c034fa8b>] unix_poll+0x2b/0xa0
 [<c03027a9>] sock_poll+0x29/0x40
 [<c016416f>] do_select+0x18f/0x2d0
 [<c0163e30>] __pollwait+0x0/0xd0
 [<c016459f>] sys_select+0x2bf/0x4d0
 [<c0151a10>] vfs_read+0xf0/0x130
 [<c01060e7>] syscall_call+0x7/0xb

xmms          S C04865C8     0 17793  17790         17797 17792 (NOTLB)
cd9dff94 00200086 cdd65830 c04865c8 00000082 c0107ead 00100100 00200200 
       8a5c6663 00000082 cdd65830 00000a8e 8a678ee1 00000082 cdd65458 cd9de000 
       cd9dffc4 4303f9d8 cd9de000 c0105235 cd9dffb0 4303f9d8 00000008 80000000 
Call Trace:
 [<c0107ead>] do_IRQ+0xfd/0x130
 [<c0105235>] sys_rt_sigsuspend+0xa5/0xd0
 [<c01060e7>] syscall_call+0x7/0xb

xmms          S C0486120     0 17797  17790         18294 17793 (NOTLB)
cee87f50 00200086 d2b90c30 c0486120 00000099 cdd64d30 c0486120 00000001 
       8f1392d6 00000000 cee87f64 00004e6a 9c45ebe0 0000009a d2b90dd8 0005350f 
       cee87f64 1ddca6a7 00000000 c036a463 cee87f64 0005350f cee87f64 c048b7c0 
Call Trace:
 [<c036a463>] schedule_timeout+0x63/0xc0
 [<c0125570>] process_timeout+0x0/0x10
 [<c012566e>] sys_nanosleep+0xde/0x170
 [<c01060e7>] syscall_call+0x7/0xb

bash          S C04865C8     0 18109  14479               14834 (NOTLB)
cdd63e8c 00200086 da737370 c04865c8 00000081 d5816000 d395b000 cdd63e68 
       4a511536 00000081 da737370 00006ebc 4a53fbd1 00000081 cd7f8f18 00000001 
       7fffffff cd39f2c0 cc8f5000 c036a4b5 cdd63fc4 cdd63f08 00000011 c01058ed 
Call Trace:
 [<c036a4b5>] schedule_timeout+0xb5/0xc0
 [<c01058ed>] setup_frame+0xed/0x1f0
 [<c0134f95>] unlock_page+0x15/0x60
 [<c026e958>] read_chan+0x678/0x810
 [<c011a4f0>] default_wake_function+0x0/0x20
 [<c011a4f0>] default_wake_function+0x0/0x20
 [<c026960d>] tty_write+0x17d/0x290
 [<c026e2e0>] read_chan+0x0/0x810
 [<c0269467>] tty_read+0x127/0x150
 [<c0269490>] tty_write+0x0/0x290
 [<c01519d8>] vfs_read+0xb8/0x130
 [<c0151c82>] sys_read+0x42/0x70
 [<c01060e7>] syscall_call+0x7/0xb

xmms          S C0486120     0 18294  17790 18295         17797 (NOTLB)
cc0e9f50 00200086 cdd64d30 c0486120 0000000c cd5f26c0 d988d4ac cc0e9e5c 
       cc0e9f2c 00000000 cbb55a30 0000024f b9646012 0000009a cdd64ed8 0005350d 
       cc0e9f64 00a7d827 00000000 c036a463 cc0e9f64 0005350d 00000000 ce703f24 
Call Trace:
 [<c036a463>] schedule_timeout+0x63/0xc0
 [<c0125570>] process_timeout+0x0/0x10
 [<c012566e>] sys_nanosleep+0xde/0x170
 [<c01060e7>] syscall_call+0x7/0xb

xmms-arts-hel S C0486120     0 18295  18294                     (NOTLB)
cc0a5eb4 00000086 cdd647b0 c0486120 0000009a 00000001 cdd647b0 00000010 
       b976cc55 00000000 cbb55a30 000000bd b978ad5a 0000009a cdd64958 00053517 
       cc0a5ec8 0000000d 0000000d c036a463 cc0a5ec8 00053517 0000000c c048b800 
Call Trace:
 [<c036a463>] schedule_timeout+0x63/0xc0
 [<c0125570>] process_timeout+0x0/0x10
 [<c016416f>] do_select+0x18f/0x2d0
 [<c0163e30>] __pollwait+0x0/0xd0
 [<c016459f>] sys_select+0x2bf/0x4d0
 [<c01060e7>] syscall_call+0x7/0xb

kdeinit       S C0486150     0 18369  11599 18370   18373 17789 (NOTLB)
cd39beb4 00200086 df1039f0 c0486150 0000009a 00000001 cdd64230 00000010 
       b7a78990 0000009a df1039f0 000025d9 b7a78990 0000009a cdd643d8 0005350d 
       cd39bec8 0000000c 0000000c c036a463 cd39bec8 0005350d d581c91c cc0e9f64 
Call Trace:
 [<c036a463>] schedule_timeout+0x63/0xc0
 [<c0125570>] process_timeout+0x0/0x10
 [<c016416f>] do_select+0x18f/0x2d0
 [<c0163e30>] __pollwait+0x0/0xd0
 [<c016459f>] sys_select+0x2bf/0x4d0
 [<c01060e7>] syscall_call+0x7/0xb

ssh           S C0486120     0 18370  18369                     (NOTLB)
cc2c7eb4 00200086 cd584330 c0486120 00000010 c03ced0c 00000000 000000d0 
       d581c000 000000d0 cf1b40c0 00000410 a31c0c2b 0000009a cd5844d8 00000000 
       7fffffff 00000005 00000005 c036a4b5 c026ee1c d4c8e000 d4c8e91c cc2c7f44 
Call Trace:
 [<c036a4b5>] schedule_timeout+0xb5/0xc0
 [<c026ee1c>] normal_poll+0x10c/0x150
 [<c026a9e5>] tty_poll+0x65/0x80
 [<c016416f>] do_select+0x18f/0x2d0
 [<c0163e30>] __pollwait+0x0/0xd0
 [<c016459f>] sys_select+0x2bf/0x4d0
 [<c0151be1>] vfs_write+0xd1/0x130
 [<c01060e7>] syscall_call+0x7/0xb

kdeinit       S C0486120     0 18373  11599 18374         18369 (NOTLB)
cc561eb4 00200086 cd5853b0 c0486120 0000009a 00000001 cd5853b0 00000010 
       c03ced0c 00000000 cc561ec8 000034bf b8182bbc 0000009a cd585558 0005351e 
       cc561ec8 0000000c 0000000c c036a463 cc561ec8 0005351e d581991c c048b838 
Call Trace:
 [<c036a463>] schedule_timeout+0x63/0xc0
 [<c0125570>] process_timeout+0x0/0x10
 [<c016416f>] do_select+0x18f/0x2d0
 [<c0163e30>] __pollwait+0x0/0xd0
 [<c016459f>] sys_select+0x2bf/0x4d0
 [<c01060e7>] syscall_call+0x7/0xb

bash          S C0486150     0 18374  18373 18425               (NOTLB)
cc57ff3c 00200086 cdd647b0 c0486150 00000092 cd584e30 c0118bdc cd4a4dc0 
       d94980dc 00000092 cdd647b0 00025359 d958bf7c 00000092 cd584fd8 fffffe00 
       cc57e000 cd584ec8 cd584ec8 c0120304 ffffffff 00000002 cd7f92f0 0000001d 
Call Trace:
 [<c0118bdc>] do_page_fault+0x32c/0x50c
 [<c0120304>] sys_wait4+0x194/0x270
 [<c011a4f0>] default_wake_function+0x0/0x20
 [<c023666e>] copy_to_user+0x3e/0x50
 [<c011a4f0>] default_wake_function+0x0/0x20
 [<c0128080>] sys_rt_sigprocmask+0xa0/0x100
 [<c0120407>] sys_waitpid+0x27/0x2b
 [<c01060e7>] syscall_call+0x7/0xb

vmstat        S C0486120     0 18425  18374                     (NOTLB)
cca95f50 00200086 cd7f92f0 c0486120 cca94000 dbe29000 cd591440 cca95f30 
       cc034440 00000000 cca95f64 00003244 8fe75458 0000009a cd7f9498 00053633 
       cca95f64 000f41a7 00000001 c036a463 cca95f64 00053633 00000000 dec85f64 
Call Trace:
 [<c036a463>] schedule_timeout+0x63/0xc0
 [<c0125570>] process_timeout+0x0/0x10
 [<c012566e>] sys_nanosleep+0xde/0x170
 [<c01060e7>] syscall_call+0x7/0xb

rsync         R running     0 18509   9259                     (NOTLB)
udev          S C04865C8     0 18544    141         18546       (NOTLB)
dec85f50 00000082 da737370 c04865c8 0000009a dec85f38 d395b000 dec84000 
       91e55ead 0000009a da737370 00007683 91e55ead 0000009a df723998 00053655 
       dec85f64 000f41a7 00000001 c036a463 dec85f64 00053655 00000000 df747f64 
Call Trace:
 [<c036a463>] schedule_timeout+0x63/0xc0
 [<c0125570>] process_timeout+0x0/0x10
 [<c012566e>] sys_nanosleep+0xde/0x170
 [<c01060e7>] syscall_call+0x7/0xb

udev          S C0486120     0 18546    141               18544 (NOTLB)
df747f50 00000082 df82e730 c0486120 df747f7c df747f38 bffff3fc df746000 
       c015af1f 00000000 cd7f87f0 00007133 98b02a4f 0000009a df82e8d8 000536c7 
       df747f64 000f41a7 00000001 c036a463 df747f64 000536c7 00000000 c048c0f8 
Call Trace:
 [<c015af1f>] vfs_stat+0x1f/0x60
 [<c036a463>] schedule_timeout+0x63/0xc0
 [<c0125570>] process_timeout+0x0/0x10
 [<c012566e>] sys_nanosleep+0xde/0x170
 [<c01060e7>] syscall_call+0x7/0xb

bash          S C0486120     0 18575  11444                     (NOTLB)
c8341e8c 00000082 cbb554b0 c0486120 c026c890 dfbc5000 00000000 c8341e68 
       00000001 31305b07 df7221f0 00014d01 29ca1466 0000009a cbb55658 00000001 
       7fffffff dba87ec0 da359000 c036a4b5 dfbc5000 c0273d98 00000000 403c6001 
Call Trace:
 [<c026c890>] opost_block+0xe0/0x190
 [<c036a4b5>] schedule_timeout+0xb5/0xc0
 [<c0273d98>] clear_selection+0x18/0x60
 [<c026e958>] read_chan+0x678/0x810
 [<c011a4f0>] default_wake_function+0x0/0x20
 [<c011a4f0>] default_wake_function+0x0/0x20
 [<c026960d>] tty_write+0x17d/0x290
 [<c026e2e0>] read_chan+0x0/0x810
 [<c0269467>] tty_read+0x127/0x150
 [<c0269490>] tty_write+0x0/0x290
 [<c01519d8>] vfs_read+0xb8/0x130
 [<c0151c82>] sys_read+0x42/0x70
 [<c01060e7>] syscall_call+0x7/0xb

cron          R running     0 18605   9518 18606               (NOTLB)
bash          S C0486150     0 18606  18605 18632               (NOTLB)
cb88df3c 00000082 cdd647b0 c0486150 0000009a cbb54430 c0118bdc db082940 
       b89230fd 0000009a cdd647b0 0000fa65 b8a06d09 0000009a cbb545d8 fffffe00 
       cb88c000 cbb544c8 cbb544c8 c0120304 ffffffff 00000000 cbb55a30 bffff8c0 
Call Trace:
 [<c0118bdc>] do_page_fault+0x32c/0x50c
 [<c0120304>] sys_wait4+0x194/0x270
 [<c011a4f0>] default_wake_function+0x0/0x20
 [<c011a4f0>] default_wake_function+0x0/0x20
 [<c0128080>] sys_rt_sigprocmask+0xa0/0x100
 [<c0120407>] sys_waitpid+0x27/0x2b
 [<c01060e7>] syscall_call+0x7/0xb

run-crons     R running     0 18632  18606 18638               (NOTLB)
rm            R running     0 18638  18632                     (NOTLB)


