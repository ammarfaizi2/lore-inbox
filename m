Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbUDIHRm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 03:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUDIHRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 03:17:42 -0400
Received: from village.ehouse.ru ([193.111.92.18]:58372 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261790AbUDIHRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 03:17:07 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.X kernel memory leak?
Date: Fri, 9 Apr 2004 11:17:00 +0400
User-Agent: KMail/1.6
Cc: Anton Kovalenko <anton@megashop.ru>
References: <200401311940.28078.rathamahata@php4.ru> <200402281756.08260.rathamahata@php4.ru> <200404081308.43056.rathamahata@php4.ru>
In-Reply-To: <200404081308.43056.rathamahata@php4.ru>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404091117.01011.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 April 2004 13:08, Sergey S. Kostyliov wrote:
> Hello all,
> 
> On Saturday 28 February 2004 17:56, Sergey S. Kostyliov wrote:
> > On Thursday 26 February 2004 23:03, Andrew Morton wrote:
> > <cut>
> > > OK, thanks.  Is there any possibility that you can run without iptables for
> > > a while, see if that fixes it?
> > 
> > I recompiled 2.6.3 without iptables support, unfortunately it doesn't
> > solve the problem, machine still hangs.
> 
> It looks like problem hasn't gone away in the last kernels. The visible
> symptoms haven't changed: machine is pingable, tcp ports which were in
> LISTEN state remains to be in LISTEN after lockup, nothing else.
> 
> The last one is for different machine than in my previous reports,
> so I suspect this is not a hardware issue. Kernel is 2.6.5-aa3 but
> I believe Andrea's changes is not related to this problem.
> 
> sysrq-M
> 	http://sysadminday.org.ru/2.6.X-lockup/terror/20040408/sysrq-M
> 
> sysrq-T
> 	http://sysadminday.org.ru/2.6.X-lockup/terror/20040408/sysrq-T
> 
> .config
> 	http://sysadminday.org.ru/2.6.X-lockup/terror/.config
> 
> `lspci -vv'
> 	http://sysadminday.org.ru/2.6.X-lockup/terror/lspci_-vv
> 
> `dmesg'
> 	http://sysadminday.org.ru/2.6.X-lockup/terror/dmesg
> 
> /etc/fstab
> 	http://sysadminday.org.ru/2.6.X-lockup/terror/fstab
> 
> 

And here is part of sysrq-T for the third machine, which have just locked up,
kernel is 2.6.5-rc3-aa2.

multilog      S F7BF3D60     0  3302   3288                     (NOTLB)
f7b83ed8 00000082 00000001 f7bf3d60 f7b83e9c c011a771 f7a4db80 00000000
       00000003 f7bf3d58 f7b82000 00000282 f7aaece0 00000000 0804ea70 f7aaece0
       f7aaed00 c180dbe0 0000111c 19e0b9c6 0001faed f7a89a70 f7b83f00 f7a6bb80
Call Trace:
 [<c011a771>] __wake_up_common+0x31/0x60
 [<c016ee7c>] pipe_wait+0x7c/0xa0
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c016f07a>] pipe_readv+0x1da/0x2c0
 [<c016f180>] pipe_read+0x20/0x30
 [<c0160cc0>] vfs_read+0xb0/0x110
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

qmail-lspawn  S C030D340     0  3325   3301          3326       (NOTLB)
f74c5ea4 00000082 c0117444 c030d340 00000246 01470f60 f7cd8b80 c030d6d0
       00000000 c030d6c0 c1382d20 00000000 00000000 19c98941 0001faed f7aaece0
       f7aaed00 c1815be0 00004ec0 19ca1051 0001faed f7bb3a10 00000010 f74c5eb4
Call Trace:
 [<c0117444>] do_page_fault+0x304/0x4ef
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c0175a90>] __pollwait+0x80/0xd0
 [<c016f5d2>] pipe_poll+0x32/0x90
 [<c0175da2>] do_select+0x1c2/0x330
 [<c0175a10>] __pollwait+0x0/0xd0
 [<c017620e>] sys_select+0x2de/0x4d0
 [<c016030f>] filp_close+0x4f/0x80
 [<c01073c9>] sysenter_past_esp+0x52/0x71

qmail-rspawn  S C030D300     0  3326   3301          3327  3325 (NOTLB)
f74d9ea4 00000082 f74d8000 c030d300 00000246 01468f60 f7a9eb80 c181756c
       f74d9e58 c030d680 c11654c0 00000000 00000000 c0118397 00000000 f7aaece0
       f7aaed00 c180dbe0 0000f336 ad9386e9 000010b2 f747bad0 cbf9ff0c f74d9eb4
Call Trace:
 [<c0118397>] recalc_task_prio+0x97/0x1c0
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c0175a90>] __pollwait+0x80/0xd0
 [<c016f5d2>] pipe_poll+0x32/0x90
 [<c0175da2>] do_select+0x1c2/0x330
 [<c0175a10>] __pollwait+0x0/0xd0
 [<c017620e>] sys_select+0x2de/0x4d0
 [<c016030f>] filp_close+0x4f/0x80
 [<c01073c9>] sysenter_past_esp+0x52/0x71

qmail-clean   S 00000012     0  3327   3301                3326 (NOTLB)
f7445ed8 00000082 f7445f00 00000012 c01bfa2f 00000000 f7a9e280 f7445ea8
       c0118397 b1f8808e 3cc9b81f f7a9e940 19ec7e20 0001faed c180dbe0 e8af92d0
       e8af92f0 c1815be0 00008b3e 19ecb28e 0001faed f747b500 00000082 f74dbf00
Call Trace:
 [<c01bfa2f>] do_journal_end+0xcf/0xbe0
 [<c0118397>] recalc_task_prio+0x97/0x1c0
 [<c016ee7c>] pipe_wait+0x7c/0xa0
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c016f07a>] pipe_readv+0x1da/0x2c0
 [<c016f42d>] pipe_writev+0x29d/0x360
 [<c016f180>] pipe_read+0x20/0x30
 [<c0160cc0>] vfs_read+0xb0/0x110
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

proftpd       D 00000000     0  3328      1          3364  3282 (NOTLB)
f7413d34 00000086 00000000 00000000 00000000 00000000 f7a9edc0 00000000
       00000000 00000000 00000000 00000000 f7412000 00000000 00000246 f73d0da0
       f73d0dc0 c180dbe0 000005ed 980d0112 000222af f747af30 00000000 c030dc20
