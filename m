Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267403AbUHSVMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267403AbUHSVMU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 17:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267407AbUHSVMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 17:12:19 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:17300 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267403AbUHSVLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 17:11:43 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: kernbench on 512p
Date: Thu, 19 Aug 2004 17:11:04 -0400
User-Agent: KMail/1.6.2
Cc: hawkes@sgi.com, linux-kernel@vger.kernel.org, wli@holomorphy.com
References: <200408191216.33667.jbarnes@engr.sgi.com> <200408191237.16959.jbarnes@engr.sgi.com> <253460000.1092939952@flay>
In-Reply-To: <253460000.1092939952@flay>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_odRJBOsy6cipmgs"
Message-Id: <200408191711.04776.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_odRJBOsy6cipmgs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday, August 19, 2004 2:25 pm, Martin J. Bligh wrote:
> Does lockmeter not work for you? It's sitting in my tree still, and
> Andrew's last time I looked.

Ok, it seems to work at least a little (btw, oprofile cause the machine to be 
unusable whenever a bunch of processes started up).

I got a bunch of scary messages like these though:

For cpu 140 entry 998 incremented kernel count=3
Bad kernel cum_hold_ticks=-8658575876528 (FFFFF82004A91E50) for cpu=140 
index=999
For cpu 140 entry 999 incremented kernel count=3

John, what does that mean?  The lock contention was heavy, but I wouldn't 
think that we'd overflow a 64 bit tick counter...

The output is attached (my mailer insists on wrapping it if I inline it).  I 
used 'lockstat -w'.

Jesse

--Boundary-00=_odRJBOsy6cipmgs
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lockstat-3.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lockstat-3.txt"

___________________________________________________________________________________________
System: Linux ascender.americas.sgi.com 2.6.8.1-mm1 #4 SMP Thu Aug 19 13:05:16 PDT 2004 ia64
Total counts

All (512) CPUs
Selecting locks that meet ALL of the following:
        requests/sec:   >  0.00/sec
        contention  :   >  0.00%
        utilization :   >  0.00%


Start time: Thu Aug 19 15:52:55 2004
End   time: Thu Aug 19 15:53:57 2004
Delta Time: 62.51 sec.
Hash table slots in use:      343.
Global read lock slots in use: 999.
./lockstat: One or more warnings were printed with the report.

*************************** Warnings! ******************************
        Read Lock table overflowed.

        The data in this report may be in error due to this.
