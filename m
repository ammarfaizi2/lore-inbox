Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUDQCTD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 22:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUDQCTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 22:19:03 -0400
Received: from web12823.mail.yahoo.com ([216.136.174.204]:42574 "HELO
	web12823.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262584AbUDQCRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 22:17:41 -0400
Message-ID: <20040417021739.78020.qmail@web12823.mail.yahoo.com>
Date: Fri, 16 Apr 2004 19:17:39 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: Re: Process hang with 2.6.6-rc1
To: Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-23523166-1082168259=:77519"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-23523166-1082168259=:77519
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Apologies if you see this message truncated earlier.
Attached is the complete report.
-------------------------------------------------------
Hi,

I have been experiencing process hangs since upgrading
to 2.6.6-rc1.  The system is usually able to stay up
for a day before the hang.  But it is quite consistent
in that it always hangs.  I experienced the same hang
with 2.6.5-bk1 as well.  In the thread traces, it
looks as though the mmap_sem of pid 3960 (pan) is not
being released preventing any other process from
locking the address space.  This is readily apparent
from the hung "ps" command.  It is trying to read
"/proc/3960/stat".
The machine is otherwise usable but trying to shut it
down via reboot hangs it.

Any clues would be appreciated as I have not been able
to make any headway in debugging this.  My hardware
information is below and I have attached the sysrq-t
output and .config.

Thanks,
Shantanu

Kernel version: 2.6.6-rc1 SMP

Hardware Info: Dell PE1600SC 2x2Ghz Xeon CPUs
               1 18GB SCSI disk (root)
               1 250GB Maxtor external USB 2.0 disk

Last few lines from "ps" trace:

open("/proc/3915/cmdline", O_RDONLY)    = 6
read(6, "/usr/lib/mozilla-1.4.1/mozilla-b"..., 2047) =
51
close(6)                                = 0
open("/proc/3915/environ", O_RDONLY)    = 6
read(6, "SSH_AGENT_PID=3230\0HOSTNAME=anu."..., 2047)
= 1134
close(6)                                = 0
stat64("/proc/3960", {st_mode=S_IFDIR|0555, st_size=0,
...}) = 0
open("/proc/3960/stat", O_RDONLY)       = 6
read(6, 


	
		
__________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online by April 15th
http://taxes.yahoo.com/filing.html
--0-23523166-1082168259=:77519
Content-Type: text/plain; name="sysrq-t.txt"
Content-Description: sysrq-t.txt
Content-Disposition: inline; filename="sysrq-t.txt"

SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
init          S 00000001  4708     1      0     2               (NOTLB)
c1a7de90 00000082 c1a21ce0 00000001 0000000f c11ff880 00000000 c1a22660 
       c1a7de90 00000246 c1a22660 c1a7dea4 c1a7deb0 c1a21ce0 00000000 053ab0c0 
       000f9465 f7f916b0 f7f91868 f7f916b0 00000010 00000000 05623bf3 c1a7dea4 
Call Trace:
 [<c02cc2f1>] schedule_timeout+0x6e/0xbf
 [<c0126f65>] process_timeout+0x0/0xc
 [<c0173438>] do_select+0x183/0x2d4
 [<c0173127>] __pollwait+0x0/0xac
 [<c017384d>] sys_select+0x299/0x4cc
 [<c0105e25>] sysenter_past_esp+0x52/0x71

migration/0   S F721BFC0  7868     2      1             3       (L-TLB)
f7f77f9c 00000046 00000001 f721bfc0 00000001 f7f77f70 c011944f f72a4c70 
       00000003 00000000 f721bfc0 f721bfb4 f7292750 c1a11ce0 00000000 4f444540 
       000f41ff f7f90030 f7f901e8 00000000 f7f916b0 c1a11ce0 c1a1262c c1a11ce0 
Call Trace:
 [<c011944f>] __wake_up_common+0x38/0x57
 [<c011aa9a>] migration_thread+0x94/0x15c
 [<c013202d>] kthread_exit_files+0x33/0x53
 [<c0132104>] kthread+0xb7/0xbc
 [<c011aa06>] migration_thread+0x0/0x15c
 [<c013204d>] kthread+0x0/0xbc
 [<c0104021>] kernel_thread_helper+0x5/0xb

ksoftirqd/0   S 00000001  6168     3      1             4     2 (L-TLB)
f7f7ffa0 00000046 c1a11ce0 00000001 0000000f 00c8b320 c035947c 00000000 
       f7f7e000 f7f7ff7c c012299e 00000000 c03cb6dc c1a11ce0 00000000 748cb240 
       000f941d f7f75730 f7f758e8 00000246 f7f7e000 ffffe000 f7f7e000 f7f7e000 
Call Trace:
 [<c012299e>] tasklet_action+0x68/0xb1
 [<c0122bd0>] ksoftirqd+0xaa/0xc5
 [<c0132104>] kthread+0xb7/0xbc
 [<c0122b26>] ksoftirqd+0x0/0xc5
 [<c013204d>] kthread+0x0/0xbc
 [<c0104021>] kernel_thread_helper+0x5/0xb

migration/1   S F7219FC0  7868     4      1             5     3 (L-TLB)
f7f7df9c 00000046 00000001 f7219fc0 00000001 f7f7df70 c011944f f76b1190 
       00000003 00000000 f7219fc0 f7219fb4 f76ca330 c1a19ce0 00000000 2b71bd00 
       000f41ff f7f75190 f7f75348 00000000 f7f75730 c1a11ce0 c1a1a62c c1a19ce0 
Call Trace:
 [<c011944f>] __wake_up_common+0x38/0x57
 [<c011aa9a>] migration_thread+0x94/0x15c
 [<c013202d>] kthread_exit_files+0x33/0x53
 [<c0132104>] kthread+0xb7/0xbc
 [<c011aa06>] migration_thread+0x0/0x15c
 [<c013204d>] kthread+0x0/0xbc
 [<c0104021>] kernel_thread_helper+0x5/0xb

ksoftirqd/1   S F7F7BF44  6852     5      1             6     4 (L-TLB)
f7f7bfa0 00000046 f7f7bf44 f7f7bf44 0000000f f6f95764 c1a1b6fc 00000000 
       f7f7a000 f7f7bf7c c012299e 00000000 f76cb410 c1a19ce0 00000000 3c7b5200 
       000f93ad f7f74bf0 f7f74da8 00000246 f7f7a000 ffffe000 f7f7a000 f7f7a000 
Call Trace:
 [<c012299e>] tasklet_action+0x68/0xb1
 [<c0122bd0>] ksoftirqd+0xaa/0xc5
 [<c0132104>] kthread+0xb7/0xbc
 [<c0122b26>] ksoftirqd+0x0/0xc5
 [<c013204d>] kthread+0x0/0xbc
 [<c0104021>] kernel_thread_helper+0x5/0xb

migration/2   S F559BFC0  7868     6      1             7     5 (L-TLB)
f7f79f9c 00000046 00000001 f559bfc0 00000001 f7f79f70 c011944f f76cb410 
       00000003 00000000 f559bfc0 f559bfb4 f4f5e6d0 c1a21ce0 00000000 cce739c0 
       000f4237 f7f74650 f7f74808 00000000 f7f916b0 c1a11ce0 c1a2262c c1a21ce0 
Call Trace:
 [<c011944f>] __wake_up_common+0x38/0x57
 [<c011aa9a>] migration_thread+0x94/0x15c
 [<c013202d>] kthread_exit_files+0x33/0x53
 [<c0132104>] ozilla-bin   S 00000001  5732  3948   3915          3949       (NOTLB)
f2f83ef8 00200086 c1a19ce0 00000001 0000000f c0140606 c0324680 00000000 
       000000d0 f2f11a50 00000001 f2ee9730 00000010 c1a19ce0 00000000 f2cfb980 
       000f9464 f2ee9730 f2ee98e8 f2f83ef0 c0140897 00200246 00000000 7fffffff 
Call Trace:
 [<c0140606>] __alloc_pages+0x97/0x2f3
 [<c0140897>] __get_free_pages+0x35/0x40
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c016cb18>] pipe_poll+0x33/0x79
 [<c0173ad7>] do_pollfd+0x57/0x98
 [<c0173bb2>] do_poll+0x9a/0xb9
 [<c0173d12>] sys_poll+0x141/0x1fc
 [<c015ea04>] sys_read+0x5b/0x5d
 [<c0173127>] __pollwait+0x0/0xac
 [<c0105e25>] sysenter_past_esp+0x52/0x71

mozilla-bin   S 00000001  6744  3949   3915          3950  3948 (NOTLB)
f2ee7e84 00200086 c1a11ce0 00000001 0000000f f2f0c800 00000001 f2d81c00 
       f2ee7e70 00000040 00002260 f4eb4370 f76b00b0 c1a11ce0 00000000 ee806740 
       000f424c f2ee8bf0 f2ee8da8 800f8000 f2ee7e8c c0150fe3 fffffff5 7fffffff 
Call Trace:
 [<c0150fe3>] find_extend_vma+0x27/0x79
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c0132443>] get_futex_key+0x48/0x1dc
 [<c0132a8e>] queue_me+0x4f/0xcb
 [<c0132d44>] futex_wait+0x12d/0x193
 [<c0119405>] default_wake_function+0x0/0x12
 [<c0119405>] default_wake_function+0x0/0x12
 [<c016ca61>] pipe_write+0x33/0x37
 [<c013307f>] do_futex+0x6d/0x7d
 [<c013316d>] sys_futex+0xde/0xea
 [<c015ea61>] sys_write+0x5b/0x5d
 [<c0105e25>] sysenter_past_esp+0x52/0x71

mozilla-bin   S F2CFB980  6324  3950   3915          6437  3949 (NOTLB)
f24d9e84 00200086 f5e406d0 f2cfb980 000f9464 c03d1cc0 00000000 c1a22660 
       f24d9e84 00200246 f2cfb980 000f9464 f5e406d0 c1a21ce0 00000000 f2cfb980 
       000f9464 f4e505d0 f4e50788 8014e000 f24d9e8c c0150fe3 056238ab f24d9e98 
Call Trace:
 [<c0150fe3>] find_extend_vma+0x27/0x79
 [<c02cc2f1>] schedule_timeout+0x6e/0xbf
 [<c0126f65>] process_timeout+0x0/0xc
 [<c0132d44>] futex_wait+0x12d/0x193
 [<c0119405>] default_wake_function+0x0/0x12
 [<c0119405>] default_wake_function+0x0/0x12
 [<c016ca61>] pipe_write+0x33/0x37
 [<c013307f>] do_futex+0x6d/0x7d
 [<c013316d>] sys_futex+0xde/0xea
 [<c0105e25>] sysenter_past_esp+0x52/0x71

mozilla-bin   S 00000001  5480  6437   3915                3950 (NOTLB)
ef7d7e84 00200086 c1a29ce0 00000001 0000000f c33b7ee8 ef7d7efc ef7d7e60 
       c013cb1c 0000006f f7ee77f0 c013ce5a 00000000 c1a29ce0 00000000 a1996340 
       000f926b e9de82b0 e9de8468 80103000 ef7d7e8c c0150fe3 fffffff5 7fffffff 
Call Trace:
 [<c013cb1c>] file_read_actor+0x0/0xf2
 [<c013ce5a>] generic_file_aio_read+0x52/0x69
 [<c0150fe3>] find_extend_vma+0x27/0x79
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c0132443>] get_futex_key+0x48/0x1dc
 [<c0132b7c>] unqueue_me+0x72/0x10d
 [<c0132a8e>] queue_me+0x4f/0xcb
 [<c0132d44>] futex_wait+0x12d/0x193
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01326bb>] futex_wake+0x58/0x126
 [<c0119405>] default_wake_function+0x0/0x12
 [<c013307f>] do_futex+0x6d/0x7d
 [<c013316d>] sys_futex+0xde/0xea
 [<c015de72>] sys_close+0x80/0xed
 [<c0105e25>] sysenter_past_esp+0x52/0x71

pan           S 00000001  5080  3960      1  3963    4150  3915 (NOTLB)
f21b5ef8 00000086 c1a19ce0 00000001 0000000f c0140606 00000000 c1a1a660 
       f21b5ef8 00000246 c1a1a660 f21b5f0c f21b5f18 c1a19ce0 00000000 eb99e900 
       000f9465 f2ee9190 f2ee9348 f21b5ef0 f4eb4058 f2f60c64 0562384a f21b5f0c 
Call Trace:
 [<c0140606>] __alloc_pages+0x97/0x2f3
 [<c02cc2f1>] schedule_timeout+0x6e/0xbf
 [<c0126f65>] process_timeout+0x0/0xc
 [<c0173bb2>] do_poll+0x9a/0xb9
 [<c0173d12>] sys_poll+0x141/0x1fc
 [<c0173127>] __pollwait+0x0/0xac
 [<c0105e25>] sysenter_past_esp+0x52/0x71

pan           S 758806C0  5224  3963   3960          3964       (NOTLB)
f2efbe84 00000086 f76b00b0 758806c0 000f74a3 c35c3510 f2efbefc 00000246 
       00000000 c1a11ce0 758806c0 000f74a3 f76b00b0 c1a19ce0 00000000 758806c0 
       000f74a3 f2ee8650 f2ee8808 081b0000 f2efbe8c c0150fe3 fffffff5 7fffffff 
Call Trace:
 [<c0150fe3>] find_extend_vma+0x27/0x79
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c0132443>] get_futex_key+0x48/0x1dc
 [<c0132a8e>] queue_me+0x4f/0xcb
 [<c0132d44>] futex_wait+0x12d/0x193
 [<c0119405>] default_wake_function+0x0/0x12
 [<c013275a>] futex_wake+0xf7/0x126
 [<c0119405>] default_wake_function+0x0/0x12
 [<c02cb767>] schedule+0x377/0x71e
 [<c013307f>] do_futex+0x6d/0x7d
 [<c013316d>] sys_futex+0xde/0xea
 [<c0105e25>] sysenter_past_esp+0x52/0x71

pan           S C16B3120  5100  3964   3960          3965  3963 (NOTLB)
f2ee5e84 00000086 00000001 c16b3120 000196d3 c0324888 00000010 c1020000 
       c0324888 00000096 ffffffff 00000247 f7f740b0 c1a21ce0 00000000 ab1d2dc0 
       000f74a2 f21b3830 f21b39e8 081b0000 f2ee5e8c c0150fe3 fffffff5 7fffffff 
Call Trace:
 [<c0150fe3>] find_extend_vma+0x27/0x79
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c0132443>] get_futex_key+0x48/0x1dc
 [<c0132a8e>] queue_me+0x4f/0xcb
 [<c0132d44>] futex_wait+0x12d/0x193
 [<c0119405>] default_wake_function+0x0/0x12
 [<c013275a>] futex_wake+0xf7/0x126
 [<c0119405>] default_wake_function+0x0/0x12
 [<c0151163>] unmap_vma_list+0x1d/0x2a
 [<c013307f>] do_futex+0x6d/0x7d
 [<c013316d>] sys_futex+0xde/0xea
 [<c0105e25>] sysenter_past_esp+0x52/0x71

pan           S 00000001  5176  3965   3960          3966  3964 (NOTLB)
f24ebe84 00000086 c1a21ce0 00000001 0000000f c0324888 00000010 c1020000 
       c0324888 00000096 ffffffff 00000247 d71fe1f4 c1a21ce0 000186a0 3fb55700 
       000f74a3 f5f4d190 f5f4d348 081b0000 f24ebe8c c0150fe3 fffffff5 7fffffff 
Call Trace:
 [<c0150fe3>] find_extend_vma+0x27/0x79
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c0132443>] get_futex_key+0x48/0x1dc
 [<c0132a8e>] queue_me+0x4f/0xcb
 [<c0132d44>] futex_wait+0x12d/0x193
 [<c0119405>] default_wake_function+0x0/0x12
 [<c013275a>] futex_wake+0xf7/0x126
 [<c0119405>] default_wake_function+0x0/0x12
 [<c0151163>] unmap_vma_list+0x1d/0x2a
 [<c013307f>] do_futex+0x6d/0x7d
 [<c013316d>] sys_futex+0xde/0xea
 [<c0105e25>] sysenter_past_esp+0x52/0x71

