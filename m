Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVCYPr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVCYPr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 10:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVCYPr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 10:47:26 -0500
Received: from village.ehouse.ru ([193.111.92.18]:24842 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261674AbVCYPqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 10:46:31 -0500
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
Date: Fri, 25 Mar 2005 18:46:23 +0300
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Cc: admin@list.net.ru
Subject: 2.6.11: spend too many time in miragtion thread
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PJDRCgb3gujD/Tg"
Message-Id: <200503251846.23708.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_PJDRCgb3gujD/Tg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Yesterday i faced strange behaviour of 2.6.11 on
one of my Dual PIII Gentoo servers. 
( 2xPIII 1400, 2G RAM, Mylex 352, 2x Ethernet Pro 100, DL2k Gigabit 
Ethernet
CONFIG_NFS_FS=y
CONFIG_NFSD=y
but actually only used as nfs server )

Description:
  At some moment i've found out that kernel spend ~2/3 
  (60-70% actually, accoring to vmstat&top) time in miragtion/1, 
  and most of other time in idle ( although it have tasks to run
  [ps out attached] )
  kerneltop shows get_stats  and poll_idle on the top permanently:

Linux s3.ir.ru 2.6.11 #1 SMP Sat Mar 5 16:22:27 MSK 2005 i686 GNU/Linux
  Sampling_step: 4 | Address range: 0xc0100294 - 0xc02db797
  address  function ...... 2005-03-24/20:28:44 ...... ticks (  1916)
  c0266530 get_stats                                    953
  c01006c0 poll_idle                                    674
  c0265ba0 rio_interrupt                                 68
  c0202b00 __copy_user_intel                              5
  c013a010 __mod_page_state                               2
  c0114a40 sub_preempt_count                              1
  c0139620 buffered_rmqueue                               1
  c013da40 kmem_cache_free                                1
  c013db00 kfree                                          1
  c01446f0 do_anonymous_page                              1
  c016d2e0 lookup_mnt                                     1
  c0202c60 __copy_to_user_ll                              1
  c0202cd0 __copy_from_user_ll                            1
  c028d350 ip_route_output_slow                           1
  c02921d0 ip_queue_xmit                                  1
  c02a2250 tcp_transmit_skb                               1

  s3:/var/tmp/kerneltop-0.8#

Sorry, but at that time i've had no idea what get_stats related to
and i have no interfaces status now, only two pieces of "SysRq-t"
(  dmesg too long to 32k buffer and i couldn't get more
then ~10k by netconsole, [both attached] )
Another thing, for a long time i observe sun/rpc messages
in the kernel log:
svc: unknown version (0)
svc: unknown version (0)
svc: unknown version (0)
svc: unknown version (0)
svc: unknown version (0)
.......................
but i've no problem with nfsd up to now.


-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc

--Boundary-00=_PJDRCgb3gujD/Tg
Content-Type: text/plain;
  charset="us-ascii";
  name="s3-netconsole-20050324.trc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="s3-netconsole-20050324.trc"

SysRq : Changing Loglevel
Loglevel set to 6
SysRq : Mem-info:
DMA per-cpu:Show Memory

cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16

cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
Free pages:      108724kB (4928kB HighMem)
Active:67801 inactive:399855 dirty:2500 writeback:0 unstable:0 free:27181 slab:20675 mapped:6550 pagetables:242
DMA free:11220kB min:68kB low:84kB high:100kB active:276kB inactive:24kB present:16384kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0
 880 2031Normal free:92576kB min:3756kB low:4692kB high:5632kB active:154188kB inactive:543608kB present:901120kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 9215
HighMem free:4928kB min:512kB low:640kB high:768kB active:116740kB inactive:1055788kB present:1179584kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0DMA: 255*4kB  0 0
64*32kB 21*64kB 143*8kB 106*16kB 1*128kB 1*512kB 1*1024kB 1*256kB 1*2048kB 0*4096kB = 11220kB
Normal: 5870*4kB 3193*8kB 2242*16kB 96*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB Total swap = 497972kB
524272 pages of RAM
294896 pages of HIGHMEM
5964 reserved pages
375189 pages shared
0 pages swap cached
SysRq : Show Regs
SysRq : Show State
                                               sibling
 00000001 
  task             PC      pid father child younger older
init          S       (NOTLB)
    0     1      0 c23f4ea8 00000082 c01396d9     2        f6ca56c0 c1436880 000000d0 c01391a5 00000001 c0332580 3ef9225c 0005d6ed c0169e41 

              f6c5aa40 00000000 0005d6ed c23f3c0c f6cec560 c200ff60 00002ae7 00000000 
3efa1562 620230db c23f4ebc  prep_new_page+0x55/0x60
0000000b Call Trace:
 [<c01396d9>] [<c01391a5>] [<c0169e41>] buffered_rmqueue+0xb9/0x1e0 __d_lookup+0x91/0x140 [<c02dcbef>]

 schedule_timeout+0x6f/0xd0
 [<c0160790>] link_path_walk+0xa00/0xd20
 [<c0122070>] process_timeout+0x0/0x10
 [<c015ee02>] pipe_poll+0x32/0xb0
 [<c0164e90>] [<c01652ae>]migration/1    [<c0128320>] [<c01009b5>]00000000 
 00000000  [<c012c980>] [<c01009b5>]
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0102642>] ret_from_fork+0x6/0x14
 [<c012c980>] autoremove_wake_function+0x0/0x50 [<c023aed0>] serio_thread+0x0/0x140

 [<c01009b5>] kernel_thread_helper+0x5/0x10
 00000020 kirqd         S [<c010f5c0>]portmap        [<c0164b30>]c16d1280  _spin_unlock+0xd/0x30       00001000 c037e320 

 [<c0114a80>] worker_thread+0x215/0x240 [<c02dcbef>]
 schedule_timeout+0x6f/0xd0 __alloc_pages+0x294/0x3b0

 [<c0122070>] [<c011dcd3>] local_bh_enable+0x33/0xa0 add_wait_queue+0x1d/0x50 [<c0139b54>] [<c02d02e3>] process_timeout+0x0/0x10 svc_recv+0x383/0x4c0 [<c02dd83d>]

 [<c012c75d>]


 _spin_unlock_bh+0xd/0x30 [<c02d04e6>] svc_send+0x86/0xf0 fh_put+0x132/0x180
       f7e21560  [<c02d04e6>]f6db8ef4 
 [<c0114a80>]
 svc_recv+0x383/0x4c0 (NOTLB)


 [<c0164b30>] sys_select+0x2be/0x4b0
 [<c0164e90>]
 [<c010275f>]
