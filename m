Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267720AbUH0Vsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUH0Vsl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268856AbUH0Vpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:45:31 -0400
Received: from d3-153.vdsl.isp-service.de ([83.122.3.153]:21891 "EHLO
	fschueller.cgn.org") by vger.kernel.org with ESMTP id S268771AbUH0Vm5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:42:57 -0400
Date: Fri, 27 Aug 2004 23:41:52 +0200
From: Felix Schueller <fschueller@netcologne.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.8.1: kernel BUG at mm/rmap.c:407!
Message-ID: <20040827214152.GA7506@fschueller.cgn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

during long runs of make, linux 2.6.8.1 gives the following message:
(If you need more information (/proc/cpuinfo etc.), have a look at
http://www.netcologne.de/~nc-schuelfe/backtrace or send me an email.)

#v+
Compiling Mplayer:

console:

Message from syslogd@fschueller at Mon Aug 23 22:50:41 2004 ...
fschueller kernel: Trying to fix it up, but a reboot is needed

Message from syslogd@fschueller at Mon Aug 23 22:50:41 2004 ...
fschueller kernel: flags:0x00100004 mapping:c71d17b0 mapcount:1 count:0

Message from syslogd@fschueller at Mon Aug 23 22:50:41 2004 ...
fschueller kernel: Backtrace:

Message from syslogd@fschueller at Mon Aug 23 22:50:41 2004 ...
fschueller kernel: Bad page state at free_hot_cold_page (in process 'cc1', page c10184e0)
motion_est_template.c: In function `sab_diamond_search':
motion_est_template.c:759: internal compiler error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://gcc.gnu.org/bugs.html> for instructions.
cc: Internal error: Segmentation fault (program cc1)
Please submit a full bug report.
See <URL:http://gcc.gnu.org/bugs.html> for instructions.
make[1]: *** [motion_est.o] Error 1
make[1]: Leaving directory `/usr/src/MPlayer-1.0pre5/libavcodec'
make: *** [libavcodec/libavcodec.a] Error 2

syslog:

Aug 23 22:50:41 fschueller kernel: Bad page state at free_hot_cold_page (in process 'cc1', page c10184e0)
Aug 23 22:50:41 fschueller kernel: flags:0x00100004 mapping:c71d17b0 mapcount:1 count:0
Aug 23 22:50:41 fschueller kernel: Backtrace:
Aug 23 22:50:41 fschueller kernel:  [<c012ffec>] bad_page+0x4c/0x80
Aug 23 22:50:41 fschueller kernel:  [<c01306de>] free_hot_cold_page+0x3e/0x100
Aug 23 22:50:41 fschueller kernel:  [<c0130d37>] __pagevec_free+0x17/0x20
Aug 23 22:50:41 fschueller kernel:  [<c013638a>] release_pages+0x18a/0x1c0
Aug 23 22:50:41 fschueller kernel:  [<c01304b2>] rmqueue_bulk+0x32/0x80
Aug 23 22:50:41 fschueller kernel:  [<c01308c4>] buffered_rmqueue+0xe4/0x1c0
Aug 23 22:50:41 fschueller kernel:  [<c013664c>] __pagevec_lru_add_active+0xcc/0x100
Aug 23 22:50:41 fschueller kernel:  [<c01360db>] lru_cache_add_active+0x3b/0x60
Aug 23 22:50:41 fschueller kernel:  [<c013b1aa>] do_anonymous_page+0xea/0x180
Aug 23 22:50:41 fschueller kernel:  [<c013b291>] do_no_page+0x51/0x340
Aug 23 22:50:41 fschueller kernel:  [<c013b76f>] handle_mm_fault+0x10f/0x160
Aug 23 22:50:41 fschueller kernel:  [<c0110544>] do_page_fault+0x1e4/0x501
Aug 23 22:50:41 fschueller kernel:  [<c0109556>] old_mmap+0xb6/0x100
Aug 23 22:50:41 fschueller kernel:  [<c0110360>] do_page_fault+0x0/0x501
Aug 23 22:50:41 fschueller kernel:  [<c0103eed>] error_code+0x2d/0x40
Aug 23 22:50:41 fschueller kernel: Trying to fix it up, but a reboot is needed
Aug 23 22:50:41 fschueller kernel: ------------[ cut here ]------------
Aug 23 22:50:41 fschueller kernel: kernel BUG at mm/rmap.c:407!
Aug 23 22:50:41 fschueller kernel: invalid operand: 0000 [#1]
Aug 23 22:50:41 fschueller kernel: PREEMPT
Aug 23 22:50:41 fschueller kernel: Modules linked in: 8250 serial_core parport_pc lp parport af_packet ipt_ULOG ipt_MASQUERADE ipt_LOG ipt_state iptable_nat ip_conntrack iptable_filter ip_tables sis900 rtc reiserfs ipv6 unix
Aug 23 22:50:41 fschueller kernel: CPU:    0
Aug 23 22:50:41 fschueller kernel: EIP:    0060:[<c013f7ff>]    Not tainted
Aug 23 22:50:41 fschueller kernel: EFLAGS: 00010246   (2.6.8.1)
Aug 23 22:50:41 fschueller kernel: EIP is at page_remove_rmap+0x5f/0xa0
Aug 23 22:50:41 fschueller kernel: eax: 00000000   ebx: 00074000   ecx: 00000000   edx: c10184e0
Aug 23 22:50:41 fschueller kernel: esi: c0ff41d0   edi: 00093000   ebp: c10184e0   esp: c3b39ea4
Aug 23 22:50:41 fschueller kernel: ds: 007b   es: 007b   ss: 0068
Aug 23 22:50:41 fschueller kernel: Process cc1 (pid: 3311, threadinfo=c3b38000 task=c54547e0)
Aug 23 22:50:41 fschueller kernel: Stack: c0139a68 c10184e0 00c27067 42400000 c39d5424 42093000 00000000 c0139bf1
Aug 23 22:50:41 fschueller kernel:        c0304f48 c39d5420 42000000 00093000 00000000 c0304f48 42000000 c39d5424
Aug 23 22:50:41 fschueller kernel:        42093000 00000000 c0139c59 c0304f48 c39d5420 42000000 00093000 00000000
Aug 23 22:50:41 fschueller kernel: Call Trace:
Aug 23 22:50:41 fschueller kernel:  [<c0139a68>] zap_pte_range+0x128/0x260
Aug 23 22:50:41 fschueller kernel:  [<c0139bf1>] zap_pmd_range+0x51/0x80
Aug 23 22:50:41 fschueller kernel:  [<c0139c59>] unmap_page_range+0x39/0x60
Aug 23 22:50:41 fschueller kernel:  [<c0139d8e>] unmap_vmas+0x10e/0x200
Aug 23 22:50:41 fschueller kernel:  [<c013dce3>] exit_mmap+0x63/0x140
Aug 23 22:50:41 fschueller kernel:  [<c01132b9>] mmput+0x59/0x80
Aug 23 22:50:41 fschueller kernel:  [<c0117328>] do_exit+0x148/0x3e0
Aug 23 22:50:41 fschueller kernel:  [<c01175ee>] sys_exit+0xe/0x20
Aug 23 22:50:41 fschueller kernel:  [<c0103c87>] syscall_call+0x7/0xb
Aug 23 22:50:41 fschueller kernel: Code: 0f 0b 97 01 dd 4d 25 c0 eb a9 e9 b2 70 10 00 0f 0b 96 01 dd
Aug 23 22:50:41 fschueller kernel:  <6>note: cc1[3311] exited with preempt_count 1


Compiling Linux 2.6.8.1:

console:

  CC [M]  fs/nfsd/nfs4state.o

Message from syslogd@fschueller at Mon Aug 23 23:12:49 2004 ...
fschueller kernel: Bad page state at free_hot_cold_page (in process 'cc1', page c1048f80)

Message from syslogd@fschueller at Mon Aug 23 23:12:49 2004 ...
fschueller kernel: flags:0x20100004 mapping:c71ce798 mapcount:1 count:0

Message from syslogd@fschueller at Mon Aug 23 23:12:49 2004 ...
fschueller kernel: Backtrace:

Message from syslogd@fschueller at Mon Aug 23 23:12:49 2004 ...
fschueller kernel: Trying to fix it up, but a reboot is needed

Message from syslogd@fschueller at Mon Aug 23 23:12:50 2004 ...
fschueller kernel: Bad page state at free_hot_cold_page (in process 'cc1', page c1034ea0)

Message from syslogd@fschueller at Mon Aug 23 23:12:51 2004 ...
fschueller kernel: flags:0x20100004 mapping:c71ce798 mapcount:1 count:0

Message from syslogd@fschueller at Mon Aug 23 23:12:51 2004 ...
fschueller kernel: Backtrace:
fs/nfsd/nfs4state.c: In function `nfs4_share_conflict':
fs/nfsd/nfs4state.c:1131: internal compiler error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://gcc.gnu.org/bugs.html> for instructions.
gcc: Internal error: Segmentation fault (program cc1)
Please submit a full bug report.
See <URL:http://gcc.gnu.org/bugs.html> for instructions.
make[2]: *** [fs/nfsd/nfs4state.o] Error 1
make[1]: *** [fs/nfsd] Error 2
make: *** [fs] Error 2
23:12:51 /usr/src/linux#
Message from syslogd@fschueller at Mon Aug 23 23:12:51 2004 ...
fschueller kernel: Trying to fix it up, but a reboot is needed

Syslog:

Aug 23 23:12:49 fschueller kernel: Bad page state at free_hot_cold_page (in process 'cc1', page c1048f80)
Aug 23 23:12:49 fschueller kernel: flags:0x20100004 mapping:c71ce798 mapcount:1 count:0
Aug 23 23:12:49 fschueller kernel: Backtrace:
Aug 23 23:12:49 fschueller kernel:  [<c012ffec>] bad_page+0x4c/0x80
Aug 23 23:12:49 fschueller kernel:  [<c01306de>] free_hot_cold_page+0x3e/0x100
Aug 23 23:12:49 fschueller kernel:  [<c0130d37>] __pagevec_free+0x17/0x20
Aug 23 23:12:49 fschueller kernel:  [<c013638a>] release_pages+0x18a/0x1c0
Aug 23 23:12:49 fschueller kernel:  [<c01304b2>] rmqueue_bulk+0x32/0x80
Aug 23 23:12:49 fschueller kernel:  [<c01308c4>] buffered_rmqueue+0xe4/0x1c0
Aug 23 23:12:49 fschueller kernel:  [<c013664c>] __pagevec_lru_add_active+0xcc/0x100
Aug 23 23:12:49 fschueller kernel:  [<c01360db>] lru_cache_add_active+0x3b/0x60
Aug 23 23:12:49 fschueller kernel:  [<c013b1aa>] do_anonymous_page+0xea/0x180
Aug 23 23:12:49 fschueller kernel:  [<c013b291>] do_no_page+0x51/0x340
Aug 23 23:12:49 fschueller kernel:  [<c013a8cb>] do_wp_page+0x16b/0x340
Aug 23 23:12:49 fschueller kernel:  [<c013b76f>] handle_mm_fault+0x10f/0x160
Aug 23 23:12:49 fschueller kernel:  [<c0110544>] do_page_fault+0x1e4/0x501
Aug 23 23:12:49 fschueller kernel:  [<c011c729>] update_process_times+0x29/0x40
Aug 23 23:12:49 fschueller kernel:  [<c011c5eb>] update_wall_time+0xb/0x40
Aug 23 23:12:49 fschueller kernel:  [<c011c97f>] do_timer+0x5f/0xe0
Aug 23 23:12:49 fschueller kernel:  [<c0109045>] timer_interrupt+0x25/0x120
Aug 23 23:12:49 fschueller kernel:  [<c0118c02>] __do_softirq+0x42/0xa0
Aug 23 23:12:49 fschueller kernel:  [<c0110360>] do_page_fault+0x0/0x501
Aug 23 23:12:49 fschueller kernel:  [<c0103eed>] error_code+0x2d/0x40
Aug 23 23:12:49 fschueller kernel: Trying to fix it up, but a reboot is needed
Aug 23 23:12:50 fschueller kernel: Bad page state at free_hot_cold_page (in process 'cc1', page c1034ea0)
Aug 23 23:12:50 fschueller kernel: flags:0x20100004 mapping:c71ce798 mapcount:1 count:0
Aug 23 23:12:50 fschueller kernel: Backtrace:
Aug 23 23:12:50 fschueller kernel:  [<c012ffec>] bad_page+0x4c/0x80
Aug 23 23:12:50 fschueller kernel:  [<c01306de>] free_hot_cold_page+0x3e/0x100
Aug 23 23:12:50 fschueller kernel:  [<c0130d37>] __pagevec_free+0x17/0x20
Aug 23 23:12:50 fschueller kernel:  [<c013638a>] release_pages+0x18a/0x1c0
Aug 23 23:12:50 fschueller kernel:  [<c01304b2>] rmqueue_bulk+0x32/0x80
Aug 23 23:12:50 fschueller kernel:  [<c01308c4>] buffered_rmqueue+0xe4/0x1c0
Aug 23 23:12:50 fschueller kernel:  [<c013664c>] __pagevec_lru_add_active+0xcc/0x100
Aug 23 23:12:50 fschueller kernel:  [<c01360db>] lru_cache_add_active+0x3b/0x60
Aug 23 23:12:50 fschueller kernel:  [<c013b1aa>] do_anonymous_page+0xea/0x180
Aug 23 23:12:50 fschueller kernel:  [<c013b291>] do_no_page+0x51/0x340
Aug 23 23:12:51 fschueller kernel:  [<c013a8cb>] do_wp_page+0x16b/0x340
Aug 23 23:12:51 fschueller kernel:  [<c013b76f>] handle_mm_fault+0x10f/0x160
Aug 23 23:12:51 fschueller kernel:  [<c0110544>] do_page_fault+0x1e4/0x501
Aug 23 23:12:51 fschueller kernel:  [<c011c729>] update_process_times+0x29/0x40
Aug 23 23:12:51 fschueller kernel:  [<c011c5eb>] update_wall_time+0xb/0x40
Aug 25 23:12:51 fschueller kernel:  [<c011c97f>] do_timer+0x5f/0xe0
Aug 23 23:12:51 fschueller kernel:  [<c0109045>] timer_interrupt+0x25/0x120
Aug 23 23:12:51 fschueller kernel:  [<c0118c02>] __do_softirq+0x42/0xa0
Aug 23 23:12:51 fschueller kernel:  [<c0110360>] do_page_fault+0x0/0x501
Aug 23 23:12:51 fschueller kernel:  [<c0103eed>] error_code+0x2d/0x40
Aug 23 23:12:51 fschueller kernel: Trying to fix it up, but a reboot is needed
Aug 23 23:12:51 fschueller kernel: ------------[ cut here ]------------
Aug 23 23:12:51 fschueller kernel: kernel BUG at mm/rmap.c:407!
Aug 23 23:12:51 fschueller kernel: invalid operand: 0000 [#1]
Aug 23 23:12:51 fschueller kernel: PREEMPT
Aug 23 23:12:51 fschueller kernel: Modules linked in: 8250 serial_core parport_pc lp parport af_packet ipt_ULOG ipt_MASQUERADE ipt_LOG ipt_state iptable_nat ip_conntrack iptable_filter ip_tables sis900 rtc reiserfs ipv6 unix
Aug 23 23:12:51 fschueller kernel: CPU:    0
Aug 23 23:12:51 fschueller kernel: EIP:    0060:[<c013f7ff>]    Not tainted
Aug 23 23:12:51 fschueller kernel: EFLAGS: 00010246   (2.6.8.1)
Aug 23 23:12:51 fschueller kernel: EIP is at page_remove_rmap+0x5f/0xa0
Aug 23 23:12:51 fschueller kernel: eax: 00000000   ebx: 00074000   ecx: c1048f98   edx: c1048f80
Aug 23 23:12:51 fschueller kernel: esi: c1841e34   edi: 000e7000   ebp: c1048f80   esp: c6519ea4
Aug 23 23:12:51 fschueller kernel: ds: 007b   es: 007b   ss: 0068
Aug 23 23:12:51 fschueller kernel: Process cc1 (pid: 4365, threadinfo=c6518000 task=c6bf12c0)
Aug 23 23:12:51 fschueller kernel: Stack: c0139a68 c1048f80 0247c067 40b19000 c2262408 40800000 00000000 c0139bf1
Aug 23 23:12:51 fschueller kernel:        c0304f48 c2262404 40719000 000e7000 00000000 c0304f48 40719000 c2262408
Aug 23 23:12:51 fschueller kernel:        40819000 00000000 c0139c59 c0304f48 c2262404 40719000 00100000 00000000
Aug 23 23:12:51 fschueller kernel: Call Trace:
Aug 23 23:12:51 fschueller kernel:  [<c0139a68>] zap_pte_range+0x128/0x260
Aug 23 23:12:51 fschueller kernel:  [<c0139bf1>] zap_pmd_range+0x51/0x80
Aug 23 23:12:51 fschueller kernel:  [<c0139c59>] unmap_page_range+0x39/0x60
Aug 23 23:12:51 fschueller kernel:  [<c0139d8e>] unmap_vmas+0x10e/0x200
Aug 23 23:12:51 fschueller kernel:  [<c013dce3>] exit_mmap+0x63/0x140
Aug 23 23:12:51 fschueller kernel:  [<c01132b9>] mmput+0x59/0x80
Aug 23 23:12:51 fschueller kernel:  [<c0117328>] do_exit+0x148/0x3e0
Aug 23 23:12:51 fschueller kernel:  [<c01175ee>] sys_exit+0xe/0x20
Aug 23 23:12:51 fschueller kernel:  [<c0103c87>] syscall_call+0x7/0xb
Aug 23 23:12:51 fschueller kernel: Code: 0f 0b 97 01 dd 4d 25 c0 eb a9 e9 b2 70 10 00 0f 0b 96 01 dd
Aug 23 23:12:51 fschueller kernel:  <6>note: cc1[4365] exited with preempt_count 1
#v-

Cu
  Felix