Call Trace:
 [<c0129642>] schedule_timeout+0x72/0xd0
 [<c01295c0>] process_timeout+0x0/0x10
 [<c011bfa8>] io_schedule_timeout+0x28/0x40
 [<c020e8ab>] blk_congestion_wait+0x7b/0x90
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c014205b>] __alloc_pages+0x29b/0x330
 [<c0144e8d>] do_page_cache_readahead+0x1cd/0x280
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c013e49f>] filemap_nopage+0x17f/0x460
 [<c015004b>] do_no_page+0xdb/0x680
 [<c013cc31>] unlock_page+0x11/0x60
 [<c014f435>] do_wp_page+0x4c5/0x570
 [<c015081c>] handle_mm_fault+0xec/0x1d0
 [<c0117444>] do_page_fault+0x304/0x4ef
 [<c010f555>] convert_fxsr_from_user+0x15/0xe0
 [<c010f92c>] restore_i387+0x8c/0x90
 [<c01066b4>] restore_sigcontext+0x114/0x130
 [<c01067b2>] sys_sigreturn+0xe2/0x150
 [<c0117140>] do_page_fault+0x0/0x4ef
 [<c0107e85>] error_code+0x2d/0x38

sshd          D 00000000     0  3364      1  3238    3391  3328 (NOTLB)
f73f7d18 00000082 00000000 00000000 00000000 00000000 f7a5d040 00000000
       00000000 00000000 00000000 00000000 f73f6000 00000000 00000246 00000000
       ffffffff c1815be0 00000149 de751563 000222af f740cf50 00000000 c030dc20
Call Trace:
 [<c0129642>] schedule_timeout+0x72/0xd0
 [<c01295c0>] process_timeout+0x0/0x10
 [<c011bfa8>] io_schedule_timeout+0x28/0x40
 [<c020e8ab>] blk_congestion_wait+0x7b/0x90
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c014205b>] __alloc_pages+0x29b/0x330
 [<c015bc11>] read_swap_cache_async+0x101/0x10d
 [<c014f79f>] swapin_readahead+0x2f/0xd0
 [<c014fb57>] do_swap_page+0x317/0x430
 [<c014d835>] pte_alloc_map+0xc5/0x130
 [<c01507f8>] handle_mm_fault+0xc8/0x1d0
 [<c0117444>] do_page_fault+0x304/0x4ef
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c0175a90>] __pollwait+0x80/0xd0
 [<c028bd2d>] tcp_poll+0x1d/0x170
 [<c0175a04>] do_select+0x1e7/0x330
 [<c0117140>] do_page_fault+0x0/0x4ef
 [<c0107e85>] error_code+0x2d/0x38
 [<c017007b>] get_write_access+0x4b/0xe0
 [<c01cf8e0>] __copy_to_user_ll+0x40/0x60
 [<c01762e7>] sys_select+0x3b7/0x4d0
 [<c010f92c>] restore_i387+0x8c/0x90
 [<c01066b4>] restore_sigcontext+0x114/0x130
 [<c01073c9>] sysenter_past_esp+0x52/0x71

cron          D 00000000     0  3391      1  6677    3401  3364 (NOTLB)
f73cbd34 00000082 00000000 00000000 00000000 00000000 f7bd5280 00000000
       00000000 00000000 00000000 00000000 f73ca000 00000000 00000246 00000000
       ffffffff c180dbe0 00000180 980ff35e 000222af f73d0f70 00000000 c030dc20
Call Trace:
 [<c0129642>] schedule_timeout+0x72/0xd0
 [<c01295c0>] process_timeout+0x0/0x10
 [<c011bfa8>] io_schedule_timeout+0x28/0x40
 [<c020e8ab>] blk_congestion_wait+0x7b/0x90
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c014205b>] __alloc_pages+0x29b/0x330
 [<c011a2c9>] schedule+0x389/0x7a0
 [<c0144e8d>] do_page_cache_readahead+0x1cd/0x280
 [<c013e49f>] filemap_nopage+0x17f/0x460
 [<c015004b>] do_no_page+0xdb/0x680
 [<c015081c>] handle_mm_fault+0xec/0x1d0
 [<c0117444>] do_page_fault+0x304/0x4ef
 [<c016c10b>] sys_stat64+0x2b/0x30
 [<c0117140>] do_page_fault+0x0/0x4ef
 [<c0107e85>] error_code+0x2d/0x38

agetty        D 00000000     0  3401      1          3402  3391 (NOTLB)
f7badc54 00000086 00000000 00000000 00000000 00000000 f7b07dc0 00000000
       00000000 00000000 00000000 00000000 f7bac000 c180e540 c01287ac 00000000
       ffffffff c180dbe0 00018704 9823a1c3 000222af f7a88ed0 00000000 c030dc20
Call Trace:
 [<c01287ac>] __mod_timer+0x23c/0x370
 [<c0129642>] schedule_timeout+0x72/0xd0
 [<c01295c0>] process_timeout+0x0/0x10
 [<c011bfa8>] io_schedule_timeout+0x28/0x40
 [<c020e8ab>] blk_congestion_wait+0x7b/0x90
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c014205b>] __alloc_pages+0x29b/0x330
 [<c015bc11>] read_swap_cache_async+0x101/0x10d
 [<c014f79f>] swapin_readahead+0x2f/0xd0
 [<c014fb57>] do_swap_page+0x317/0x430
 [<c014d835>] pte_alloc_map+0xc5/0x130
 [<c01507f8>] handle_mm_fault+0xc8/0x1d0
 [<c0117444>] do_page_fault+0x304/0x4ef
 [<c011a2c9>] schedule+0x389/0x7a0
 [<c01bee6f>] journal_end+0xf/0x20
 [<c01aeac7>] reiserfs_dirty_inode+0x77/0x110
 [<c0117140>] do_page_fault+0x0/0x4ef
 [<c0107e85>] error_code+0x2d/0x38
 [<c025007b>] sg_res_in_use+0x6b/0x80
 [<c01cf8e0>] __copy_to_user_ll+0x40/0x60
 [<c01fa91d>] read_chan+0x5dd/0xb00
 [<c011a730>] default_wake_function+0x0/0x10
 [<c011a730>] default_wake_function+0x0/0x10
 [<c014e246>] unmap_vmas+0xf6/0x310
 [<c011a730>] default_wake_function+0x0/0x10
 [<c01f46dd>] tty_write+0x1ad/0x360
 [<c01f44f6>] tty_read+0x176/0x1b0
 [<c0160cc0>] vfs_read+0xb0/0x110
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

agetty        S F7D2E800     0  3402      1          3403  3401 (NOTLB)
f7a87e58 00000082 00000000 f7d2e800 f7a87e20 f78200d8 f7b07b80 f7820114
       c01bee6f 00000000 c01aeac7 000000ff 00000000 c02d88f7 00000000 00000001
       0064d901 c180dbe0 000850e1 ef9caa45 00000013 f7a414e0 00000286 f7d2e800