pan           D 00000001  5240  3966   3960          3967  3965 (NOTLB)
f24edd68 00000086 c1a11ce0 00000001 0000000f 00000001 c039c388 0000000a 
       f24edd3c c01226f8 c039c388 00000046 00000000 c1a11ce0 000186a0 90884200 
       000f74a3 f6f08b70 f6f08d28 00000000 80000800 f7fffe80 f6fa0b98 f6f08b70 
Call Trace:
 [<c01226f8>] __do_softirq+0xac/0xae
 [<c01c71e9>] rwsem_down_failed_common+0xa4/0x17e
 [<c01162b0>] do_page_fault+0x0/0x542
 [<c02cc3f8>] rwsem_down_read_failed+0x29/0x32
 [<c011680d>] .text.lock.fault+0x1b/0x82
 [<c02779bb>] release_sock+0x6c/0xcb
 [<c0277909>] lock_sock+0x6f/0xb5
 [<c029a6c9>] tcp_recvmsg+0x2e9/0x701
 [<c01162b0>] do_page_fault+0x0/0x542
 [<c0106979>] error_code+0x2d/0x38
 [<c015007b>] vma_link+0x8/0xfd
 [<c0152a1c>] move_one_page+0x32/0x1a1
 [<c0152bc5>] move_page_tables+0x3a/0x4b
 [<c0152c64>] move_vma+0x8e/0x1b4
 [<c015302a>] do_mremap+0x2a0/0x3e8
 [<c01531da>] sys_mremap+0x68/0x8e
 [<c0105e25>] sysenter_past_esp+0x52/0x71

pan           S F74BB118  5080  3967   3960          3968  3966 (NOTLB)
f4d95e84 00000086 00000001 f74bb118 00003dd3 c0324888 00000010 c1020000 
       c0324888 00000096 ffffffff 00000247 f7f740b0 c1a21ce0 000186a0 0b411b40 
       000f74a2 f21b3290 f21b3448 081b0000 f4d95e8c c0150fe3 fffffff5 7fffffff 
Call Trace:
 [<c0150fe3>] find_extend_vma+0x27/0x79
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c0132443>] get_futex_key+0x48/0x1dc
 [<c0132a8e>] queue_me+0x4f/0xcb
 [<c0132d44>] futex_wait+0x12d/0x193
 [<c0119405>] default_wake_function+0x0/0x12
 [<c013275a>] futex_wake+0xf7/0x126
 [<c0119405>] default_wake_function+0x0/0x12
 [<c0118ed6>] scheduler_tick+0x10d/0x63c
 [<c013307f>] do_futex+0x6d/0x7d
 [<c013316d>] sys_futex+0xde/0xea
 [<c01132e0>] smp_apic_timer_interrupt+0xd9/0x141
 [<c0105e25>] sysenter_past_esp+0x52/0x71

pan           D 00000001  5004  3968   3960                3967 (NOTLB)
f2ee3ea8 00000086 c1a29ce0 00000001 0000000f f2ee3e70 c01226f8 c039c388 
       54f7d008 fffc3df4 eef4754c f2ee3ec8 c014eb7b c1a29ce0 000f4240 90978440 
       000f74a3 f21b2750 f21b2908 54f73004 f2ee3f04 f6fa0b78 f6fa0b98 f21b2750 
Call Trace:
 [<c01226f8>] __do_softirq+0xac/0xae
 [<c014eb7b>] do_no_page+0x5d/0x3d5
 [<c01c71e9>] rwsem_down_failed_common+0xa4/0x17e
 [<c01162b0>] do_page_fault+0x0/0x542
 [<c02cc3f8>] rwsem_down_read_failed+0x29/0x32
 [<c011680d>] .text.lock.fault+0x1b/0x82
 [<c0126f65>] process_timeout+0x0/0xc
 [<c0117a5e>] recalc_task_prio+0x90/0x1aa
 [<c0118ed6>] scheduler_tick+0x10d/0x63c
 [<c01226f8>] __do_softirq+0xac/0xae
 [<c01078ae>] do_nmi+0x56/0x58
 [<c01162b0>] do_page_fault+0x0/0x542
 [<c0106979>] error_code+0x2d/0x38

bash          S 00000001  5464  3988   3331  6766    4025  3333 (NOTLB)
cb533f34 00200086 c1a21ce0 00000001 0000000f 3f5fe065 cba290ec f65c02ac 
       00000001 00000001 f65c0278 f65c0298 cb526428 c1a21ce0 00000000 f45a4980 
       000f9295 f21b2cf0 f21b2ea8 00000001 cb532000 cb533f3c fffffe00 f21b2cf0 
Call Trace:
 [<c01215ed>] sys_wait4+0x19b/0x25c
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01c8e86>] copy_to_user+0x50/0x5e
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01216d5>] sys_waitpid+0x27/0x2b
 [<c0105e25>] sysenter_past_esp+0x52/0x71

bash          S 00000001  5420  4025   3331          4073  3988 (NOTLB)
dcb53e30 00200082 c1a19ce0 00000001 0000000f f4ea26f8 f21b21b0 c1a19ce0 
       f7f65fb4 00000016 f5f15000 00000016 dcb53e2c c1a19ce0 00000000 e9642ac0 
       000f9298 f21b21b0 f21b2368 dcb53e48 00000016 00000016 f10a3000 7fffffff 
Call Trace:
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c01fdc30>] read_chan+0x861/0xa1f
 [<c014ddd4>] do_wp_page+0x8d/0x3e5
 [<c01fdf41>] write_chan+0x153/0x219
 [<c0119405>] default_wake_function+0x0/0x12
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01f76a1>] tty_read+0x16a/0x1ab
 [<c015e77e>] vfs_read+0xa1/0x10c
 [<c012a29b>] sys_rt_sigprocmask+0x97/0x140
 [<c015e9e8>] sys_read+0x3f/0x5d
 [<c0105e25>] sysenter_past_esp+0x52/0x71

bash          S 195AEFC0  5416  4073   3331  6196    4248  4025 (NOTLB)
c5ff9f34 00200086 f5ff85d0 195aefc0 000f7250 0438f065 dc8cd430 f4ea24ec 
       00000001 00000001 195aefc0 000f7250 f5ff85d0 c1a11ce0 00000000 195aefc0 
       000f7250 c62ab830 c62ab9e8 00000001 c5ff8000 c5ff9f3c fffffe00 c62ab830 
Call Trace:
 [<c01215ed>] sys_wait4+0x19b/0x25c
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01c8e86>] copy_to_user+0x50/0x5e
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01216d5>] sys_waitpid+0x27/0x2b
 [<c0105e25>] sysenter_past_esp+0x52/0x71

run-mozilla.s S 00000001  5048  4150      1  4164    4170  3960 (NOTLB)
c3e2df34 00200086 c1a19ce0 00000001 0000000f 4b989065 c3d69fc4 c7c2a4ec 
       c3e2df10 c012eff8 c7c2a4b8 c7c2a4d8 cb5262ac c1a19ce0 00000000 57b49680 
       000f428b c94728d0 c9472a88 00000001 080e0d88 c94728d0 fffffe00 c94728d0 
Call Trace:
 [<c012eff8>] attach_pid+0x21/0xd2
 [<c01215ed>] sys_wait4+0x19b/0x25c
 [<c0119405>] default_wake_function+0x0/0x12
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01216d5>] sys_waitpid+0x27/0x2b
 [<c0105e25>] sysenter_past_esp+0x52/0x71

firefox-bin   S 00000001  4620  4164   4150  4168               (NOTLB)
c3d69ef8 00200086 c1a21ce0 00000001 0000000f 00000001 c9472330 00000010 
       00000000 000000d0 00000000 000000d0 f76b00b0 c1a21ce0 00000000 e8807400 
       000f9465 c9472330 c94724e8 c017319d f5c49a68 00200246 00000000 7fffffff 
Call Trace:
 [<c017319d>] __pollwait+0x76/0xac
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c0274a64>] sock_poll+0x29/0x30
 [<c0173ad7>] do_pollfd+0x57/0x98
 [<c0173bb2>] do_poll+0x9a/0xb9
 [<c0173d12>] sys_poll+0x141/0x1fc
 [<c0173127>] __pollwait+0x0/0xac
 [<c0105e25>] sysenter_past_esp+0x52/0x71

firefox-bin   S 00000001  5724  4168   4164          4171       (NOTLB)
c4d27ef8 00200086 c1a21ce0 00000001 0000000f c0140606 c0324680 00000000 
       000000d0 c01078ae 00000001 cf2376b0 00000010 c1a21ce0 00000000 843e2c00 
       000f9463 cf2376b0 cf237868 c4d27ef0 c0140897 00200246 00000000 7fffffff 
Call Trace:
 [<c0140606>] __alloc_pages+0x97/0x2f3
 [<c01078ae>] do_nmi+0x56/0x58
 [<c0140897>] __get_free_pages+0x35/0x40
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c016cb18>] pipe_poll+0x33/0x79
 [<c0173ad7>] do_pollfd+0x57/0x98
 [<c0173bb2>] do_poll+0x9a/0xb9
 [<c0173d12>] sys_poll+0x141/0x1fc
 [<c015ea04>] sys_read+0x5b/0x5d
 [<c0173127>] __pollwait+0x0/0xac
 [<c0105e25>] sysenter_past_esp+0x52/0x71

firefox-bin   S 00000001  5936  4171   4164                4168 (NOTLB)
c772de84 00200086 c1a19ce0 00000001 0000000f c772de98 00000000 c1a1a660 
       c772de84 00200246 c1a1a660 c772de98 f76b00b0 c1a19ce0 00000000 e87131c0 
       000f9465 f6fd68d0 f6fd6a88 08aee000 c772de8c c0150fe3 05623885 c772de98 
Call Trace:
 [<c0150fe3>] find_extend_vma+0x27/0x79
 [<c02cc2f1>] schedule_timeout+0x6e/0xbf
 [<c0126f65>] process_timeout+0x0/0xc
 [<c0132d44>] futex_wait+0x12d/0x193
 [<c0119405>] default_wake_function+0x0/0x12
 [<c0119405>] default_wake_function+0x0/0x12
 [<c016ca61>] pipe_write+0x33/0x37
 [<c013307f>] do_futex+0x6d/0x7d
 [<c013316d>] sys_futex+0xde/0xea
 [<c0105e25>] sysenter_past_esp+0x52/0x71

gconfd-2      S 00000001  5364  4170      1                4150 (NOTLB)
c70a9ef8 00200086 c1a11ce0 00000001 0000000f c0140606 00000000 c1a12660 
       c70a9ef8 00200246 c1a12660 c70a9f0c c70a9f18 c1a11ce0 00000000 8591a580 
       000f944c f66fd8b0 f66fda68 c70a9ef0 f5c49c00 c62b5730 056261c5 c70a9f0c 
Call Trace:
 [<c0140606>] __alloc_pages+0x97/0x2f3
 [<c02cc2f1>] schedule_timeout+0x6e/0xbf
 [<c0126f65>] process_timeout+0x0/0xc
 [<c0173bb2>] do_poll+0x9a/0xb9
 [<c0173d12>] sys_poll+0x141/0x1fc
 [<c0173127>] __pollwait+0x0/0xac
 [<c0105e25>] sysenter_past_esp+0x52/0x71

bash          S 00000001  5440  4248   3331          4364  4073 (NOTLB)
ca437e30 00200086 c1a21ce0 00000001 0000000f f6ee54b8 f66fd310 c1a21ce0 
       f7f73fb4 00000013 c581a000 00000013 ca437e2c c1a21ce0 00000000 65b11880 
       000f924a f66fd310 f66fd4c8 ca437e48 00000013 00000013 cde37000 7fffffff 
Call Trace:
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c01fdc30>] read_chan+0x861/0xa1f
 [<c014ddd4>] do_wp_page+0x8d/0x3e5
 [<c01fdf41>] write_chan+0x153/0x219
 [<c0119405>] default_wake_function+0x0/0x12
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01f76a1>] tty_read+0x16a/0x1ab
 [<c015e77e>] vfs_read+0xa1/0x10c
 [<c012a29b>] sys_rt_sigprocmask+0x97/0x140
 [<c015e9e8>] sys_read+0x3f/0x5d
 [<c0105e25>] sysenter_past_esp+0x52/0x71

bash          S 376C7680  5364  4364   3331  5002    4403  4248 (NOTLB)
cb55bf34 00200082 c94739b0 376c7680 000f50ce 0cb3c065 dc8cddb0 f71ed96c 
       00000001 00000001 376c7680 000f50ce c94739b0 c1a19ce0 00000000 376c7680 
       000f50ce f66fc7d0 f66fc988 00000001 cb55a000 cb55bf3c fffffe00 f66fc7d0 
Call Trace:
 [<c01215ed>] sys_wait4+0x19b/0x25c
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01c8e86>] copy_to_user+0x50/0x5e
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01216d5>] sys_waitpid+0x27/0x2b
 [<c0105e25>] sysenter_past_esp+0x52/0x71

bash          S 00000001  5308  4403   3331          6236  4364 (NOTLB)
c6c9fe30 00200082 c1a19ce0 00000001 0000000f 00000000 000004d2 00000000 
       00000002 00000013 f1081000 00000013 c6c9fe2c c1a19ce0 0001b207 4de56a40 
       000f725f f2ee80b0 f2ee8268 c6c9fe48 00000013 00000013 f0dda000 7fffffff 
Call Trace:
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c020245d>] con_get_trans_new+0x1c/0x56
 [<c01fdc30>] read_chan+0x861/0xa1f
 [<c014ddd4>] do_wp_page+0x8d/0x3e5
 [<c01fdf41>] write_chan+0x153/0x219
 [<c0119405>] default_wake_function+0x0/0x12
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01f76a1>] tty_read+0x16a/0x1ab
 [<c015e77e>] vfs_read+0xa1/0x10c
 [<c012a29b>] sys_rt_sigprocmask+0x97/0x140
 [<c015e9e8>] sys_read+0x3f/0x5d
 [<c0105e25>] sysenter_past_esp+0x52/0x71

rlogin        S 00000001  6204  5002   4364  5003               (NOTLB)
c3b73e30 00200086 c1a21ce0 00000001 0000000f f6c423c0 c3b73e68 c0299234 
       f6c421b8 00000000 00000001 00000000 00000000 c1a21ce0 00000000 f4c9a2c0 
       000f50ce c94739b0 c9473b68 00000000 efae17e0 f75cb92c f589f000 7fffffff 
Call Trace:
 [<c0299234>] tcp_sendmsg+0x479/0x1127
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c02bb201>] inet_sendmsg+0x4b/0x56
 [<c01fdc30>] read_chan+0x861/0xa1f
 [<c015e872>] do_sync_write+0x89/0xb4
 [<c0119405>] default_wake_function+0x0/0x12
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01f76a1>] tty_read+0x16a/0x1ab
 [<c015e77e>] vfs_read+0xa1/0x10c
 [<c010685c>] common_interrupt+0x18/0x20
 [<c015e9e8>] sys_read+0x3f/0x5d
 [<c0105e25>] sysenter_past_esp+0x52/0x71

rlogin        S 00000001  6016  5003   5002                     (NOTLB)
f3283d50 00200086 c1a19ce0 00000001 0000000f c01fbc40 f75cb000 0000001d 
       00020001 f6c423c0 f75cbc14 00010800 00200202 c1a19ce0 00000000 4e7bbe00 
       000f9465 c9472e70 c9473028 0000001d 00020001 f752bafc f6c421b8 7fffffff 