cron           do_select+0x190/0x2d0 __pollwait+0x0/0xd0S         1962
f6d4ff4c  [<c01652ae>]f6d4ff70 

 write_chan+0x0/0x220 _spin_unlock_irqrestore+0xf/0x30f6d4ce74 00000020  schedule_timeout+0xc0/0xd0 [<c02dcc40>]
 default_wake_function+0x0/0x10
 [<c011cb15>] sys_waitpid+0x25/0x29
 [<c0114a80>] syscall_call+0x7/0xb
 [<c0273955>] sys_socketcall+0xc5/0x250S C119AA80 
 [<c010275f>]      
munin-node       9113    0  7277      1  (NOTLB)
ee3ccea8   683500000082 c119aa80 00000008 00000006 c013b880  kernel_thread_helper+0x5/0x10 pdflush+0x0/0x20 [<c01009b5>] [<c02dd346>] sys_select+0x2be/0x4b0


 sys_read+0x47/0x80 [<c01652ae>] _spin_unlock_irq+0xe/0x30
 [<c0139b54>]
 [<c0227d41>] tty_ldisc_deref+0x61/0x80
 process_timeout+0x0/0x10 [<c0122070>]
 [<c0164e90>] do_select+0x190/0x2d0
 __pollwait+0x0/0xd0 sys_select+0x2be/0x4b0 [<c01641b1>] [<c0164b30>]

 [<c0163c99>] [<c01652ae>]
 do_ioctl+0x71/0x90 sys_fcntl64+0x59/0x90
 syscall_call+0x7/0xb
 [<c010275f>]S 00000000 823ad403  (NOTLB)
dd057000 
 autoremove_wake_function+0x0/0x50 _spin_unlock+0xd/0x30
 [<c0144736>] do_anonymous_page+0x46/0x170 sock_aio_read+0xda/0xf0
 [<c0152c2d>]
 autoremove_wake_function+0x0/0x50 [<c0152d62>] vfs_read+0xf2/0x100
 [<c0152f97>] [<c010275f>] syscall_call+0x7/0xb
sshd          S sys_read+0x47/0x80
 [<c02dd80e>] [<f88cf935>]7fffffff  [<f88cf535>]
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c0152c2d>] do_sync_read+0x9d/0xe0
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0152d62>] vfs_read+0xf2/0x100
 [<c0152f97>] sys_read+0x47/0x80
 [<c010275f>] syscall_call+0x7/0xb
sshd          S [<c012c850>] [<c012c980>]

d2bc6d74 
000000d2 svc: unknown version (0)


______________________________________________________________
SysRq : 
  task             PC      pid father child younger older
                                               sibling
init          S    0     1      0  00000001              c23f4ea8 c0332580     2 c01396d9 c0169e41  (NOTLB)
00000082 c01391a5 
c1436880 00000001 000000d0 f6ca56c0 ab87f7a5 0005d701        f6c5aa40        00002416 0000001a f6d0e560 c200ff60 
ab87f7a5 c23f3c0c 620387b4 0005d701 c23f4ebc 0000000b 

 [<c01396d9>]00000000  [<c0169e41>]Call Trace:
 [<c01391a5>] prep_new_page+0x55/0x60
 buffered_rmqueue+0xb9/0x1e0 [<c02dcbef>] schedule_timeout+0x6f/0xd0
 __d_lookup+0x91/0x140
 [<c0160790>] link_path_walk+0xa00/0xd20 [<c0122070>]
 process_timeout+0x0/0x10
 pipe_poll+0x32/0xb0
 [<c012c440>] [<c012c440>]c200ff60 00010000  [<c0114a80>]
 [<c023ac23>]
 [<c023acc9>] serio_find_driver+0x69/0x70
 serio_thread+0xde/0x140 [<c023afae>]
 autoremove_wake_function+0x0/0x50 [<c012c980>]
 [<c0102642>] ret_from_fork+0x6/0x14
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c023aed0>] serio_thread+0x0/0x140
 [<c01009b5>] kernel_thread_helper+0x5/0x10


7fffffff 
Sc8c17bf5  __alloc_pages+0x294/0x3b0 nfsd+0xe0/0x310 local_bh_enable+0x33/0xa0 default_wake_function+0x0/0x10
 [<c02dd346>] _spin_lock+0x16/0x90
 [<c02dcbef>] schedule_timeout+0x6f/0xd0
 [<c0139b54>] __alloc_pages+0x294/0x3b0
 [<c0122070>] process_timeout+0x0/0x10
 [<c011dcd3>] local_bh_enable+0x33/0xa0
 [<c012c75d>] add_wait_queue+0x1d/0x50
 [<c012c75d>]
 [<c0122070>] local_bh_enable+0x33/0xa0f6f28e00  [<c02dcbef>]000000d0 00000010 
 _spin_unlock_irqrestore+0xf/0x30 [<c02dd7df>]
 [<c02961e6>] tcp_poll+0x16/0x170
 [<c02dd74d>] _spin_unlock+0xd/0x30

 [<c02dd346>]
 _spin_lock+0x16/0x90 [<c0164e90>] [<c0164b30>]
 [<c01652ae>] do_select+0x190/0x2d0 [<c010275f>]f6d4ff4c  _spin_unlock_irq+0xe/0x30
00003daf  [<c0152f97>]
68f3c0f2 00000009  syscall_call+0x7/0xb [<c012c75d>]6ac50d58 

 remove_wait_queue+0x1a/0x50 [<c012c7fa>]
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<c011c77e>] do_wait+0x1ce/0x460
 [<c0114a80>] default_wake_function+0x0/0x10
 [<c0273955>] sys_socketcall+0xc5/0x250
 [<c011cb15>] sys_waitpid+0x25/0x29
 [<c010275f>] syscall_call+0x7/0xb