Call Trace:
 [<c01bee6f>] journal_end+0xf/0x20
 [<c01aeac7>] reiserfs_dirty_inode+0x77/0x110
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c0205ba3>] do_con_write+0x2b3/0x740
 [<c01facaa>] read_chan+0x96a/0xb00
 [<c011a730>] default_wake_function+0x0/0x10
 [<c011a730>] default_wake_function+0x0/0x10
 [<c014e246>] unmap_vmas+0xf6/0x310
 [<c011a730>] default_wake_function+0x0/0x10
 [<c01f46dd>] tty_write+0x1ad/0x360
 [<c01f44f6>] tty_read+0x176/0x1b0
 [<c0160cc0>] vfs_read+0xb0/0x110
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

agetty        S 00003500     0  3403      1          3404  3402 (NOTLB)
f73e5e58 00000082 00000000 00003500 175c6fc1 f7de0844 f7b07940 e05da8c0
       00000011 00000000 f7de9220 c192f000 c0283e93 c192f000 00000000 f7de9220
       f7de0830 c180dbe0 000b78d0 ef8aa30a 00000013 f740c980 00000286 f7d2e800
Call Trace:
 [<c0283e93>] ip_local_deliver+0xd3/0x1f0
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c0205ba3>] do_con_write+0x2b3/0x740
 [<c01facaa>] read_chan+0x96a/0xb00
 [<c011a730>] default_wake_function+0x0/0x10
 [<c011a730>] default_wake_function+0x0/0x10
 [<c014e246>] unmap_vmas+0xf6/0x310
 [<c011a730>] default_wake_function+0x0/0x10
 [<c01f46dd>] tty_write+0x1ad/0x360
 [<c01f44f6>] tty_read+0x176/0x1b0
 [<c0160cc0>] vfs_read+0xb0/0x110
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

agetty        S 00000000     0  3404      1          3405  3403 (NOTLB)
f74c3e58 00000082 000001ff 00000000 00000003 00000000 f7a4d280 00000000
       00020000 00000000 f74c3e6c 000000ff 00000000 00000000 00000000 00000003
       00000286 c1815be0 0007e435 ef918c51 00000013 f7bb3440 00000286 00000000
Call Trace:
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c0205ba3>] do_con_write+0x2b3/0x740
 [<c01facaa>] read_chan+0x96a/0xb00
 [<c011a730>] default_wake_function+0x0/0x10
 [<c011a730>] default_wake_function+0x0/0x10
 [<c014e246>] unmap_vmas+0xf6/0x310
 [<c011a730>] default_wake_function+0x0/0x10
 [<c01f46dd>] tty_write+0x1ad/0x360
 [<c01f44f6>] tty_read+0x176/0x1b0
 [<c0160cc0>] vfs_read+0xb0/0x110
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

agetty        S 00000000     0  3405      1          3406  3404 (NOTLB)
f73cfe58 00000086 000001ff 00000000 00000004 00000000 f7a6a4c0 00000000
       00020000 00000000 f73cfe6c 000000ff 00000000 00000000 00000000 00000004
       00000286 c180dbe0 00084d71 efb34714 00000013 f73d1b10 00000286 00000000
Call Trace:
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c0205ba3>] do_con_write+0x2b3/0x740
 [<c01facaa>] read_chan+0x96a/0xb00
 [<c011a730>] default_wake_function+0x0/0x10
 [<c011a730>] default_wake_function+0x0/0x10
 [<c014e246>] unmap_vmas+0xf6/0x310
 [<c011a730>] default_wake_function+0x0/0x10
 [<c01f46dd>] tty_write+0x1ad/0x360
 [<c01f44f6>] tty_read+0x176/0x1b0
 [<c0160cc0>] vfs_read+0xb0/0x110
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

agetty        S F7D2E800     0  3406      1          4611  3405 (NOTLB)
f73e3e58 00000082 00000000 f7d2e800 f73e3e20 f78200d8 f7cd8040 f7820114
       c01bee6f 00000000 c01aeac7 000000ff 00000000 c02d88f7 00000000 00000001
       0064d901 c1815be0 0007cc5c efa78898 00000013 f740c3b0 00000286 f7d2e800
Call Trace:
 [<c01bee6f>] journal_end+0xf/0x20
 [<c01aeac7>] reiserfs_dirty_inode+0x77/0x110
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c0205ba3>] do_con_write+0x2b3/0x740
 [<c01facaa>] read_chan+0x96a/0xb00
 [<c011a730>] default_wake_function+0x0/0x10
 [<c011a730>] default_wake_function+0x0/0x10
 [<c014e246>] unmap_vmas+0xf6/0x310
 [<c011a730>] default_wake_function+0x0/0x10
 [<c01f46dd>] tty_write+0x1ad/0x360
 [<c01f44f6>] tty_read+0x176/0x1b0
 [<c0160cc0>] vfs_read+0xb0/0x110
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

ntpd          D 00000000     0  4611      1                3406 (NOTLB)
ce397bd0 00000082 00000000 00000000 00000000 00000000 f7bd5b80 00000000
       00000000 00000000 00000000 00000000 ce396000 00000000 00000246 f7bb2100
       f7bb2120 c1815be0 0000018d f19a9e2b 000222af cc3de3b0 00000000 c030dc20
Call Trace:
 [<c0129642>] schedule_timeout+0x72/0xd0
 [<c01295c0>] process_timeout+0x0/0x10
 [<c011bfa8>] io_schedule_timeout+0x28/0x40
 [<c020e8ab>] blk_congestion_wait+0x7b/0x90
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c014205b>] __alloc_pages+0x29b/0x330
 [<c013cf9d>] find_lock_page+0x4d/0x270
 [<c013f42c>] generic_file_aio_write_nolock+0x33c/0xba0
 [<c0148054>] mark_page_accessed+0x34/0x40
 [<c0164052>] __find_get_block+0x62/0xc0
 [<c0164052>] __find_get_block+0x62/0xc0
 [<c01b6c92>] search_by_key+0x642/0xe10
 [<c013fced>] generic_file_write_nolock+0x5d/0x80
 [<c019fa27>] reiserfs_find_entry+0x97/0x150
 [<c013fddf>] generic_file_write+0x3f/0x60
 [<c01aa31f>] reiserfs_file_write+0x7ff/0x810
 [<c019fbfc>] reiserfs_lookup+0x11c/0x1f0
 [<c0130dd9>] in_group_p+0x39/0x70
 [<c016ff29>] vfs_permission+0x79/0x140
 [<c017a24c>] dput+0x1c/0x3a0
 [<c01701fa>] path_release+0xa/0x30
 [<c0171be7>] open_namei+0xb7/0x3e0
 [<c015fc6d>] filp_open+0x2d/0x60
 [<c0160e80>] vfs_write+0xb0/0x110
 [<c0160f78>] sys_write+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

