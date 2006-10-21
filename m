Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422685AbWJURa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWJURa4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 13:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423355AbWJURa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 13:30:56 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:8619 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1422685AbWJURaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 13:30:55 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc2-mm2: reproducible hang on shutdown on i386
Date: Sat, 21 Oct 2006 19:30:05 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20061020015641.b4ed72e5.akpm@osdl.org>
In-Reply-To: <20061020015641.b4ed72e5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610211930.05492.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 20 October 2006 10:56, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/
> 
> - Added the IOAT tree as git-ioat.patch (Chris Leech)
> 
> - I worked out the git magic to make the wireless tree work
>   (git-wireless.patch).  Hopefully it will be in -mm more often now.

[Margin note: bcm43xx doesn't work on my test boxes although it used to on one
of them, but I have to play with it a bit more.]

It looks like i386 cannot shut down cleanly with this kernel.  On my test
boxes (2 of them) it hangs after killing all processes, 100% of the time.
Fortunately the console remains functional so I have used SysRq to
collect some traces (below).

Greetings,
Rafael


eth0: network connection down
SysRq : Show Regs

Pid: 0, comm:              swapper
EIP: 0060:[<c0101af3>] CPU: 0
EIP is at default_idle+0x43/0x80
 EFLAGS: 00000206    Not tainted  (2.6.19-rc2-mm2 #3)
EAX: 000d64ad EBX: 00000800 ECX: 00000000 EDX: 00000000
ESI: 00099100 EDI: c042b000 EBP: c0481fd0 DS: 007b ES: 007b GS: 00d8
CR0: 8005003b CR2: b7e44ec0 CR3: 1fe90000 CR4: 000006d0
 [<c0101b71>] cpu_idle+0x41/0x70
 [<c0100617>] rest_init+0x37/0x40
 [<c04827c8>] start_kernel+0x2c8/0x370
 =======================
SysRq : HELP : loglevel0-8 reBoot show-all-locks(D) tErm Full kIll saK showMem Nice powerOff showPc unRaw Sync showTasks Unmount showBlockedTa
SysRq : Show Regs

Pid: 0, comm:              swapper
EIP: 0060:[<c0101af3>] CPU: 0
EIP is at default_idle+0x43/0x80
 EFLAGS: 00000202    Not tainted  (2.6.19-rc2-mm2 #3)
EAX: 000e7e4d EBX: 00000800 ECX: 00000000 EDX: 00000000
ESI: 00099100 EDI: c042b000 EBP: c0481fd0 DS: 007b ES: 007b GS: 00d8
CR0: 8005003b CR2: b7e44ec0 CR3: 1fe90000 CR4: 000006d0
 [<c0101b71>] cpu_idle+0x41/0x70
 [<c0100617>] rest_init+0x37/0x40
 [<c04827c8>] start_kernel+0x2c8/0x370
 =======================
SysRq : HELP : loglevel0-8 reBoot show-all-locks(D) tErm Full kIll saK showMem Nice powerOff showPc unRaw Sync showTasks Unmount showBlockedTa
SysRq : Show Regs

Pid: 0, comm:              swapper
EIP: 0060:[<c0101af3>] CPU: 0
EIP is at default_idle+0x43/0x80
 EFLAGS: 00000202    Not tainted  (2.6.19-rc2-mm2 #3)
EAX: 001016a9 EBX: 00000800 ECX: 00000000 EDX: 00000000
ESI: 00099100 EDI: c042b000 EBP: c0481fd0 DS: 007b ES: 007b GS: 00d8
CR0: 8005003b CR2: b7e44ec0 CR3: 1fe90000 CR4: 000006d0
 [<c0101b71>] cpu_idle+0x41/0x70
 [<c0100617>] rest_init+0x37/0x40
 [<c04827c8>] start_kernel+0x2c8/0x370
 =======================
SysRq : HELP : loglevel0-8 reBoot show-all-locks(D) tErm Full kIll saK showMem Nice powerOff showPc unRaw Sync showTasks Unmount showBlockedTa
SysRq : Show Regs

Pid: 0, comm:              swapper
EIP: 0060:[<c0101af3>] CPU: 0
EIP is at default_idle+0x43/0x80
 EFLAGS: 00000202    Not tainted  (2.6.19-rc2-mm2 #3)
EAX: 00107c2b EBX: 00000800 ECX: 00000000 EDX: 00000000
ESI: 00099100 EDI: c042b000 EBP: c0481fd0 DS: 007b ES: 007b GS: 00d8
CR0: 8005003b CR2: b7e44ec0 CR3: 1fe90000 CR4: 000006d0
 [<c0101b71>] cpu_idle+0x41/0x70
 [<c0100617>] rest_init+0x37/0x40
 [<c04827c8>] start_kernel+0x2c8/0x370
 =======================
SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
init          S C0136453  4336     1      0     2               (NOTLB)
       dfb85b28 00000046 dfb85af8 c0136453 00000000 00000001 00000046 c04fa6e0
       0000000a dfb83530 64fd9700 00000029 00000000 dfb83650 dfb85b28 c0124808
       a048c3c0 00000000 00000282 dfb85b3c ffff8d89 00000000 dfb85b5c c033bd8a
Call Trace:
 [<c033bd8a>] schedule_timeout+0x4a/0xc0
 [<c0181e00>] do_select+0x490/0x590
 [<c01820d6>] core_sys_select+0x1d6/0x300
 [<c0182674>] sys_select+0xd4/0x190
 [<c0103268>] syscall_call+0x7/0xb
 [<0805d4b8>] 0x805d4b8
 =======================
ksoftirqd/0   S 00000002  7208     2      1             3       (L-TLB)
       dfb87fb8 00000046 00000000 00000002 c033b14b c04fc01c 2da57300 00000019
       0000000a dfb82ab0 2da57300 00000019 00000000 dfb82bd0 00f42400 00000000
       003d1581 00000000 dfb85ec4 fffffffc dfb85ec4 00000000 dfb87fc0 c0120a38
Call Trace:
 [<c0120a38>] ksoftirqd+0xd8/0x100
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
watchdog/0    S 00000002  7252     3      1             4     2 (L-TLB)
       dfb89fb4 00000046 00000000 00000002 c033b14b c013b641 104a5a00 00000028
       00000001 dfb82030 45d1be00 0000002a 00000000 dfb82150 00000000 00000000
       00026614 00000000 dfb89fc0 fffffffc dfb85ec8 00000000 dfb89fc0 c014cca6
Call Trace:
 [<c014cca6>] watchdog+0x46/0x60
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
khelper       S C033E335  6436     5      1             6     4 (L-TLB)
       dfb9bf5c 00000046 dfbf2ab0 c033e335 00000282 dfb9bf38 c0136453 dfbef56c
       00000004 dfbf2ab0 e28b6000 00000018 00000000 dfbf2bd0 c033e319 dfb9bf98
       02bea45a 00000000 c012f143 dfbef564 dfbef56c dfbef534 dfb9bfc0 c012c013
Call Trace:
 [<c012c013>] worker_thread+0x123/0x150
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
kthread       S C033E335  7084     6      1    31             5 (L-TLB)
       dff41f5c 00000046 dfbf2030 c033e335 00000282 dff41f38 c0136453 dfbef4a0
       0000000a dfbf2030 9d3959c8 00000016 00002471 dfbf2150 c033e319 dff41f98
       00157b2c 00000000 c012f143 dfbef498 dfbef4a0 dfbef468 dff41fc0 c012c013
Call Trace:
 [<c012c013>] worker_thread+0x123/0x150
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
kblockd/0     S C033E335  6692    31      6            32       (L-TLB)
       dff07f5c 00000046 dfb34030 c033e335 00000282 dff07f38 c0136453 dffd723c
       0000000a dfb34030 339b5400 00000019 00000000 dfb34150 c033e319 dff07f98
       08c3ba7b 00000000 c012f143 dffd7234 dffd723c dffd7204 dff07fc0 c012c013
Call Trace:
 [<c012c013>] worker_thread+0x123/0x150
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
kacpid        S C033E335  5620    32      6            33    31 (L-TLB)
       dff0bf5c 00000046 dff09530 c033e335 00000282 dff0bf38 c0136453 dffd7e30
       00000009 dff09530 373c9e00 00000016 00000000 dff09650 c033e319 dff0bf98
       009a954a 00000000 c012f143 dffd7e28 dffd7e30 dffd7df8 dff0bfc0 c012c013
Call Trace:
 [<c012c013>] worker_thread+0x123/0x150
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
kacpi_notify  S C033E335  6784    33      6           130    32 (L-TLB)
       dff0df5c 00000046 dff08ab0 c033e335 00000282 dff0df38 a8e1d055 00000016
       0000000a dff08ab0 a8e1f9da 00000016 0020b2d7 dff08bd0 00001187 00000000
       0020e40a 00000000 c012f143 dffd7d5c dffd7d64 dffd7d2c dff0dfc0 c012c013
Call Trace:
 [<c012c013>] worker_thread+0x123/0x150
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
ksuspend_usbd S C033E335  7672   130      6           133    33 (L-TLB)
       dff39f5c 00000046 dfb34ab0 c033e335 00000282 dff39f38 c0136453 dffc77d0
       00000002 dfb34ab0 3a70ee29 0000000a 00000ca0 dfb34bd0 c033e319 dff39f98
       00001c6d 00000000 c012f143 dffc77c8 dffc77d0 dffc7798 dff39fc0 c012c013
Call Trace:
 [<c012c013>] worker_thread+0x123/0x150
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
khubd         S 00000296  5832   133      6           135   130 (L-TLB)
       dff15ef8 00000046 c033e335 00000296 dff15ed0 c0136453 7c2659fd 0000000f
       00000009 dfb2d530 7c2659fd 0000000f 014c0f8b dfb2d650 03d1da7d 00000000
       278691df 00000000 00000001 dff15f94 00000000 00000002 dff15fc0 c02a7f0f
Call Trace:
 [<c02a7f0f>] hub_thread+0x95f/0xf70
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
kseriod       S 00000282  6276   135      6           157   133 (L-TLB)
       dff17f64 00000046 c033e335 00000282 dff17f3c c0136453 c03c4740 00000001
       0000000a dfb15530 4e3af0c5 0000000b 00007763 dfb15650 dfb15530 c03c4740
       05c0435c 00000000 00000001 dff17fa0 dfa67dfc dfa67dfc dff17fc0 c02b8821
Call Trace:
 [<c02b8821>] serio_thread+0xf1/0x340
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
pdflush       S 00000000  5808   157      6           158   135 (L-TLB)
       dff31f98 00000046 00000000 00000000 00000000 dfb1c030 c033e372 00000000
       0000000a dfb1c030 7fee9000 00000029 00000000 dfb1c150 00000001 00000046
       0624565d 00000000 dfb85ed0 dff31fb0 dfb85ed0 00000000 dff31fc0 c0157c0a
Call Trace:
 [<c0157c0a>] pdflush+0x8a/0x190
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
pdflush       S 00000000  6160   158      6           159   157 (L-TLB)
       dff3bf98 00000046 00000000 00000000 00000000 dfb25530 c033e372 00000000
       0000000a dfb25530 ec4dd300 00000010 00000000 dfb25650 00000001 00000046
       025fc3ab 00000000 dfb85ed0 dff3bfb0 dfb85ed0 00000000 dff3bfc0 c0157c0a
Call Trace:
 [<c0157c0a>] pdflush+0x8a/0x190
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
kswapd0       S 00000292  7632   159      6           160   158 (L-TLB)
       dff13f18 00000046 c033e335 00000292 dff13ef0 c0136453 c03b0520 00000001
       00000005 dfbfcab0 5132c504 0000000a 000006da dfbfcbd0 dfbfcab0 c03b0520
       0000174c 00000000 00000001 fffffffc dfb85ec8 c03b0000 dff13fc0 c015ca8c
Call Trace:
 [<c015ca8c>] kswapd+0x49c/0x4e0
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
kprefetchd    S 00000000  7276   160      6           161   159 (L-TLB)
       dfb13f9c 00000046 00000000 00000000 dfb35530 c033e335 00000000 dfb35530
       00000001 dfb35530 551a00a4 0000000a 00004aeb dfb35650 00000046 c03b0bc4
       000068ad 00000000 dfb13f9c 00000000 00000001 00000000 dfb13fc0 c016a5a7
Call Trace:
 [<c016a5a7>] kprefetchd+0x287/0x410
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
aio/0         S C033E335  7672   161      6           807   160 (L-TLB)
       dfb29f5c 00000046 dfb2cab0 c033e335 00000282 dfb29f38 c0136453 dfb39a34
       00000005 dfb2cab0 51f7b825 0000000a 00000dfa dfb2cbd0 c033e319 dfb29f98
       00001b2e 00000000 c012f143 dfb39a2c dfb39a34 dfb399fc dfb29fc0 c012c013
Call Trace:
 [<c012c013>] worker_thread+0x123/0x150
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
kpsmoused     S C033E335  7672   807      6          1661   161 (L-TLB)
       dfa61f5c 00000046 dfb24030 c033e335 00000282 dfa61f38 c0136453 dfed1b00
       00000009 dfb24030 0bccbbf6 0000000b 00000d85 dfb24150 c033e319 dfa61f98
       00001e8f 00000000 c012f143 dfed1af8 dfed1b00 dfed1ac8 dfa61fc0 c012c013
Call Trace:
 [<c012c013>] worker_thread+0x123/0x150
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
reiserfs/0    S C033E335  6852  1661      6          2674   807 (L-TLB)
       df841f5c 00000046 dfef6030 c033e335 00000282 df841f38 c0136453 dfed1efc
       0000000a dfef6030 635a1e00 0000001a 00000000 dfef6150 c033e319 df841f98
       000c7ffb 00000000 c012f143 dfed1ef4 dfed1efc dfed1ec4 df841fc0 c012c013
Call Trace:
 [<c012c013>] worker_thread+0x123/0x150
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
khpsbpkt      S C033E335  7284  2674      6          2803  1661 (L-TLB)
       f74cbfb8 00000046 f74c4030 c033e335 f90db1ac f74cbf94 c0136453 f90db1ac
       0000000a f74c4030 9554b8ff 0000000f 0000071f f74c4150 c033e319 f90db1a0
       000184cd 00000000 c02d4493 fffffffc f7441de4 00000000 f74cbfc0 f9091805
Call Trace:
 [<f9091805>] hpsbpkt_thread+0x85/0x90 [ieee1394]
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
knodemgrd_0   S F74C7F28  6260  2803      6          2826  2674 (L-TLB)
       f74c7f54 00000046 00000246 f74c7f28 c0136453 f90a3334 9995029c 0000000f
       00000009 f7477530 9995029c 0000000f 000fcbe3 f7477650 01695db0 00000000
       0454a396 00000000 00000000 00000001 00000000 f7478000 f74c7fc0 f90973a9
Call Trace:
 [<f90973a9>] nodemgr_host_thread+0x509/0xb00 [ieee1394]
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
pccardd       S 00000000  7076  2826      6          2858  2803 (L-TLB)
       df853f60 00000046 00000000 00000000 f7476030 c033e335 00000000 f7476030
       00000009 f7476030 34be0970 0000000f 00001814 f7476150 00000046 f75af2b0
       00052481 00000000 df853f60 f75af094 00000000 f75af2b0 df853fc0 f8f83275
Call Trace:
 [<f8f83275>] pccardd+0x145/0x270 [pcmcia_core]
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
pccardd       S 00000000  7288  2858      6          2863  2826 (L-TLB)
       f75d5f60 00000046 00000000 00000000 dfee6ab0 c033e335 00000000 dfee6ab0
       00000009 dfee6ab0 4ba3886d 0000000f 000014ce dfee6bd0 00000046 f7a4c7cc
       00036604 00000000 f75d5f60 f7a4c5b0 00000000 f7a4c7cc f75d5fc0 f8f83275
Call Trace:
 [<f8f83275>] pccardd+0x145/0x270 [pcmcia_core]
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
ac97/0        S C033E335  7592  2863      6          4743  2858 (L-TLB)
       f75d3f5c 00000046 f74ff530 c033e335 00000282 f75d3f38 c0136453 f75d8308
       00000009 f74ff530 4c1ae574 0000000f 00000ba0 f74ff650 c033e319 f75d3f98
       000045cc 00000000 c012f143 f75d8300 f75d8308 f75d82d0 f75d3fc0 c012c013
Call Trace:
 [<c012c013>] worker_thread+0x123/0x150
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
kauditd       S C033E335  7204  4743      6          5003  2863 (L-TLB)
       f733df74 00000046 dfa00ab0 c033e335 00000292 f733df50 c0136453 c03afa60
       0000000a dfa00ab0 0a2afa00 00000012 00000000 dfa00bd0 c033e319 f733dfa4
       00022dfe 00000000 c012f143 00000000 f733dfa4 00000000 f733dfc0 c0147d32
Call Trace:
 [<c0147d32>] kauditd_thread+0x152/0x180
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================
kondemand/0   S C033E335  6612  5003      6                4743 (L-TLB)
       f7647f5c 00000046 f6500ab0 c033e335 00000282 f7647f38 c0136453 f6b3c170
       0000000a f6500ab0 5c3b0c00 0000002a 00000000 f6500bd0 c033e319 f7647f98
       009d83be 00000000 c012f143 f6b3c168 f6b3c170 f6b3c138 f7647fc0 c012c013
Call Trace:
 [<c012c013>] worker_thread+0x123/0x150
 [<c012ed23>] kthread+0xa3/0xd0
 [<c0103657>] kernel_thread_helper+0x7/0x10
 =======================

Showing all locks held in the system:

=============================================

