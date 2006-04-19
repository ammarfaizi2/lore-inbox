Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWDSQr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWDSQr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWDSQr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:47:29 -0400
Received: from javor.praha12.net ([86.49.90.3]:23507 "HELO javor.praha12.net")
	by vger.kernel.org with SMTP id S1750772AbWDSQr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:47:28 -0400
From: =?utf-8?q?Luk=C3=A1=C5=A1_Turek?= <turek.lukas@centrum.cz>
Reply-To: turek.lukas@centrum.cz
To: linux-kernel@vger.kernel.org
Subject: Re: Strange ACPI bug after resume
Date: Wed, 19 Apr 2006 17:47:11 +0100
User-Agent: KMail/1.8.3
References: <200604191727.01688.turek.lukas@centrum.cz> <20060419154106.GA13102@rhlx01.fht-esslingen.de>
In-Reply-To: <20060419154106.GA13102@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604191847.11987.turek.lukas@centrum.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for quick reply.

On 19.4.2006 17:41, you wrote:
> Please enable CONFIG_MAGIC_SYSRQ, go to a text console and press
> Alt-SysRq-T to see where exactly in the kernel code this process is
> trapped.

I send full dmesg output, im not sure what is relevant. I triggered the bug 
with "cat /proc/acpi/thermal_zone/THRM/temperature" after resume, PID of the 
cat process is 8585.  

Lukas Turek


default_wake_function+0x0/0xc
 <c0146ff9> ll_rw_block+0x94/0xa0   <c0185133> search_by_key+0x698/0xa6a
 <c01847ff> pathrelse+0x1b/0x26   <c0176a63> 
reiserfs_update_sd_size+0x15e/0x16b
 <c0188b44> reiserfs_async_progress_wait+0x41/0x6b   <c0151c4d> 
core_sys_select+0x225/0x300
 <c02adae4> schedule+0x476/0x4db   <c011cf48> __dequeue_signal+0x68/0x70
 <c011cf7d> dequeue_signal+0x2d/0x7f   <c011e0ab> 
get_signal_to_deliver+0x5b/0x20b
 <c010278b> do_signal+0x48/0xeb   <c01363d6> unmap_vmas+0xce/0x180
 <c0151dbf> sys_select+0x97/0x14b   <c015030d> sys_renameat+0x55/0x5b
 <c0102907> sysenter_past_esp+0x54/0x75  
cron          S 7E0C86D0     0  7260      1          7443  6547 (NOTLB)
       de6f9f3c c0302ea8 c0125a05 7e0c86d0 00000000 c15df0f0 00000000 ea479a00 
       003d08d4 c15df0f0 df14e0f0 df14e1f8 de6f9f68 de6f8000 00000000 bfe06f84 
       c02ae4ba 00000001 00000000 de6f9f68 00000001 c0125c81 bfe06e28 00000000 
Call Trace:
 <c0125a05> enqueue_hrtimer+0x5b/0x80   <c02ae4ba> do_nanosleep+0x3b/0x61
 <c0125c81> hrtimer_nanosleep+0x45/0xe6   <c011ecd5> 
sys_rt_sigaction+0x73/0x88
 <c0125c19> hrtimer_wakeup+0x0/0x18   <c011e30d> sigprocmask+0x9e/0xa5
 <c0125d68> sys_nanosleep+0x46/0x4e   <c0102907> sysenter_past_esp+0x54/0x75
login         S 00000001     0  7443      1  7570    7446  7260 (NOTLB)
       de51ff48 c13ded40 00000000 00000001 00000001 c16e70b0 00000000 c1535100 
       003d08d1 c16e70b0 c15e1030 c15e1138 fffffe00 c15e10e0 c15e1030 00000004 
       c011873f 00000001 00000000 ffffffff 00000000 c15e1030 c011325a 00000000 
Call Trace:
 <c011873f> do_wait+0x25e/0x309   <c011325a> default_wake_function+0x0/0xc
 <c011325a> default_wake_function+0x0/0xc   <c011887d> sys_wait4+0x27/0x2a
 <c0102907> sysenter_past_esp+0x54/0x75  