munin-node    S C1319940     0  7277      1          9308        [<c013b880>]sshd          
00000000 
e25c9080  sigprocmask+0x6c/0xd0 schedule_timeout+0xc0/0xd0
 unix_stream_recvmsg+0x3c5/0x420 [unix]f6d64c0c 
Call Trace:
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c01030ce>] common_interrupt+0x1a/0x20
 [<c012c850>] prepare_to_wait+0x20/0x70
 [<f88cf535>] unix_stream_data_wait+0xc5/0x100 [unix]
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0139b54>] __alloc_pages+0x294/0x3b0
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c02dd7df>]
 sock_aio_read+0xda/0xf07fffffff 




    0  8739   8737  syscall_call+0x7/0xb do_sync_read+0x9d/0xe0 schedule_timeout+0xc0/0xd0c200ff60 f6d00aa0 
       0604b20b 00001eb7 f6cce6cc 0005d6bf 7fffffff e692ed2c cd05b000 7fffffff 
Call Trace:
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c012c850>] prepare_to_wait+0x20/0x70 [<f88cf535>] unix_stream_data_wait+0xc5/0x100 [unix]
 [<c0164b30>]de99c560 f6cec560  autoremove_wake_function+0x0/0x50       [<f88cfc02>] unix_poll+0x12/0x90 [unix] __pollwait+0x0/0xd0 [<c0114ac7>] (NOTLB)

 [<c0139b54>] __alloc_pages+0x294/0x3b0
 autoremove_wake_function+0x0/0x50 [<c012c980>]
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<f88cf935>] unix_stream_recvmsg+0x3c5/0x420 [unix]
 [<c027201a>]
 [<c02dd74d>] _spin_unlock+0xd/0x30
 [<c02dbf7b>]
 [<c0152c2d>] sock_aio_read+0xda/0xf0 do_sync_read+0x9d/0xe0 _spin_unlock_irq+0xe/0x30 schedule+0x3db/0x740
 [<c012c980>] autoremove_wake_function+0x0/0x50 vfs_read+0xf2/0x100
f6f4e18c 
 [<c02dd346>] [<c01123e8>]00000286 7fffffff 

 [<c01652ae>]      
SysRq : 
  task             PC      pid father child younger older
init          Show State
    0     1      0                                                sibling
    2  (NOTLB)
Sc23f4ea8  00000001        00000082 c01391a5       f6ca56c0 00000001 c0332580 c0169e41        c01396d9 c1436880 00000000 
000000d0 55cf206c c200ff60 f6c5aa40 0005d707 f6d0e560 
00001681 55cf206c        0005d707 c23f3c0c 6203e6cd c23f4ebc 00000000 0000000b 
 [<c01391a5>]
Call Trace:
 [<c01396d9>] prep_new_page+0x55/0x60
 [<c0169e41>] buffered_rmqueue+0xb9/0x1e0
 __d_lookup+0x91/0x140 [<c02dcbef>] schedule_timeout+0x6f/0xd0
 [<c0160790>] link_path_walk+0xa00/0xd20
 [<c0122070>] process_timeout+0x0/0x10

 [<c0128535>] worker_thread+0x215/0x240
 [<c02dd80e>] _spin_unlock_irq+0xe/0x30 [<c011335a>] finish_task_switch+0x3a/0x90

 [<c0128020>]       
      
 worker_thread+0x0/0x240
 [<c0128320>]
 [<c012c440>]
 [<c01009b5>]
 C024915A     0    87     13     22 (L-TLB)
f7e1bf50  [<c012c4e4>]c024915a c025a0e0  kthread+0xa4/0xb00000001f 
 kthread+0x0/0xb000000001 f6ea3d40  kernel_thread_helper+0x5/0x10kblockd/0     S00000001 e7306560            8800000046 f7f1bcac 0000067b 275d261b f7f68000 00000001        f7c86030 f7e166cc 00000000 00000000 f7e1bfa0 c200ff60 
f7f0ae3c 
        elv_next_request+0x1a/0xf0
 [<c025a0e0>]0005d708 f7c86018  DAC960_V2_QueueReadWriteCommand+0x130/0x160
 _spin_unlock_irq+0xe/0x30f7c86000 Call Trace:
 [<c024915a>]
 [<c0128535>] worker_thread+0x215/0x2400000001e 00000115 7fffffff  [<c02961e6>]
 [<c02dd74d>] _spin_unlock+0xd/0x30
 sock_poll+0x12/0x20 [<c02725e2>]
 [<c01654fb>] do_pollfd+0x5b/0xa0
 [<c01655dd>]
 do_poll+0x9d/0xc0 [<c016572f>] sys_poll+0x12f/0x210
 [<c0164b30>] __pollwait+0x0/0xd0
 [<c010275f>] syscall_call+0x7/0xbsyslogd               [<c02dd7df>]000000d0  [<c012574f>]
 [<c01009b5>] [<c02d02e3>]
f6d25000  fh_put+0x132/0x180
 [<c02dd346>] _spin_lock+0x16/0x90
 [<c02dcbef>] schedule_timeout+0x6f/0xd0
 [<c011dcd3>] local_bh_enable+0x33/0xa0
 [<c0122070>] process_timeout+0x0/0x10
 [<c011dcd3>] local_bh_enable+0x33/0xa0
 add_wait_queue+0x1d/0x50 fh_put+0x132/0x18000001000  [<c0114a80>]f7a8dea8 

 sys_nanosleep+0xce/0x150 [<c0114a80>]
 [<c0114a80>] default_wake_function+0x0/0x10
 [<c0114a80>] default_wake_function+0x0/0x10
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<c0228c26>] tty_write+0x1f6/0x260
 [<c0228a0c>] tty_read+0xec/0x110
 [<c022e0d0>] write_chan+0x0/0x220
 [<c0152d04>] vfs_read+0x94/0x100
 [<c022dfc4>] remove_wait_queue+0x1a/0x50 [<c0114a80>] sys_read+0x47/0x80 [<c010275f>]6203e81a pdflush       
 [<c012c980>] autoremove_wake_function+0x0/0x50
 autoremove_wake_function+0x0/0x50 [<c012c980>]
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<f88cf935>] unix_stream_recvmsg+0x3c5/0x420 [unix]
 [<c0169e41>] __d_lookup+0x91/0x140
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c0152c2d>] do_sync_read+0x9d/0xe0
Call Trace:
 [<c0227d41>]ed7a4020 
 _spin_unlock_irq+0xe/0x30

 sock_aio_read+0xda/0xf0 [<f88cf535>] 00000000 

 [<c02dd80e>] _spin_unlock_irq+0xe/0x30
 [<c0125443>]
 [<c012c980>] autoremove_wake_function+0x0/0x50 vfs_read+0xf2/0x100
 do_sigaction+0x1e3/0x200 [<c0152f97>]
 [<c0152d62>]

 sys_read+0x47/0x80 [<c010275f>] syscall_call+0x7/0xbsshd          R 8888 00000086  _spin_unlock_irqrestore+0xf/0x30