httpd         D 00000000     0 12739   3100         12740       (NOTLB)
ee10dc70 00000086 00000000 00000000 00000000 00000000 f7a9c4c0 00000000
       00000000 00000000 00000000 00000000 ee10c000 9821ec28 000222af eff200a0
       eff200c0 c180dbe0 00000644 9821eff8 000222af f714e3f0 00000000 c030dc20
Call Trace:
 [<c0129642>] schedule_timeout+0x72/0xd0
 [<c01295c0>] process_timeout+0x0/0x10
 [<c011bfa8>] io_schedule_timeout+0x28/0x40
 [<c020e8ab>] blk_congestion_wait+0x7b/0x90
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c014205b>] __alloc_pages+0x29b/0x330
 [<c015bc11>] read_swap_cache_async+0x101/0x10d
 [<c014f79f>] swapin_readahead+0x2f/0xd0
 [<c014fb57>] do_swap_page+0x317/0x430
 [<c014d835>] pte_alloc_map+0xc5/0x130
 [<c01507f8>] handle_mm_fault+0xc8/0x1d0
 [<c0117444>] do_page_fault+0x304/0x4ef
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c02688fa>] lock_sock+0x6a/0xc0
 [<c0268e09>] __kfree_skb+0x79/0x100
 [<c02905fc>] wait_for_connect+0xec/0x110
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c0117140>] do_page_fault+0x0/0x4ef
 [<c0107e85>] error_code+0x2d/0x38
 [<c01cf529>] __get_user_4+0x11/0x17
 [<c0264955>] move_addr_to_user+0x25/0x90
 [<c017dab0>] new_inode+0x10/0xc0
 [<c0265f7c>] sys_accept+0xec/0x160
 [<c028fd7b>] tcp_close+0x36b/0x720
 [<c0266b05>] sys_socketcall+0xf5/0x2a0
 [<c01073c9>] sysenter_past_esp+0x52/0x71

httpd         D 00000000     0 12740   3100         12741 12739 (NOTLB)
dc433c70 00000086 00000000 00000000 00000000 00000000 e45efdc0 00000000
       00000000 00000000 00000000 00000000 dc432000 00000000 00000246 f714e220
       f714e240 c180dbe0 0000022d 981ea476 000222af eff219b0 00000000 c030dc20
Call Trace:
 [<c0129642>] schedule_timeout+0x72/0xd0
 [<c01295c0>] process_timeout+0x0/0x10
 [<c011bfa8>] io_schedule_timeout+0x28/0x40
 [<c020e8ab>] blk_congestion_wait+0x7b/0x90
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c014205b>] __alloc_pages+0x29b/0x330
 [<c015bc11>] read_swap_cache_async+0x101/0x10d
 [<c014f79f>] swapin_readahead+0x2f/0xd0
 [<c014fb57>] do_swap_page+0x317/0x430
 [<c014d835>] pte_alloc_map+0xc5/0x130
 [<c01507f8>] handle_mm_fault+0xc8/0x1d0
 [<c0117444>] do_page_fault+0x304/0x4ef
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c02688fa>] lock_sock+0x6a/0xc0
 [<c0268e09>] __kfree_skb+0x79/0x100
 [<c02905fc>] wait_for_connect+0xec/0x110
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c0117140>] do_page_fault+0x0/0x4ef
 [<c0107e85>] error_code+0x2d/0x38
 [<c01cf529>] __get_user_4+0x11/0x17
 [<c0264955>] move_addr_to_user+0x25/0x90
 [<c017dab0>] new_inode+0x10/0xc0
 [<c0265f7c>] sys_accept+0xec/0x160
 [<c028fd7b>] tcp_close+0x36b/0x720
 [<c0266b05>] sys_socketcall+0xf5/0x2a0
 [<c01073c9>] sysenter_past_esp+0x52/0x71

httpd         D 00000000     0 12741   3100         12742 12740 (NOTLB)
f580dc70 00000086 00000000 00000000 00000000 00000000 f7a6a700 00000000
       00000000 00000000 00000000 00000000 f580c000 00000000 00000246 00000000
       ffffffff c1815be0 00000182 fdf459c5 000222af f7a63a90 00000000 c030dc20
Call Trace:
 [<c0129642>] schedule_timeout+0x72/0xd0
 [<c01295c0>] process_timeout+0x0/0x10
 [<c011bfa8>] io_schedule_timeout+0x28/0x40
 [<c020e8ab>] blk_congestion_wait+0x7b/0x90
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c014205b>] __alloc_pages+0x29b/0x330
 [<c015bc11>] read_swap_cache_async+0x101/0x10d
 [<c014f79f>] swapin_readahead+0x2f/0xd0
 [<c014fb57>] do_swap_page+0x317/0x430
 [<c014d835>] pte_alloc_map+0xc5/0x130
 [<c01507f8>] handle_mm_fault+0xc8/0x1d0
 [<c0117444>] do_page_fault+0x304/0x4ef
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c02688fa>] lock_sock+0x6a/0xc0
 [<c0268e09>] __kfree_skb+0x79/0x100
 [<c02905fc>] wait_for_connect+0xec/0x110
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c0117140>] do_page_fault+0x0/0x4ef
 [<c0107e85>] error_code+0x2d/0x38
 [<c01cf529>] __get_user_4+0x11/0x17
 [<c0264955>] move_addr_to_user+0x25/0x90
 [<c017dab0>] new_inode+0x10/0xc0
 [<c0265f7c>] sys_accept+0xec/0x160
 [<c028fd7b>] tcp_close+0x36b/0x720
 [<c0266b05>] sys_socketcall+0xf5/0x2a0
 [<c01073c9>] sysenter_past_esp+0x52/0x71

httpd         R running     0 12742   3100         12743 12741 (NOTLB)
httpd         D 00000000     0 12743   3100         13713 12742 (NOTLB)
f7501c70 00000086 00000000 00000000 00000000 00000000 f7a9e700 00000000
       00000000 00000000 00000000 00000000 f7500000 00000000 00000246 f73d07d0
       f73d07f0 c1815be0 0000015c 0315f596 000222b0 f7c9d9f0 00000000 c030dc20