agetty        S 18ECBF00     0  7446      1          7447  7443 (NOTLB)
       de655ec4 de655ec8 00000000 18ecbf00 00000001 dfee5560 00000000 c1535100 
       003d08d1 dfee5560 c16e70b0 c16e71b8 7fffffff dec42000 de655f24 bff9f4ab 
       c02ae10f de654000 0804c760 de655f24 c011e0ab 00000008 dec4200c dec423c4 
Call Trace:
 <c02ae10f> schedule_timeout+0x13/0x8c   <c011e0ab> 
get_signal_to_deliver+0x5b/0x20b
 <c01ecbcf> read_chan+0x2a2/0x49a   <c011325a> default_wake_function+0x0/0xc
 <c011325a> default_wake_function+0x0/0xc   <c01e8fc3> tty_read+0x6c/0x9a
 <c01438f4> vfs_read+0x83/0x11f   <c0143be6> sys_read+0x3c/0x62
 <c0102907> sysenter_past_esp+0x54/0x75  
agetty        S 18ECBF00     0  7447      1          7448  7446 (NOTLB)
       de6f7ec4 de6f7ec8 00000000 18ecbf00 00000001 dffa5070 00000000 c1535100 
       003d08d1 dffa5070 dfee5560 dfee5668 7fffffff def8c800 de6f7f24 bfd03a0b 
       c02ae10f de6f6000 0804c760 de6f7f24 c011e0ab 00000008 def8c80c def8cbc4 
Call Trace:
 <c02ae10f> schedule_timeout+0x13/0x8c   <c011e0ab> 
get_signal_to_deliver+0x5b/0x20b
 <c01ecbcf> read_chan+0x2a2/0x49a   <c011325a> default_wake_function+0x0/0xc
 <c011325a> default_wake_function+0x0/0xc   <c01e8fc3> tty_read+0x6c/0x9a
 <c01438f4> vfs_read+0x83/0x11f   <c0143be6> sys_read+0x3c/0x62
 <c0102907> sysenter_past_esp+0x54/0x75  
agetty        S 18ECBF00     0  7448      1          7449  7447 (NOTLB)
       de5f5ec4 de5f5ec8 00000000 18ecbf00 00000001 dfee0ad0 00000000 c1535100 
       003d08d1 dfee0ad0 dffa5070 dffa5178 7fffffff def8c000 de5f5f24 bffc7ccb 
       c02ae10f de5f4000 0804c760 de5f5f24 c011e0ab 00000008 def8c00c def8c3c4 
Call Trace:
 <c02ae10f> schedule_timeout+0x13/0x8c   <c011e0ab> 
get_signal_to_deliver+0x5b/0x20b
 <c01ecbcf> read_chan+0x2a2/0x49a   <c011325a> default_wake_function+0x0/0xc
 <c011325a> default_wake_function+0x0/0xc   <c01e8fc3> tty_read+0x6c/0x9a
 <c01438f4> vfs_read+0x83/0x11f   <c0143be6> sys_read+0x3c/0x62
 <c0102907> sysenter_past_esp+0x54/0x75  
agetty        S 18ECBF00     0  7449      1          7450  7448 (NOTLB)
       de61dec4 de61dec8 00000000 18ecbf00 00000001 c15e2560 00000000 c1535100 
       003d08d1 c15e2560 dfee0ad0 dfee0bd8 7fffffff dfbe1800 de61df24 bfb8988b 
       c02ae10f de61c000 0804c760 de61df24 c011e0ab 00000008 dfbe180c dfbe1bc4 
Call Trace:
 <c02ae10f> schedule_timeout+0x13/0x8c   <c011e0ab> 
get_signal_to_deliver+0x5b/0x20b
 <c01ecbcf> read_chan+0x2a2/0x49a   <c011325a> default_wake_function+0x0/0xc
 <c011325a> default_wake_function+0x0/0xc   <c01e8fc3> tty_read+0x6c/0x9a
 <c01438f4> vfs_read+0x83/0x11f   <c0143be6> sys_read+0x3c/0x62
 <c0102907> sysenter_past_esp+0x54/0x75  