************************ End of Warnings! **************************


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME

        1.1%  6.9us( 158ms)   33ms(1015ms)(51.4%)  47254182 98.9%  1.1% 0.03%  *TOTAL*

 0.08% 0.11%  1.4us( 253us) 1448us(  17ms)(0.00%)     35255 99.9% 0.11%    0%  [0xe00000b0037fe5d0]
 0.00%    0%  8.7us(  19us)    0us                       14  100%    0%    0%    xfs_log_need_covered+0x100
 0.01% 0.10%  1.1us(  34us)  775us(2977us)(0.00%)      3848 99.9% 0.10%    0%    xfs_log_notify+0x40
 0.00%    0%  3.4us(  44us)    0us                      181  100%    0%    0%    xlog_state_do_callback+0x50
 0.00%    0%  0.1us( 1.2us)    0us                      181  100%    0%    0%    xlog_state_do_callback+0x410
 0.00%    0%  2.0us(  17us)    0us                      181  100%    0%    0%    xlog_state_do_callback+0x480
 0.00%    0%  0.2us( 0.6us)    0us                      182  100%    0%    0%    xlog_state_done_syncing+0x40
 0.03% 0.17%  2.8us(  80us)  935us(  12ms)(0.00%)      7853 99.8% 0.17%    0%    xlog_state_get_iclog_space+0x30
 0.01% 0.11%  2.4us(  41us)   15us(  40us)(0.00%)      3506 99.9% 0.11%    0%    xlog_state_put_ticket+0x20
 0.00% 0.06%  0.1us(  48us)  458us(2212us)(0.00%)      7875  100% 0.06%    0%    xlog_state_release_iclog+0x50
 0.00%    0%   10us(  29us)    0us                       32  100%    0%    0%    xlog_state_sync_all+0x30
 0.00%    0%  0.8us(  15us)    0us                       21  100%    0%    0%    xlog_state_sync_all+0x420
 0.00%    0% 10.0us(10.0us)    0us                        1  100%    0%    0%    xlog_state_sync+0x40
 0.00%    0%   20us(  20us)    0us                        1  100%    0%    0%    xlog_state_sync+0x3d0
 0.00%    0%  3.1us(  20us)    0us                       25  100%    0%    0%    xlog_state_want_sync+0x20
 0.01% 0.29%  1.2us(  63us) 3883us(  17ms)(0.00%)      3506 99.7% 0.29%    0%    xlog_ticket_get+0x50
 0.01% 0.04%  1.1us( 253us)  9.0us(  17us)(0.00%)      7694  100% 0.04%    0%    xlog_write+0x590
 0.00%    0%  6.3us(  41us)    0us                       25  100%    0%    0%    xlog_write+0x660
 0.00%    0%  0.5us(  19us)    0us                      129  100%    0%    0%    xlog_write+0x7a0

 0.12% 0.22%  3.1us( 101us) 2272us(  31ms)(0.00%)     25111 99.8% 0.22%    0%  [0xe00000b0037fe670]
 0.02% 0.13%  3.5us(  55us)   10ms(  27ms)(0.00%)      3888 99.9% 0.13%    0%    xfs_log_move_tail+0x70
 0.00% 0.27%  0.1us(  22us) 1373us(  28ms)(0.00%)      7875 99.7% 0.27%    0%    xlog_assign_tail_lsn+0x50
 0.06% 0.29%   10us( 101us) 3117us(  31ms)(0.00%)      3506 99.7% 0.29%    0%    xlog_grant_log_space+0x30
 0.02% 0.23%  3.2us(  88us) 1293us(  11ms)(0.00%)      4745 99.8% 0.23%    0%    xlog_grant_push_ail+0x50
 0.00% 0.08%  2.2us(  29us)   22us(  22us)(0.00%)      1239  100% 0.08%    0%    xlog_regrant_reserve_log_space+0x60
 0.01%    0%   26us(  63us)    0us                      171  100%    0%    0%    xlog_regrant_write_log_space+0x90
 0.00%    0%  0.0us( 0.1us)    0us                      181  100%    0%    0%    xlog_state_do_callback+0x3c0
 0.01% 0.23%  1.0us(  40us)  185us(1307us)(0.00%)      3506 99.8% 0.23%    0%    xlog_ungrant_log_space+0x50

 0.02% 0.14%  0.5us( 203us) 1261us(  15ms)(0.00%)     29681 99.9% 0.14%    0%  [0xe000193003e3e024]
 0.00%    0%  0.2us(  12us)    0us                      364  100%    0%    0%    xfs_buf_iodone+0x30
 0.00%    0%  0.1us( 4.9us)    0us                      170  100%    0%    0%    xfs_efi_item_unpin+0x30
 0.00%    0%  0.1us( 3.4us)    0us                      170  100%    0%    0%    xfs_efi_release+0x40
 0.00% 0.50%  0.1us( 6.6us)  6.1us(  12us)(0.00%)      2004 99.5% 0.50%    0%    xfs_iflush_done+0xc0
 0.00% 0.50%  0.8us(  29us)   18us(  89us)(0.00%)      2004 99.5% 0.50%    0%    xfs_iflush_int+0x3f0
 0.00% 0.01%  0.2us(  17us)   35us(  36us)(0.00%)     15515  100% 0.01%    0%    xfs_trans_chunk_committed+0x220
 0.00% 50.0%  124us( 203us)   14ms(  15ms)(0.00%)         6 50.0% 50.0%    0%    xfs_trans_push_ail+0x40
 0.01% 0.57%  2.1us(  56us)   19us(  94us)(0.00%)      1567 99.4% 0.57%    0%    xfs_trans_push_ail+0x2b0
 0.00%    0%  1.7us(  10us)    0us                        6  100%    0%    0%    xfs_trans_push_ail+0x420
 0.01% 0.11%  0.7us(  35us) 1319us(  12ms)(0.00%)      7875 99.9% 0.11%    0%    xfs_trans_tail_ail+0x30

 0.04% 0.08%  1.4us(  65us)   77us( 871us)(0.00%)     19294  100% 0.08%    0%  [0xe000193003e3e110]
 0.04% 0.07%  1.6us(  65us)   23us(  51us)(0.00%)     16434  100% 0.07%    0%    xfs_mod_incore_sb+0x20
 0.00% 0.17%  0.6us(  65us)  196us( 871us)(0.00%)      2859 99.8% 0.17%    0%    xfs_mod_incore_sb_batch+0x30
 0.00%    0%   22us(  22us)    0us                        1  100%    0%    0%    xfs_statvfs+0x40

 0.09% 0.36%  4.5us( 824us)   27us( 342us)(0.00%)     12079 99.6% 0.36%    0%  [0xe000353003c8e040]
 0.08% 0.62%   22us( 824us)   22us( 201us)(0.00%)      2419 99.4% 0.62%    0%    qla1280_intr_handler+0x30
 0.00% 0.17%  0.8us(  25us)   15us(  40us)(0.00%)      2415 99.8% 0.17%    0%    scsi_device_unbusy+0x40
    0% 0.04%                 3.9us( 3.9us)(0.00%)      2415  100% 0.04%    0%    scsi_dispatch_cmd+0x330
    0% 0.50%                  55us( 342us)(0.00%)      2415 99.5% 0.50%    0%    scsi_request_fn+0x260
    0% 0.50%                  13us(  29us)(0.00%)      2415 99.5% 0.50%    0%    scsi_run_queue+0xa0

 0.14%  1.2%  3.1us(2630us)   81us(5265us)(0.00%)     28773 98.8%  1.2%    0%  [0xe00039b003b6b834]
 0.00%  1.1%  0.2us( 204us)   76us(1582us)(0.00%)     11558 98.9%  1.1%    0%    __make_request+0x150
 0.02%  1.3%  4.0us( 182us)   19us(  59us)(0.00%)      2415 98.7%  1.3%    0%    blk_run_queue+0x40
 0.11%  1.0%   52us(2630us)  747us(5265us)(0.00%)      1342 99.0%  1.0%    0%    generic_unplug_device+0x40
    0% 0.50%                 172us(1021us)(0.00%)      2415 99.5% 0.50%    0%    get_request+0x80
    0% 0.91%                  25us( 124us)(0.00%)      2415 99.1% 0.91%    0%    scsi_device_unbusy+0xd0
    0%  1.6%                  22us( 113us)(0.00%)      2415 98.4%  1.6%    0%    scsi_end_request+0x160
 0.01%  4.2%  3.5us( 132us)   40us( 310us)(0.00%)      2415 95.8%  4.2%    0%    scsi_request_fn+0x4a0
    0% 0.08%                  57us(  97us)(0.00%)      3798  100% 0.08%    0%    scsi_request_fn+0x540

 71.7% 81.0%   82us(  16ms)   36ms(1015ms)(49.3%)    545870 19.0% 81.0%    0%  dcache_lock
 0.10% 96.7%   74us(1190us)   39ms( 403ms)(0.10%)       869  3.3% 96.7%    0%    d_alloc+0x270
 0.05% 97.3%  132us(1058us)   39ms( 325ms)(0.03%)       259  2.7% 97.3%    0%    d_delete+0x40
 0.15% 81.7%   60us(1273us)   36ms( 446ms)(0.14%)      1533 18.3% 81.7%    0%    d_instantiate+0x90
 0.06% 95.3%  184us(1082us)   33ms( 217ms)(0.02%)       212  4.7% 95.3%    0%    d_move+0x60
 0.13% 65.4%   95us(1045us)   35ms( 356ms)(0.06%)       869 34.6% 65.4%    0%    d_rehash+0xe0
 71.1% 80.9%   82us(  16ms)   36ms(1015ms)(48.8%)    540564 19.1% 80.9%    0%    dput+0x40
 0.16% 89.5%   66us( 902us)   40ms( 336ms)(0.17%)      1536 10.5% 89.5%    0%    link_path_walk+0xef0
 0.00%  100%   91us( 326us)   43ms( 134ms)(0.00%)        28    0%  100%    0%    sys_getcwd+0x210

 0.94%  3.0%  3.7us(4918us) 1113us(  43ms)(0.02%)    157922 97.0%  3.0%    0%  files_lock
 0.00% 0.83%  0.6us(  21us)   71us( 148us)(0.00%)       360 99.2% 0.83%    0%    check_tty_count+0x40
 0.06%  1.7%  0.5us(4918us) 1127us(  43ms)(0.00%)     78366 98.3%  1.7%    0%    file_kill+0x60
 0.87%  4.4%  6.9us( 289us) 1109us(  43ms)(0.01%)     79196 95.6%  4.4%    0%    file_move+0x40

 0.78% 0.33%   11us(6090us)  584us(  20ms)(0.00%)     43999 99.7% 0.33%    0%  inode_lock
 0.02%  1.3%  2.5us(1019us)  638us(  16ms)(0.00%)      4654 98.7%  1.3%    0%    __mark_inode_dirty+0xf0
 0.55% 0.20%   34us(6090us)   35us(  82us)(0.00%)     10047 99.8% 0.20%    0%    __sync_single_inode+0xf0
 0.00% 0.77%  1.1us(  24us)   42us(  60us)(0.00%)       390 99.2% 0.77%    0%    generic_delete_inode+0x260
 0.03%  1.3%   20us(  83us)   57us( 143us)(0.00%)       796 98.7%  1.3%    0%    get_new_inode_fast+0x50
 0.02%  1.0%   15us(  87us) 3385us(  20ms)(0.00%)       796 99.0%  1.0%    0%    iget_locked+0xd0
 0.01% 0.51%  2.5us(  51us)   44us( 132us)(0.00%)      2743 99.5% 0.51%    0%    igrab+0x20
 0.06% 0.19%  2.8us( 162us)  561us(8501us)(0.00%)     13905 99.8% 0.19%    0%    iput+0xb0
 0.02% 0.45%   28us( 116us) 1018us(2019us)(0.00%)       449 99.6% 0.45%    0%    new_inode+0x60
 0.06%    0%  3.6us( 200us)    0us                    10047  100%    0%    0%    sync_sb_inodes+0x570
 0.01% 0.58%   37us( 166us)   27us(  27us)(0.00%)       172 99.4% 0.58%    0%    writeback_inodes+0x30

 0.25% 0.06%   89us(1143us)  300us( 300us)(0.00%)      1771  100% 0.06%    0%  kernel_flag
 0.10%    0%  340us(1143us)    0us                      192  100%    0%    0%    chrdev_open+0x1c0
 0.00%    0%  2.2us(  21us)    0us                      131  100%    0%    0%    de_put+0x50
 0.00%    0%  0.1us( 7.5us)    0us                      176  100%    0%    0%    linvfs_ioctl+0x150
 0.09%    0%  416us( 854us)    0us                      131  100%    0%    0%    proc_lookup+0x60
 0.00%    0%  6.8us(  21us)    0us                        7  100%    0%    0%    schedule+0xc20
 0.02% 0.11%   15us( 871us)  300us( 300us)(0.00%)       920 99.9% 0.11%    0%    sys_ioctl+0xa0
 0.00%    0%   24us( 462us)    0us                       21  100%    0%    0%    tty_read+0x160
 0.04%    0%  127us( 385us)    0us                      180  100%    0%    0%    tty_release+0x50
 0.00%    0%   39us( 428us)    0us                       13  100%    0%    0%    tty_write+0x3d0

 0.10%  1.1%  8.4us( 558us)   51ms( 239ms)(0.01%)      7632 98.9%  1.1%    0%  mmlist_lock
 0.01%  1.6%  2.4us( 146us)   80ms( 215ms)(0.01%)      1771 98.4%  1.6%    0%    copy_mm+0x2c0
 0.05%  1.4%   17us( 558us)   55ms( 239ms)(0.00%)      1989 98.6%  1.4%    0%    exec_mmap+0x40
 0.04% 0.75%  6.8us( 121us)   20ms( 156ms)(0.00%)      3872 99.3% 0.75%    0%    mmput+0x40

  4.4% 58.6%   48us(7191us)   19ms(  84ms)( 1.9%)     57005 41.4% 58.6%    0%  rcu_state
 0.01% 38.7%   58us( 679us)   10ms(  41ms)(0.00%)       119 61.3% 38.7%    0%    __rcu_process_callbacks+0x260
  4.4% 58.6%   48us(7191us)   19ms(  84ms)( 1.9%)     56886 41.4% 58.6%    0%    rcu_check_quiescent_state+0xf0

 0.00% 0.45%  2.1us(  39us) 3128us(9317us)(0.00%)       665 99.5% 0.45%    0%  vnumber_lock
 0.00% 0.45%  2.1us(  39us) 3128us(9317us)(0.00%)       665 99.5% 0.45%    0%    vn_initialize+0xb0

  1.0% 0.00%  9.9us(1399us) 3843us(3843us)(0.00%)     64014  100% 0.00%    0%  xtime_lock+0x4
 0.00%    0%   20us(  28us)    0us                        2  100%    0%    0%    do_adjtimex+0x1a0
  1.0% 0.00%  9.9us(1399us) 3843us(3843us)(0.00%)     64012  100% 0.00%    0%    timer_interrupt+0x2a0

 0.24% 0.17%  0.4us(  32ms)  686us(  32ms)(0.00%)    414014 99.8% 0.17%    0%  __d_lookup+0x1b0
 0.07% 0.01%  3.1us( 124us)   15us(  15us)(0.00%)     13477  100% 0.01%    0%  _pagebuf_find+0xf0
 0.03% 0.00%  0.5us(  60us)  9.9us(  17us)(0.00%)     45039  100% 0.00%    0%  anon_vma_unlink+0x40
 0.31% 0.14%  9.6us( 243us)   26us( 114us)(0.00%)     20408 99.9% 0.14%    0%  cache_alloc_refill+0xd0
 0.01% 0.18%  0.4us(  42us)   16ms(  55ms)(0.00%)     21913 99.8% 0.18%    0%  copy_mm+0x6f0
 0.02% 0.09%  1.2us( 340us)  6.6us(  30us)(0.00%)     11937  100% 0.09%    0%  deny_write_access+0x40
 0.11% 0.06%  0.9us(  14ms)  8.4us(  42us)(0.00%)     80024  100% 0.06%    0%  dnotify_parent+0x70
  2.5%  2.4%  2.5us( 789us)    0us                   608901 97.6%    0%  2.4%  double_lock_balance+0x20
 0.07% 66.0%  6.7us( 338us)  939us( 149ms)(0.01%)      6226 34.0% 66.0%    0%  double_lock_balance+0x90
 0.14% 52.9%  6.3us( 412us) 3804us( 158ms)(0.09%)     14339 47.1% 52.9%    0%  double_lock_balance+0xb0
 0.00% 0.41%  2.3us(  31us)  2.8us( 3.9us)(0.00%)       482 99.6% 0.41%    0%  double_rq_lock+0x60
 0.00% 0.73%  2.9us( 179us)  376us( 750us)(0.00%)       274 99.3% 0.73%    0%  double_rq_lock+0x90
 0.10% 0.00%  0.8us( 297us)  4.9us( 5.8us)(0.00%)     75211  100% 0.00%    0%  dput+0x80
 0.13%  1.4%  0.4us( 307us)  138us(  30ms)(0.00%)    194583 98.6%  1.4%    0%  load_balance+0x170
  422% 0.01%   66us( 158ms)   31us(5303us)(0.00%)   3989432  100% 0.01%    0%  load_balance+0x30
 0.05% 0.81%  4.7us(  22ms)   15us(  58us)(0.00%)      6686 99.2% 0.81%    0%  migration_thread+0x110
 0.11% 0.16%  1.0us( 557us) 6661us(  58ms)(0.00%)     72120 99.8% 0.16%    0%  remove_vm_struct+0x60
 0.56%  1.8%  2.3us(1112us)   12us(  67us)(0.00%)    151051 98.2%  1.8%    0%  schedule+0x290
  2.3% 0.01%  0.2us(7619us)   92us(9305us)(0.00%)   9418925  100% 0.01%    0%  scheduler_tick+0x370
 0.07% 0.21%  5.3us(4483us)   15us( 158us)(0.00%)      8470 99.8% 0.21%    0%  vma_adjust+0x140
 0.40% 0.11%  5.9us(  43ms) 1567us(  39ms)(0.00%)     42753 99.9% 0.11%    0%  vma_link+0x70

- - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK READS   HOLD    MAX  RDR BUSY PERIOD      WAIT
  UTIL  CON    MEAN   RDRS   MEAN(  MAX )   MEAN(  MAX )( %CPU)     TOTAL NOWAIT SPIN  NAME

       0.07%                                49us( 558us)(0.00%)    457364  100% 0.07%  *TOTAL*

  131%  3.6%   9.8us     2 9874us(45704ms)   49us( 558us)(0.00%)      8357 96.4%  3.6%  tasklist_lock
       0.94%                               113us( 282us)(0.00%)      3180 99.1% 0.94%    do_sigaction+0x270
        5.4%                                42us( 558us)(0.00%)      5107 94.6%  5.4%    do_wait+0x120
          0%                                 0us                       66  100%    0%    send_group_sig_info+0x30
          0%                                 0us                        4  100%    0%    session_of_pgrp+0x40

- - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK WRITES     HOLD           WAIT (ALL)           WAIT (WW)
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )( %CPU)   MEAN(  MAX )     TOTAL NOWAIT SPIN(  WW )  NAME

       0.41%  0.1us( 178us) 2097us(  47ms)(0.00%) 1313us(  47ms)     23738 99.6% 0.08%(0.33%)  *TOTAL*
_________________________________________________________________________________________________________________________
Number of read locks found=1

--Boundary-00=_odRJBOsy6cipmgs--