Call Trace:
 [<c0129642>] schedule_timeout+0x72/0xd0
 [<c01295c0>] process_timeout+0x0/0x10
 [<c011bfa8>] io_schedule_timeout+0x28/0x40
 [<c020e8ab>] blk_congestion_wait+0x7b/0x90
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c014205b>] __alloc_pages+0x29b/0x330
 [<c015bc11>] read_swap_cache_async+0x101/0x10d
 [<c014f79f>] swapin_readahead+0x2f/0xd0
 [<c014fb57>] do_swap_page+0x317/0x430
 [<c014d835>] pte_alloc_map+0xc5/0x130
 [<c01507f8>] handle_mm_fault+0xc8/0x1d0
 [<c0117444>] do_page_fault+0x304/0x4ef
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c02688fa>] lock_sock+0x6a/0xc0
 [<c0268e09>] __kfree_skb+0x79/0x100
 [<c02905fc>] wait_for_connect+0xec/0x110
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c0117140>] do_page_fault+0x0/0x4ef
 [<c0107e85>] error_code+0x2d/0x38
 [<c01cf529>] __get_user_4+0x11/0x17
 [<c0264955>] move_addr_to_user+0x25/0x90
 [<c017dab0>] new_inode+0x10/0xc0
 [<c0265f7c>] sys_accept+0xec/0x160
 [<c028fd7b>] tcp_close+0x36b/0x720
 [<c0266b05>] sys_socketcall+0xf5/0x2a0
 [<c01073c9>] sysenter_past_esp+0x52/0x71

httpd         D 00000000     0 13713   3100         19047 12743 (NOTLB)
df9a5c70 00000082 00000000 00000000 00000000 00000000 e45ef280 00000000
       00000000 00000000 00000000 00000000 df9a4000 00000000 00000246 00000000
       ffffffff c180dbe0 000001f6 976392ca 000222af f714e9c0 00000000 c030dc20
Call Trace:
 [<c0129642>] schedule_timeout+0x72/0xd0
 [<c01295c0>] process_timeout+0x0/0x10
 [<c011bfa8>] io_schedule_timeout+0x28/0x40
 [<c020e8ab>] blk_congestion_wait+0x7b/0x90
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c014205b>] __alloc_pages+0x29b/0x330
 [<c015bc11>] read_swap_cache_async+0x101/0x10d
 [<c014f79f>] swapin_readahead+0x2f/0xd0
 [<c014fb57>] do_swap_page+0x317/0x430
 [<c014d835>] pte_alloc_map+0xc5/0x130
 [<c01507f8>] handle_mm_fault+0xc8/0x1d0
 [<c0117444>] do_page_fault+0x304/0x4ef
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c02688fa>] lock_sock+0x6a/0xc0
 [<c0268e09>] __kfree_skb+0x79/0x100
 [<c02905fc>] wait_for_connect+0xec/0x110
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c0117140>] do_page_fault+0x0/0x4ef
 [<c0107e85>] error_code+0x2d/0x38
 [<c01cf529>] __get_user_4+0x11/0x17
 [<c0264955>] move_addr_to_user+0x25/0x90
 [<c017dab0>] new_inode+0x10/0xc0
 [<c0265f7c>] sys_accept+0xec/0x160
 [<c014e121>] unmap_page_range+0x31/0x60
 [<c014e246>] unmap_vmas+0xf6/0x310
 [<c01488ff>] __pagevec_lru_add_active+0x13f/0x1b0
 [<c017a24c>] dput+0x1c/0x3a0
 [<c0161d39>] __fput+0xb9/0x120
 [<c0266b05>] sys_socketcall+0xf5/0x2a0
 [<c0152ce4>] do_munmap+0x154/0x1b0
 [<c01073c9>] sysenter_past_esp+0x52/0x71

httpd         D 00000000     0 19047   3100               13713 (NOTLB)
c5e5dc70 00000082 00000000 00000000 00000000 00000000 f7a9e040 00000000
       00000000 00000000 00000000 00000000 c5e5c000 00000000 00000246 f740cd80
       f740cda0 c1815be0 00000160 0cfd8041 000222b0 eff20840 00000000 c030dc20
Call Trace:
 [<c0129642>] schedule_timeout+0x72/0xd0
 [<c01295c0>] process_timeout+0x0/0x10
 [<c011bfa8>] io_schedule_timeout+0x28/0x40
 [<c020e8ab>] blk_congestion_wait+0x7b/0x90
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c014205b>] __alloc_pages+0x29b/0x330
 [<c015bc11>] read_swap_cache_async+0x101/0x10d
 [<c014f79f>] swapin_readahead+0x2f/0xd0
 [<c014fb57>] do_swap_page+0x317/0x430
 [<c014d835>] pte_alloc_map+0xc5/0x130
 [<c01507f8>] handle_mm_fault+0xc8/0x1d0
 [<c0117444>] do_page_fault+0x304/0x4ef
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c02688fa>] lock_sock+0x6a/0xc0
 [<c0268e09>] __kfree_skb+0x79/0x100
 [<c02905fc>] wait_for_connect+0xec/0x110
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c0117140>] do_page_fault+0x0/0x4ef
 [<c0107e85>] error_code+0x2d/0x38
 [<c01cf529>] __get_user_4+0x11/0x17
 [<c0264955>] move_addr_to_user+0x25/0x90
 [<c017dab0>] new_inode+0x10/0xc0
 [<c0265f7c>] sys_accept+0xec/0x160
 [<c028fd7b>] tcp_close+0x36b/0x720
 [<c0266b05>] sys_socketcall+0xf5/0x2a0
 [<c01073c9>] sysenter_past_esp+0x52/0x71

sshd          S C3331DA4     0  3238   3364  3247    3756       (NOTLB)
c3331d7c 00000086 c3331e50 c3331da4 00000000 c3331e50 c1fa6dc0 00000000
       000475c4 00000000 fac86840 00000000 00000000 c1064f80 00000001 c3331e50
       c01b637e c1815be0 0004594a 64ab66fa 0001d39c f7aafa50 c3331da8 e06aaa38
Call Trace:
 [<c01b637e>] pathrelse+0x1e/0x30
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c013fced>] generic_file_write_nolock+0x5d/0x80
 [<c02c090a>] unix_stream_data_wait+0xfa/0x180
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c02c1003>] unix_stream_recvmsg+0x673/0x710
 [<c01aa31f>] reiserfs_file_write+0x7ff/0x810
 [<c0265030>] sock_aio_read+0xb0/0xd0
 [<c0160bcd>] do_sync_read+0x6d/0xb0
 [<c01f556e>] release_dev+0x33e/0x7e0
 [<c015fdec>] dentry_open+0x14c/0x220
 [<c015fc8f>] filp_open+0x4f/0x60
 [<c0160cf7>] vfs_read+0xe7/0x110
 [<c0161d39>] __fput+0xb9/0x120
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