S

 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<f88cf935>] unix_stream_recvmsg+0x3c5/0x420 [unix]
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c0152c2d>] do_sync_read+0x9d/0xe0
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0152d62>] vfs_read+0xf2/0x100
 [<c0152f97>] sys_read+0x47/0x80
 00000000  unix_stream_data_wait+0xc5/0x100 [unix] [<c02dbf7b>] schedule+0x3db/0x740 [<c0152f97>] syscall_call+0x7/0xbf6d402c0  [<c0152f97>] autoremove_wake_function+0x0/0x50 [<c010275f>]00000086 

 [<c012c980>]
 [<c0142f64>]
svc: unknown version (0)

--Boundary-00=_PJDRCgb3gujD/Tg
Content-Type: text/plain;
  charset="us-ascii";
  name="s3-dmesg-20050324.trc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="s3-dmesg-20050324.trc"

0e0 00000001 00000001 b8ce4793 e477ed4c c0112a93 
       c200ff60 de99c560 f6c5a7c0 00000000 b8ce49e8 0005d718 de99c560 c200ff60 
       000004dc c2820dd6 0005d718 f6dec6cc e477e000 7fffffff e37e25cc 7fffffff 
Call Trace:
 [<c0112a93>] activate_task+0x63/0xa0
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c0114ac7>] __wake_up_common+0x37/0x70
 [<c012c850>] prepare_to_wait+0x20/0x70
 [<f88cf535>] unix_stream_data_wait+0xc5/0x100 [unix]
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<f88cf935>] unix_stream_recvmsg+0x3c5/0x420 [unix]
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c0152c2d>] do_sync_read+0x9d/0xe0
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0152d62>] vfs_read+0xf2/0x100
 [<c0152f97>] sys_read+0x47/0x80
 [<c010275f>] syscall_call+0x7/0xb
sshd          S 00000000     0  9051   1900  9053    9084  8907 (NOTLB)
da7bed74 00000082 f6dfd3d8 00000000 00000001 da7bed50 c0114b38 00000000 
       00000000 00000286 f6ec85e0 00000001 06d1a69b 0005d6d1 f6cec560 c200ff60 
       00001d02 06e2d9cd 0005d6d1 f6df16cc da7be000 7fffffff e37e220c 7fffffff 
Call Trace:
 [<c0114b38>] __wake_up+0x38/0x50
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c012c850>] prepare_to_wait+0x20/0x70
 [<f88cf535>] unix_stream_data_wait+0xc5/0x100 [unix]
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0139b54>] __alloc_pages+0x294/0x3b0
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<f88cf935>] unix_stream_recvmsg+0x3c5/0x420 [unix]
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c02dd74d>] _spin_unlock+0xd/0x30
 [<c02dbf7b>] schedule+0x3db/0x740
 [<c0152c2d>] do_sync_read+0x9d/0xe0
 [<c02dd80e>] _spin_unlock_irq+0xe/0x30
 [<c0125443>] do_sigaction+0x1e3/0x200
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0152d62>] vfs_read+0xf2/0x100
 [<c0152f97>] sys_read+0x47/0x80
 [<c010275f>] syscall_call+0x7/0xb
sshd          S C137E700     0  9053   9051  9054               (NOTLB)
e972aea8 00000082 c037c780 c137e700 000000d0 00000000 c0332580 00000010 
       00000000 000000d0 f6f20320 00000001 00000000 00000000 c027201a c200ff60 
       0001ad78 c876b5aa 0005d718 f6d2618c 00000000 7fffffff 0000000c 00000000 
Call Trace:
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c012c75d>] add_wait_queue+0x1d/0x50
 [<c012c75d>] add_wait_queue+0x1d/0x50
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<f88cfc02>] unix_poll+0x12/0x90 [unix]
 [<c0164e90>] do_select+0x190/0x2d0
 [<c0164b30>] __pollwait+0x0/0xd0
 [<c01652ae>] sys_select+0x2be/0x4b0
 [<c010275f>] syscall_call+0x7/0xb
scp           S 00000001     0  9054   9053                     (NOTLB)
e3c96d74 00000082 f6f20320 00000001 00000001 c83848b9 e3c96d4c c0112a93 
       c200ff60 f6d26020 f6db27e0 00000000 c838503d 0005d718 f6d26020 c200ff60 
       000007ce c838620c 0005d718 f7e21c0c e3c96000 7fffffff f383bdac 7fffffff 
Call Trace:
 [<c0112a93>] activate_task+0x63/0xa0
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c0114ac7>] __wake_up_common+0x37/0x70
 [<c012c850>] prepare_to_wait+0x20/0x70
 [<f88cf535>] unix_stream_data_wait+0xc5/0x100 [unix]
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<f88cf935>] unix_stream_recvmsg+0x3c5/0x420 [unix]
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c0152c2d>] do_sync_read+0x9d/0xe0
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0152d62>] vfs_read+0xf2/0x100
 [<c0152f97>] sys_read+0x47/0x80
 [<c010275f>] syscall_call+0x7/0xb
