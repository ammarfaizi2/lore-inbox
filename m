Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266051AbUBCVyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 16:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266167AbUBCVyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 16:54:10 -0500
Received: from s4.uklinux.net ([80.84.72.14]:34519 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S266051AbUBCVyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 16:54:02 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>
	<20040202194626.191cbb95.akpm@osdl.org>
	<87llnk2js9.fsf@codematters.co.uk>
	<20040203132913.6145f4e6.akpm@osdl.org>
From: Philip Martin <philip@codematters.co.uk>
Date: Tue, 03 Feb 2004 21:53:27 +0000
In-Reply-To: <20040203132913.6145f4e6.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 3 Feb 2004 13:29:13 -0800")
Message-ID: <87znbzg78o.fsf@codematters.co.uk>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

>> 2.6.1
>
> Odd.  Are you really sure that it was the correct System.map?

I think so. I always build kernels using Debian's kernel-package so
both vmlinuz and System.map get placed into a .deb package as
vmlinuz-2.6.1 and System.map-2.6.1.

$ ls -l /boot/Sys*
-rw-r--r--    1 root     root       492205 Dec  1 19:27 /boot/System.map-2.4.23
-rw-r--r--    1 root     root       492205 Jan  5 21:21 /boot/System.map-2.4.24
-rw-r--r--    1 root     root       715800 Feb  1 21:02 /boot/System.map-2.6.1

$ ls -l /boot/vm*
-rw-r--r--    1 root     root       880826 Dec  1 19:27 /boot/vmlinuz-2.4.23
-rw-r--r--    1 root     root       880822 Jan  5 21:21 /boot/vmlinuz-2.4.24
-rw-r--r--    1 root     root      1095040 Feb  1 21:02 /boot/vmlinuz-2.6.1

Hmm, I see that my 2.6.1 image is 25% bigger than 2.4.24, I'd not
noticed that before.

I have just tried another 2.6 profile run and got similar results.

248.88user 122.00system 3:41.18elapsed 167%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (453major+3770323minor)pagefaults 0swaps

c011e158 add_wait_queue                              442   5.5250
c010b1e0 error_code                                  444   7.9286
c0114658 sched_clock                                 460   3.8333
c0108ac8 copy_thread                                 473   0.8631
c01229e0 wait_task_zombie                            488   1.0252
c010a79c syscall_call                                489  44.4545
c0127a1c del_timer_sync                              529   4.0076
c0128d18 flush_signal_handlers                       592   8.7059
c010c570 handle_IRQ_event                            597   6.7841
c011fbe0 do_fork                                     606   1.5947
c0121970 put_files_struct                            616   3.2083
c0123ec0 do_softirq                                  617   3.0245
c011add4 wake_up_forked_process                      776   1.9020
c0110d1c old_mmap                                    868   2.6790
c012c638 sys_rt_sigaction                            942   3.8607
c0122d78 sys_wait4                                   958   1.6404
c01168b8 flush_tlb_mm                               1040   7.0270
c012b0a4 get_signal_to_deliver                      1385   1.4610
c0123e38 current_kernel_time                        1487  21.8676
c011afc8 schedule_tail                              1606   8.9222
c01223e8 do_exit                                    1807   1.8514
c011df4f .text.lock.sched                           2302   7.9654
c012b560 sys_rt_sigprocmask                         2417   7.0262
c012c0a0 do_sigaction                               2736   4.0473
c011e3c8 dup_task_struct                            3034  22.3088
c011ec08 copy_files                                 3103   3.5261
c011de6c __preempt_spin_lock                        3171  39.6375
c012b474 sigprocmask                                3387  14.3517
c011c2e0 __wake_up                                  3699  48.6711
c0121d58 exit_notify                                3780   2.2500
c0121150 release_task                               4071   7.4288
c011694c flush_tlb_page                             7069  44.1812
c011bbf0 schedule                                   7123   4.4519
c011e6d4 copy_mm                                    7826   7.5833
c010a770 system_call                                8249 187.4773
c011efe0 copy_process                               8760   2.8516
c0119588 pte_alloc_one                             16097 251.5156
c01199b8 do_page_fault                             44492  37.3255
c01086b0 default_idle                             937243 18023.9038
00000000 total                                    1095569   6.7218

-- 
Philip Martin