agetty        S 18ECBF00     0  7450      1          7474  7449 (NOTLB)
       de769ec4 de769ec8 00000000 18ecbf00 00000001 def150b0 00000000 c1535100 
       003d08d1 def150b0 c15e2560 c15e2668 7fffffff dfbe1000 de769f24 bfaff85b 
       c02ae10f de768000 0804c760 de769f24 c011e0ab 00000008 dfbe100c dfbe13c4 
Call Trace:
 <c02ae10f> schedule_timeout+0x13/0x8c   <c011e0ab> 
get_signal_to_deliver+0x5b/0x20b
 <c01ecbcf> read_chan+0x2a2/0x49a   <c011325a> default_wake_function+0x0/0xc
 <c011325a> default_wake_function+0x0/0xc   <c01e8fc3> tty_read+0x6c/0x9a
 <c01438f4> vfs_read+0x83/0x11f   <c0143be6> sys_read+0x3c/0x62
 <c0102907> sysenter_past_esp+0x54/0x75  
kdm           S 003D08C3     0  7474      1  7477    9501  7450 (NOTLB)
       de6ddb5c 008603a7 54b2d100 003d08c3 00000001 df773a50 00000000 c1535100 
       003d08d1 df773a50 def150b0 def151b8 7fffffff 00000000 00020000 00000000 
       c02ae10f de6e1c00 df533e00 00200246 de6ddbe0 df533e00 c014cec8 de6e1c00 
Call Trace:
 <c02ae10f> schedule_timeout+0x13/0x8c   <c014cec8> pipe_poll+0x2c/0x86
 <c01519df> do_select+0x29d/0x2e6   <c0151656> __pollwait+0x0/0x44
 <c011325a> default_wake_function+0x0/0xc   <c011325a> 
default_wake_function+0x0/0xc
 <c011325a> default_wake_function+0x0/0xc   <c011325a> 
default_wake_function+0x0/0xc
 <c011325a> default_wake_function+0x0/0xc   <c011325a> 
default_wake_function+0x0/0xc
 <c011325a> default_wake_function+0x0/0xc   <c01766e8> inode2sd+0x12a/0x13f
 <c0188b44> reiserfs_async_progress_wait+0x41/0x6b   <c01239c6> 
autoremove_wake_function+0x0/0x2d
 <c01239c6> autoremove_wake_function+0x0/0x2d   <c018c252> 
do_journal_end+0x128/0x81c
 <c01558e5> __d_lookup+0xaa/0xca   <c0151c4d> core_sys_select+0x225/0x300
 <c02adae4> schedule+0x476/0x4db   <c0135f70> copy_pte_range+0x198/0x1ac
 <c011cf48> __dequeue_signal+0x68/0x70   <c011cf7d> dequeue_signal+0x2d/0x7f
 <c011e0ab> get_signal_to_deliver+0x5b/0x20b   <c010278b> do_signal+0x48/0xeb
 <c0156f57> touch_atime+0x8b/0x8f   <c014cab4> pipe_readv+0x231/0x23d
 <c0151dbf> sys_select+0x97/0x14b   <c0143957> vfs_read+0xe6/0x11f
 <c0102907> sysenter_past_esp+0x54/0x75  
X             S 003D08DC     0  7477   7474          7478       (NOTLB)
       df0a3b5c 00000010 779daf00 003d08dc 00000002 df773560 00000000 779daf00 
       003d08dc df773560 c15df5e0 c15df6e8 00014c22 00014c22 00000100 00000000 
       c02ae16d c03923d0 c03923d0 00014c22 c011c75b c15df5e0 c03919a0 00000080 
Call Trace:
 <c02ae16d> schedule_timeout+0x71/0x8c   <c011c75b> process_timeout+0x0/0x5
 <c01519df> do_select+0x29d/0x2e6   <c0151656> __pollwait+0x0/0x44
 <c011325a> default_wake_function+0x0/0xc   <c011325a> 
default_wake_function+0x0/0xc
 <c011325a> default_wake_function+0x0/0xc   <c015dc7f> 
mpage_bio_submit+0x19/0x1d
 <c015e058> do_mpage_readpage+0x303/0x361   <c01b5b24> 
radix_tree_node_alloc+0x10/0x41
 <c01b5c98> radix_tree_insert+0x5a/0xe5   <c0132f3a> 