sshd          S 00000000     0  9084   1900  9098    9190  9051 (NOTLB)
c53b0d74 00000082 cb56c040 00000000 123781d8 0005d6d7 f6d00aa0 c200ff60 
       00003fe4 123787ab cb56c040 00000002 ffffffff f6d4baa0 f6cec560 c200ff60 
       00002006 12589d8e 0005d6d7 f6d4bc0c c53b0000 7fffffff f6d7bb4c 7fffffff 
Call Trace:
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c012c850>] prepare_to_wait+0x20/0x70
 [<f88cf535>] unix_stream_data_wait+0xc5/0x100 [unix]
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0139b54>] __alloc_pages+0x294/0x3b0
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<f88cf935>] unix_stream_recvmsg+0x3c5/0x420 [unix]
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c02dd74d>] _spin_unlock+0xd/0x30
 [<c02dbf7b>] schedule+0x3db/0x740
 [<c0152c2d>] do_sync_read+0x9d/0xe0
 [<c02dd80e>] _spin_unlock_irq+0xe/0x30
 [<c0125443>] do_sigaction+0x1e3/0x200
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0152d62>] vfs_read+0xf2/0x100
 [<c0152f97>] sys_read+0x47/0x80
 [<c010275f>] syscall_call+0x7/0xb
sshd          S C10A8E40     0  9098   9084  9099               (NOTLB)
d48fbea8 00000086 c037c780 c10a8e40 000000d0 00000000 c0332580 00000010 
       00000000 000000d0 f6e6bcc0 00000001 00000000 00000000 c027201a c200ff60 
       0001dc5b ca4116c7 0005d718 f6d0ec0c 00000000 7fffffff 0000000c 00000000 
Call Trace:
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c012c75d>] add_wait_queue+0x1d/0x50
 [<c012c75d>] add_wait_queue+0x1d/0x50
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<f88cfc02>] unix_poll+0x12/0x90 [unix]
 [<c0164e90>] do_select+0x190/0x2d0
 [<c0164b30>] __pollwait+0x0/0xd0
 [<c01652ae>] sys_select+0x2be/0x4b0
 [<c010275f>] syscall_call+0x7/0xb
scp           S 0B4FB0F9     0  9099   9098                     (NOTLB)
eda1bd74 00000086 c015c24b 0b4fb0f9 005e17ac 00000000 f5364770 c018ff6c 
       000017ac 00000000 f6db2a60 00000000 eda1bd68 eda1bd68 f6d0eaa0 c200ff60 
       0000057d c8fc7cff 0005d718 f6cce18c eda1b000 7fffffff e37e2f2c 7fffffff 
Call Trace:
 [<c015c24b>] inode_get_bytes+0x3b/0x60
 [<c018ff6c>] inode2sd+0xcc/0x120
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c01abb0e>] do_journal_end+0x63e/0x990
 [<c02dd74d>] _spin_unlock+0xd/0x30
 [<c012c850>] prepare_to_wait+0x20/0x70
 [<f88cf535>] unix_stream_data_wait+0xc5/0x100 [unix]
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<f88cf935>] unix_stream_recvmsg+0x3c5/0x420 [unix]
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c0152c2d>] do_sync_read+0x9d/0xe0
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0152d62>] vfs_read+0xf2/0x100
 [<c0152f97>] sys_read+0x47/0x80
 [<c010275f>] syscall_call+0x7/0xb
sshd          S 00000000     0  9190   1900  9195    9369  9084 (NOTLB)
f4a53d74 00000086 f6e6b2c0 00000000 8e2e0ff9 0005d6e8 f6d00aa0 c200ff60 
       0000470b 8e2e14ee f6e6b2c0 00000002 ffffffff f7a8c020 f6cec560 c200ff60 
       00002142 8e523bfa 0005d6e8 f7a8c18c f4a53000 7fffffff f6d7b3cc 7fffffff 
Call Trace:
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c012c850>] prepare_to_wait+0x20/0x70
 [<f88cf535>] unix_stream_data_wait+0xc5/0x100 [unix]
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0139b54>] __alloc_pages+0x294/0x3b0
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<f88cf935>] unix_stream_recvmsg+0x3c5/0x420 [unix]
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c02dd74d>] _spin_unlock+0xd/0x30
 [<c02dbf7b>] schedule+0x3db/0x740
 [<c0152c2d>] do_sync_read+0x9d/0xe0
 [<c02dd80e>] _spin_unlock_irq+0xe/0x30
 [<c0125443>] do_sigaction+0x1e3/0x200
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0152d62>] vfs_read+0xf2/0x100
 [<c0152f97>] sys_read+0x47/0x80
 [<c010275f>] syscall_call+0x7/0xb
sshd          R running     0  9195   9190  9198               (NOTLB)
scp           S 0B4FB0FB     0  9198   9195                     (NOTLB)
d2bc6d74 00000082 c015c24b 0b4fb0fb 00ae2bac 00000000 db268b28 c018ff6c 
       00002bac 00000000 f6d02d40 00000000 d2bc6d68 d2bc6d68 f6d0e560 c200ff60 
       00000920 cea21c97 0005d718 f6f4e18c d2bc6000 7fffffff f5c8182c 7fffffff 
Call Trace:
 [<c015c24b>] inode_get_bytes+0x3b/0x60
 [<c018ff6c>] inode2sd+0xcc/0x120
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c01abb0e>] do_journal_end+0x63e/0x990
 [<c02dd74d>] _spin_unlock+0xd/0x30
 [<c012c850>] prepare_to_wait+0x20/0x70
 [<f88cf535>] unix_stream_data_wait+0xc5/0x100 [unix]
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<f88cf935>] unix_stream_recvmsg+0x3c5/0x420 [unix]
 [<c02dd74d>] _spin_unlock+0xd/0x30
 [<c0144736>] do_anonymous_page+0x46/0x170
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c0152c2d>] do_sync_read+0x9d/0xe0
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0152d62>] vfs_read+0xf2/0x100
 [<c0152f97>] sys_read+0x47/0x80
 [<c010275f>] syscall_call+0x7/0xb