sshd          D 00000000     0  3247   3238  3248               (NOTLB)
c309dd18 00000086 00000000 00000000 00000000 00000000 c1fa64c0 00000000
       00000000 00000000 00000000 00000000 c309c000 00000000 00000246 00000000
       ffffffff c1815be0 c030dc20
Call Trace:
 [<c0129642>] schedule_timeout+0x72/0xd0
 [<c01295c0>] process_timeout+0x0/0x10
 [<c011bfa8>] io_schedule_timeout+0x28/0x40
 [<c020e8ab>] blk_congestion_wait+0x7b/0x90
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c014205b>] __alloc_pages+0x29b/0x330
 [<c015bc11>] read_swap_cache_async+0x101/0x10d
 [<c014f79f>] swapin_readahead+0x2f/0xd0
 [<c014fb57>] do_swap_page+0x317/0x430
 [<c014d835>] pte_alloc_map+0xc5/0x130
 [<c01507f8>] handle_mm_fault+0xc8/0x1d0
 [<c0117444>] do_page_fault+0x304/0x4ef
 [<c01fc19a>] pty_chars_in_buffer+0x1a/0x40
 [<c01fc175>] pty_write_room+0x25/0x30
 [<c0175a04>] poll_freewait+0x44/0x50
 [<c0175dc7>] do_select+0x1e7/0x330
 [<c0117140>] do_page_fault+0x0/0x4ef
 [<c0107e85>] error_code+0x2d/0x38
 [<c017007b>] get_write_access+0x4b/0xe0
 [<c01cf8e0>] __copy_to_user_ll+0x40/0x60
 [<c01762e7>] sys_select+0x3b7/0x4d0
 [<c0160f78>] sys_write+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

bash          S C030D340     0  3248   3247                     (NOTLB)
c757be58 00000086 00000010 c030d340 00000246 01470f60 f7a5d4c0 00000000
       00000000 00000010 c1817708 00000000        f406c260 c180dbe0 0001e5df 4853c415 0001e873 c19633c0 c0129026 00000001
Call Trace:
 [<c0129026>] update_wall_time+0x16/0x40
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c01f81b4>] opost_block+0xf4/0x1b0
 [<c01facaa>] read_chan+0x96a/0xb00
 [<c014f435>] do_wp_page+0x4c5/0x570
 [<c011a730>] default_wake_function+0x0/0x10
 [<c011a730>] default_wake_function+0x0/0x10
 [<c011a730>] default_wake_function+0x0/0x10
 [<c01f46dd>] tty_write+0x1ad/0x360
 [<c01f44f6>] tty_read+0x176/0x1b0
 [<c0160cc0>] vfs_read+0xb0/0x110
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

sshd          S EDEF5DA4     0  3756   3364  3759    3914  3238 (NOTLB)
edef5d7c 00000082 edef5e50 edef5da4 c010dfe0 c03c6cb0 f7a9cb80 e089c860
       00000620 c192f240 c0268b62 d7c83812 d7c83812 d7c83812 00000000 00000246
       f7fa3190 c1815be0 000024d4 56c3dc45 0001da75 f70aa9e0 f70ab980 f70aa810
Call Trace:
 [<c010dfe0>] do_gettimeofday+0x20/0xc0
 [<c0268b62>] alloc_skb+0x32/0xd0
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c02c090a>] unix_stream_data_wait+0xfa/0x180
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c0107365>] need_resched+0x27/0x32
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c02c1003>] unix_stream_recvmsg+0x673/0x710
 [<c013dc64>] file_read_actor+0xc4/0xd0
 [<c01aa31f>] reiserfs_file_write+0x7ff/0x810
 [<c0265030>] sock_aio_read+0xb0/0xd0
 [<c0160bcd>] do_sync_read+0x6d/0xb0
 [<c01f556e>] release_dev+0x33e/0x7e0
 [<c015fdec>] dentry_open+0x14c/0x220
 [<c015fc8f>] filp_open+0x4f/0x60
 [<c0160cf7>] vfs_read+0xe7/0x110
 [<c0161d39>] __fput+0xb9/0x120
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

sshd          D 00000000     0  3759   3756  3760               (NOTLB)
d49bfd18 00000086 00000000 00000000 00000000 00000000 c1fa6700 00000000
       00000000 00000000 00000000 00000000 d49be000 00000000 00000246 00000000
       ffffffff c1815be0 00000bad 1ca15353 000222b0 f7c9ce50 00000000 c030dc20
Call Trace:
 [<c0129642>] schedule_timeout+0x72/0xd0
 [<c01295c0>] process_timeout+0x0/0x10
 [<c011bfa8>] io_schedule_timeout+0x28/0x40
 [<c020e8ab>] blk_congestion_wait+0x7b/0x90
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c014205b>] __alloc_pages+0x29b/0x330
 [<c015bc11>] read_swap_cache_async+0x101/0x10d
 [<c014f79f>] swapin_readahead+0x2f/0xd0
 [<c014fb57>] do_swap_page+0x317/0x430
 [<c014d835>] pte_alloc_map+0xc5/0x130
 [<c01507f8>] handle_mm_fault+0xc8/0x1d0
 [<c0117444>] do_page_fault+0x304/0x4ef
 [<c01fc19a>] pty_chars_in_buffer+0x1a/0x40
 [<c01fc175>] pty_write_room+0x25/0x30
 [<c0175a04>] poll_freewait+0x44/0x50
 [<c0175dc7>] do_select+0x1e7/0x330
 [<c0117140>] do_page_fault+0x0/0x4ef
 [<c0107e85>] error_code+0x2d/0x38
 [<c017007b>] get_write_access+0x4b/0xe0
 [<c01cf8e0>] __copy_to_user_ll+0x40/0x60
 [<c01762e7>] sys_select+0x3b7/0x4d0
 [<c0160f78>] sys_write+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

bash          S 00000246     0  3760   3759                     (NOTLB)
e7045e58 00000086 c030d300 00000246 01468f60 c0141c4f f7cd84c0 db8215b4
       c030d680 c12446c0 00000000 00000000 00000082 c1914c00 d20a9000 e7045e94
       e7045e6c c180dbe0 0008cdf5 57ea2b52 0001db26 f714fb30 c013ce05 c011a771