__pagevec_lru_add+0x77/0x82
 <c015e19d> mpage_readpages+0xe7/0x10d   <c0130a52> buffered_rmqueue+0xe6/0xfd
 <c0130b82> get_page_from_freelist+0x7d/0x96   <c01129e3> 
__activate_task+0x4b/0x52
 <c01129e3> __activate_task+0x4b/0x52   <c0113298> __wake_up_common+0x32/0x4d
 <c01132c4> __wake_up+0x11/0x1a   <c02a5168> unix_write_space+0x2a/0x4d
 <c02ae347> mutex_lock+0x9/0x16   <c02a6d0a> unix_stream_recvmsg+0x2c4/0x34d
 <c0151c4d> core_sys_select+0x225/0x300   <c0267760> sock_aio_read+0x53/0x61
 <c0106fd6> save_i387_fxsave+0x7a/0x89   <c0143833> do_sync_read+0xbb/0xf9
 <c01239c6> autoremove_wake_function+0x0/0x2d   <c0151dbf> 
sys_select+0x97/0x14b
 <c01b8161> copy_to_user+0x41/0x49   <c0102907> sysenter_past_esp+0x54/0x75
kdm           S DF773A50     0  7478   7474  7569          7477 (NOTLB)
       de73deec 00000000 de73df24 df773a50 00000001 dff5b0f0 00000000 c1535100 
       003d08d1 dff5b0f0 df773a50 df773b58 df616c00 c0304580 de73df14 df616c00 
       c014c768 00000000 df773a50 c01239c6 de73df20 de73df20 dff31600 de73df28 
Call Trace:
 <c014c768> pipe_wait+0x68/0x89   <c01239c6> autoremove_wake_function+0x0/0x2d
 <c0119643> current_fs_time+0x38/0x3f   <c01239c6> 
autoremove_wake_function+0x0/0x2d
 <c02ae347> mutex_lock+0x9/0x16   <c014ca57> pipe_readv+0x1d4/0x23d
 <c014cadc> pipe_read+0x1c/0x20   <c01438f4> vfs_read+0x83/0x11f
 <c0143be6> sys_read+0x3c/0x62   <c0102907> sysenter_past_esp+0x54/0x75
kdm_greet     S 003D08DC     0  7569   7478                     (NOTLB)
       de76fb5c c1681c5c 779daf00 003d08dc 00000000 c15df0f0 00000000 779daf00 
       003d08dc c15df0f0 df773560 df773668 ffff6b74 ffff6b74 00000100 00000000 
       c02ae16d c0391d48 c0391d48 ffff6b74 c011c75b df773560 c03919a0 df530180 
Call Trace:
 <c02ae16d> schedule_timeout+0x71/0x8c   <c011c75b> process_timeout+0x0/0x5
 <c01519df> do_select+0x29d/0x2e6   <c0151656> __pollwait+0x0/0x44
 <c011325a> default_wake_function+0x0/0xc   <c011325a> 
default_wake_function+0x0/0xc
 <c011325a> default_wake_function+0x0/0xc   <c01b2b11> 
cfq_crq_enqueued+0x7b/0x9e
 <c01aba44> elv_insert+0x96/0x12f   <c01aeb27> __make_request+0x340/0x36f
 <c01aec85> generic_make_request+0xcf/0xde   <c0130a52> 
buffered_rmqueue+0xe6/0xfd
 <c0130b82> get_page_from_freelist+0x7d/0x96   <c0130bea> 
__alloc_pages+0x4f/0x269
 <c01129e3> __activate_task+0x4b/0x52   <c01413e1> cache_grow+0xda/0x121
 <c01129e3> __activate_task+0x4b/0x52   <c0113298> __wake_up_common+0x32/0x4d
 <c01132c4> __wake_up+0x11/0x1a   <c0269f48> sock_def_readable+0x1f/0x42
 <c02a669e> unix_stream_sendmsg+0x1fe/0x2a5   <c0151c4d> 
core_sys_select+0x225/0x300
 <c026791e> sock_aio_write+0x53/0x61   <c02adae4> schedule+0x476/0x4db
 <c0143a4b> do_sync_write+0xbb/0xf9   <c0156f57> touch_atime+0x8b/0x8f
 <c014cab4> pipe_readv+0x231/0x23d   <c0267b20> sock_ioctl+0x19a/0x1b5
 <c0151dbf> sys_select+0x97/0x14b   <c01b8161> copy_to_user+0x41/0x49
 <c0102907> sysenter_past_esp+0x54/0x75  