sshd          S 00000000     0  9369   1900  9377    9548  9190 (NOTLB)
ebc23d74 00000082 f6e6b540 00000000 d920b8ae 0005d6ff f6d00aa0 c200ff60 
       00004226 d920bdb7 f6e6b540 00000002 ffffffff f6f4e560 f6cec560 c200ff60 
       000023fe d9418ca8 0005d6ff f6f4e6cc ebc23000 7fffffff f383b26c 7fffffff 
Call Trace:
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c012c850>] prepare_to_wait+0x20/0x70
 [<f88cf535>] unix_stream_data_wait+0xc5/0x100 [unix]
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0139b54>] __alloc_pages+0x294/0x3b0
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<f88cf935>] unix_stream_recvmsg+0x3c5/0x420 [unix]
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c02dd74d>] _spin_unlock+0xd/0x30
 [<c02dbf7b>] schedule+0x3db/0x740
 [<c0152c2d>] do_sync_read+0x9d/0xe0
 [<c02dd80e>] _spin_unlock_irq+0xe/0x30
 [<c0125443>] do_sigaction+0x1e3/0x200
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0152d62>] vfs_read+0xf2/0x100
 [<c0152f97>] sys_read+0x47/0x80
 [<c010275f>] syscall_call+0x7/0xb
sshd          S C1409D40     0  9377   9369  9384               (NOTLB)
ce754ea8 00000086 c037c780 c1409d40 000000d0 00000000 c0332580 00000010 
       00000000 000000d0 cb56c7c0 00000001 00000000 00000000 c027201a c200ff60 
       0000109c b9fc5ab4 0005d718 f6d266cc 00000000 7fffffff 0000000c 00000000 
Call Trace:
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c012c75d>] add_wait_queue+0x1d/0x50
 [<c012c75d>] add_wait_queue+0x1d/0x50
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<f88cfc02>] unix_poll+0x12/0x90 [unix]
 [<c0164e90>] do_select+0x190/0x2d0
 [<c0164b30>] __pollwait+0x0/0xd0
 [<c01652ae>] sys_select+0x2be/0x4b0
 [<c010275f>] syscall_call+0x7/0xb
scp           S C010315C     0  9384   9377                     (NOTLB)
c88d6d74 00000086 00000000 c010315c f8811000 c88d6ecc 00000014 00000002 
       f7a08a00 00000000 f6f00800 00000000 c88d6d68 c88d6d68 f6d26560 c200ff60 
       0001654f b9bb0272 0005d718 e398618c c88d6000 7fffffff cb0c440c 7fffffff 
Call Trace:
 [<c010315c>] apic_timer_interrupt+0x1c/0x24
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c01abb0e>] do_journal_end+0x63e/0x990
 [<c02dd74d>] _spin_unlock+0xd/0x30
 [<c012c850>] prepare_to_wait+0x20/0x70
 [<f88cf535>] unix_stream_data_wait+0xc5/0x100 [unix]
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<f88cf935>] unix_stream_recvmsg+0x3c5/0x420 [unix]
 [<c02dd74d>] _spin_unlock+0xd/0x30
 [<c0144736>] do_anonymous_page+0x46/0x170
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c0152c2d>] do_sync_read+0x9d/0xe0
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0152d62>] vfs_read+0xf2/0x100
 [<c0152f97>] sys_read+0x47/0x80
 [<c010275f>] syscall_call+0x7/0xb
log2ora.pl    S F6D00020     0  9499      1                7277 (NOTLB)
cb8bbd74 00000086 c041eb08 f6d00020 f6e6ec80 e9c6c800 00000000 c23d67a0 
       00000286 00000000 f6c5a2c0 00000004 f696a9b4 c0275bf3 f696a960 c200ff60 
       0001d457 4e29c4d5 0005d718 f6d0018c f696a940 7fffffff 00000000 cb8bbe48 
Call Trace:
 [<c0275bf3>] __kfree_skb+0x83/0x120
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c011dcd3>] local_bh_enable+0x33/0xa0
 [<c0274e6a>] sk_wait_data+0xba/0xd0
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c02a9880>] tcp_v4_do_rcv+0x100/0x110
 [<c0298aa2>] tcp_recvmsg+0x362/0x710
 [<c0275668>] sock_common_recvmsg+0x48/0x70
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c0152c2d>] do_sync_read+0x9d/0xe0
 [<c02dd346>] _spin_lock+0x16/0x90
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c02dbf7b>] schedule+0x3db/0x740
 [<c02dd346>] _spin_lock+0x16/0x90
 [<c0152d62>] vfs_read+0xf2/0x100
 [<c0152f97>] sys_read+0x47/0x80
 [<c010275f>] syscall_call+0x7/0xb
sshd          S 00000002     0  9548   1900  9549    9559  9369 (NOTLB)
d01a6d74 00000086 c02f042f 00000002 0000000e 0000000b c200ff60 00000000 
       d01a6d84 c02dd7df cacf1d60 00000001 a683c0cb 0005d718 f6d59aa0 c200ff60 
       0000010c a68d178b 0005d718 f6cb218c d01a6000 7fffffff f6dfe98c 7fffffff 
Call Trace:
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c012c99b>] autoremove_wake_function+0x1b/0x50
 [<c0114ac7>] __wake_up_common+0x37/0x70
 [<c012c850>] prepare_to_wait+0x20/0x70
 [<f88cf535>] unix_stream_data_wait+0xc5/0x100 [unix]
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<f88cf935>] unix_stream_recvmsg+0x3c5/0x420 [unix]
 [<c02dd48e>] _read_lock+0xe/0x90
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c0142edd>] zap_pud_range+0x3d/0x60
 [<c0152c2d>] do_sync_read+0x9d/0xe0
 [<c0142f64>] unmap_page_range+0x64/0x80
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0152d62>] vfs_read+0xf2/0x100
 [<c0152f97>] sys_read+0x47/0x80
 [<c010275f>] syscall_call+0x7/0xb
sshd          S C156E360     0  9549   9548                     (NOTLB)
dda8bea8 00000086 0000254c c156e360 000000d0 00000000 c0332580 00000010 
       00000000 000000d0 f6d025c0 00000000 a68b82e7 0005d718 f6cb2020 c200ff60 
       00004418 a68d0e19 0005d718 f6d59c0c 00000000 7fffffff 00000005 00000000 