Call Trace:
 [<c01fbc40>] n_tty_receive_buf+0x1b2/0x1670
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c0277d19>] kfree_skbmem+0x25/0x2c
 [<c0277d93>] __kfree_skb+0x73/0xdf
 [<c02779bb>] release_sock+0x6c/0xcb
 [<c02a1df8>] tcp_rcv_established+0x141/0x74f
 [<c029a1a7>] tcp_data_wait+0xab/0xaf
 [<c011b4c4>] autoremove_wake_function+0x0/0x4b
 [<c011b4c4>] autoremove_wake_function+0x0/0x4b
 [<c029a753>] tcp_recvmsg+0x373/0x701
 [<c02bb19e>] inet_recvmsg+0x54/0x6c
 [<c027437b>] sock_aio_read+0xbe/0xd1
 [<c015e6b2>] do_sync_read+0x89/0xb4
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01fddee>] write_chan+0x0/0x219
 [<c02cb767>] schedule+0x377/0x71e
 [<c015e7b5>] vfs_read+0xd8/0x10c
 [<c015e9e8>] sys_read+0x3f/0x5d
 [<c0105e25>] sysenter_past_esp+0x52/0x71

rlogin        S EBC6FDEB  6244  6196   4073  6197               (NOTLB)
e844fe30 00200082 f6edec70 ebc6fdeb 000f7250 f679c240 e844fe68 c0299234 
       f679c038 00000000 ebc6fdeb 000f7250 f6edec70 c1a19ce0 00000000 ebd1b880 
       000f7250 f5ff85d0 f5ff8788 00000000 dcc84fd4 f7c6d92c f5b17000 7fffffff 
Call Trace:
 [<c0299234>] tcp_sendmsg+0x479/0x1127
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c02bb201>] inet_sendmsg+0x4b/0x56
 [<c01fdc30>] read_chan+0x861/0xa1f
 [<c015e872>] do_sync_write+0x89/0xb4
 [<c0119405>] default_wake_function+0x0/0x12
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01f76a1>] tty_read+0x16a/0x1ab
 [<c015e77e>] vfs_read+0xa1/0x10c
 [<c015e9e8>] sys_read+0x3f/0x5d
 [<c0105e25>] sysenter_past_esp+0x52/0x71

rlogin        S 00000001  6296  6197   6196                     (NOTLB)
cc53dd50 00200082 c1a19ce0 00000001 0000000f c01fbc40 f7c6d000 0000001d 
       00020001 f679c240 f7c6dc14 00010800 00200202 c1a19ce0 00000000 9d666100 
       000f9465 cf236030 cf2361e8 00000100 c0277d19 f720855c f679c038 7fffffff 
Call Trace:
 [<c01fbc40>] n_tty_receive_buf+0x1b2/0x1670
 [<c0277d19>] kfree_skbmem+0x25/0x2c
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c0277d19>] kfree_skbmem+0x25/0x2c
 [<c0277d93>] __kfree_skb+0x73/0xdf
 [<c02779bb>] release_sock+0x6c/0xcb
 [<c02a1df8>] tcp_rcv_established+0x141/0x74f
 [<c029a1a7>] tcp_data_wait+0xab/0xaf
 [<c011b4c4>] autoremove_wake_function+0x0/0x4b
 [<c011b4c4>] autoremove_wake_function+0x0/0x4b
 [<c029a753>] tcp_recvmsg+0x373/0x701
 [<c02bb19e>] inet_recvmsg+0x54/0x6c
 [<c027437b>] sock_aio_read+0xbe/0xd1
 [<c015e6b2>] do_sync_read+0x89/0xb4
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01fddee>] write_chan+0x0/0x219
 [<c02cb767>] schedule+0x377/0x71e
 [<c015e7b5>] vfs_read+0xd8/0x10c
 [<c015e9e8>] sys_read+0x3f/0x5d
 [<c0105e25>] sysenter_past_esp+0x52/0x71

bash          S 00000001  5436  6236   3331                4403 (NOTLB)
d41cfe30 00200086 c1a21ce0 00000001 0000000f 0000000f c0325210 c0324e80 
       d41cfe18 00000011 f08ca000 00000011 d41cfe2c c1a21ce0 0001e848 b9c33c00 
       000f7369 f72921b0 f7292368 d41cfe48 00000011 00000011 d6c9b000 7fffffff 
Call Trace:
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c01fdc30>] read_chan+0x861/0xa1f
 [<c014ddd4>] do_wp_page+0x8d/0x3e5
 [<c01fdf41>] write_chan+0x153/0x219
 [<c0119405>] default_wake_function+0x0/0x12
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01f76a1>] tty_read+0x16a/0x1ab
 [<c015e77e>] vfs_read+0xa1/0x10c
 [<c012a29b>] sys_rt_sigprocmask+0x97/0x140
 [<c015e9e8>] sys_read+0x3f/0x5d
 [<c0105e25>] sysenter_past_esp+0x52/0x71

pdflush       S 9D389A40  4972  6344     13                     (L-TLB)
dbddbf5c 00000046 f5d6acf0 9d389a40 000f9465 00000000 00000000 00000000 
       00000000 00000000 9d389a40 000f9465 f5d6acf0 c1a21ce0 00000000 9d389a40 
       000f9465 c9473410 c94735c8 00000000 00000000 00000000 dbdda000 dbddbfa8 
Call Trace:
 [<c0142780>] __pdflush+0xbc/0x312
 [<c0142a00>] pdflush+0x2a/0x2e
 [<c0132104>] kthread+0xb7/0xbc
 [<c01429d6>] pdflush+0x0/0x2e
 [<c013204d>] kthread+0x0/0xbc
 [<c0104021>] kernel_thread_helper+0x5/0xb

pdflush       S 00000001  5452  6355     11                     (L-TLB)
c54c7f5c 00000046 c1a21ce0 00000001 0000000f 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 c1a21ce0 00000000 d9730b00 
       000f9436 e9de9930 e9de9ae8 00000000 00000000 00000000 c54c6000 c54c7fa8 
Call Trace:
 [<c0142780>] __pdflush+0xbc/0x312
 [<c0142a00>] pdflush+0x2a/0x2e
 [<c0132104>] kthread+0xb7/0xbc
 [<c01429d6>] pdflush+0x0/0x2e
 [<c013204d>] kthread+0x0/0xbc
 [<c0104021>] kernel_thread_helper+0x5/0xb

ps            D 00000001  5608  6766   3988                     (NOTLB)
f4bc7db8 00200082 c1a21ce0 00000001 0000000f c1a236fc f7fefee0 00000000 
       0000016f 00200246 00000000 00000170 c018d9aa c1a21ce0 005b8d80 f78300c0 
       000f9295 eae98650 eae98808 00000001 00000000 f7c30644 f6fa0b98 eae98650 
Call Trace:
 [<c018d9aa>] proc_alloc_inode+0x1e/0x73
 [<c01c71e9>] rwsem_down_failed_common+0xa4/0x17e
 [<c017a380>] alloc_inode+0x1c/0x141
 [<c02cc3f8>] rwsem_down_read_failed+0x29/0x32
 [<c0192bde>] .text.lock.array+0x5b/0xcd
 [<c018f938>] pid_revalidate+0x23/0x112
 [<c018f951>] pid_revalidate+0x3c/0x112
 [<c01777f7>] dput+0x24/0x2ca
 [<c016e3c0>] link_path_walk+0x713/0xb1c
 [<c014042b>] buffered_rmqueue+0xf5/0x239
 [<c018ec72>] proc_info_read+0x53/0x10e
 [<c015d7de>] filp_open+0x5d/0x5f
 [<c015e77e>] vfs_read+0xa1/0x10c
 [<c015e9e8>] sys_read+0x3f/0x5d
 [<c0105e25>] sysenter_past_esp+0x52/0x71

bash          S ABA88D80  6440  6770   3114  6837               (NOTLB)
c221df34 00000086 f76b5110 aba88d80 000f92a1 44d9f065 cba29988 f70064ec 
       00000001 00000001 aba88d80 000f92a1 f76b5110 c1a19ce0 00000000 aba88d80 
       000f92a1 e9de8850 e9de8a08 00000001 c221c000 c221df3c fffffe00 e9de8850 
Call Trace:
 [<c01215ed>] sys_wait4+0x19b/0x25c
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01c8e86>] copy_to_user+0x50/0x5e
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01216d5>] sys_waitpid+0x27/0x2b
 [<c0105e25>] sysenter_past_esp+0x52/0x71

ps            D 00000001  6440  6837   6770                     (NOTLB)
c3f8bdb8 00000086 c1a19ce0 00000001 0000000f c03ca104 00000000 00000002 
       c01162b0 c3f8bdd8 c0106979 c3f8bd88 00000002 c1a19ce0 004c4b40 ad16c380 
       000f92a1 f76b5110 f76b52c8 c8763132 00000000 c3f8bde8 f6fa0b98 f76b5110 
Call Trace:
 [<c01162b0>] do_page_fault+0x0/0x542
 [<c0106979>] error_code+0x2d/0x38
 [<c01c71e9>] rwsem_down_failed_common+0xa4/0x17e
 [<c02cc3f8>] rwsem_down_read_failed+0x29/0x32
 [<c0192bde>] .text.lock.array+0x5b/0xcd
 [<c018f938>] pid_revalidate+0x23/0x112
 [<c018f951>] pid_revalidate+0x3c/0x112
 [<c01777f7>] dput+0x24/0x2ca
 [<c016e3c0>] link_path_walk+0x713/0xb1c
 [<c012d4df>] in_group_p+0x43/0x76
 [<c014042b>] buffered_rmqueue+0xf5/0x239
 [<c018ec72>] proc_info_read+0x53/0x10e
 [<c015d7de>] filp_open+0x5d/0x5f
 [<c015e77e>] vfs_read+0xa1/0x10c
 [<c015e9e8>] sys_read+0x3f/0x5d
 [<c0105e25>] sysenter_past_esp+0x52/0x71

bash          S 00000001  6440  6838   3115  6902               (NOTLB)
f4b8df34 00000082 c1a11ce0 00000001 0000000f 43c9a065 f4e5c34c f7c3406c 
       00000001 00000001 f7c34038 f7c34058 f220d89c c1a11ce0 00000000 2eb0dc40 
       000f92ad c62aa1b0 c62aa368 00000001 f4b8c000 f4b8df3c fffffe00 c62aa1b0 
Call Trace:
 [<c01215ed>] sys_wait4+0x19b/0x25c
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01c8e86>] copy_to_user+0x50/0x5e
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01216d5>] sys_waitpid+0x27/0x2b
 [<c0105e25>] sysenter_past_esp+0x52/0x71

strace        S 396B7140  5848  6902   6838  6903               (NOTLB)
d6ceff4c 00000086 f7292750 396b7140 000f92ad 00017d0e 00000000 c172f1c0 
       ff8085b0 d6ceff30 396b7140 000f92ad f7292750 c1a21ce0 00000000 396b7140 
       000f92ad f66fc230 f66fc3e8 00000282 f7292750 396b7140 fffffe00 f66fc230 
Call Trace:
 [<c01215ed>] sys_wait4+0x19b/0x25c
 [<c0119405>] default_wake_function+0x0/0x12
 [<c0119405>] default_wake_function+0x0/0x12
 [<c0105e25>] sysenter_past_esp+0x52/0x71

ps            D 00000001  6656  6903   6902                     (NOTLB)
f4b57db8 00000086 c1a21ce0 00000001 0000000f 00000001 00000000 00000002 
       c01162b0 f4b57dd8 c0106979 f4b57d88 00000002 c1a21ce0 00000000 396b7140 
       000f92ad f7292750 f7292908 dbe13132 00000000 f4b57de8 f6fa0b98 f7292750 
Call Trace:
 [<c01162b0>] do_page_fault+0x0/0x542
 [<c0106979>] error_code+0x2d/0x38
 [<c01c71e9>] rwsem_down_failed_common+0xa4/0x17e
 [<c014042b>] buffered_rmqueue+0xf5/0x239
 [<c02cc3f8>] rwsem_down_read_failed+0x29/0x32
 [<c0192bde>] .text.lock.array+0x5b/0xcd
 [<c011944f>] __wake_up_common+0x38/0x57
 [<c0128889>] __group_send_sig_info+0x59/0xd2
 [<c01293e6>] __wake_up_parent+0x37/0x6f
 [<c014042b>] buffered_rmqueue+0xf5/0x239
 [<c018ec72>] proc_info_read+0x53/0x10e
 [<c015e77e>] vfs_read+0xa1/0x10c
 [<c015e9e8>] sys_read+0x3f/0x5d
 [<c0105e77>] syscall_call+0x7/0xb

bash          S 2BE3BBC0  5480  6904   3116  6972               (NOTLB)
d6a19f34 00000086 eae99190 2be3bbc0 000f941c 4f22f065 cba29398 c7c2abac 
       00000001 00000001 2be3bbc0 000f941c eae99190 c1a11ce0 00000000 2be3bbc0 
       000f941c f76b0650 f76b0808 00000001 d6a18000 d6a19f3c fffffe00 f76b0650 
Call Trace:
 [<c01215ed>] sys_wait4+0x19b/0x25c
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01c8e86>] copy_to_user+0x50/0x5e
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01216d5>] sys_waitpid+0x27/0x2b
 [<c0105e25>] sysenter_past_esp+0x52/0x71

emacs         T 7E70A840  5340  6972   6904  7026    7092       (NOTLB)
f4b8fe98 00000082 f76b0650 7e70a840 000f941b 00000000 00000086 00000800 
       f71a3084 f7ff5080 7e70a840 000f941b f76b0650 c1a21ce0 00000000 7e70a840 
       000f941b f7d41310 f7d414c8 00000082 00000014 f71a3f24 f6f9356c f7c83a58 
Call Trace:
 [<c012983e>] finish_stop+0x5e/0xce
 [<c012991e>] do_signal_stop+0x70/0x2fa
 [<c011f446>] will_become_orphaned_pgrp+0x20/0x98
 [<c0129e56>] get_signal_to_deliver+0x2ae/0x4f6
 [<c0128ac7>] __kill_pg_info+0x53/0x84
 [<c0105c12>] do_signal+0x6c/0xf1
 [<c01f9d02>] tty_ioctl+0x3b6/0x4c6
 [<c01f9d02>] tty_ioctl+0x3b6/0x4c6
 [<c01729f6>] sys_ioctl+0x104/0x2cd
 [<c012f1ec>] find_task_by_pid+0xd/0x20
 [<c012cc1b>] sys_setpgid+0x62/0x1cc
 [<c0105cd2>] do_notify_resume+0x3b/0x3d
 [<c0105ec2>] work_notifysig+0x13/0x15

bash          S F10C4200  6440  7026   6972  7056               (NOTLB)
d6b03f34 00000086 eae980b0 f10c4200 000f937c 00000000 f5c7a3e4 f5c7a3dc 
       00000001 00000001 f10c4200 000f937c eae980b0 c1a19ce0 00000000 f10c4200 
       000f937c f6f085d0 f6f08788 00010800 d6b02000 d6b03f3c fffffe00 f6f085d0 
Call Trace:
 [<c01215ed>] sys_wait4+0x19b/0x25c
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01c8e86>] copy_to_user+0x50/0x5e
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01216d5>] sys_waitpid+0x27/0x2b
 [<c0105e25>] sysenter_past_esp+0x52/0x71

gdb           S 00000001  5416  7056   7026                     (NOTLB)
d6f2bef8 00000086 c1a19ce0 00000001 0000000f 00000010 00000000 000000d0 
       00000006 00000246 d4819d98 d6f2bfa0 00000246 c1a19ce0 00000000 62045d80 
       000f93a5 eae980b0 eae98268 d6f2beec c01ff066 e5ba0000 00000000 7fffffff 
Call Trace:
 [<c01ff066>] pty_write_room+0x2c/0x2e
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c01f8f56>] tty_poll+0x69/0x77
 [<c0173ad7>] do_pollfd+0x57/0x98
 [<c0173bb2>] do_poll+0x9a/0xb9
 [<c0173d12>] sys_poll+0x141/0x1fc
 [<c0173127>] __pollwait+0x0/0xac
 [<c0105e25>] sysenter_past_esp+0x52/0x71