bash          S 00000000     0  7570   7443  7578               (NOTLB)
       de773f34 c010278b 00000000 00000000 00000001 c15e2070 00000000 c1535100 
       003d08d1 c15e2070 dff5b0f0 dff5b1f8 fffffe00 dff5b1a0 dff5b0f0 00000004 
       c011873f 00000001 00000000 ffffffff 00000000 dff5b0f0 c011325a 00000000 
Call Trace:
 <c010278b> do_signal+0x48/0xeb   <c011873f> do_wait+0x25e/0x309
 <c011325a> default_wake_function+0x0/0xc   <c011ecd5> 
sys_rt_sigaction+0x73/0x88
 <c011325a> default_wake_function+0x0/0xc   <c011887d> sys_wait4+0x27/0x2a
 <c0118893> sys_waitpid+0x13/0x17   <c0102907> sysenter_past_esp+0x54/0x75
mc            S 003D08C5     0  7578   7570  7581               (NOTLB)
       dd72fb5c c01e8488 fe565400 003d08c5 00000001 dff65a50 00000000 c1535100 
       003d08d1 dff65a50 c15e2070 c15e2178 7fffffff 00000000 00000200 00000000 
       c02ae10f dfc30240 dfb9c400 00200246 dd72fbe0 dfb9c400 c014cec8 dfc30240 
Call Trace:
 <c01e8488> tty_ldisc_ref_wait+0xc/0x95   <c02ae10f> 
schedule_timeout+0x13/0x8c
 <c014cec8> pipe_poll+0x2c/0x86   <c01519df> do_select+0x29d/0x2e6
 <c0151656> __pollwait+0x0/0x44   <c011325a> default_wake_function+0x0/0xc
 <c011325a> default_wake_function+0x0/0xc   <c011325a> 
default_wake_function+0x0/0xc
 <c011325a> default_wake_function+0x0/0xc   <c011325a> 
default_wake_function+0x0/0xc
 <c01b5b24> radix_tree_node_alloc+0x10/0x41   <c01b5c98> 
radix_tree_insert+0x5a/0xe5
 <c0130a52> buffered_rmqueue+0xe6/0xfd   <c0130b82> 
get_page_from_freelist+0x7d/0x96
 <c0130bea> __alloc_pages+0x4f/0x269   <c0137527> do_anonymous_page+0xa8/0x109
 <c013785d> __handle_mm_fault+0xa6/0x16d   <c0111c6b> 
do_page_fault+0x239/0x55d
 <c01129e3> __activate_task+0x4b/0x52   <c0113298> __wake_up_common+0x32/0x4d
 <c0151c4d> core_sys_select+0x225/0x300   <c01f2798> scrup+0x5a/0xb7
 <c02adae4> schedule+0x476/0x4db   <c01f4666> do_con_trol+0x10a/0x8fc
 <c011cf48> __dequeue_signal+0x68/0x70   <c011cf7d> dequeue_signal+0x2d/0x7f
 <c011e0ab> get_signal_to_deliver+0x5b/0x20b   <c010278b> do_signal+0x48/0xeb
 <c011325a> default_wake_function+0x0/0xc   <c01132c4> __wake_up+0x11/0x1a
 <c01e856e> tty_ldisc_deref+0x47/0x4d   <c0151dbf> sys_select+0x97/0x14b
 <c0143b71> vfs_write+0xe8/0x121   <c0102907> sysenter_past_esp+0x54/0x75
cons.saver    S DFF65A50     0  7581   7578          7582       (NOTLB)
       de771eec 00000000 de771f24 dff65a50 00000001 df06aa10 00000000 c1535100 
       003d08d1 df06aa10 dff65a50 dff65b58 dfb9ca00 c0304580 de771f14 dfb9ca00 
       c014c768 00000000 dff65a50 c01239c6 de771f20 de771f20 dff31600 444665fe 