Call Trace:
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c012c75d>] add_wait_queue+0x1d/0x50
 [<c02dd7df>] _spin_unlock_irqrestore+0xf/0x30
 [<c02961e6>] tcp_poll+0x16/0x170
 [<c02dd346>] _spin_lock+0x16/0x90
 [<c02dd74d>] _spin_unlock+0xd/0x30
 [<c0164e90>] do_select+0x190/0x2d0
 [<c0164b30>] __pollwait+0x0/0xd0
 [<c01652ae>] sys_select+0x2be/0x4b0
 [<c0202dda>] copy_from_user+0x3a/0x80
 [<c010275f>] syscall_call+0x7/0xb
sshd          S 00000002     0  9559   1900                9548 (NOTLB)
cd239d74 00000082 c02f042f 00000002 0000000e 0000000b f6d00aa0 c200ff60 
       00003ee5 bcbf1322 f6f00a80 00030002 bce3d24d 0005d717 f6d0eaa0 c200ff60 
       0000a4b0 c5e7beb9 0005d718 f6f356cc f6fe2520 7fffffff 00000000 cd239e48 
Call Trace:
 [<c02dcc40>] schedule_timeout+0xc0/0xd0
 [<c011dcd3>] local_bh_enable+0x33/0xa0
 [<c0274e6a>] sk_wait_data+0xba/0xd0
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c011dcd3>] local_bh_enable+0x33/0xa0
 [<c0298aa2>] tcp_recvmsg+0x362/0x710
 [<c01357c5>] do_generic_mapping_read+0x325/0x5e0
 [<c0275668>] sock_common_recvmsg+0x48/0x70
 [<c027201a>] sock_aio_read+0xda/0xf0
 [<c0142edd>] zap_pud_range+0x3d/0x60
 [<c0152c2d>] do_sync_read+0x9d/0xe0
 [<c0142f64>] unmap_page_range+0x64/0x80
 [<c0121544>] __mod_timer+0xe4/0x120
 [<c012c980>] autoremove_wake_function+0x0/0x50
 [<c0152d62>] vfs_read+0xf2/0x100
 [<c0152f97>] sys_read+0x47/0x80
 [<c010275f>] syscall_call+0x7/0xb