ps            D 00000001  6440  7092   6904                6972 (NOTLB)
f6b1fdb8 00000086 c1a11ce0 00000001 0000000f f6b1fd88 00000000 00000002 
       c01162b0 f6b1fdd8 c0106979 f6b1fd88 00000002 c1a11ce0 004c4b40 2d613400 
       000f941c eae99190 eae99348 c0324e80 f6b1fdd0 00000096 f6fa0b98 eae99190 
Call Trace:
 [<c01162b0>] do_page_fault+0x0/0x542
 [<c0106979>] error_code+0x2d/0x38
 [<c01c71e9>] rwsem_down_failed_common+0xa4/0x17e
 [<c014042b>] buffered_rmqueue+0xf5/0x239
 [<c02cc3f8>] rwsem_down_read_failed+0x29/0x32
 [<c0192bde>] .text.lock.array+0x5b/0xcd
 [<c018f938>] pid_revalidate+0x23/0x112
 [<c018f951>] pid_revalidate+0x3c/0x112
 [<c01777f7>] dput+0x24/0x2ca
 [<c016e3c0>] link_path_walk+0x713/0xb1c
 [<c012d4df>] in_group_p+0x43/0x76
 [<c014042b>] buffered_rmqueue+0xf5/0x239
 [<c018ec72>] proc_info_read+0x53/0x10e
 [<c015d7de>] filp_open+0x5d/0x5f
 [<c015e77e>] vfs_read+0xa1/0x10c
 [<c015e9e8>] sys_read+0x3f/0x5d
 [<c0105e25>] sysenter_past_esp+0x52/0x71

bash          S 00000001  6440  7093   3117  7182               (NOTLB)
cc165e30 00000086 c1a21ce0 00000001 0000000f f7561000 cc165e58 cc165dfc 
       c0205b06 00000282 00000001 f7561000 cc165e0c c1a21ce0 00000000 3052cb80 
       000f9465 c62aacf0 c62aaea8 00000000 cc165e58 00000010 f7561000 7fffffff 
Call Trace:
 [<c0205b06>] set_cursor+0x75/0x8c
 [<c02cc340>] schedule_timeout+0xbd/0xbf
 [<c0261846>] vgacon_cursor+0x10a/0x26e
 [<c01fdc30>] read_chan+0x861/0xa1f
 [<c01fdf41>] write_chan+0x153/0x219
 [<c0119405>] default_wake_function+0x0/0x12
 [<c0119405>] default_wake_function+0x0/0x12
 [<c01f76a1>] tty_read+0x16a/0x1ab
 [<c015e77e>] vfs_read+0xa1/0x10c
 [<c012a29b>] sys_rt_sigprocmask+0x97/0x140
 [<c015e9e8>] sys_read+0x3f/0x5d
 [<c0105e25>] sysenter_past_esp+0x52/0x71

emacs         T 00000001  6032  7182   7093                     (NOTLB)
ce3a3e98 00000086 c1a11ce0 00000001 0000000f 00000000 00000086 00000800 
       f71a3084 f7ff5080 ce3a3e90 00000082 f7ff5080 c1a11ce0 000f4240 6235e700 
       000f9464 f508f390 f508f548 00000082 00000014 f71a3744 f687c1d0 f7d76540 
Call Trace:
 [<c012983e>] finish_stop+0x5e/0xce
 [<c012991e>] do_signal_stop+0x70/0x2fa
 [<c011f446>] will_become_orphaned_pgrp+0x20/0x98
 [<c0129e56>] get_signal_to_deliver+0x2ae/0x4f6
 [<c0128ac7>] __kill_pg_info+0x53/0x84
 [<c0105c12>] do_signal+0x6c/0xf1
 [<c01f9d02>] tty_ioctl+0x3b6/0x4c6
 [<c01f9d02>] tty_ioctl+0x3b6/0x4c6
 [<c01729f6>] sys_ioctl+0x104/0x2cd
 [<c01078ae>] do_nmi+0x56/0x58
 [<c0105cd2>] do_notify_resume+0x3b/0x3d
 [<c0105ec2>] work_notifysig+0x13/0x15