Call Trace:
 [<c0141c4f>] buffered_rmqueue+0x10f/0x280
 [<c013ce05>] find_get_page+0x35/0xc0
 [<c011a771>] __wake_up_common+0x31/0x60
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c01f81b4>] opost_block+0xf4/0x1b0
 [<c01facaa>] read_chan+0x96a/0xb00
 [<c011a730>] default_wake_function+0x0/0x10
 [<c011a730>] default_wake_function+0x0/0x10
 [<c011a730>] default_wake_function+0x0/0x10
 [<c01f46dd>] tty_write+0x1ad/0x360
 [<c01f44f6>] tty_read+0x176/0x1b0
 [<c0160cc0>] vfs_read+0xb0/0x110
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

sshd          S D806FDA4     0  3914   3364  3917          3756 (NOTLB)
d806fd7c 00000086 d806fe50 d806fda4 00000000 d806fe50 f7a6adc0 00000000
       00047c9c 00000000 1ec86840 d806fd5c f7aae140 d5d0fb1e 02036e86 d19acde0
       d19ace00 c180dbe0 0000201b 11d21020 000203d5 eff20e10 c180dbe0 d806fd98
Call Trace:
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c0118397>] recalc_task_prio+0x97/0x1c0
 [<c02c090a>] unix_stream_data_wait+0xfa/0x180
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4b1>] autoremove_wake_function+0x11/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c0268b62>] alloc_skb+0x32/0xd0
 [<c02c1003>] unix_stream_recvmsg+0x673/0x710
 [<c0265030>] sock_aio_read+0xb0/0xd0
 [<c0160bcd>] do_sync_read+0x6d/0xb0
 [<c0129026>] update_wall_time+0x16/0x40
 [<c0160cf7>] vfs_read+0xe7/0x110
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

sshd          D 00000000     0  3917   3914  3918               (NOTLB)
f682dd18 00000000 00000000 00000000 00000000 f7a9c040        00000000 00000000 00000000 00000000 f682c000 00000000 00000246 00000000
       ffffffff c180dbe0 000014af 982fad90 000222af f7aae310 00000000 c030dc20
Call Trace:
 [<c0129642>] schedule_timeout+0x72/0xd0
 [<c01295c0>] process_timeout+0x0/0x10
 [<c011bfa8>] io_schedule_timeout+0x28/0x40
 [<c020e8ab>] blk_congestion_wait+0x7b/0x90
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c014205b>] __alloc_pages+0x29b/0x330
 [<c01cf8f9>] __copy_to_user_ll+0x59/0x60
 [<c015bc11>] read_swap_cache_async+0x101/0x10d
 [<c014f79f>] swapin_readahead+0x2f/0xd0
 [<c014fb57>] do_swap_page+0x317/0x430
 [<c014d835>] pte_alloc_map+0xc5/0x130
 [<c01507f8>] handle_mm_fault+0xc8/0x1d0
 [<c0117444>] do_page_fault+0x304/0x4ef
 [<c01fc19a>] pty_chars_in_buffer+0x1a/0x40
 [<c01fc175>] pty_write_room+0x25/0x30
 [<c0175a04>] poll_freewait+0x44/0x50
 [<c0175dc7>] do_select+0x1e7/0x330
 [<c0117140>] do_page_fault+0x0/0x4ef
 [<c0107e85>] error_code+0x2d/0x38
 [<c017007b>] get_write_access+0x4b/0xe0
 [<c01cf8e0>] __copy_to_user_ll+0x40/0x60
 [<c01762e7>] sys_select+0x3b7/0x4d0
 [<c0114246>] smp_apic_timer_interrupt+0xd6/0x140
 [<c01073c9>] sysenter_past_esp+0x52/0x71

bash          S 00000246     0  3918   3917                     (NOTLB)
ef5dde58 00000082 c030d780 00000246 c030d780 c0141c4f f7bd5040 db8215b4
       c030db00 c17735c0 00000000 00000000 0000038e c1914c00 eff81000 d19ac810
       d19ac830 c180dbe0 000cb843 74fcf82c 0001dc80 f7a40940 c013ce05 00000000
Call Trace:
 [<c0141c4f>] buffered_rmqueue+0x10f/0x280
 [<c013ce05>] find_get_page+0x35/0xc0
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c01f81b4>] opost_block+0xf4/0x1b0
 [<c01facaa>] read_chan+0x96a/0xb00
 [<c011a730>] default_wake_function+0x0/0x10
 [<c011a730>] default_wake_function+0x0/0x10
 [<c011a730>] default_wake_function+0x0/0x10
 [<c01f46dd>] tty_write+0x1ad/0x360
 [<c01f44f6>] tty_read+0x176/0x1b0
 [<c0160cc0>] vfs_read+0xb0/0x110
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

pdflush       S 00000000     0  3951      6                  24 (L-TLB)
c268df78 00000046 00000000 00000000 00000000 00000000 f7a4d940 00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 f73d07d0
       f73d07f0 c1815be0 00000110 29477494 000222b0 f7bb28a0 00000000 00000000
Call Trace:
 [<c0144105>] __pdflush+0xd5/0x380
 [<c011a771>] __wake_up_common+0x31/0x60
 [<c01443b0>] pdflush+0x0/0x10
 [<c01443ba>] pdflush+0xa/0x10
 [<c01443b0>] pdflush+0x0/0x10
 [<c0135e94>] kthread+0xa4/0xb0
 [<c0135df0>] kthread+0x0/0xb0
 [<c0104ec5>] kernel_thread_helper+0x5/0x10

pdflush       S 00000000     0  6583      7                     (L-TLB)
c4ae1f78 00000046 00000000 00000000 00000000 00000000 f7a9c040 00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
       00000000 c180dbe0 00000285 9884aecd 000222af eff20270 00000000 00000000
Call Trace:
 [<c0144105>] __pdflush+0xd5/0x380
 [<c011a771>] __wake_up_common+0x31/0x60
 [<c01443b0>] pdflush+0x0/0x10
 [<c01443ba>] pdflush+0xa/0x10
 [<c01443b0>] pdflush+0x0/0x10
 [<c0135e94>] kthread+0xa4/0xb0
 [<c0135df0>] kthread+0x0/0xb0
 [<c0104ec5>] kernel_thread_helper+0x5/0x10

cron          S C030D300     0  6677   3391  6678    6760       (NOTLB)
f4233ed8 00000082 c0141e77 c030d300 00000010 00000001 e45efb80 d19ac240
       f7b074c0 f7a85f0c c011a2c9 f4233f04 00000082 d19ac240 00000010 e7892280
       e78922a0 c1815be0 0000eff8 924d6713 00020568 d19ac410 f7fffaa0 f7a62180