--Boundary-00=_PJDRCgb3gujD/Tg
Content-Type: text/plain;
  charset="us-ascii";
  name="s3-ps-aux-20050324.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="s3-ps-aux-20050324.out"

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1580  516 ?        S    Mar05   0:29 init [2]  
root         2  0.0  0.0     0    0 ?        S    Mar05   0:10 [migration/0]
root         3  0.0  0.0     0    0 ?        SN   Mar05   0:00 [ksoftirqd/0]
root         4  0.4  0.0     0    0 ?        S    Mar05 125:40 [migration/1]
root         5  0.0  0.0     0    0 ?        RN   Mar05   5:49 [ksoftirqd/1]
root         6  0.0  0.0     0    0 ?        S<   Mar05   0:00 [events/0]
root         7  0.1  0.0     0    0 ?        R<   Mar05  34:20 [events/1]
root         8  0.0  0.0     0    0 ?        S<   Mar05   0:00 [khelper]
root        13  0.0  0.0     0    0 ?        S<   Mar05   0:00 [kthread]
root        22  0.0  0.0     0    0 ?        S<   Mar05   0:00 [kacpid]
root        87  0.0  0.0     0    0 ?        S<   Mar05   0:24 [kblockd/0]
root        88  0.0  0.0     0    0 ?        S<   Mar05   0:09 [kblockd/1]
root       130  0.0  0.0     0    0 ?        S    Mar05  13:29 [kswapd0]
root       131  0.0  0.0     0    0 ?        S<   Mar05   0:00 [aio/0]
root       132  0.0  0.0     0    0 ?        S<   Mar05   0:00 [aio/1]
root       717  0.0  0.0     0    0 ?        S    Mar05   0:00 [kseriod]
root       784  0.0  0.0     0    0 ?        S    Mar05   0:00 [kirqd]
root       785  0.0  0.0     0    0 ?        S<   Mar05   9:09 [reiserfs/0]
root       786  0.0  0.0     0    0 ?        S<   Mar05   5:28 [reiserfs/1]
daemon    1552  0.0  0.0  1680  540 ?        Ss   Mar05   0:06 /sbin/portmap
root      1741  0.0  0.0  1748  608 ?        Ss   Mar05   4:45 /sbin/syslogd
root      1744  0.0  0.0  1704  476 ?        Ss   Mar05   0:00 /sbin/klogd
root      1871  0.0  0.0  1612  520 ?        Ss   Mar05   0:00 /usr/sbin/inetd
root      1880  0.0  0.0     0    0 ?        S    Mar05   4:17 [nfsd]
root      1886  0.0  0.0     0    0 ?        S    Mar05   0:00 [lockd]
root      1877  0.0  0.0     0    0 ?        S    Mar05   4:31 [nfsd]
root      1887  0.0  0.0     0    0 ?        S<   Mar05   0:00 [rpciod/0]
root      1879  0.0  0.0     0    0 ?        S    Mar05   4:08 [nfsd]
root      1888  0.0  0.0     0    0 ?        S<   Mar05   0:00 [rpciod/1]
root      1878  0.0  0.0     0    0 ?        S    Mar05   4:26 [nfsd]
root      1882  0.0  0.0     0    0 ?        S    Mar05   4:13 [nfsd]
root      1881  0.0  0.0     0    0 ?        S    Mar05   4:26 [nfsd]
root      1883  0.0  0.0     0    0 ?        S    Mar05   4:01 [nfsd]
root      1884  0.0  0.0     0    0 ?        S    Mar05   4:40 [nfsd]
root      1891  0.0  0.0  1872  876 ?        Ss   Mar05   0:00 /usr/sbin/rpc.mountd
root      1900  0.0  0.0  3540 1532 ?        Ss   Mar05   1:19 /usr/sbin/sshd
root      1908  0.0  0.0  1744  712 ?        Ss   Mar05   0:00 /sbin/rpc.statd --port 4000
root      1914  0.0  0.0  1940  816 ?        Ss   Mar05   0:11 /usr/sbin/cron
root      1962  0.0  0.0  1700  480 tty2     Ss+  Mar05   0:00 /sbin/getty 38400 tty2
root      1963  0.0  0.0  1700  480 tty3     Ss+  Mar05   0:00 /sbin/getty 38400 tty3
root      1964  0.0  0.0  1700  480 tty4     Ss+  Mar05   0:00 /sbin/getty 38400 tty4
root      1965  0.0  0.0  1700  480 tty5     Ss+  Mar05   0:00 /sbin/getty 38400 tty5
root      2012  0.0  0.0  1700  480 tty6     Ss+  Mar05   0:00 /sbin/getty 38400 tty6
root     24663  0.0  0.0  1700  480 tty1     Ss+  Mar06   0:00 /sbin/getty 38400 tty1
nagios    6835  0.0  0.0  1764  648 ?        Ss   Mar10   0:24 /usr/local/sbin/nrpe -c /etc/nrpe.cfg --daemon
root      7277  0.0  0.2  6248 4764 ?        Ss   Mar16   0:13 /usr/sbin/munin-node
root     13913  0.1  0.0     0    0 ?        S    05:19   1:14 [pdflush]
root      6476  0.1  0.0     0    0 ?        S    16:35   0:19 [pdflush]
root      4091  0.0  0.0 14512 2032 ?        Ss   19:58   0:00 sshd: shap [priv]
shap      4094  0.1  0.1 14680 2120 ?        S    19:58   0:04 sshd: shap@pts/1
shap      4095  0.0  0.0  2636 1440 pts/1    Ss   19:58   0:00 -bash
root      4100  0.0  0.0  2668 1500 pts/1    S    19:58   0:00 -su
root      6774  0.0  0.0 14512 2020 ?        Ss   20:15   0:00 sshd: gluk [priv]
gluk      6824  0.1  0.1 14664 2140 ?        S    20:15   0:03 sshd: gluk@pts/2
gluk      6825  0.0  0.0  2652 1452 pts/2    Ss   20:15   0:00 -bash
root      6833  0.0  0.0  2676 1512 pts/2    S    20:15   0:00 -su
root      6980  0.2  0.0  2128 1076 pts/1    S+   20:15   0:04 top
root     10547  0.0  0.0  6268 1916 ?        Ss   20:42   0:00 sshd: bannerbank [priv]
bannerb  10556  3.7  0.1  6588 2288 ?        S    20:42   0:13 sshd: bannerbank@notty
bannerb  10569  0.0  0.0  3272 1044 ?        Ss   20:42   0:00 scp -t /home/bannerbank/log/log_convert/new/s7/83_203211_7403_bannerbank.log
root     10680  0.0  0.0  6268 1916 ?        Ss   20:43   0:00 sshd: bannerbank [priv]
root     10703  0.0  0.0  6268 1916 ?        Ss   20:44   0:00 sshd: bannerbank [priv]
bannerb  10739  1.8  0.1  6588 2188 ?        S    20:44   0:04 sshd: bannerbank@notty
bannerb  10741  0.0  0.0  3272 1044 ?        Ss   20:44   0:00 scp -t /home/bannerbank/log/log_convert/new/s1/83_194749_11167_bannerbank.log
bannerb  10742  2.9  0.1  6588 2196 ?        S    20:44   0:07 sshd: bannerbank@notty
bannerb  10743  0.0  0.0  3272 1044 ?        Ss   20:44   0:00 scp -t /home/bannerbank/log/log_convert/new/s7/83_202809_7403_bannerbank.log
root     10948  0.0  0.0  6268 1916 ?        Ss   20:45   0:00 sshd: bannerbank [priv]
root     10957  0.0  0.0  6268 1916 ?        Ss   20:45   0:00 sshd: bannerbank [priv]
bannerb  10989  1.0  0.1  6576 2168 ?        S    20:46   0:01 sshd: bannerbank@notty
bannerb  11022  0.0  0.0  3272 1044 ?        Ss   20:46   0:00 scp -t /home/bannerbank/log/log_convert/new/s1/83_203814_11170_bannerbank.log
bannerb  11032  0.9  0.0  6420 2064 ?        S    20:46   0:01 sshd: bannerbank@notty
bannerb  11034  0.0  0.0  3272 1044 ?        Ss   20:46   0:00 scp -t /home/bannerbank/log/log_convert/new/s2/83_184325_9051_bannerbank.log
root     11147  0.0  0.0  6268 1916 ?        Ss   20:46   0:00 sshd: bannerbank [priv]
bannerb  11179  2.1  0.1  6588 2192 ?        R    20:46   0:02 sshd: bannerbank@notty
root     11180  0.0  0.0  6268 1916 ?        Ss   20:46   0:00 sshd: bannerbank [priv]
bannerb  11188  0.0  0.0  3272 1044 ?        Ss   20:46   0:00 scp -t /home/bannerbank/log/log_convert/new/s7/83_204216_7403_bannerbank.log
bannerb  11197  1.2  0.1  6576 2168 ?        S    20:46   0:01 sshd: bannerbank@notty
bannerb  11203  0.0  0.0  3272 1044 ?        Ss   20:46   0:00 scp -t /home/bannerbank/log/log_convert/new/s7/83_181503_7403_bannerbank.log
root     11331  0.0  0.0  6268 1916 ?        Ss   20:47   0:00 sshd: bannerbank [priv]
bannerb  11337  0.5  0.1  6432 2092 ?        S    20:47   0:00 sshd: bannerbank@notty
bannerb  11346  0.0  0.0  3272 1044 ?        Ss   20:47   0:00 scp -t /home/bannerbank/log/log_convert/new/s1/83_203814_11170_bannerbank.log
bannerb  11366 38.0  2.5 64000 53036 ?       R    20:48   0:08 /usr/bin/perl /home/bannerbank/utils/croned/log_convert.pl
root     11410  0.0  0.0  2684  856 pts/2    R+   20:48   0:00 ps aux

--Boundary-00=_PJDRCgb3gujD/Tg--