--0-23523166-1082168259=:77519
Content-Type: application/octet-stream; name=".config"
Content-Transfer-Encoding: base64
Content-Description: .config
Content-Disposition: attachment; filename=".config"

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24n
dCBlZGl0CiMKQ09ORklHX1g4Nj15CkNPTkZJR19NTVU9eQpDT05GSUdfVUlE
MTY9eQpDT05GSUdfR0VORVJJQ19JU0FfRE1BPXkKCiMKIyBDb2RlIG1hdHVy
aXR5IGxldmVsIG9wdGlvbnMKIwpDT05GSUdfRVhQRVJJTUVOVEFMPXkKQ09O
RklHX0NMRUFOX0NPTVBJTEU9eQpDT05GSUdfU1RBTkRBTE9ORT15CgojCiMg
R2VuZXJhbCBzZXR1cAojCkNPTkZJR19TV0FQPXkKQ09ORklHX1NZU1ZJUEM9
eQpDT05GSUdfUE9TSVhfTVFVRVVFPXkKQ09ORklHX0JTRF9QUk9DRVNTX0FD
Q1Q9eQpDT05GSUdfU1lTQ1RMPXkKQ09ORklHX0FVRElUPXkKQ09ORklHX0FV
RElUU1lTQ0FMTD15CkNPTkZJR19MT0dfQlVGX1NISUZUPTE1CkNPTkZJR19I
T1RQTFVHPXkKQ09ORklHX0lLQ09ORklHPXkKQ09ORklHX0lLQ09ORklHX1BS
T0M9eQojIENPTkZJR19FTUJFRERFRCBpcyBub3Qgc2V0CkNPTkZJR19LQUxM
U1lNUz15CkNPTkZJR19GVVRFWD15CkNPTkZJR19FUE9MTD15CkNPTkZJR19J
T1NDSEVEX05PT1A9eQpDT05GSUdfSU9TQ0hFRF9BUz15CkNPTkZJR19JT1ND
SEVEX0RFQURMSU5FPXkKQ09ORklHX0lPU0NIRURfQ0ZRPXkKIyBDT05GSUdf
Q0NfT1BUSU1JWkVfRk9SX1NJWkUgaXMgbm90IHNldAoKIwojIExvYWRhYmxl
IG1vZHVsZSBzdXBwb3J0CiMKQ09ORklHX01PRFVMRVM9eQpDT05GSUdfTU9E
VUxFX1VOTE9BRD15CiMgQ09ORklHX01PRFVMRV9GT1JDRV9VTkxPQUQgaXMg
bm90IHNldApDT05GSUdfT0JTT0xFVEVfTU9EUEFSTT15CiMgQ09ORklHX01P
RFZFUlNJT05TIGlzIG5vdCBzZXQKQ09ORklHX0tNT0Q9eQpDT05GSUdfU1RP
UF9NQUNISU5FPXkKCiMKIyBQcm9jZXNzb3IgdHlwZSBhbmQgZmVhdHVyZXMK
IwpDT05GSUdfWDg2X1BDPXkKIyBDT05GSUdfWDg2X0VMQU4gaXMgbm90IHNl
dAojIENPTkZJR19YODZfVk9ZQUdFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1g4
Nl9OVU1BUSBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9TVU1NSVQgaXMgbm90
IHNldAojIENPTkZJR19YODZfQklHU01QIGlzIG5vdCBzZXQKIyBDT05GSUdf
WDg2X1ZJU1dTIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0dFTkVSSUNBUkNI
IGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0VTNzAwMCBpcyBub3Qgc2V0CiMg
Q09ORklHX00zODYgaXMgbm90IHNldAojIENPTkZJR19NNDg2IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTTU4NiBpcyBub3Qgc2V0CiMgQ09ORklHX001ODZUU0Mg
aXMgbm90IHNldAojIENPTkZJR19NNTg2TU1YIGlzIG5vdCBzZXQKIyBDT05G
SUdfTTY4NiBpcyBub3Qgc2V0CiMgQ09ORklHX01QRU5USVVNSUkgaXMgbm90
IHNldAojIENPTkZJR19NUEVOVElVTUlJSSBpcyBub3Qgc2V0CiMgQ09ORklH
X01QRU5USVVNTSBpcyBub3Qgc2V0CkNPTkZJR19NUEVOVElVTTQ9eQojIENP
TkZJR19NSzYgaXMgbm90IHNldAojIENPTkZJR19NSzcgaXMgbm90IHNldAoj
IENPTkZJR19NSzggaXMgbm90IHNldAojIENPTkZJR19NQ1JVU09FIGlzIG5v
dCBzZXQKIyBDT05GSUdfTVdJTkNISVBDNiBpcyBub3Qgc2V0CiMgQ09ORklH
X01XSU5DSElQMiBpcyBub3Qgc2V0CiMgQ09ORklHX01XSU5DSElQM0QgaXMg
bm90IHNldAojIENPTkZJR19NQ1lSSVhJSUkgaXMgbm90IHNldAojIENPTkZJ
R19NVklBQzNfMiBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9HRU5FUklDIGlz
IG5vdCBzZXQKQ09ORklHX1g4Nl9DTVBYQ0hHPXkKQ09ORklHX1g4Nl9YQURE
PXkKQ09ORklHX1g4Nl9MMV9DQUNIRV9TSElGVD03CkNPTkZJR19SV1NFTV9Y
Q0hHQUREX0FMR09SSVRITT15CkNPTkZJR19YODZfV1BfV09SS1NfT0s9eQpD
T05GSUdfWDg2X0lOVkxQRz15CkNPTkZJR19YODZfQlNXQVA9eQpDT05GSUdf
WDg2X1BPUEFEX09LPXkKQ09ORklHX1g4Nl9HT09EX0FQSUM9eQpDT05GSUdf
WDg2X0lOVEVMX1VTRVJDT1BZPXkKQ09ORklHX1g4Nl9VU0VfUFBST19DSEVD
S1NVTT15CkNPTkZJR19IUEVUX1RJTUVSPXkKIyBDT05GSUdfSFBFVF9FTVVM
QVRFX1JUQyBpcyBub3Qgc2V0CkNPTkZJR19TTVA9eQpDT05GSUdfTlJfQ1BV
Uz04CiMgQ09ORklHX1BSRUVNUFQgaXMgbm90IHNldApDT05GSUdfWDg2X0xP
Q0FMX0FQSUM9eQpDT05GSUdfWDg2X0lPX0FQSUM9eQpDT05GSUdfWDg2X1RT
Qz15CkNPTkZJR19YODZfTUNFPXkKQ09ORklHX1g4Nl9NQ0VfTk9ORkFUQUw9
eQpDT05GSUdfWDg2X01DRV9QNFRIRVJNQUw9eQojIENPTkZJR19UT1NISUJB
IGlzIG5vdCBzZXQKIyBDT05GSUdfSThLIGlzIG5vdCBzZXQKQ09ORklHX01J
Q1JPQ09ERT1tCkNPTkZJR19YODZfTVNSPW0KQ09ORklHX1g4Nl9DUFVJRD1t
CgojCiMgRmlybXdhcmUgRHJpdmVycwojCiMgQ09ORklHX0VERCBpcyBub3Qg
c2V0CiMgQ09ORklHX05PSElHSE1FTSBpcyBub3Qgc2V0CkNPTkZJR19ISUdI
TUVNNEc9eQojIENPTkZJR19ISUdITUVNNjRHIGlzIG5vdCBzZXQKQ09ORklH
X0hJR0hNRU09eQpDT05GSUdfSElHSFBURT15CiMgQ09ORklHX01BVEhfRU1V
TEFUSU9OIGlzIG5vdCBzZXQKQ09ORklHX01UUlI9eQojIENPTkZJR19FRkkg
aXMgbm90IHNldApDT05GSUdfSVJRQkFMQU5DRT15CkNPTkZJR19IQVZFX0RF
Q19MT0NLPXkKIyBDT05GSUdfUkVHUEFSTSBpcyBub3Qgc2V0CgojCiMgUG93
ZXIgbWFuYWdlbWVudCBvcHRpb25zIChBQ1BJLCBBUE0pCiMKQ09ORklHX1BN
PXkKIyBDT05GSUdfU09GVFdBUkVfU1VTUEVORCBpcyBub3Qgc2V0CiMgQ09O
RklHX1BNX0RJU0sgaXMgbm90IHNldAoKIwojIEFDUEkgKEFkdmFuY2VkIENv
bmZpZ3VyYXRpb24gYW5kIFBvd2VyIEludGVyZmFjZSkgU3VwcG9ydAojCkNP
TkZJR19BQ1BJPXkKQ09ORklHX0FDUElfQk9PVD15CkNPTkZJR19BQ1BJX0lO
VEVSUFJFVEVSPXkKIyBDT05GSUdfQUNQSV9TTEVFUCBpcyBub3Qgc2V0CkNP
TkZJR19BQ1BJX0FDPW0KQ09ORklHX0FDUElfQkFUVEVSWT1tCkNPTkZJR19B
Q1BJX0JVVFRPTj1tCkNPTkZJR19BQ1BJX0ZBTj1tCkNPTkZJR19BQ1BJX1BS
T0NFU1NPUj1tCkNPTkZJR19BQ1BJX1RIRVJNQUw9bQojIENPTkZJR19BQ1BJ
X0FTVVMgaXMgbm90IHNldAojIENPTkZJR19BQ1BJX1RPU0hJQkEgaXMgbm90
IHNldAojIENPTkZJR19BQ1BJX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX0FD
UElfQlVTPXkKQ09ORklHX0FDUElfRUM9eQpDT05GSUdfQUNQSV9QT1dFUj15
CkNPTkZJR19BQ1BJX1BDST15CkNPTkZJR19BQ1BJX1NZU1RFTT15CkNPTkZJ
R19YODZfUE1fVElNRVI9eQoKIwojIEFQTSAoQWR2YW5jZWQgUG93ZXIgTWFu
YWdlbWVudCkgQklPUyBTdXBwb3J0CiMKIyBDT05GSUdfQVBNIGlzIG5vdCBz
ZXQKCiMKIyBDUFUgRnJlcXVlbmN5IHNjYWxpbmcKIwojIENPTkZJR19DUFVf
RlJFUSBpcyBub3Qgc2V0CiMgQ09ORklHX0NQVV9GUkVRX0RFRkFVTFRfR09W
X1BFUkZPUk1BTkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BVX0ZSRVFfREVG
QVVMVF9HT1ZfVVNFUlNQQUNFIGlzIG5vdCBzZXQKCiMKIyBCdXMgb3B0aW9u
cyAoUENJLCBQQ01DSUEsIEVJU0EsIE1DQSwgSVNBKQojCkNPTkZJR19QQ0k9
eQojIENPTkZJR19QQ0lfR09CSU9TIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJ
X0dPTU1DT05GSUcgaXMgbm90IHNldAojIENPTkZJR19QQ0lfR09ESVJFQ1Qg
aXMgbm90IHNldApDT05GSUdfUENJX0dPQU5ZPXkKQ09ORklHX1BDSV9CSU9T
PXkKQ09ORklHX1BDSV9ESVJFQ1Q9eQpDT05GSUdfUENJX01NQ09ORklHPXkK
Q09ORklHX1BDSV9VU0VfVkVDVE9SPXkKQ09ORklHX1BDSV9MRUdBQ1lfUFJP
Qz15CkNPTkZJR19QQ0lfTkFNRVM9eQpDT05GSUdfSVNBPXkKIyBDT05GSUdf
RUlTQSBpcyBub3Qgc2V0CiMgQ09ORklHX01DQSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDeDIwMCBpcyBub3Qgc2V0CgojCiMgUENNQ0lBL0NhcmRCdXMgc3Vw
cG9ydAojCiMgQ09ORklHX1BDTUNJQSBpcyBub3Qgc2V0CkNPTkZJR19QQ01D
SUFfUFJPQkU9eQoKIwojIFBDSSBIb3RwbHVnIFN1cHBvcnQKIwojIENPTkZJ
R19IT1RQTFVHX1BDSSBpcyBub3Qgc2V0CgojCiMgRXhlY3V0YWJsZSBmaWxl
IGZvcm1hdHMKIwpDT05GSUdfQklORk1UX0VMRj15CkNPTkZJR19CSU5GTVRf
QU9VVD1tCkNPTkZJR19CSU5GTVRfTUlTQz1tCgojCiMgRGV2aWNlIERyaXZl
cnMKIwoKIwojIEdlbmVyaWMgRHJpdmVyIE9wdGlvbnMKIwpDT05GSUdfRldf
TE9BREVSPW0KIyBDT05GSUdfREVCVUdfRFJJVkVSIGlzIG5vdCBzZXQKCiMK
IyBNZW1vcnkgVGVjaG5vbG9neSBEZXZpY2VzIChNVEQpCiMKIyBDT05GSUdf
TVREIGlzIG5vdCBzZXQKCiMKIyBQYXJhbGxlbCBwb3J0IHN1cHBvcnQKIwpD
T05GSUdfUEFSUE9SVD1tCkNPTkZJR19QQVJQT1JUX1BDPW0KQ09ORklHX1BB
UlBPUlRfUENfQ01MMT1tCkNPTkZJR19QQVJQT1JUX1NFUklBTD1tCiMgQ09O
RklHX1BBUlBPUlRfUENfRklGTyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUlBP
UlRfUENfU1VQRVJJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUlBPUlRfT1RI
RVIgaXMgbm90IHNldApDT05GSUdfUEFSUE9SVF8xMjg0PXkKCiMKIyBQbHVn
IGFuZCBQbGF5IHN1cHBvcnQKIwpDT05GSUdfUE5QPXkKIyBDT05GSUdfUE5Q
X0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBQcm90b2NvbHMKIwpDT05GSUdfSVNB
UE5QPXkKIyBDT05GSUdfUE5QQklPUyBpcyBub3Qgc2V0CgojCiMgQmxvY2sg
ZGV2aWNlcwojCkNPTkZJR19CTEtfREVWX0ZEPXkKIyBDT05GSUdfQkxLX0RF
Vl9YRCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUklERSBpcyBub3Qgc2V0CiMg
Q09ORklHX0JMS19DUFFfREEgaXMgbm90IHNldAojIENPTkZJR19CTEtfQ1BR
X0NJU1NfREEgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0RBQzk2MCBp
cyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVU1FTSBpcyBub3Qgc2V0CkNP
TkZJR19CTEtfREVWX0xPT1A9bQojIENPTkZJR19CTEtfREVWX0NSWVBUT0xP
T1AgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX05CRCBpcyBub3Qgc2V0
CkNPTkZJR19CTEtfREVWX0NBUk1FTD1tCkNPTkZJR19CTEtfREVWX1JBTT15
CkNPTkZJR19CTEtfREVWX1JBTV9TSVpFPTgxOTIKQ09ORklHX0JMS19ERVZf
SU5JVFJEPXkKQ09ORklHX0xCRD15CgojCiMgQVRBL0FUQVBJL01GTS9STEwg
c3VwcG9ydAojCkNPTkZJR19JREU9eQpDT05GSUdfQkxLX0RFVl9JREU9eQoK
IwojIFBsZWFzZSBzZWUgRG9jdW1lbnRhdGlvbi9pZGUudHh0IGZvciBoZWxw
L2luZm8gb24gSURFIGRyaXZlcwojCiMgQ09ORklHX0JMS19ERVZfSERfSURF
IGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfSURFRElTSz15CkNPTkZJR19J
REVESVNLX01VTFRJX01PREU9eQojIENPTkZJR19JREVESVNLX1NUUk9LRSBp
cyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0lERUNEPXkKIyBDT05GSUdfQkxL
X0RFVl9JREVUQVBFIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JREVG
TE9QUFkgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9JREVTQ1NJPW0KIyBD
T05GSUdfSURFX1RBU0tfSU9DVEwgaXMgbm90IHNldAojIENPTkZJR19JREVf
VEFTS0ZJTEVfSU8gaXMgbm90IHNldAoKIwojIElERSBjaGlwc2V0IHN1cHBv
cnQvYnVnZml4ZXMKIwpDT05GSUdfSURFX0dFTkVSSUM9eQojIENPTkZJR19C
TEtfREVWX0NNRDY0MCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSURF
UE5QIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfSURFUENJPXkKQ09ORklH
X0lERVBDSV9TSEFSRV9JUlE9eQojIENPTkZJR19CTEtfREVWX09GRkJPQVJE
IGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfR0VORVJJQz15CiMgQ09ORklH
X0JMS19ERVZfT1BUSTYyMSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZf
UloxMDAwIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfSURFRE1BX1BDST15
CiMgQ09ORklHX0JMS19ERVZfSURFRE1BX0ZPUkNFRCBpcyBub3Qgc2V0CkNP
TkZJR19JREVETUFfUENJX0FVVE89eQojIENPTkZJR19JREVETUFfT05MWURJ
U0sgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9BRE1BPXkKIyBDT05GSUdf
QkxLX0RFVl9BRUM2MlhYIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9B
TEkxNVgzIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfQU1ENzRYWD15CiMg
Q09ORklHX0JMS19ERVZfQVRJSVhQIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxL
X0RFVl9DTUQ2NFggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1RSSUZM
RVggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0NZODJDNjkzIGlzIG5v
dCBzZXQKIyBDT05GSUdfQkxLX0RFVl9DUzU1MjAgaXMgbm90IHNldAojIENP
TkZJR19CTEtfREVWX0NTNTUzMCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19E
RVZfSFBUMzRYIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9IUFQzNjYg
aXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1NDMTIwMCBpcyBub3Qgc2V0
CkNPTkZJR19CTEtfREVWX1BJSVg9eQojIENPTkZJR19CTEtfREVWX05TODc0
MTUgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9QREMyMDJYWF9PTEQ9eQpD
T05GSUdfUERDMjAyWFhfQlVSU1Q9eQpDT05GSUdfQkxLX0RFVl9QREMyMDJY
WF9ORVc9eQpDT05GSUdfUERDMjAyWFhfRk9SQ0U9eQpDT05GSUdfQkxLX0RF
Vl9TVldLUz15CkNPTkZJR19CTEtfREVWX1NJSU1BR0U9eQojIENPTkZJR19C
TEtfREVWX1NJUzU1MTMgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1NM
QzkwRTY2IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9UUk0yOTAgaXMg
bm90IHNldApDT05GSUdfQkxLX0RFVl9WSUE4MkNYWFg9eQojIENPTkZJR19J
REVfQ0hJUFNFVFMgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9JREVETUE9
eQojIENPTkZJR19JREVETUFfSVZCIGlzIG5vdCBzZXQKQ09ORklHX0lERURN
QV9BVVRPPXkKIyBDT05GSUdfQkxLX0RFVl9IRCBpcyBub3Qgc2V0CgojCiMg
U0NTSSBkZXZpY2Ugc3VwcG9ydAojCkNPTkZJR19TQ1NJPW0KQ09ORklHX1ND
U0lfUFJPQ19GUz15CgojCiMgU0NTSSBzdXBwb3J0IHR5cGUgKGRpc2ssIHRh
cGUsIENELVJPTSkKIwpDT05GSUdfQkxLX0RFVl9TRD1tCiMgQ09ORklHX0NI
Ul9ERVZfU1QgaXMgbm90IHNldAojIENPTkZJR19DSFJfREVWX09TU1QgaXMg
bm90IHNldApDT05GSUdfQkxLX0RFVl9TUj1tCkNPTkZJR19CTEtfREVWX1NS
X1ZFTkRPUj15CkNPTkZJR19DSFJfREVWX1NHPW0KCiMKIyBTb21lIFNDU0kg
ZGV2aWNlcyAoZS5nLiBDRCBqdWtlYm94KSBzdXBwb3J0IG11bHRpcGxlIExV
TnMKIwojIENPTkZJR19TQ1NJX01VTFRJX0xVTiBpcyBub3Qgc2V0CkNPTkZJ
R19TQ1NJX1JFUE9SVF9MVU5TPXkKQ09ORklHX1NDU0lfQ09OU1RBTlRTPXkK
Q09ORklHX1NDU0lfTE9HR0lORz15CgojCiMgU0NTSSBUcmFuc3BvcnQgQXR0
cmlidXRlcwojCiMgQ09ORklHX1NDU0lfU1BJX0FUVFJTIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSV9GQ19BVFRSUyBpcyBub3Qgc2V0CgojCiMgU0NTSSBs
b3ctbGV2ZWwgZHJpdmVycwojCiMgQ09ORklHX0JMS19ERVZfM1dfWFhYWF9S
QUlEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV83MDAwRkFTU1QgaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX0FDQVJEIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0NTSV9BSEExNTJYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BSEExNTQy
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BQUNSQUlEIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSV9BSUM3WFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9BSUM3WFhYX09MRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQUlDNzlY
WCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQURWQU5TWVMgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX0lOMjAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfTUVHQVJBSUQgaXMgbm90IHNldApDT05GSUdfU0NTSV9TQVRBPXkKQ09O
RklHX1NDU0lfU0FUQV9TVlc9bQpDT05GSUdfU0NTSV9BVEFfUElJWD1tCkNP
TkZJR19TQ1NJX1NBVEFfUFJPTUlTRT1tCkNPTkZJR19TQ1NJX1NBVEFfU0lM
PW0KQ09ORklHX1NDU0lfU0FUQV9TSVM9bQpDT05GSUdfU0NTSV9TQVRBX1ZJ
QT1tCkNPTkZJR19TQ1NJX1NBVEFfVklURVNTRT1tCiMgQ09ORklHX1NDU0lf
QlVTTE9HSUMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0NQUUZDVFMgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX0RNWDMxOTFEIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9EVEMzMjgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9F
QVRBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9FQVRBX1BJTyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NDU0lfRlVUVVJFX0RPTUFJTiBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfR0RUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfR0VO
RVJJQ19OQ1I1MzgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9HRU5FUklD
X05DUjUzODBfTU1JTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSVBTIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JTklBMTAwIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9QUEEgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lNTSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTkNSNTNDNDA2QSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfU1lNNTNDOFhYXzIgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX1BBUzE2IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9QU0kyNDBJ
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9RTE9HSUNfRkFTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9RTE9HSUNfSVNQIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9RTE9HSUNfRkMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FM
T0dJQ18xMjgwIGlzIG5vdCBzZXQKQ09ORklHX1NDU0lfUUxBMlhYWD1tCiMg
Q09ORklHX1NDU0lfUUxBMjFYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
UUxBMjJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUUxBMjMwMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NDU0lfUUxBMjMyMiBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfUUxBNjMxMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUUxB
NjMyMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU1lNNTNDNDE2IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9EQzM5NXggaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX0RDMzkwVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfVDEyOCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfVTE0XzM0RiBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfVUxUUkFTVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9OU1AzMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfREVCVUcgaXMgbm90
IHNldAoKIwojIE9sZCBDRC1ST00gZHJpdmVycyAobm90IFNDU0ksIG5vdCBJ
REUpCiMKIyBDT05GSUdfQ0RfTk9fSURFU0NTSSBpcyBub3Qgc2V0CgojCiMg
TXVsdGktZGV2aWNlIHN1cHBvcnQgKFJBSUQgYW5kIExWTSkKIwpDT05GSUdf
TUQ9eQpDT05GSUdfQkxLX0RFVl9NRD15CkNPTkZJR19NRF9MSU5FQVI9bQpD
T05GSUdfTURfUkFJRDA9bQpDT05GSUdfTURfUkFJRDE9bQpDT05GSUdfTURf
UkFJRDU9bQpDT05GSUdfTURfUkFJRDY9bQpDT05GSUdfTURfTVVMVElQQVRI
PW0KQ09ORklHX0JMS19ERVZfRE09bQojIENPTkZJR19ETV9DUllQVCBpcyBu
b3Qgc2V0CgojCiMgRnVzaW9uIE1QVCBkZXZpY2Ugc3VwcG9ydAojCkNPTkZJ
R19GVVNJT049bQpDT05GSUdfRlVTSU9OX01BWF9TR0U9NDAKQ09ORklHX0ZV
U0lPTl9JU0VOU0U9bQpDT05GSUdfRlVTSU9OX0NUTD1tCgojCiMgSUVFRSAx
Mzk0IChGaXJlV2lyZSkgc3VwcG9ydAojCkNPTkZJR19JRUVFMTM5ND15Cgoj
CiMgU3Vic3lzdGVtIE9wdGlvbnMKIwojIENPTkZJR19JRUVFMTM5NF9WRVJC
T1NFREVCVUcgaXMgbm90IHNldAojIENPTkZJR19JRUVFMTM5NF9PVUlfREIg
aXMgbm90IHNldAojIENPTkZJR19JRUVFMTM5NF9FWFRSQV9DT05GSUdfUk9N
UyBpcyBub3Qgc2V0CgojCiMgRGV2aWNlIERyaXZlcnMKIwpDT05GSUdfSUVF
RTEzOTRfUENJTFlOWD1tCkNPTkZJR19JRUVFMTM5NF9PSENJMTM5ND1tCgoj
CiMgUHJvdG9jb2wgRHJpdmVycwojCiMgQ09ORklHX0lFRUUxMzk0X1ZJREVP
MTM5NCBpcyBub3Qgc2V0CkNPTkZJR19JRUVFMTM5NF9TQlAyPW0KIyBDT05G
SUdfSUVFRTEzOTRfU0JQMl9QSFlTX0RNQSBpcyBub3Qgc2V0CiMgQ09ORklH
X0lFRUUxMzk0X0VUSDEzOTQgaXMgbm90IHNldApDT05GSUdfSUVFRTEzOTRf
RFYxMzk0PW0KQ09ORklHX0lFRUUxMzk0X1JBV0lPPW0KIyBDT05GSUdfSUVF
RTEzOTRfQ01QIGlzIG5vdCBzZXQKCiMKIyBJMk8gZGV2aWNlIHN1cHBvcnQK
IwojIENPTkZJR19JMk8gaXMgbm90IHNldAoKIwojIE5ldHdvcmtpbmcgc3Vw
cG9ydAojCkNPTkZJR19ORVQ9eQoKIwojIE5ldHdvcmtpbmcgb3B0aW9ucwoj
CkNPTkZJR19QQUNLRVQ9eQpDT05GSUdfUEFDS0VUX01NQVA9eQojIENPTkZJ
R19ORVRMSU5LX0RFViBpcyBub3Qgc2V0CkNPTkZJR19VTklYPXkKIyBDT05G
SUdfTkVUX0tFWSBpcyBub3Qgc2V0CkNPTkZJR19JTkVUPXkKQ09ORklHX0lQ
X01VTFRJQ0FTVD15CiMgQ09ORklHX0lQX0FEVkFOQ0VEX1JPVVRFUiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lQX1BOUCBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VF9JUElQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0lQR1JFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSVBfTVJPVVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJQ
RCBpcyBub3Qgc2V0CiMgQ09ORklHX1NZTl9DT09LSUVTIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5FVF9BSCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVRfRVNQ
IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9JUENPTVAgaXMgbm90IHNldAoK
IwojIElQOiBWaXJ0dWFsIFNlcnZlciBDb25maWd1cmF0aW9uCiMKIyBDT05G
SUdfSVBfVlMgaXMgbm90IHNldAojIENPTkZJR19JUFY2IGlzIG5vdCBzZXQK
IyBDT05GSUdfREVDTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfQlJJREdFIGlz
IG5vdCBzZXQKQ09ORklHX05FVEZJTFRFUj15CiMgQ09ORklHX05FVEZJTFRF
Ul9ERUJVRyBpcyBub3Qgc2V0CgojCiMgSVA6IE5ldGZpbHRlciBDb25maWd1
cmF0aW9uCiMKQ09ORklHX0lQX05GX0NPTk5UUkFDSz1tCkNPTkZJR19JUF9O
Rl9GVFA9bQpDT05GSUdfSVBfTkZfSVJDPW0KQ09ORklHX0lQX05GX1RGVFA9
bQpDT05GSUdfSVBfTkZfQU1BTkRBPW0KIyBDT05GSUdfSVBfTkZfUVVFVUUg
aXMgbm90IHNldApDT05GSUdfSVBfTkZfSVBUQUJMRVM9bQpDT05GSUdfSVBf
TkZfTUFUQ0hfTElNSVQ9bQpDT05GSUdfSVBfTkZfTUFUQ0hfSVBSQU5HRT1t
CkNPTkZJR19JUF9ORl9NQVRDSF9NQUM9bQpDT05GSUdfSVBfTkZfTUFUQ0hf
UEtUVFlQRT1tCkNPTkZJR19JUF9ORl9NQVRDSF9NQVJLPW0KQ09ORklHX0lQ
X05GX01BVENIX01VTFRJUE9SVD1tCkNPTkZJR19JUF9ORl9NQVRDSF9UT1M9
bQpDT05GSUdfSVBfTkZfTUFUQ0hfUkVDRU5UPW0KQ09ORklHX0lQX05GX01B
VENIX0VDTj1tCkNPTkZJR19JUF9ORl9NQVRDSF9EU0NQPW0KQ09ORklHX0lQ
X05GX01BVENIX0FIX0VTUD1tCkNPTkZJR19JUF9ORl9NQVRDSF9MRU5HVEg9
bQpDT05GSUdfSVBfTkZfTUFUQ0hfVFRMPW0KQ09ORklHX0lQX05GX01BVENI
X1RDUE1TUz1tCkNPTkZJR19JUF9ORl9NQVRDSF9IRUxQRVI9bQpDT05GSUdf
SVBfTkZfTUFUQ0hfU1RBVEU9bQpDT05GSUdfSVBfTkZfTUFUQ0hfQ09OTlRS
QUNLPW0KQ09ORklHX0lQX05GX01BVENIX09XTkVSPW0KQ09ORklHX0lQX05G
X0ZJTFRFUj1tCkNPTkZJR19JUF9ORl9UQVJHRVRfUkVKRUNUPW0KQ09ORklH
X0lQX05GX05BVD1tCkNPTkZJR19JUF9ORl9OQVRfTkVFREVEPXkKQ09ORklH
X0lQX05GX1RBUkdFVF9NQVNRVUVSQURFPW0KQ09ORklHX0lQX05GX1RBUkdF
VF9SRURJUkVDVD1tCkNPTkZJR19JUF9ORl9UQVJHRVRfTkVUTUFQPW0KQ09O
RklHX0lQX05GX1RBUkdFVF9TQU1FPW0KQ09ORklHX0lQX05GX05BVF9MT0NB
TD15CiMgQ09ORklHX0lQX05GX05BVF9TTk1QX0JBU0lDIGlzIG5vdCBzZXQK
Q09ORklHX0lQX05GX05BVF9JUkM9bQpDT05GSUdfSVBfTkZfTkFUX0ZUUD1t
CkNPTkZJR19JUF9ORl9OQVRfVEZUUD1tCkNPTkZJR19JUF9ORl9OQVRfQU1B
TkRBPW0KQ09ORklHX0lQX05GX01BTkdMRT1tCkNPTkZJR19JUF9ORl9UQVJH
RVRfVE9TPW0KQ09ORklHX0lQX05GX1RBUkdFVF9FQ049bQpDT05GSUdfSVBf
TkZfVEFSR0VUX0RTQ1A9bQpDT05GSUdfSVBfTkZfVEFSR0VUX01BUks9bQpD
T05GSUdfSVBfTkZfVEFSR0VUX0NMQVNTSUZZPW0KQ09ORklHX0lQX05GX1RB
UkdFVF9MT0c9bQpDT05GSUdfSVBfTkZfVEFSR0VUX1VMT0c9bQpDT05GSUdf
SVBfTkZfVEFSR0VUX1RDUE1TUz1tCkNPTkZJR19JUF9ORl9BUlBUQUJMRVM9
bQpDT05GSUdfSVBfTkZfQVJQRklMVEVSPW0KQ09ORklHX0lQX05GX0FSUF9N
QU5HTEU9bQojIENPTkZJR19JUF9ORl9DT01QQVRfSVBDSEFJTlMgaXMgbm90
IHNldAojIENPTkZJR19JUF9ORl9DT01QQVRfSVBGV0FETSBpcyBub3Qgc2V0
CgojCiMgU0NUUCBDb25maWd1cmF0aW9uIChFWFBFUklNRU5UQUwpCiMKIyBD
T05GSUdfSVBfU0NUUCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTSBpcyBub3Qg
c2V0CiMgQ09ORklHX1ZMQU5fODAyMVEgaXMgbm90IHNldAojIENPTkZJR19M
TEMyIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBYIGlzIG5vdCBzZXQKIyBDT05G
SUdfQVRBTEsgaXMgbm90IHNldAojIENPTkZJR19YMjUgaXMgbm90IHNldAoj
IENPTkZJR19MQVBCIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0RJVkVSVCBp
cyBub3Qgc2V0CiMgQ09ORklHX0VDT05FVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1dBTl9ST1VURVIgaXMgbm90IHNldAojIENPTkZJR19ORVRfRkFTVFJPVVRF
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0hXX0ZMT1dDT05UUk9MIGlzIG5v
dCBzZXQKCiMKIyBRb1MgYW5kL29yIGZhaXIgcXVldWVpbmcKIwojIENPTkZJ
R19ORVRfU0NIRUQgaXMgbm90IHNldAoKIwojIE5ldHdvcmsgdGVzdGluZwoj
CiMgQ09ORklHX05FVF9QS1RHRU4gaXMgbm90IHNldApDT05GSUdfTkVUREVW
SUNFUz15CgojCiMgQVJDbmV0IGRldmljZXMKIwojIENPTkZJR19BUkNORVQg
aXMgbm90IHNldAojIENPTkZJR19EVU1NWSBpcyBub3Qgc2V0CiMgQ09ORklH
X0JPTkRJTkcgaXMgbm90IHNldAojIENPTkZJR19FUVVBTElaRVIgaXMgbm90
IHNldAojIENPTkZJR19UVU4gaXMgbm90IHNldAojIENPTkZJR19ORVRfU0Ix
MDAwIGlzIG5vdCBzZXQKCiMKIyBFdGhlcm5ldCAoMTAgb3IgMTAwTWJpdCkK
IwpDT05GSUdfTkVUX0VUSEVSTkVUPXkKQ09ORklHX01JST1tCiMgQ09ORklH
X0hBUFBZTUVBTCBpcyBub3Qgc2V0CiMgQ09ORklHX1NVTkdFTSBpcyBub3Qg
c2V0CkNPTkZJR19ORVRfVkVORE9SXzNDT009eQojIENPTkZJR19FTDEgaXMg
bm90IHNldAojIENPTkZJR19FTDIgaXMgbm90IHNldAojIENPTkZJR19FTFBM
VVMgaXMgbm90IHNldAojIENPTkZJR19FTDE2IGlzIG5vdCBzZXQKIyBDT05G
SUdfRUwzIGlzIG5vdCBzZXQKIyBDT05GSUdfM0M1MTUgaXMgbm90IHNldApD
T05GSUdfVk9SVEVYPW0KIyBDT05GSUdfVFlQSE9PTiBpcyBub3Qgc2V0CiMg
Q09ORklHX0xBTkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9T
TUMgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1JBQ0FMIGlzIG5v
dCBzZXQKCiMKIyBUdWxpcCBmYW1pbHkgbmV0d29yayBkZXZpY2Ugc3VwcG9y
dAojCiMgQ09ORklHX05FVF9UVUxJUCBpcyBub3Qgc2V0CiMgQ09ORklHX0FU
MTcwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFUENBIGlzIG5vdCBzZXQKIyBD
T05GSUdfSFAxMDAgaXMgbm90IHNldAojIENPTkZJR19ORVRfSVNBIGlzIG5v
dCBzZXQKQ09ORklHX05FVF9QQ0k9eQojIENPTkZJR19QQ05FVDMyIGlzIG5v
dCBzZXQKIyBDT05GSUdfQU1EODExMV9FVEggaXMgbm90IHNldAojIENPTkZJ
R19BREFQVEVDX1NUQVJGSVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfQUMzMjAw
IGlzIG5vdCBzZXQKIyBDT05GSUdfQVBSSUNPVCBpcyBub3Qgc2V0CiMgQ09O
RklHX0I0NCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZPUkNFREVUSCBpcyBub3Qg
c2V0CiMgQ09ORklHX0NTODl4MCBpcyBub3Qgc2V0CiMgQ09ORklHX0RHUlMg
aXMgbm90IHNldAojIENPTkZJR19FRVBSTzEwMCBpcyBub3Qgc2V0CkNPTkZJ
R19FMTAwPW0KIyBDT05GSUdfRTEwMF9OQVBJIGlzIG5vdCBzZXQKIyBDT05G
SUdfRkVBTE5YIGlzIG5vdCBzZXQKIyBDT05GSUdfTkFUU0VNSSBpcyBub3Qg
c2V0CkNPTkZJR19ORTJLX1BDST1tCiMgQ09ORklHXzgxMzlDUCBpcyBub3Qg
c2V0CiMgQ09ORklHXzgxMzlUT08gaXMgbm90IHNldAojIENPTkZJR19TSVM5
MDAgaXMgbm90IHNldAojIENPTkZJR19FUElDMTAwIGlzIG5vdCBzZXQKIyBD
T05GSUdfU1VOREFOQ0UgaXMgbm90IHNldAojIENPTkZJR19UTEFOIGlzIG5v
dCBzZXQKIyBDT05GSUdfVklBX1JISU5FIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX1BPQ0tFVCBpcyBub3Qgc2V0CgojCiMgRXRoZXJuZXQgKDEwMDAgTWJp
dCkKIwojIENPTkZJR19BQ0VOSUMgaXMgbm90IHNldAojIENPTkZJR19ETDJL
IGlzIG5vdCBzZXQKQ09ORklHX0UxMDAwPW0KIyBDT05GSUdfRTEwMDBfTkFQ
SSBpcyBub3Qgc2V0CiMgQ09ORklHX05TODM4MjAgaXMgbm90IHNldAojIENP
TkZJR19IQU1BQ0hJIGlzIG5vdCBzZXQKIyBDT05GSUdfWUVMTE9XRklOIGlz
IG5vdCBzZXQKIyBDT05GSUdfUjgxNjkgaXMgbm90IHNldAojIENPTkZJR19T
Szk4TElOIGlzIG5vdCBzZXQKQ09ORklHX1RJR09OMz1tCgojCiMgRXRoZXJu
ZXQgKDEwMDAwIE1iaXQpCiMKIyBDT05GSUdfSVhHQiBpcyBub3Qgc2V0CiMg
Q09ORklHX1MySU8gaXMgbm90IHNldAojIENPTkZJR19GRERJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSElQUEkgaXMgbm90IHNldAojIENPTkZJR19QTElQIGlz
IG5vdCBzZXQKIyBDT05GSUdfUFBQIGlzIG5vdCBzZXQKIyBDT05GSUdfU0xJ
UCBpcyBub3Qgc2V0CgojCiMgV2lyZWxlc3MgTEFOIChub24taGFtcmFkaW8p
CiMKIyBDT05GSUdfTkVUX1JBRElPIGlzIG5vdCBzZXQKCiMKIyBUb2tlbiBS
aW5nIGRldmljZXMKIwojIENPTkZJR19UUiBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9GQyBpcyBub3Qgc2V0CiMgQ09ORklHX1JDUENJIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0hBUEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUQ09OU09M
RSBpcyBub3Qgc2V0CgojCiMgV2FuIGludGVyZmFjZXMKIwojIENPTkZJR19X
QU4gaXMgbm90IHNldAoKIwojIEFtYXRldXIgUmFkaW8gc3VwcG9ydAojCiMg
Q09ORklHX0hBTVJBRElPIGlzIG5vdCBzZXQKCiMKIyBJckRBIChpbmZyYXJl
ZCkgc3VwcG9ydAojCiMgQ09ORklHX0lSREEgaXMgbm90IHNldAoKIwojIEJs
dWV0b290aCBzdXBwb3J0CiMKIyBDT05GSUdfQlQgaXMgbm90IHNldAojIENP
TkZJR19ORVRQT0xMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1BPTExfQ09O
VFJPTExFUiBpcyBub3Qgc2V0CgojCiMgSVNETiBzdWJzeXN0ZW0KIwojIENP
TkZJR19JU0ROIGlzIG5vdCBzZXQKCiMKIyBUZWxlcGhvbnkgU3VwcG9ydAoj
CiMgQ09ORklHX1BIT05FIGlzIG5vdCBzZXQKCiMKIyBJbnB1dCBkZXZpY2Ug
c3VwcG9ydAojCkNPTkZJR19JTlBVVD15CgojCiMgVXNlcmxhbmQgaW50ZXJm
YWNlcwojCkNPTkZJR19JTlBVVF9NT1VTRURFVj15CkNPTkZJR19JTlBVVF9N
T1VTRURFVl9QU0FVWD15CkNPTkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5f
WD0xMDI0CkNPTkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5fWT03NjgKIyBD
T05GSUdfSU5QVVRfSk9ZREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRf
VFNERVYgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9FVkRFViBpcyBub3Qg
c2V0CiMgQ09ORklHX0lOUFVUX0VWQlVHIGlzIG5vdCBzZXQKCiMKIyBJbnB1
dCBJL08gZHJpdmVycwojCiMgQ09ORklHX0dBTUVQT1JUIGlzIG5vdCBzZXQK
Q09ORklHX1NPVU5EX0dBTUVQT1JUPXkKQ09ORklHX1NFUklPPXkKQ09ORklH
X1NFUklPX0k4MDQyPXkKQ09ORklHX1NFUklPX1NFUlBPUlQ9eQojIENPTkZJ
R19TRVJJT19DVDgyQzcxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX1BB
UktCRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX1BDSVBTMiBpcyBub3Qg
c2V0CgojCiMgSW5wdXQgRGV2aWNlIERyaXZlcnMKIwpDT05GSUdfSU5QVVRf
S0VZQk9BUkQ9eQpDT05GSUdfS0VZQk9BUkRfQVRLQkQ9eQojIENPTkZJR19L
RVlCT0FSRF9TVU5LQkQgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9M
S0tCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1hUS0JEIGlzIG5v
dCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfTkVXVE9OIGlzIG5vdCBzZXQKQ09O
RklHX0lOUFVUX01PVVNFPXkKQ09ORklHX01PVVNFX1BTMj15CiMgQ09ORklH
X01PVVNFX1NFUklBTCBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX0lOUE9S
VCBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX0xPR0lCTSBpcyBub3Qgc2V0
CiMgQ09ORklHX01PVVNFX1BDMTEwUEFEIGlzIG5vdCBzZXQKIyBDT05GSUdf
TU9VU0VfVlNYWFhBQSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0pPWVNU
SUNLIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfVE9VQ0hTQ1JFRU4gaXMg
bm90IHNldApDT05GSUdfSU5QVVRfTUlTQz15CkNPTkZJR19JTlBVVF9QQ1NQ
S1I9eQojIENPTkZJR19JTlBVVF9VSU5QVVQgaXMgbm90IHNldAoKIwojIENo
YXJhY3RlciBkZXZpY2VzCiMKQ09ORklHX1ZUPXkKQ09ORklHX1ZUX0NPTlNP
TEU9eQpDT05GSUdfSFdfQ09OU09MRT15CiMgQ09ORklHX1NFUklBTF9OT05T
VEFOREFSRCBpcyBub3Qgc2V0CgojCiMgU2VyaWFsIGRyaXZlcnMKIwpDT05G
SUdfU0VSSUFMXzgyNTA9eQpDT05GSUdfU0VSSUFMXzgyNTBfQ09OU09MRT15
CkNPTkZJR19TRVJJQUxfODI1MF9BQ1BJPXkKQ09ORklHX1NFUklBTF84MjUw
X05SX1VBUlRTPTQKIyBDT05GSUdfU0VSSUFMXzgyNTBfRVhURU5ERUQgaXMg
bm90IHNldAoKIwojIE5vbi04MjUwIHNlcmlhbCBwb3J0IHN1cHBvcnQKIwpD
T05GSUdfU0VSSUFMX0NPUkU9eQpDT05GSUdfU0VSSUFMX0NPUkVfQ09OU09M
RT15CkNPTkZJR19VTklYOThfUFRZUz15CkNPTkZJR19MRUdBQ1lfUFRZUz15
CkNPTkZJR19MRUdBQ1lfUFRZX0NPVU5UPTI1NgpDT05GSUdfUFJJTlRFUj1t
CiMgQ09ORklHX0xQX0NPTlNPTEUgaXMgbm90IHNldAojIENPTkZJR19QUERF
ViBpcyBub3Qgc2V0CiMgQ09ORklHX1RJUEFSIGlzIG5vdCBzZXQKIyBDT05G
SUdfUUlDMDJfVEFQRSBpcyBub3Qgc2V0CgojCiMgSVBNSQojCkNPTkZJR19J
UE1JX0hBTkRMRVI9bQpDT05GSUdfSVBNSV9QQU5JQ19FVkVOVD15CkNPTkZJ
R19JUE1JX1BBTklDX1NUUklORz15CkNPTkZJR19JUE1JX0RFVklDRV9JTlRF
UkZBQ0U9bQpDT05GSUdfSVBNSV9TST1tCkNPTkZJR19JUE1JX1dBVENIRE9H
PW0KCiMKIyBXYXRjaGRvZyBDYXJkcwojCkNPTkZJR19XQVRDSERPRz15CiMg
Q09ORklHX1dBVENIRE9HX05PV0FZT1VUIGlzIG5vdCBzZXQKCiMKIyBXYXRj
aGRvZyBEZXZpY2UgRHJpdmVycwojCiMgQ09ORklHX1NPRlRfV0FUQ0hET0cg
aXMgbm90IHNldAojIENPTkZJR19BQ1FVSVJFX1dEVCBpcyBub3Qgc2V0CiMg
Q09ORklHX0FEVkFOVEVDSF9XRFQgaXMgbm90IHNldAojIENPTkZJR19BTElN
MTUzNV9XRFQgaXMgbm90IHNldAojIENPTkZJR19BTElNNzEwMV9XRFQgaXMg
bm90IHNldApDT05GSUdfQU1EN1hYX1RDTz1tCiMgQ09ORklHX1NDNTIwX1dE
VCBpcyBub3Qgc2V0CiMgQ09ORklHX0VVUk9URUNIX1dEVCBpcyBub3Qgc2V0
CiMgQ09ORklHX0lCNzAwX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1dBRkVS
X1dEVCBpcyBub3Qgc2V0CkNPTkZJR19JOFhYX1RDTz1tCiMgQ09ORklHX1ND
MTIwMF9XRFQgaXMgbm90IHNldAojIENPTkZJR19TQ3gyMDBfV0RUIGlzIG5v
dCBzZXQKIyBDT05GSUdfNjBYWF9XRFQgaXMgbm90IHNldAojIENPTkZJR19D
UFU1X1dEVCBpcyBub3Qgc2V0CkNPTkZJR19XODM2MjdIRl9XRFQ9bQpDT05G
SUdfVzgzODc3Rl9XRFQ9bQojIENPTkZJR19NQUNIWl9XRFQgaXMgbm90IHNl
dAoKIwojIElTQS1iYXNlZCBXYXRjaGRvZyBDYXJkcwojCiMgQ09ORklHX1BD
V0FUQ0hET0cgaXMgbm90IHNldAojIENPTkZJR19NSVhDT01XRCBpcyBub3Qg
c2V0CiMgQ09ORklHX1dEVCBpcyBub3Qgc2V0CgojCiMgUENJLWJhc2VkIFdh
dGNoZG9nIENhcmRzCiMKIyBDT05GSUdfUENJUENXQVRDSERPRyBpcyBub3Qg
c2V0CiMgQ09ORklHX1dEVFBDSSBpcyBub3Qgc2V0CgojCiMgVVNCLWJhc2Vk
IFdhdGNoZG9nIENhcmRzCiMKIyBDT05GSUdfVVNCUENXQVRDSERPRyBpcyBu
b3Qgc2V0CkNPTkZJR19IV19SQU5ET009bQpDT05GSUdfTlZSQU09bQpDT05G
SUdfUlRDPW0KQ09ORklHX0dFTl9SVEM9bQpDT05GSUdfR0VOX1JUQ19YPXkK
IyBDT05GSUdfRFRMSyBpcyBub3Qgc2V0CiMgQ09ORklHX1IzOTY0IGlzIG5v
dCBzZXQKIyBDT05GSUdfQVBQTElDT00gaXMgbm90IHNldAojIENPTkZJR19T
T05ZUEkgaXMgbm90IHNldAoKIwojIEZ0YXBlLCB0aGUgZmxvcHB5IHRhcGUg
ZGV2aWNlIGRyaXZlcgojCkNPTkZJR19BR1A9eQojIENPTkZJR19BR1BfQUxJ
IGlzIG5vdCBzZXQKIyBDT05GSUdfQUdQX0FUSSBpcyBub3Qgc2V0CiMgQ09O
RklHX0FHUF9BTUQgaXMgbm90IHNldAojIENPTkZJR19BR1BfQU1ENjQgaXMg
bm90IHNldApDT05GSUdfQUdQX0lOVEVMPXkKQ09ORklHX0FHUF9JTlRFTF9N
Q0g9eQojIENPTkZJR19BR1BfTlZJRElBIGlzIG5vdCBzZXQKIyBDT05GSUdf
QUdQX1NJUyBpcyBub3Qgc2V0CkNPTkZJR19BR1BfU1dPUktTPXkKQ09ORklH
X0FHUF9WSUE9eQojIENPTkZJR19BR1BfRUZGSUNFT04gaXMgbm90IHNldApD
T05GSUdfRFJNPXkKIyBDT05GSUdfRFJNX1RERlggaXMgbm90IHNldAojIENP
TkZJR19EUk1fR0FNTUEgaXMgbm90IHNldApDT05GSUdfRFJNX1IxMjg9bQpD
T05GSUdfRFJNX1JBREVPTj1tCkNPTkZJR19EUk1fSTgxMD1tCkNPTkZJR19E
Uk1fSTgzMD1tCkNPTkZJR19EUk1fTUdBPW0KIyBDT05GSUdfRFJNX1NJUyBp
cyBub3Qgc2V0CiMgQ09ORklHX01XQVZFIGlzIG5vdCBzZXQKIyBDT05GSUdf
UkFXX0RSSVZFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0hBTkdDSEVDS19USU1F
UiBpcyBub3Qgc2V0CgojCiMgSTJDIHN1cHBvcnQKIwpDT05GSUdfSTJDPW0K
Q09ORklHX0kyQ19DSEFSREVWPW0KCiMKIyBJMkMgQWxnb3JpdGhtcwojCkNP
TkZJR19JMkNfQUxHT0JJVD1tCiMgQ09ORklHX0kyQ19BTEdPUENGIGlzIG5v
dCBzZXQKCiMKIyBJMkMgSGFyZHdhcmUgQnVzIHN1cHBvcnQKIwojIENPTkZJ
R19JMkNfQUxJMTUzNSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTEkxNTYz
IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FMSTE1WDMgaXMgbm90IHNldAoj
IENPTkZJR19JMkNfQU1ENzU2IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FN
RDgxMTEgaXMgbm90IHNldApDT05GSUdfSTJDX0k4MDE9bQpDT05GSUdfSTJD
X0k4MTA9bQpDT05GSUdfSTJDX0lTQT1tCiMgQ09ORklHX0kyQ19ORk9SQ0Uy
IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1BBUlBPUlQgaXMgbm90IHNldAoj
IENPTkZJR19JMkNfUEFSUE9SVF9MSUdIVCBpcyBub3Qgc2V0CkNPTkZJR19J
MkNfUElJWDQ9bQojIENPTkZJR19JMkNfUFJPU0FWQUdFIGlzIG5vdCBzZXQK
IyBDT05GSUdfSTJDX1NBVkFHRTQgaXMgbm90IHNldAojIENPTkZJR19TQ3gy
MDBfQUNCIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NJUzU1OTUgaXMgbm90
IHNldAojIENPTkZJR19JMkNfU0lTNjMwIGlzIG5vdCBzZXQKIyBDT05GSUdf
STJDX1NJUzk2WCBpcyBub3Qgc2V0CkNPTkZJR19JMkNfVklBPW0KQ09ORklH
X0kyQ19WSUFQUk89bQojIENPTkZJR19JMkNfVk9PRE9PMyBpcyBub3Qgc2V0
CgojCiMgSGFyZHdhcmUgU2Vuc29ycyBDaGlwIHN1cHBvcnQKIwpDT05GSUdf
STJDX1NFTlNPUj1tCkNPTkZJR19TRU5TT1JTX0FETTEwMjE9bQpDT05GSUdf
U0VOU09SU19BU0IxMDA9bQpDT05GSUdfU0VOU09SU19EUzE2MjE9bQpDT05G
SUdfU0VOU09SU19GU0NIRVI9bQpDT05GSUdfU0VOU09SU19HTDUxOFNNPW0K
Q09ORklHX1NFTlNPUlNfSVQ4Nz1tCkNPTkZJR19TRU5TT1JTX0xNNzU9bQpD
T05GSUdfU0VOU09SU19MTTc4PW0KQ09ORklHX1NFTlNPUlNfTE04MD1tCkNP
TkZJR19TRU5TT1JTX0xNODM9bQpDT05GSUdfU0VOU09SU19MTTg1PW0KQ09O
RklHX1NFTlNPUlNfTE05MD1tCkNPTkZJR19TRU5TT1JTX1ZJQTY4NkE9bQpD
T05GSUdfU0VOU09SU19XODM3ODFEPW0KQ09ORklHX1NFTlNPUlNfVzgzTDc4
NVRTPW0KQ09ORklHX1NFTlNPUlNfVzgzNjI3SEY9bQoKIwojIE90aGVyIEky
QyBDaGlwIHN1cHBvcnQKIwpDT05GSUdfU0VOU09SU19FRVBST009bQpDT05G
SUdfU0VOU09SU19QQ0Y4NTc0PW0KQ09ORklHX1NFTlNPUlNfUENGODU5MT1t
CiMgQ09ORklHX0kyQ19ERUJVR19DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdf
STJDX0RFQlVHX0FMR08gaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdf
QlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFQlVHX0NISVAgaXMgbm90
IHNldAoKIwojIE1pc2MgZGV2aWNlcwojCiMgQ09ORklHX0lCTV9BU00gaXMg
bm90IHNldAoKIwojIE11bHRpbWVkaWEgZGV2aWNlcwojCkNPTkZJR19WSURF
T19ERVY9bQoKIwojIFZpZGVvIEZvciBMaW51eAojCgojCiMgVmlkZW8gQWRh
cHRlcnMKIwpDT05GSUdfVklERU9fQlQ4NDg9bQojIENPTkZJR19WSURFT19Q
TVMgaXMgbm90IHNldAojIENPTkZJR19WSURFT19CV1FDQU0gaXMgbm90IHNl
dAojIENPTkZJR19WSURFT19DUUNBTSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJ
REVPX1c5OTY2IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fQ1BJQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1ZJREVPX1NBQTUyNDZBIGlzIG5vdCBzZXQKIyBD
T05GSUdfVklERU9fU0FBNTI0OSBpcyBub3Qgc2V0CiMgQ09ORklHX1RVTkVS
XzMwMzYgaXMgbm90IHNldAojIENPTkZJR19WSURFT19TVFJBRElTIGlzIG5v
dCBzZXQKIyBDT05GSUdfVklERU9fWk9SQU4gaXMgbm90IHNldAojIENPTkZJ
R19WSURFT19TQUE3MTM0IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fTVhC
IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fRFBDIGlzIG5vdCBzZXQKIyBD
T05GSUdfVklERU9fSEVYSVVNX09SSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdf
VklERU9fSEVYSVVNX0dFTUlOSSBpcyBub3Qgc2V0CkNPTkZJR19WSURFT19D
WDg4PW0KCiMKIyBSYWRpbyBBZGFwdGVycwojCiMgQ09ORklHX1JBRElPX0NB
REVUIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFESU9fUlRSQUNLIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUkFESU9fUlRSQUNLMiBpcyBub3Qgc2V0CiMgQ09ORklH
X1JBRElPX0FaVEVDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1JBRElPX0dFTVRF
SyBpcyBub3Qgc2V0CiMgQ09ORklHX1JBRElPX0dFTVRFS19QQ0kgaXMgbm90
IHNldAojIENPTkZJR19SQURJT19NQVhJUkFESU8gaXMgbm90IHNldAojIENP
TkZJR19SQURJT19NQUVTVFJPIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFESU9f
U0YxNkZNSSBpcyBub3Qgc2V0CiMgQ09ORklHX1JBRElPX1NGMTZGTVIyIGlz
IG5vdCBzZXQKIyBDT05GSUdfUkFESU9fVEVSUkFURUMgaXMgbm90IHNldAoj
IENPTkZJR19SQURJT19UUlVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1JBRElP
X1RZUEhPT04gaXMgbm90IHNldAojIENPTkZJR19SQURJT19aT0xUUklYIGlz
IG5vdCBzZXQKCiMKIyBEaWdpdGFsIFZpZGVvIEJyb2FkY2FzdGluZyBEZXZp
Y2VzCiMKIyBDT05GSUdfRFZCIGlzIG5vdCBzZXQKQ09ORklHX1ZJREVPX1RV
TkVSPW0KQ09ORklHX1ZJREVPX0JVRj1tCkNPTkZJR19WSURFT19CVENYPW0K
Q09ORklHX1ZJREVPX0lSPW0KCiMKIyBHcmFwaGljcyBzdXBwb3J0CiMKIyBD
T05GSUdfRkIgaXMgbm90IHNldApDT05GSUdfVklERU9fU0VMRUNUPXkKCiMK
IyBDb25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQKIwpDT05GSUdfVkdB
X0NPTlNPTEU9eQojIENPTkZJR19NREFfQ09OU09MRSBpcyBub3Qgc2V0CkNP
TkZJR19EVU1NWV9DT05TT0xFPXkKCiMKIyBTb3VuZAojCkNPTkZJR19TT1VO
RD1tCgojCiMgQWR2YW5jZWQgTGludXggU291bmQgQXJjaGl0ZWN0dXJlCiMK
IyBDT05GSUdfU05EIGlzIG5vdCBzZXQKCiMKIyBPcGVuIFNvdW5kIFN5c3Rl
bQojCkNPTkZJR19TT1VORF9QUklNRT1tCkNPTkZJR19TT1VORF9CVDg3OD1t
CiMgQ09ORklHX1NPVU5EX0NNUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfU09V
TkRfRU1VMTBLMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX0ZVU0lPTiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX0NTNDI4MSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NPVU5EX0VTMTM3MCBpcyBub3Qgc2V0CkNPTkZJR19TT1VORF9F
UzEzNzE9bQojIENPTkZJR19TT1VORF9FU1NTT0xPMSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NPVU5EX01BRVNUUk8gaXMgbm90IHNldAojIENPTkZJR19TT1VO
RF9NQUVTVFJPMyBpcyBub3Qgc2V0CkNPTkZJR19TT1VORF9JQ0g9bQojIENP
TkZJR19TT1VORF9TT05JQ1ZJQkVTIGlzIG5vdCBzZXQKIyBDT05GSUdfU09V
TkRfVFJJREVOVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX01TTkRDTEFT
IGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfTVNORFBJTiBpcyBub3Qgc2V0
CkNPTkZJR19TT1VORF9WSUE4MkNYWFg9bQojIENPTkZJR19NSURJX1ZJQTgy
Q1hYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX09TUyBpcyBub3Qgc2V0
CkNPTkZJR19TT1VORF9UVk1JWEVSPW0KIyBDT05GSUdfU09VTkRfQUxJNTQ1
NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX0ZPUlRFIGlzIG5vdCBzZXQK
IyBDT05GSUdfU09VTkRfUk1FOTZYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NP
VU5EX0FEMTk4MCBpcyBub3Qgc2V0CgojCiMgVVNCIHN1cHBvcnQKIwpDT05G
SUdfVVNCPW0KIyBDT05GSUdfVVNCX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBN
aXNjZWxsYW5lb3VzIFVTQiBvcHRpb25zCiMKQ09ORklHX1VTQl9ERVZJQ0VG
Uz15CiMgQ09ORklHX1VTQl9CQU5EV0lEVEggaXMgbm90IHNldAojIENPTkZJ
R19VU0JfRFlOQU1JQ19NSU5PUlMgaXMgbm90IHNldAoKIwojIFVTQiBIb3N0
IENvbnRyb2xsZXIgRHJpdmVycwojCkNPTkZJR19VU0JfRUhDSV9IQ0Q9bQoj
IENPTkZJR19VU0JfRUhDSV9TUExJVF9JU08gaXMgbm90IHNldAojIENPTkZJ
R19VU0JfRUhDSV9ST09UX0hVQl9UVCBpcyBub3Qgc2V0CkNPTkZJR19VU0Jf
T0hDSV9IQ0Q9bQpDT05GSUdfVVNCX1VIQ0lfSENEPW0KCiMKIyBVU0IgRGV2
aWNlIENsYXNzIGRyaXZlcnMKIwojIENPTkZJR19VU0JfQVVESU8gaXMgbm90
IHNldAojIENPTkZJR19VU0JfQkxVRVRPT1RIX1RUWSBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9NSURJIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0FDTSBp
cyBub3Qgc2V0CkNPTkZJR19VU0JfUFJJTlRFUj1tCkNPTkZJR19VU0JfU1RP
UkFHRT1tCiMgQ09ORklHX1VTQl9TVE9SQUdFX0RFQlVHIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1NUT1JBR0VfREFUQUZBQiBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9TVE9SQUdFX0ZSRUVDT00gaXMgbm90IHNldAojIENPTkZJR19V
U0JfU1RPUkFHRV9JU0QyMDAgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RP
UkFHRV9EUENNIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfSFA4
MjAwZSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX1NERFIwOSBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX1NERFI1NSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0pVTVBTSE9UIGlzIG5vdCBzZXQK
CiMKIyBVU0IgSHVtYW4gSW50ZXJmYWNlIERldmljZXMgKEhJRCkKIwpDT05G
SUdfVVNCX0hJRD1tCkNPTkZJR19VU0JfSElESU5QVVQ9eQojIENPTkZJR19I
SURfRkYgaXMgbm90IHNldAojIENPTkZJR19VU0JfSElEREVWIGlzIG5vdCBz
ZXQKCiMKIyBVU0IgSElEIEJvb3QgUHJvdG9jb2wgZHJpdmVycwojCiMgQ09O
RklHX1VTQl9LQkQgaXMgbm90IHNldAojIENPTkZJR19VU0JfTU9VU0UgaXMg
bm90IHNldAojIENPTkZJR19VU0JfQUlQVEVLIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1dBQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0tCVEFCIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1BPV0VSTUFURSBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9NVE9VQ0ggaXMgbm90IHNldAojIENPTkZJR19VU0JfWFBB
RCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BVElfUkVNT1RFIGlzIG5vdCBz
ZXQKCiMKIyBVU0IgSW1hZ2luZyBkZXZpY2VzCiMKIyBDT05GSUdfVVNCX01E
QzgwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9NSUNST1RFSyBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9IUFVTQlNDU0kgaXMgbm90IHNldAoKIwojIFVT
QiBNdWx0aW1lZGlhIGRldmljZXMKIwojIENPTkZJR19VU0JfREFCVVNCIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1ZJQ0FNIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX0RTQlIgaXMgbm90IHNldAojIENPTkZJR19VU0JfSUJNQ0FNIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX0tPTklDQVdDIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX09WNTExIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFNDAx
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUVjY4MCBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9XOTk2OENGIGlzIG5vdCBzZXQKCiMKIyBVU0IgTmV0d29y
ayBhZGFwdG9ycwojCiMgQ09ORklHX1VTQl9DQVRDIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX0tBV0VUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9QRUdB
U1VTIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1JUTDgxNTAgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfVVNCTkVUIGlzIG5vdCBzZXQKCiMKIyBVU0IgcG9y
dCBkcml2ZXJzCiMKIyBDT05GSUdfVVNCX1VTUzcyMCBpcyBub3Qgc2V0Cgoj
CiMgVVNCIFNlcmlhbCBDb252ZXJ0ZXIgc3VwcG9ydAojCiMgQ09ORklHX1VT
Ql9TRVJJQUwgaXMgbm90IHNldAoKIwojIFVTQiBNaXNjZWxsYW5lb3VzIGRy
aXZlcnMKIwojIENPTkZJR19VU0JfRU1JNjIgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfRU1JMjYgaXMgbm90IHNldAojIENPTkZJR19VU0JfVElHTCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9BVUVSU1dBTEQgaXMgbm90IHNldAojIENP
TkZJR19VU0JfUklPNTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xFR09U
T1dFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9MQ0QgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfTEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0NZVEhF
Uk0gaXMgbm90IHNldAojIENPTkZJR19VU0JfVEVTVCBpcyBub3Qgc2V0Cgoj
CiMgVVNCIEdhZGdldCBTdXBwb3J0CiMKIyBDT05GSUdfVVNCX0dBREdFVCBp
cyBub3Qgc2V0CgojCiMgRmlsZSBzeXN0ZW1zCiMKQ09ORklHX0VYVDJfRlM9
eQojIENPTkZJR19FWFQyX0ZTX1hBVFRSIGlzIG5vdCBzZXQKQ09ORklHX0VY
VDNfRlM9eQojIENPTkZJR19FWFQzX0ZTX1hBVFRSIGlzIG5vdCBzZXQKQ09O
RklHX0pCRD15CiMgQ09ORklHX0pCRF9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJ
R19SRUlTRVJGU19GUz1tCiMgQ09ORklHX1JFSVNFUkZTX0NIRUNLIGlzIG5v
dCBzZXQKIyBDT05GSUdfUkVJU0VSRlNfUFJPQ19JTkZPIGlzIG5vdCBzZXQK
Q09ORklHX0pGU19GUz1tCiMgQ09ORklHX0pGU19QT1NJWF9BQ0wgaXMgbm90
IHNldAojIENPTkZJR19KRlNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19K
RlNfU1RBVElTVElDUyBpcyBub3Qgc2V0CkNPTkZJR19YRlNfRlM9bQojIENP
TkZJR19YRlNfUlQgaXMgbm90IHNldAojIENPTkZJR19YRlNfUVVPVEEgaXMg
bm90IHNldAojIENPTkZJR19YRlNfU0VDVVJJVFkgaXMgbm90IHNldAojIENP
TkZJR19YRlNfUE9TSVhfQUNMIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlOSVhf
RlMgaXMgbm90IHNldAojIENPTkZJR19ST01GU19GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1FVT1RBIGlzIG5vdCBzZXQKIyBDT05GSUdfQVVUT0ZTX0ZTIGlz
IG5vdCBzZXQKQ09ORklHX0FVVE9GUzRfRlM9bQoKIwojIENELVJPTS9EVkQg
RmlsZXN5c3RlbXMKIwpDT05GSUdfSVNPOTY2MF9GUz15CkNPTkZJR19KT0xJ
RVQ9eQpDT05GSUdfWklTT0ZTPXkKQ09ORklHX1pJU09GU19GUz15CkNPTkZJ
R19VREZfRlM9bQoKIwojIERPUy9GQVQvTlQgRmlsZXN5c3RlbXMKIwpDT05G
SUdfRkFUX0ZTPW0KQ09ORklHX01TRE9TX0ZTPW0KQ09ORklHX1ZGQVRfRlM9
bQpDT05GSUdfTlRGU19GUz1tCiMgQ09ORklHX05URlNfREVCVUcgaXMgbm90
IHNldAojIENPTkZJR19OVEZTX1JXIGlzIG5vdCBzZXQKCiMKIyBQc2V1ZG8g
ZmlsZXN5c3RlbXMKIwpDT05GSUdfUFJPQ19GUz15CkNPTkZJR19QUk9DX0tD
T1JFPXkKQ09ORklHX1NZU0ZTPXkKIyBDT05GSUdfREVWRlNfRlMgaXMgbm90
IHNldAojIENPTkZJR19ERVZQVFNfRlNfWEFUVFIgaXMgbm90IHNldApDT05G
SUdfVE1QRlM9eQpDT05GSUdfSFVHRVRMQkZTPXkKQ09ORklHX0hVR0VUTEJf
UEFHRT15CkNPTkZJR19SQU1GUz15CgojCiMgTWlzY2VsbGFuZW91cyBmaWxl
c3lzdGVtcwojCiMgQ09ORklHX0FERlNfRlMgaXMgbm90IHNldAojIENPTkZJ
R19BRkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSEZTX0ZTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSEZTUExVU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JF
RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19CRlNfRlMgaXMgbm90IHNldAoj
IENPTkZJR19FRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19DUkFNRlMgaXMg
bm90IHNldAojIENPTkZJR19WWEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdf
SFBGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1FOWDRGU19GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NZU1ZfRlMgaXMgbm90IHNldAojIENPTkZJR19VRlNf
RlMgaXMgbm90IHNldAoKIwojIE5ldHdvcmsgRmlsZSBTeXN0ZW1zCiMKQ09O
RklHX05GU19GUz1tCkNPTkZJR19ORlNfVjM9eQojIENPTkZJR19ORlNfVjQg
aXMgbm90IHNldAojIENPTkZJR19ORlNfRElSRUNUSU8gaXMgbm90IHNldApD
T05GSUdfTkZTRD1tCkNPTkZJR19ORlNEX1YzPXkKIyBDT05GSUdfTkZTRF9W
NCBpcyBub3Qgc2V0CiMgQ09ORklHX05GU0RfVENQIGlzIG5vdCBzZXQKQ09O
RklHX0xPQ0tEPW0KQ09ORklHX0xPQ0tEX1Y0PXkKQ09ORklHX0VYUE9SVEZT
PW0KQ09ORklHX1NVTlJQQz1tCiMgQ09ORklHX1JQQ1NFQ19HU1NfS1JCNSBp
cyBub3Qgc2V0CkNPTkZJR19TTUJfRlM9bQojIENPTkZJR19TTUJfTkxTX0RF
RkFVTFQgaXMgbm90IHNldAojIENPTkZJR19DSUZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkNQX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09EQV9GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lOVEVSTUVaWk9fRlMgaXMgbm90IHNldAojIENP
TkZJR19BRlNfRlMgaXMgbm90IHNldAoKIwojIFBhcnRpdGlvbiBUeXBlcwoj
CiMgQ09ORklHX1BBUlRJVElPTl9BRFZBTkNFRCBpcyBub3Qgc2V0CkNPTkZJ
R19NU0RPU19QQVJUSVRJT049eQoKIwojIE5hdGl2ZSBMYW5ndWFnZSBTdXBw
b3J0CiMKQ09ORklHX05MUz15CkNPTkZJR19OTFNfREVGQVVMVD0iaXNvODg1
OS0xIgpDT05GSUdfTkxTX0NPREVQQUdFXzQzNz1tCiMgQ09ORklHX05MU19D
T0RFUEFHRV83MzcgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0Vf
Nzc1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1MCBpcyBu
b3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NTIgaXMgbm90IHNldAoj
IENPTkZJR19OTFNfQ09ERVBBR0VfODU1IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzg1NyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RF
UEFHRV84NjAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYx
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MiBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjMgaXMgbm90IHNldAojIENP
TkZJR19OTFNfQ09ERVBBR0VfODY0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X0NPREVQQUdFXzg2NSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFH
RV84NjYgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY5IGlz
IG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzkzNiBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19DT0RFUEFHRV85NTAgaXMgbm90IHNldAojIENPTkZJ
R19OTFNfQ09ERVBBR0VfOTMyIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NP
REVQQUdFXzk0OSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84
NzQgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV84IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzEyNTAgaXMgbm90IHNldAojIENP
TkZJR19OTFNfQ09ERVBBR0VfMTI1MSBpcyBub3Qgc2V0CkNPTkZJR19OTFNf
SVNPODg1OV8xPW0KIyBDT05GSUdfTkxTX0lTTzg4NTlfMiBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19JU084ODU5XzMgaXMgbm90IHNldAojIENPTkZJR19O
TFNfSVNPODg1OV80IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlf
NSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzYgaXMgbm90IHNl
dAojIENPTkZJR19OTFNfSVNPODg1OV83IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0lTTzg4NTlfOSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5
XzEzIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMTQgaXMgbm90
IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8xNSBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19LT0k4X1IgaXMgbm90IHNldAojIENPTkZJR19OTFNfS09JOF9V
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX1VURjggaXMgbm90IHNldAoKIwoj
IFByb2ZpbGluZyBzdXBwb3J0CiMKQ09ORklHX1BST0ZJTElORz15CkNPTkZJ
R19PUFJPRklMRT1tCgojCiMgS2VybmVsIGhhY2tpbmcKIwpDT05GSUdfREVC
VUdfS0VSTkVMPXkKQ09ORklHX0VBUkxZX1BSSU5USz15CkNPTkZJR19ERUJV
R19TVEFDS09WRVJGTE9XPXkKQ09ORklHX0RFQlVHX1NUQUNLX1VTQUdFPXkK
Q09ORklHX0RFQlVHX1NMQUI9eQpDT05GSUdfTUFHSUNfU1lTUlE9eQpDT05G
SUdfREVCVUdfU1BJTkxPQ0s9eQojIENPTkZJR19ERUJVR19QQUdFQUxMT0Mg
aXMgbm90IHNldAojIENPTkZJR19ERUJVR19ISUdITUVNIGlzIG5vdCBzZXQK
IyBDT05GSUdfREVCVUdfSU5GTyBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19T
UElOTE9DS19TTEVFUD15CkNPTkZJR19GUkFNRV9QT0lOVEVSPXkKIyBDT05G
SUdfNEtTVEFDS1MgaXMgbm90IHNldApDT05GSUdfWDg2X0ZJTkRfU01QX0NP
TkZJRz15CkNPTkZJR19YODZfTVBQQVJTRT15CgojCiMgU2VjdXJpdHkgb3B0
aW9ucwojCiMgQ09ORklHX1NFQ1VSSVRZIGlzIG5vdCBzZXQKCiMKIyBDcnlw
dG9ncmFwaGljIG9wdGlvbnMKIwojIENPTkZJR19DUllQVE8gaXMgbm90IHNl
dAoKIwojIExpYnJhcnkgcm91dGluZXMKIwpDT05GSUdfQ1JDMzI9bQpDT05G
SUdfWkxJQl9JTkZMQVRFPXkKQ09ORklHX1g4Nl9TTVA9eQpDT05GSUdfWDg2
X0hUPXkKQ09ORklHX1g4Nl9CSU9TX1JFQk9PVD15CkNPTkZJR19YODZfVFJB
TVBPTElORT15CkNPTkZJR19QQz15Cg==

--0-23523166-1082168259=:77519--