Call Trace:
 [<c0141e77>] __alloc_pages+0xb7/0x330
 [<c011a2c9>] schedule+0x389/0x7a0
 [<c016ee7c>] pipe_wait+0x7c/0xa0
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c01cf8f9>] __copy_to_user_ll+0x59/0x60
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c016f07a>] pipe_readv+0x1da/0x2c0
 [<c016f180>] pipe_read+0x20/0x30
 [<c0160cc0>] vfs_read+0xb0/0x110
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

sh            S E0B63080     0  6678   6677  6679               (NOTLB)
caa4df48 c01508a3 e78483bc e45ef940 2c5fa065
       c011db30 f6f71380 e45ef940 e45ef960 f6f71380 d19ad3b0 c0117444 f73d0da0
       f73d0dc0 c1815be0 0002185a 91df5d00 00020568 d19ad580 f1499544 00000001
Call Trace:
 [<c01508a3>] handle_mm_fault+0x173/0x1d0
 [<c011db30>] copy_mm+0x250/0x570
 [<c0117444>] do_page_fault+0x304/0x4ef
 [<c012354b>] sys_wait4+0x1bb/0x280
 [<c011a730>] default_wake_function+0x0/0x10
 [<c011a730>] default_wake_function+0x0/0x10
 [<c0123635>] sys_waitpid+0x25/0x29
 [<c01073c9>] sysenter_past_esp+0x52/0x71

daily_reports S F0D7B080     0  6679   6678  6689               (NOTLB)
e9afbf48 00000086 080f1e34 f0d7b080 c01508a3 edc523c4 f7cd8700 347c9065
       c011db30 f6f71770 f7cd8700 f7cd8720 f6f71770 d19ac810 c0117444 00000001
       aea87c72 c180dbe0 00016174 5e27e5ad 0002057f d19ac9e0 f712a584 00000000
Call Trace:
 [<c01508a3>] handle_mm_fault+0x173/0x1d0
 [<c011db30>] copy_mm+0x250/0x570
 [<c0117444>] do_page_fault+0x304/0x4ef
 [<c012354b>] sys_wait4+0x1bb/0x280
 [<c011a730>] default_wake_function+0x0/0x10
 [<c011a730>] default_wake_function+0x0/0x10
 [<c0123635>] sys_waitpid+0x25/0x29
 [<c01073c9>] sysenter_past_esp+0x52/0x71

mysql         S C015081C     0  6689   6679                     (NOTLB)
f5fe5d7c 00000086 d57ed400 c015081c 00000001 f4182998 f7d66dc0 c01bebe9
       ccadf818 f7d66dc0 f7d66de0 ccadf818 f73d07d0 603d05d3 0002057f f73d07d0
       f73d07f0 c1815be0 000021e1 605a5570 0002057f e78935c0 00000000 f5fe5df8
Call Trace:
 [<c015081c>] handle_mm_fault+0xec/0x1d0
 [<c01bebe9>] journal_mark_dirty+0x159/0x2e0
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c0141e77>] __alloc_pages+0xb7/0x330
 [<c011d4b1>] autoremove_wake_function+0x11/0x40
 [<c02c090a>] unix_stream_data_wait+0xfa/0x180
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c0268b62>] alloc_skb+0x32/0xd0
 [<c02c1003>] unix_stream_recvmsg+0x673/0x710
 [<c0265030>] sock_aio_read+0xb0/0xd0
 [<c0160bcd>] do_sync_read+0x6d/0xb0
 [<c014e246>] unmap_vmas+0xf6/0x310
 [<c01488ff>] __pagevec_lru_add_active+0x13f/0x1b0
 [<c012eb45>] sys_rt_sigaction+0xd5/0xf0
 [<c0160cf7>] vfs_read+0xe7/0x110
 [<c017489b>] do_fcntl+0x11b/0x1d0
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

cron          S C030D300     0  6760   3391  6761          6677 (NOTLB)
eb401ed8 00000082 c0141e77 c030d300 00000010 00000001 f7a4d040 e7892280
       f7a4d040 d4323c28 c011a2c9 eb401f04 00000082 e7892280 00000010 c1962c20
       c1962c40 c1815be0 0000d409 4121cbab 0002062c e7892450 f7fffaa0 c1962c20
Call Trace:
 [<c0141e77>] __alloc_pages+0xb7/0x330
 [<c011a2c9>] schedule+0x389/0x7a0
 [<c016ee7c>] pipe_wait+0x7c/0xa0
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c01cf8f9>] __copy_to_user_ll+0x59/0x60
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c016f07a>] pipe_readv+0x1da/0x2c0
 [<c016f180>] pipe_read+0x20/0x30
 [<c0160cc0>] vfs_read+0xb0/0x110
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

sh            S F7B97860     0  6761   6760  6763               (NOTLB)
d4323f48 00000086 0002062c f7b97860 f7b97880 c1815be0 f7a4d4c0 4190165b
       0002062c c1962df4 d4323f7c d4322000 d4322000 d4323f7c d4322000 e8af8160
       e8af8180 c1815be0 000015ca 41908132 0002062c c1962df0 f7bf5fa4 00000001
Call Trace:
 [<c012354b>] sys_wait4+0x1bb/0x280
 [<c011a730>] default_wake_function+0x0/0x10
 [<c011a730>] default_wake_function+0x0/0x10
 [<c0123635>] sys_waitpid+0x25/0x29
 [<c01073c9>] sysenter_past_esp+0x52/0x71

php           S D2527DA4     0  6763   6761                     (NOTLB)
d2527d7c 00000082 d2527e50 d2527da4 00000000 d2527e50 c1fa6280 00000000
       00008c65 00000000 36d5b0c8 00000000 f70ab3b0 c10c0900 e5d5b060 f70ab3b0
       f70ab3d0 c180dbe0 00002530 8a40e181 0002062c e8af8ed0 00000000 f7dacc00
Call Trace:
 [<c0129693>] schedule_timeout+0xc3/0xd0
 [<c0118397>] recalc_task_prio+0x97/0x1c0
 [<c02c090a>] unix_stream_data_wait+0xfa/0x180
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c011d4b1>] autoremove_wake_function+0x11/0x40
 [<c011d4a0>] autoremove_wake_function+0x0/0x40
 [<c02c1003>] unix_stream_recvmsg+0x673/0x710
 [<c0265030>] sock_aio_read+0xb0/0xd0
 [<c0160bcd>] do_sync_read+0x6d/0xb0
 [<c0160cf7>] vfs_read+0xe7/0x110
 [<c017489b>] do_fcntl+0x11b/0x1d0
 [<c0160f18>] sys_read+0x38/0x60
 [<c01073c9>] sysenter_past_esp+0x52/0x71

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