Call Trace:
 <c014c768> pipe_wait+0x68/0x89   <c01239c6> autoremove_wake_function+0x0/0x2d
 <c01239c6> autoremove_wake_function+0x0/0x2d   <c02ae347> mutex_lock+0x9/0x16
 <c014ca57> pipe_readv+0x1d4/0x23d   <c014cadc> pipe_read+0x1c/0x20
 <c01438f4> vfs_read+0x83/0x11f   <c0143be6> sys_read+0x3c/0x62
 <c0102907> sysenter_past_esp+0x54/0x75  
bash          S 003D08C7     0  7582   7578  7588          7581 (NOTLB)
       dd72df34 c010278b 00000000 003d08c7 00000001 dff65070 00000000 c1535100 
       003d08d1 dff65070 df06aa10 df06ab18 fffffe00 df06aac0 df06aa10 0000000e 
       c011873f 00000001 00000000 ffffffff 00000000 df06aa10 c011325a 00000000 
Call Trace:
 <c010278b> do_signal+0x48/0xeb   <c011873f> do_wait+0x25e/0x309
 <c011325a> default_wake_function+0x0/0xc   <c01ea5d9> tiocspgrp+0x6f/0x90
 <c011325a> default_wake_function+0x0/0xc   <c011887d> sys_wait4+0x27/0x2a
 <c0118893> sys_waitpid+0x13/0x17   <c0102907> sysenter_past_esp+0x54/0x75
bash          S DC7C2DDC     0  7588   7582  8585               (NOTLB)
       de6a9f34 ddc29300 de6a9f30 dc7c2ddc 00000000 db028ad0 00000000 c2847e00 
       003d08d1 db028ad0 debacad0 debacbd8 fffffe00 debacb80 debacad0 00000004 
       c011873f 00000001 00000000 ffffffff 00000000 debacad0 c011325a 00000000 
Call Trace:
 <c011873f> do_wait+0x25e/0x309   <c011325a> default_wake_function+0x0/0xc
 <c011325a> default_wake_function+0x0/0xc   <c011887d> sys_wait4+0x27/0x2a
 <c0118893> sys_waitpid+0x13/0x17   <c0102907> sysenter_past_esp+0x54/0x75
cat           R running     0  8585   7588                     (NOTLB)
dhcpcd        S 00000019     0  9501      1                7474 (NOTLB)
       db8f7b5c 7373656c 01010100 00000019 00000000 db6e90b0 00000000 08328400 
       003d08d3 db6e90b0 c15dfad0 c15dfbd8 7fffffff 00000000 00000020 00000000 
       c02ae10f de625e00 db418cc0 00000010 00000145 c0298a5d c02b9400 00000000 
Call Trace:
 <c02ae10f> schedule_timeout+0x13/0x8c   <c0298a5d> udp_poll+0xc/0xb0
 <c01519df> do_select+0x29d/0x2e6   <c0151656> __pollwait+0x0/0x44
 <c011325a> default_wake_function+0x0/0xc   <c011325a> 
default_wake_function+0x0/0xc
 <c01558e5> __d_lookup+0xaa/0xca   <c014daaf> do_lookup+0x3a/0x78
 <c0154db5> dput+0x22/0x113   <c01b80c3> __copy_to_user_ll+0x4f/0x56
 <c012dae4> file_read_actor+0x71/0xd5   <c01558e5> __d_lookup+0xaa/0xca
 <c01e75dc> extract_buf+0x8f/0xca   <c01558e5> __d_lookup+0xaa/0xca
 <c014daaf> do_lookup+0x3a/0x78   <c0154db5> dput+0x22/0x113
 <c014e3d5> __link_path_walk+0x8e8/0x9d6   <c0151c4d> 
core_sys_select+0x225/0x300
 <c0130b82> get_page_from_freelist+0x7d/0x96   <c0130bea> 
__alloc_pages+0x4f/0x269
 <c0136ddd> do_wp_page+0x242/0x25c   <c01378c9> __handle_mm_fault+0x112/0x16d
 <c012e114> filemap_nopage+0x166/0x2c0   <c0137738> do_no_page+0x1b0/0x1d0
 <c0137872> __handle_mm_fault+0xbb/0x16d   <c0151dbf> sys_select+0x97/0x14b
 <c0102907> sysenter_past_esp+0x54/0x75  
