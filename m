Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316832AbSFEARH>; Tue, 4 Jun 2002 20:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317514AbSFEARG>; Tue, 4 Jun 2002 20:17:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:27837 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316832AbSFEAQ7>; Tue, 4 Jun 2002 20:16:59 -0400
From: Ruth Forester <lilo@us.ibm.com>
Message-Id: <200206050016.g550Gl110934@eng4.beaverton.ibm.com>
Subject: Lockstats for SMP DB Workload
To: linux-kernel@vger.kernel.org
Date: Tue, 4 Jun 2002 17:16:46 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone, 

I am running with the following configuration

	2.4.19pre8aa2+dj2+ (dj2 removes global semaphore_lock spinlock)
	 +fast_walkA3-2_4_19-pre8_patch.

The database is set up to use raw-io, yet looking at this data, it appears that
I am still hitting a lot of filesystem accesses, among other things.  This is an
oltp workload, although there are some contentions (pread?) that cause the 
cpu sys time to go to 99%, it was during this part of the "workload" that this
snapshot of lockmeter was taken.

Any comments?  Recommendations for other patches?

Thanks,


Ruth Forester
lilo@us.ibm.com
IBM LTC - Performance Analysis
___________________________________________________________________________________________
System: Linux el19a115.ent.beaverton.ibm.com 2.4.19-remfstwlk #11 SMP Tue Jun 4 09:45:57 PDT 2002 i686
Total counts

All (8) CPUs

Start time: Tue Jun  4 11:23:58 2002
End   time: Tue Jun  4 11:24:08 2002
Delta Time: 10.02 sec.
Hash table slots in use:      390.
Global read lock slots in use: 973.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME

        6.7%  2.5us(  25ms)   62us(  12ms)( 6.8%)   2650959 93.3%  6.6% 0.05%  *TOTAL*

  5.9% 28.4%   15us( 481us)   40us( 902us)(0.29%)     40973 71.6% 28.4%    0%  [0xd9fffc04]
  3.7% 34.4%   18us( 481us)   41us( 902us)(0.18%)     20794 65.6% 34.4%    0%    semctl_main+0x70
 0.81% 20.3%  6.6us( 249us)   40us( 892us)(0.06%)     12212 79.7% 20.3%    0%    sys_semop+0x124
  1.4% 25.3%   18us( 378us)   36us( 896us)(0.05%)      7967 74.7% 25.3%    0%    sys_semop+0x488

 0.01%    0%  0.1us( 4.4us)    0us                    10657  100%    0%    0%  [0xda8ab8d4]
 0.00%    0%  0.1us( 2.3us)    0us                     3545  100%    0%    0%    ips_next+0x3c0
 0.00%    0%  0.1us( 2.6us)    0us                     1778  100%    0%    0%    ips_putq_wait_tail+0x1c
 0.00%    0%  0.1us( 3.7us)    0us                     1778  100%    0%    0%    ips_queue+0x9c
 0.00%    0%  0.1us( 2.0us)    0us                     1778  100%    0%    0%    ips_removeq_wait+0x20
 0.00%    0%  0.1us( 4.4us)    0us                     1778  100%    0%    0%    ips_removeq_wait+0x40

 0.02%    0%  0.6us(  85us)    0us                     3545  100%    0%    0%  [0xda8ab8e8]
 0.02%    0%  0.6us(  85us)    0us                     3545  100%    0%    0%    ips_next+0xe8

 0.01%    0%  0.2us( 6.1us)    0us                     4827  100%    0%    0%  [0xda8ab8fc]
 0.01%    0%  0.3us( 5.9us)    0us                     1778  100%    0%    0%    ips_chkstatus+0x68
 0.00%    0%  0.3us( 3.6us)    0us                     1271  100%    0%    0%    ips_chkstatus+0x88
 0.00%    0%  0.1us( 6.1us)    0us                     1778  100%    0%    0%    ips_putq_scb_head+0x1c

 0.01%    0%  0.4us(  83us)    0us                     3556  100%    0%    0%  [0xda8ab98c]
 0.00%    0%  0.1us( 1.4us)    0us                     1778  100%    0%    0%    ips_freescb+0x30
 0.01%    0%  0.7us(  83us)    0us                     1778  100%    0%    0%    ips_getscb+0x14

 0.35%    0%  2.0us(  98us)    0us                    17689  100%    0%    0%  [0xda8ab994]
 0.15%    0%  8.7us(  55us)    0us                     1767  100%    0%    0%    ips_intr_copperhead+0x2c
 0.03%    0%  1.8us(  17us)    0us                     1778  100%    0%    0%    ips_intr_copperhead+0xa4
 0.01%    0%  0.3us(  82us)    0us                     1778  100%    0%    0%    ips_issue_i2o_memio+0x18
 0.00%    0%  0.1us( 3.2us)    0us                     1720  100%    0%    0%    ips_next+0x6c
 0.03%    0%  1.0us(  87us)    0us                     3545  100%    0%    0%    ips_next+0xd4
 0.11%    0%  3.2us(  97us)    0us                     3545  100%    0%    0%    ips_next+0x3ac
 0.00%    0%  0.2us(  98us)    0us                     1778  100%    0%    0%    ips_next+0x8d0
 0.00%    0%  0.1us( 4.4us)    0us                     1778  100%    0%    0%    ips_queue+0x1b8

 0.01%    0%  7.2us(  24us)    0us                       74  100%    0%    0%  [0xda8eecd0]
 0.00%    0%  7.2us(  18us)    0us                       37  100%    0%    0%    ahc_linux_isr+0x28
 0.00%    0%  7.1us(  24us)    0us                       37  100%    0%    0%    ahc_linux_queue+0x34

 0.00%    0%  1.0us( 1.3us)    0us                        2  100%    0%    0%  [0xda9560d4]
 0.00%    0%  1.0us( 1.3us)    0us                        2  100%    0%    0%    dev_watchdog+0x14

 0.02%    0%  6.6us(  51us)    0us                      266  100%    0%    0%  [0xda956160]
 0.01%    0%  8.3us(  51us)    0us                      154  100%    0%    0%    tg3_interrupt+0x14
 0.00%    0%  4.2us(  12us)    0us                       12  100%    0%    0%    tg3_start_xmit_4gbug+0x30
 0.00%    0%  4.1us( 8.6us)    0us                      100  100%    0%    0%    tg3_timer+0xc

 0.00%    0%  0.3us( 1.9us)    0us                      208  100%    0%    0%  [0xda9a8d00]
 0.00%    0%  0.3us( 1.9us)    0us                      208  100%    0%    0%    shmem_getpage_locked+0x270

 0.00%    0%  0.6us( 2.4us)    0us                       29  100%    0%    0%  [0xdab02f80]
 0.00%    0%  1.0us( 2.4us)    0us                       14  100%    0%    0%    tcp_put_port+0x38
 0.00%    0%  0.3us( 0.9us)    0us                       15  100%    0%    0%    tcp_v4_syn_recv_sock+0x200

 0.01% 36.4%  0.7us(  17us)    0us                     1082 63.6%    0% 36.4%  [0xdb0848dc]
 0.01% 36.4%  0.7us(  17us)    0us                     1082 63.6%    0% 36.4%    net_tx_action+0xc4

 0.01%    0%  117us( 127us)    0us                        5  100%    0%    0%  [0xdb08496c]
 0.01%    0%  117us( 127us)    0us                        5  100%    0%    0%    [0xdb3d40f0]

 0.84%    0%  207us( 450us)    0us                      407  100%    0%    0%  [0xdb084970]
 0.84%    0%  207us( 450us)    0us                      407  100%    0%    0%    [0xdb3d4e1c]

 0.00%    0%  4.1us(  36us)    0us                       30  100%    0%    0%  [0xdb68b160]
 0.00%    0%  3.8us(  10us)    0us                       15  100%    0%    0%    mprotect_fixup+0x1e0
 0.00%    0%  4.4us(  36us)    0us                       15  100%    0%    0%    mprotect_fixup+0x3d8

 0.00%    0%  1.9us(  84us)    0us                      208  100%    0%    0%  [0xdb68b3a4]
 0.00%    0%  1.9us(  84us)    0us                      208  100%    0%    0%    shmem_getpage_locked+0xd4

  4.0% 69.4%  7.0us( 365us)  158us(3311us)( 3.9%)     56846 30.6% 69.4%    0%  [0xdb68b3b0]
  4.0% 69.4%  7.0us( 365us)  158us(3311us)( 3.9%)     56846 30.6% 69.4%    0%    __down+0x88

 0.00%    0%  0.2us( 0.9us)    0us                       30  100%    0%    0%  [0xdba4e8ac]
 0.00%    0%  0.1us( 0.6us)    0us                       15  100%    0%    0%    tcp_accept+0x2c
 0.00%    0%  0.3us( 0.9us)    0us                       15  100%    0%    0%    tcp_accept+0x140

 0.00%    0%  0.1us( 0.3us)    0us                       30  100%    0%    0%  [0xdc447c24]
 0.00%    0%  0.2us( 0.2us)    0us                        2  100%    0%    0%    n_tty_receive_buf+0x688
 0.00%    0%  0.1us( 0.1us)    0us                        3  100%    0%    0%    n_tty_receive_buf+0x824
 0.00%    0%  0.1us( 0.3us)    0us                       25  100%    0%    0%    read_chan+0x45c

 0.00%    0%  0.1us( 0.1us)    0us                        2  100%    0%    0%  [0xe10f449c]
 0.00%    0%  0.1us( 0.1us)    0us                        1  100%    0%    0%    write_ldt+0xb0
 0.00%    0%  0.1us( 0.1us)    0us                        1  100%    0%    0%    write_ldt+0x23c

 0.00%    0%  0.2us( 0.2us)    0us                        1  100%    0%    0%  [0xe3022774]
 0.00%    0%  0.2us( 0.2us)    0us                        1  100%    0%    0%    __down_interruptible+0x94

 0.00%    0%  0.1us( 0.1us)    0us                        1  100%    0%    0%  [0xe34986a0]
 0.00%    0%  0.1us( 0.1us)    0us                        1  100%    0%    0%    task_dumpable+0x18

 0.00%    0%  0.7us( 3.2us)    0us                       75  100%    0%    0%  [0xf8a1900c]
 0.00%    0%  0.3us( 1.3us)    0us                       45  100%    0%    0%    shm_open+0x58
 0.00%    0%  1.7us( 3.2us)    0us                       15  100%    0%    0%    sys_shmctl+0x2d8
 0.00%    0%  0.9us( 1.6us)    0us                       15  100%    0%    0%    sys_shmget+0xcc

 0.02%    0%  0.7us(  84us)    0us                     3630  100%    0%    0%  allocator_request_lock
 0.01%    0%  0.7us( 7.6us)    0us                     1815  100%    0%    0%    scsi_free+0x1c
 0.01%    0%  0.7us(  84us)    0us                     1815  100%    0%    0%    scsi_malloc+0x48

 0.00%    0%  0.3us( 2.8us)    0us                      201  100%    0%    0%  arbitration_lock
 0.00%    0%  0.4us( 2.5us)    0us                      102  100%    0%    0%    deny_write_access+0xc
 0.00%    0%  0.2us( 2.8us)    0us                       99  100%    0%    0%    get_write_access+0xc

 0.02%    0%  411us( 616us)    0us                        5  100%    0%    0%  call_lock
 0.02%    0%  411us( 616us)    0us                        5  100%    0%    0%    smp_call_function+0x4c

 0.33%  1.1%  0.6us( 131us)  5.0us( 191us)(0.00%)     59907 98.9%  1.1%    0%  dcache_lock
 0.00% 1.00%  0.1us( 1.2us)  1.9us( 1.9us)(0.00%)       100 99.0% 1.00%    0%    d_alloc+0x144
 0.00%    0%  0.1us( 1.6us)    0us                      100  100%    0%    0%    d_instantiate+0x24
 0.00%  8.3%  0.2us( 0.8us)  2.9us( 3.3us)(0.00%)        24 91.7%  8.3%    0%    d_lookup+0x14
 0.00%    0%  0.6us( 8.1us)    0us                      100  100%    0%    0%    d_rehash+0x48
 0.00%    0%  0.6us( 1.8us)    0us                       29  100%    0%    0%    do_lookup+0xfc
 0.01%  1.9%  0.3us( 7.5us)  2.2us(  12us)(0.00%)      1726 98.1%  1.9%    0%    dput+0x30
 0.04% 0.28%  5.6us( 102us)  2.1us( 2.4us)(0.00%)       714 99.7% 0.28%    0%    link_path_walk+0x318
 0.00% 0.45%  0.4us( 4.5us)  6.8us( 6.8us)(0.00%)       223 99.6% 0.45%    0%    link_path_walk+0x598
 0.00%    0%  0.3us( 0.3us)    0us                        1  100%    0%    0%    link_path_walk+0x7d8
 0.05% 0.37%  5.0us( 106us)  1.2us( 1.9us)(0.00%)      1088 99.6% 0.37%    0%    path_lookup+0xd0
 0.00%    0%  8.9us( 8.9us)    0us                        1  100%    0%    0%    path_lookup+0xf8
 0.00%    0%   12us( 101us)    0us                       31  100%    0%    0%    path_walk+0x20
 0.00%    0%  0.3us( 0.6us)    0us                       30  100%    0%    0%    sys_chdir+0x94
 0.00%    0%  1.9us( 6.2us)    0us                       15  100%    0%    0%    sys_getcwd+0xd8
 0.01%  1.2%  0.8us( 8.7us)   18us( 191us)(0.00%)      1155 98.8%  1.2%    0%    sys_pread+0xd0
 0.00% 0.64%  0.5us( 4.6us)  3.0us( 9.9us)(0.00%)       621 99.4% 0.64%    0%    sys_pwrite+0xd0
 0.12%  1.1%  0.4us(  93us)  4.3us( 112us)(0.00%)     29895 98.9%  1.1%    0%    sys_read+0xac
 0.06%  1.0%  0.3us(  85us)  5.9us(  85us)(0.00%)     23117 99.0%  1.0%    0%    sys_write+0xac
 0.04% 0.96%  4.2us( 131us)  4.0us(  18us)(0.00%)       937 99.0% 0.96%    0%    vfs_follow_link+0x124

 0.05% 0.03%  1.3us(  87us)  2.6us( 2.6us)(0.00%)      3630  100% 0.03%    0%  device_request_lock
 0.01% 0.06%  0.3us( 4.9us)  2.6us( 2.6us)(0.00%)      1815  100% 0.06%    0%    __scsi_release_command+0x14
 0.04%    0%  2.3us(  87us)    0us                     1815  100%    0%    0%    scsi_allocate_device+0x30

 0.00%    0%  4.7us(  14us)    0us                        6  100%    0%    0%  emergency_lock
 0.00%    0%  4.7us(  14us)    0us                        6  100%    0%    0%    bounce_end_io_read+0xc8

 0.01% 0.05%  0.7us(  85us)  2.9us( 2.9us)(0.00%)      1963  100% 0.05%    0%  files_lock
 0.00%    0%  0.3us( 0.7us)    0us                        8  100%    0%    0%    check_tty_count+0x10
 0.00%    0%  0.2us( 3.0us)    0us                      584  100%    0%    0%    file_move+0x18
 0.00% 0.16%  0.1us( 1.5us)  2.9us( 2.9us)(0.00%)       611 99.8% 0.16%    0%    fput+0x80
 0.01%    0%  1.5us(  85us)    0us                      685  100%    0%    0%    get_empty_filp+0xc
 0.00%    0%  1.2us( 4.3us)    0us                       74  100%    0%    0%    get_empty_filp+0xdc
 0.00%    0%  0.1us( 0.1us)    0us                        1  100%    0%    0%    put_filp+0x18

  1.1%  3.0%   30us(2085us)    0us                     3565 97.0%    0%  3.0%  global_bh_lock
  1.1%  3.0%   30us(2085us)    0us                     3565 97.0%    0%  3.0%    bh_action+0x18

 0.14%    0%   14us(  49us)    0us                     1001  100%    0%    0%  i8253_lock
 0.14%    0%   14us(  49us)    0us                     1001  100%    0%    0%    timer_interrupt+0x2c

 0.06%    0%  5.7us(  14us)    0us                     1001  100%    0%    0%  i8259A_lock
 0.06%    0%  5.7us(  14us)    0us                     1001  100%    0%    0%    timer_interrupt+0x90

 0.00%    0%  0.3us( 2.2us)    0us                       18  100%    0%    0%  init_mm+0x2c
 0.00%    0%  2.2us( 2.2us)    0us                        1  100%    0%    0%    __vmalloc+0x78
 0.00%    0%  0.2us( 0.9us)    0us                       16  100%    0%    0%    __vmalloc+0x198
 0.00%    0%  0.1us( 0.1us)    0us                        1  100%    0%    0%    pte_alloc+0x22c

 0.00%    0%  1.2us(  84us)    0us                      429  100%    0%    0%  inode_lock
 0.00%    0%  0.1us( 1.1us)    0us                      132  100%    0%    0%    __mark_inode_dirty+0x48
 0.00%    0%  0.6us( 2.0us)    0us                        9  100%    0%    0%    generic_osync_inode+0x50
 0.00%    0%  0.9us( 5.5us)    0us                       78  100%    0%    0%    get_empty_inode+0x24
 0.00%    0%  1.7us( 3.3us)    0us                        7  100%    0%    0%    get_new_inode+0x34
 0.00%    0%  1.6us( 2.1us)    0us                        7  100%    0%    0%    iget4+0x3c
 0.00%    0%  2.1us(  84us)    0us                       84  100%    0%    0%    iput+0x68
 0.00%    0%  6.8us( 7.0us)    0us                        2  100%    0%    0%    sync_unlocked_inodes+0x10
 0.00%    0%  1.7us( 9.2us)    0us                      110  100%    0%    0%    sync_unlocked_inodes+0x110

  1.1%  1.1%  6.7us( 214us)   17us( 169us)(0.00%)     16961 98.9%  1.1%    0%  io_request_lock
 0.25%  1.4%  5.7us( 184us)   18us( 104us)(0.00%)      4353 98.6%  1.4%    0%    __make_request+0xec
 0.00%    0%  4.5us(  11us)    0us                       37  100%    0%    0%    ahc_linux_isr+0x290
 0.33%  1.1%   19us(  74us)   24us( 169us)(0.00%)      1767 98.9%  1.1%    0%    do_ipsintr+0x14
 0.12% 0.73%  6.8us( 106us)  9.6us(  34us)(0.00%)      1777 99.3% 0.73%    0%    generic_unplug_device+0x10
 0.02% 0.45%  1.2us(  24us)  7.5us(  16us)(0.00%)      1767 99.5% 0.45%    0%    ips_next+0x28
 0.39% 0.94%   21us( 214us)   22us( 100us)(0.00%)      1815 99.1% 0.94%    0%    scsi_dispatch_cmd+0x11c
 0.01%  1.6%  0.6us( 5.3us)   11us(  46us)(0.00%)      1815 98.4%  1.6%    0%    scsi_finish_command+0x18
 0.02% 0.83%  1.0us( 6.1us)  9.9us(  35us)(0.00%)      1815 99.2% 0.83%    0%    scsi_queue_next_request+0x18
 0.01%  1.2%  0.3us( 7.0us)   21us( 128us)(0.00%)      1815 98.8%  1.2%    0%    scsi_request_fn+0x31c

  2.4%  1.0%   38us(  15ms) 3185us(  12ms)(0.13%)      6291 99.0%  1.0%    0%  kernel_flag_cacheline
 0.00%    0%  6.5us( 108us)    0us                       30  100%    0%    0%    blkdev_put+0x44
 0.01%  3.1%   12us( 182us) 5182us(9390us)(0.01%)       129 96.9%  3.1%    0%    chrdev_open+0x4c
 0.00%    0%  0.2us( 0.3us)    0us                        6  100%    0%    0%    de_put+0x28
  2.3%  9.1% 6865us(  15ms) 3551us(5592us)(0.01%)        33 90.9%  9.1%    0%    do_exit+0xf4
 0.00%    0%  0.7us( 2.4us)    0us                       30  100%    0%    0%    do_fcntl+0x19c
 0.00%  6.7%  0.2us( 1.7us)   94us( 181us)(0.00%)        30 93.3%  6.7%    0%    locks_remove_flock+0x34
 0.00% 10.0%  1.0us( 2.7us) 8981us(  11ms)(0.02%)        30 90.0% 10.0%    0%    locks_remove_posix+0x3c
 0.00%    0%  1.7us( 1.7us)    0us                        1  100%    0%    0%    permission+0x38
 0.00% 10.0%  0.8us( 6.5us)  191us( 541us)(0.00%)        30 90.0% 10.0%    0%    posix_lock_file+0x78
 0.01%    0%   26us(  71us)    0us                       24  100%    0%    0%    real_lookup+0x64
 0.00% 50.0%   34us(  57us)  2.9us( 2.9us)(0.00%)         2 50.0% 50.0%    0%    schedule+0x538
 0.01%    0%  407us( 461us)    0us                        2  100%    0%    0%    sync_old_buffers+0x20
 0.01%  7.4%   53us( 757us) 1780us(3546us)(0.00%)        27 92.6%  7.4%    0%    sys_ioctl+0x4c
 0.00% 20.0%  0.4us( 0.9us)   11us(  11us)(0.00%)         5 80.0% 20.0%    0%    sys_llseek+0x88
 0.05% 0.65%  0.9us(  84us) 3408us(  12ms)(0.08%)      5853 99.4% 0.65%    0%    sys_lseek+0x70
 0.00%    0%  9.8us(  17us)    0us                       16  100%    0%    0%    sys_sysctl+0x70
 0.00% 28.6%   11us(  23us) 1750us(6449us)(0.00%)        14 71.4% 28.6%    0%    tty_read+0xb4
 0.00%    0%  4.3us(  12us)    0us                        4  100%    0%    0%    tty_release+0x1c
 0.00% 16.7%   13us(  27us) 1956us(6520us)(0.00%)        24 83.3% 16.7%    0%    tty_write+0x20c
 0.00%    0%   14us(  14us)    0us                        1  100%    0%    0%    vfs_readdir+0x70

 0.26% 0.63%  0.8us(2518us)   41us(1692us)(0.01%)     31766 99.4% 0.63%    0%  kmap_lock_cacheline
 0.23% 0.55%  1.4us(2518us)   90us(1692us)(0.00%)     15883 99.4% 0.55%    0%    kmap_high+0x14
 0.03% 0.71%  0.2us(  83us)  3.5us(  86us)(0.00%)     15883 99.3% 0.71%    0%    kunmap_high+0x4c

 0.00%    0%  0.5us(  35us)    0us                      291  100%    0%    0%  lru_list_lock_cacheline
 0.00%    0%  0.5us( 1.2us)    0us                       18  100%    0%    0%    buffer_insert_inode_data_queue+0x10
 0.00%    0%  0.3us( 1.2us)    0us                       18  100%    0%    0%    fsync_buffers_list+0x28
 0.00%    0%  0.2us( 0.5us)    0us                       18  100%    0%    0%    fsync_buffers_list+0x98
 0.00%    0%  0.5us( 2.9us)    0us                       18  100%    0%    0%    fsync_buffers_list+0xf4
 0.00%    0%  0.1us( 0.6us)    0us                       84  100%    0%    0%    inode_has_buffers+0x10
 0.00%    0%  0.2us( 1.4us)    0us                       75  100%    0%    0%    invalidate_inode_buffers+0x10
 0.00%    0%  0.5us( 2.0us)    0us                       18  100%    0%    0%    osync_buffers_list+0x14
 0.00%    0%  1.0us( 5.3us)    0us                       39  100%    0%    0%    refile_buffer+0xc
 0.00%    0%   12us(  35us)    0us                        3  100%    0%    0%    sync_old_buffers+0x74

 0.00%    0%  0.8us( 3.8us)    0us                       66  100%    0%    0%  mmlist_lock
 0.00%    0%  0.6us( 2.4us)    0us                       33  100%    0%    0%    copy_mm+0x140
 0.00%    0%  1.0us( 3.8us)    0us                       33  100%    0%    0%    mmput+0x28

  3.3%  1.5%  1.3us(1343us)  4.8us(1290us)(0.01%)    257486 98.5%  1.5%    0%  pagecache_lock_cacheline
 0.06%  4.0%  0.9us(  90us)  5.0us( 106us)(0.00%)      6478 96.0%  4.0%    0%    __do_generic_file_read+0x194
 0.47%  5.6%  1.4us( 185us)  5.1us(1290us)(0.01%)     33301 94.4%  5.6%    0%    __find_get_page+0x18
  2.7% 0.84%  1.3us(1343us)  4.6us( 174us)(0.01%)    217164 99.2% 0.84%    0%    __find_lock_page+0xc
 0.00%    0%  1.6us(  13us)    0us                      208  100%    0%    0%    add_to_page_cache+0x18
 0.00%  2.7%  0.1us( 2.1us)  4.3us( 5.7us)(0.00%)       110 97.3%  2.7%    0%    filemap_fdatasync+0x20
 0.00%    0%  0.1us( 0.6us)    0us                      110  100%    0%    0%    filemap_fdatawait+0x14
 0.00%  7.0%  0.2us( 1.6us)  2.5us( 6.5us)(0.00%)       115 93.0%  7.0%    0%    set_page_dirty+0x24

 0.10% 0.63%  0.5us(  95us)  6.5us(  91us)(0.00%)     19228 99.4% 0.63%    0%  pagemap_lru_lock_cacheline
 0.07% 0.54%  0.6us(  95us)  6.7us(  84us)(0.00%)     13017 99.5% 0.54%    0%    lru_cache_add+0x1c
 0.03% 0.82%  0.5us(  86us)  6.3us(  91us)(0.00%)      6211 99.2% 0.82%    0%    lru_cache_del+0xc

 13.0% 33.3%  5.1us( 258us)   20us( 758us)( 1.1%)    255478 66.7% 33.3%    0%  runqueue_lock
  1.8% 35.2%  3.2us( 171us)   15us( 571us)(0.18%)     56493 64.8% 35.2%    0%    __wake_up+0x54
 0.88% 33.5%  2.6us( 180us)   17us( 402us)(0.12%)     33525 66.5% 33.5%    0%    __wake_up_locked+0x40
 0.00% 13.8%  0.1us( 0.5us)   16us(  44us)(0.00%)        29 86.2% 13.8%    0%    deliver_signal+0x48
 0.02% 35.5%  4.2us(  22us)   25us( 341us)(0.00%)       459 64.5% 35.5%    0%    process_timeout+0x14
  9.4% 31.9%  6.4us( 258us)   24us( 758us)(0.69%)    147110 68.1% 31.9%    0%    schedule+0xa8
 0.26% 47.8%  2.8us(  99us)  8.9us( 265us)(0.02%)      9171 52.2% 47.8%    0%    schedule+0x4f8
 0.61% 29.4%  7.0us( 167us)   23us( 449us)(0.04%)      8691 70.6% 29.4%    0%    wake_up_process+0x14

 0.00%    0%  2.1us( 5.4us)    0us                        8  100%    0%    0%  sb_lock
 0.00%    0%  0.7us( 0.8us)    0us                        2  100%    0%    0%    sync_supers+0x78
 0.00%    0%  5.2us( 5.4us)    0us                        2  100%    0%    0%    sync_unlocked_inodes+0x18
 0.00%    0%  1.3us( 1.6us)    0us                        4  100%    0%    0%    sync_unlocked_inodes+0x194

 0.01%    0%  0.2us( 3.8us)    0us                     5412  100%    0%    0%  scsi_bhqueue_lock
 0.00%    0%  0.1us( 2.6us)    0us                     3597  100%    0%    0%    scsi_bottom_half_handler+0x1c
 0.01%    0%  0.4us( 3.8us)    0us                     1815  100%    0%    0%    scsi_done+0x3c

  1.2%  2.4%  1.4us( 177us)  4.6us( 146us)(0.01%)     84981 97.6%  2.4%    0%  timerlist_lock
 0.04%  1.6%  1.2us( 166us)  9.8us( 130us)(0.00%)      3226 98.4%  1.6%    0%    add_timer+0x10
 0.00%  1.7%  0.1us( 4.9us)  3.1us( 8.2us)(0.00%)      1872 98.3%  1.7%    0%    del_timer+0x14
 0.01%  3.6%  0.4us(  96us)  4.8us(  90us)(0.00%)      2030 96.4%  3.6%    0%    del_timer_sync+0x1c
  1.1%  2.5%  1.5us( 177us)  4.5us( 146us)(0.01%)     71051 97.5%  2.5%    0%    mod_timer+0x18
 0.02% 0.80%  2.1us(  10us)  2.8us( 6.8us)(0.00%)      1001 99.2% 0.80%    0%    timer_bh+0xcc
 0.04%  1.3%  0.7us(  28us)  3.5us(  36us)(0.00%)      5801 98.7%  1.3%    0%    timer_bh+0x298

 0.01%    0%   15us(  96us)    0us                       62  100%    0%    0%  tlbstate_lock
 0.01%    0%   15us(  96us)    0us                       62  100%    0%    0%    flush_tlb_others+0x64

 0.01% 0.08%  0.2us( 8.9us)  1.7us( 5.6us)(0.00%)      4866  100% 0.08%    0%  tqueue_lock
 0.01% 0.08%  0.2us( 8.9us)  0.3us( 0.5us)(0.00%)      2430  100% 0.08%    0%    __run_task_queue+0x14
 0.00% 0.15%  0.4us( 4.7us)  0.6us( 0.6us)(0.00%)       659 99.8% 0.15%    0%    batch_entropy_store+0x7c
 0.00% 0.06%  0.1us( 3.5us)  5.6us( 5.6us)(0.00%)      1777  100% 0.06%    0%    generic_plug_device+0x34

 0.00%    0%  0.2us( 1.9us)    0us                      124  100%    0%    0%  uts_sem
 0.00%    0%  0.2us( 1.0us)    0us                       62  100%    0%    0%    sys_newuname+0x14
 0.00%    0%  0.2us( 1.9us)    0us                       62  100%    0%    0%    sys_newuname+0x84

  5.0% 46.6%   14us( 710us)   76us(1602us)(0.78%)     35173 53.4% 46.6%    0%  __down+0x40
 0.00%    0%  2.4us( 3.3us)    0us                        3  100%    0%    0%  __down_interruptible+0x48
 0.03% 0.75%  0.3us(  93us)  4.0us(  32us)(0.00%)     10728 99.3% 0.75%    0%  __free_pages_ok+0x144
 0.00%    0%  0.2us( 1.3us)    0us                       95  100%    0%    0%  __release_sock+0x5c
  7.1% 20.8%   13us( 585us)   74us(2808us)(0.54%)     56142 79.2% 20.8%    0%  __wake_up+0x24
 0.03%    0%  0.1us(  84us)    0us                    26904  100%    0%    0%  add_wait_queue+0x10
 0.01%    0%  7.1us( 109us)    0us                      189  100%    0%    0%  change_protection+0x3c
 0.05%    0%   85us( 327us)    0us                       64  100%    0%    0%  clear_page_tables+0x28
 0.00%    0%  0.1us( 1.3us)    0us                      592  100%    0%    0%  copy_mm+0x218
 0.07%    0%  9.9us( 236us)    0us                      754  100%    0%    0%  copy_mm+0x24c
 0.00%    0%  0.1us( 0.5us)    0us                       33  100%    0%    0%  copy_mm+0x2cc
 0.00%    0%  0.1us( 0.6us)    0us                       33  100%    0%    0%  copy_mm+0xdc
 0.13%    0%   15us( 360us)    0us                      874  100%    0%    0%  copy_page_range+0x1ec
 0.45%  1.3%  1.8us( 171us)  5.3us( 100us)(0.00%)     25045 98.7%  1.3%    0%  dev_queue_xmit+0x12c
 0.09%    0%  0.2us(  14us)    0us                    41161  100%    0%    0%  do_IRQ+0x40
 0.14%    0%  0.3us(  15us)    0us                    41161  100%    0%    0%  do_IRQ+0xc0
 0.15%    0%  1.6us( 167us)    0us                     9087  100%    0%    0%  do_anonymous_page+0x1c0
 0.00%    0%  0.4us( 0.9us)    0us                       18  100%    0%    0%  do_brk+0x1cc
 0.00%    0%  0.2us( 1.6us)    0us                       33  100%    0%    0%  do_exit+0x114
 0.00%    0%  0.1us( 0.8us)    0us                       33  100%    0%    0%  do_exit+0x14c
 0.00%    0%  0.1us( 0.1us)    0us                       33  100%    0%    0%  do_exit+0x1fc
 0.00%    0%  0.1us( 0.4us)    0us                       33  100%    0%    0%  do_exit+0xa8
 0.00%    0%  1.1us( 4.4us)    0us                      382  100%    0%    0%  do_mmap_pgoff+0x49c
 0.00%    0%  0.5us(  12us)    0us                      511  100%    0%    0%  do_mmap_pgoff+0x4a8
 0.00%    0%  0.2us( 3.2us)    0us                      248  100%    0%    0%  do_munmap+0x1b8
 0.00%    0%  0.7us( 6.6us)    0us                      493  100%    0%    0%  do_munmap+0xe0
 0.45%    0%  0.2us( 165us)    0us                   250224  100%    0%    0%  do_no_page+0x288
 0.00%    0%  0.2us( 4.0us)    0us                      191  100%    0%    0%  do_page_fault+0x134
 0.24%    0%  0.1us(  94us)    0us                   263259  100%    0%    0%  do_page_fault+0x248
 0.23%    0%  0.1us( 155us)    0us                   263271  100%    0%    0%  do_page_fault+0x7c
 0.00%    0%  0.6us(  87us)    0us                      816  100%    0%    0%  do_sigaction+0x58
 0.00%    0%  0.3us( 2.1us)    0us                      157  100%    0%    0%  do_sigaction+0xd8
 0.00%    0%  4.7us(  14us)    0us                       32  100%    0%    0%  do_signal+0x54
 0.08%    0%  2.7us( 180us)    0us                     2957  100%    0%    0%  do_wp_page+0x35c
 0.00%    0%  0.1us( 0.3us)    0us                       50  100%    0%    0%  exit_mmap+0x18
 0.00%    0%  0.2us(  45us)    0us                      912  100%    0%    0%  exit_mmap+0x88
 0.00%    0%  2.7us( 6.3us)    0us                       33  100%    0%    0%  exit_sighand+0x18
  3.5%  7.8%   26us( 322us)   41us( 719us)(0.03%)     13811 92.2%  7.8%    0%  free_block+0x1c
 0.05%    0%  3.1us( 111us)    0us                     1769  100%    0%    0%  get_user_pages+0x7c
 0.03%    0%  1.4us( 102us)    0us                     2251  100%    0%    0%  get_user_pages+0xf4
  2.2%    0%  0.8us( 245us)    0us                   265524  100%    0%    0%  handle_mm_fault+0x30
 0.00%    0%  0.1us( 0.2us)    0us                       32  100%    0%    0%  handle_signal+0xb0
 0.00%    0%  0.1us( 0.2us)    0us                       15  100%    0%    0%  inet_accept+0x130
 0.00%    0%  0.2us( 1.1us)    0us                       15  100%    0%    0%  inet_accept+0x50
 0.00%    0%  0.8us( 2.6us)    0us                       17  100%    0%    0%  insert_vm_struct+0x64
  1.9%  7.3%   14us( 382us)   40us( 685us)(0.03%)     13843 92.7%  7.3%    0%  kmem_cache_alloc_batch+0x18
 0.00%    0%  0.1us( 0.3us)    0us                        5  100%    0%    0%  kmem_cache_grow+0x1e4
 0.00%    0%  0.9us( 4.1us)    0us                        5  100%    0%    0%  kmem_cache_grow+0x8c
 0.00%    0%  0.1us( 0.6us)    0us                       34  100%    0%    0%  load_elf_binary+0x62c
 0.00%    0%  0.1us( 1.3us)    0us                       34  100%    0%    0%  load_elf_binary+0x6b0
 0.00%    0%  0.2us( 1.9us)    0us                       34  100%    0%    0%  load_elf_interp+0x18c
 0.00%    0%  0.1us( 0.2us)    0us                       34  100%    0%    0%  load_elf_interp+0x214
 0.00%    0%  0.1us( 3.3us)    0us                     1769  100%    0%    0%  map_user_kiobuf+0x88
 0.00%    0%  0.2us( 6.0us)    0us                     1767  100%    0%    0%  map_user_kiobuf+0xe0
 0.00%    0%  2.1us( 6.7us)    0us                       15  100%    0%    0%  mprotect_fixup+0x1ec
 0.00%    0%  1.0us( 9.9us)    0us                      127  100%    0%    0%  mprotect_fixup+0x2a8
 0.00%    0%  0.6us( 6.0us)    0us                      127  100%    0%    0%  mprotect_fixup+0x2b4
 0.00%    0%  3.0us(  31us)    0us                       15  100%    0%    0%  mprotect_fixup+0x3e4
 0.00%    0%  0.1us( 0.2us)    0us                       32  100%    0%    0%  mprotect_fixup+0xdc
 0.00%    0%  0.4us( 3.9us)    0us                       64  100%    0%    0%  n_tty_chars_in_buffer+0x18
 0.00%    0%  0.4us( 4.0us)    0us                       58  100%    0%    0%  n_tty_receive_buf+0x44
 0.00%    0%  0.3us(  82us)    0us                      473  100%    0%    0%  old_mmap+0x120
 0.00%    0%  0.1us( 2.0us)    0us                      473  100%    0%    0%  old_mmap+0xd4
 0.16%    0%  1.9us( 362us)    0us                     8560  100%    0%    0%  pte_alloc_atomic+0x12c
 0.00%    0%  3.0us( 8.6us)    0us                       17  100%    0%    0%  put_dirty_page+0x3c
 0.81%  2.8%  3.1us( 185us)    0us                    25759 97.2%    0%  2.8%  qdisc_restart+0x2c
 0.11%  2.5%  0.5us( 173us)  4.1us(  89us)(0.00%)     25045 97.5%  2.5%    0%  qdisc_restart+0x90
 0.00%    0%  0.1us( 0.1us)    0us                       12  100%    0%    0%  read_chan+0x504
 0.00%    0%  0.1us( 0.1us)    0us                       12  100%    0%    0%  read_chan+0x568
 0.00%    0%  0.1us( 0.1us)    0us                       12  100%    0%    0%  read_chan+0x5a4
 0.00% 14.6%  0.2us( 1.2us)  2.2us( 5.7us)(0.00%)        48 85.4% 14.6%    0%  release_task+0x4c
 0.03%    0%  0.1us(  83us)    0us                    26977  100%    0%    0%  remove_wait_queue+0x10
 0.00%    0%  0.8us( 3.8us)    0us                       80  100%    0%    0%  rh_int_timer_do+0x48
 0.00%    0%  0.2us( 0.9us)    0us                       80  100%    0%    0%  rh_int_timer_do+0x6c
 0.00%    0%  3.6us( 6.5us)    0us                       80  100%    0%    0%  rh_send_irq+0x40
 0.35% 0.81%  1.6us(  98us)  6.7us(  88us)(0.00%)     21901 99.2% 0.81%    0%  rmqueue+0x28
  1.2% 0.01%  1.0us( 281us)   59us( 245us)(0.00%)    120899  100% 0.01%    0%  schedule+0x4a0
 0.00%    0%  0.4us( 2.8us)    0us                       33  100%    0%    0%  schedule_tail+0x20
 0.01%    0%   12us(  64us)    0us                       47  100%    0%    0%  send_sig_info+0x4c
 0.00%    0%  0.2us( 0.5us)    0us                       17  100%    0%    0%  setup_arg_pages+0x13c
 0.00%    0%  0.2us( 0.5us)    0us                       17  100%    0%    0%  setup_arg_pages+0x6c
 0.00%    0%  0.6us( 5.5us)    0us                       85  100%    0%    0%  shm_close+0x70
 0.00%    0%  0.1us( 0.2us)    0us                       45  100%    0%    0%  shm_mmap+0x74
 0.00%    0%  0.2us( 0.8us)    0us                       45  100%    0%    0%  sock_fasync+0x2ac
 0.00%    0%  0.1us( 0.6us)    0us                       45  100%    0%    0%  sock_fasync+0x80
 0.00%    0%  0.3us( 1.2us)    0us                       29  100%    0%    0%  sock_setsockopt+0x4e8
 0.00%    0%  0.3us( 1.6us)    0us                       29  100%    0%    0%  sock_setsockopt+0x8c
 0.00%    0%  0.1us(  82us)    0us                     2393  100%    0%    0%  sys_brk+0x24
 0.00%    0%  0.1us( 3.0us)    0us                     2393  100%    0%    0%  sys_brk+0xfc
 0.00%    0%  0.1us( 0.2us)    0us                       24  100%    0%    0%  sys_mmap2+0x44
 0.00%    0%  0.1us( 0.1us)    0us                       24  100%    0%    0%  sys_mmap2+0x94
 0.00%    0%  0.1us( 1.4us)    0us                      189  100%    0%    0%  sys_mprotect+0x228
 0.00%    0%  0.1us( 0.8us)    0us                      189  100%    0%    0%  sys_mprotect+0x70
 0.00%    0%  0.1us( 1.2us)    0us                      161  100%    0%    0%  sys_munmap+0x18
 0.00%    0%  0.1us( 0.9us)    0us                      161  100%    0%    0%  sys_munmap+0x54
 0.00%    0%  0.1us( 1.5us)    0us                      732  100%    0%    0%  sys_rt_sigprocmask+0x18c
 0.01%    0%  0.2us(  85us)    0us                     3194  100%    0%    0%  sys_rt_sigprocmask+0x98
 0.00%    0%  0.2us( 0.4us)    0us                        6  100%    0%    0%  sys_rt_sigreturn+0x70
 0.00%    0%  0.1us( 0.9us)    0us                       45  100%    0%    0%  sys_shmat+0x1fc
 0.00%    0%  0.2us( 2.2us)    0us                       45  100%    0%    0%  sys_shmat+0x2a0
 0.00%    0%  0.1us( 1.1us)    0us                       45  100%    0%    0%  sys_shmat+0x318
 0.00%    0%  2.8us(  82us)    0us                       45  100%    0%    0%  sys_shmat+0xcc
 0.00%    0%  0.2us( 1.1us)    0us                       43  100%    0%    0%  sys_shmdt+0x1c
 0.00%    0%  0.1us( 0.2us)    0us                       43  100%    0%    0%  sys_shmdt+0x90
 0.00%    0%  0.1us( 0.2us)    0us                       19  100%    0%    0%  sys_sigreturn+0x84
 0.00%    0%  0.2us( 0.8us)    0us                       14  100%    0%    0%  tcp_close+0x28
 0.00%    0%  0.5us( 1.1us)    0us                       14  100%    0%    0%  tcp_close+0x3ec
 0.00%    0%  4.7us( 9.0us)    0us                       14  100%    0%    0%  tcp_close+0x460
 0.01%    0%   57us( 119us)    0us                       15  100%    0%    0%  tcp_create_openreq_child+0x74
 0.03%  2.0%  0.1us(  83us)  8.1us( 119us)(0.00%)     24832 98.0%  2.0%    0%  tcp_data_wait+0x118
 0.04%    0%  0.2us(  88us)    0us                    24760  100%    0%    0%  tcp_data_wait+0x88
 0.12%    0%  3.2us(  78us)    0us                     3829  100%    0%    0%  tcp_delack_timer+0x18
 0.03% 0.08%  0.1us( 8.6us)   17us(  71us)(0.00%)     23445  100% 0.08%    0%  tcp_recvmsg+0x40
 0.00%    0%  0.2us( 0.6us)    0us                       46  100%    0%    0%  tcp_recvmsg+0x428
 0.00%    0%  0.3us( 3.7us)    0us                       46  100%    0%    0%  tcp_recvmsg+0x4b0
 0.04% 0.00%  0.2us(  84us)  2.9us( 2.9us)(0.00%)     23517  100% 0.00%    0%  tcp_recvmsg+0x7d4
 0.05%    0%  0.2us(  82us)    0us                    23002  100%    0%    0%  tcp_sendmsg+0x1088
 0.04% 0.00%  0.2us(  82us)   31us(  31us)(0.00%)     23002  100% 0.00%    0%  tcp_sendmsg+0x34
 0.00%    0%  0.3us( 2.2us)    0us                       30  100%    0%    0%  tcp_setsockopt+0x710
 0.00%    0%  0.2us( 1.2us)    0us                       30  100%    0%    0%  tcp_setsockopt+0x90
  3.8% 0.03%   15us( 602us)   18us(  64us)(0.00%)     26072  100% 0.03%    0%  tcp_v4_rcv+0x2dc
 0.02%    0%  1.2us( 6.6us)    0us                     1311  100%    0%    0%  tcp_write_timer+0x18
 0.00%    0%  0.1us( 0.7us)    0us                       62  100%    0%    0%  unix_release_sock+0x1bc
 0.00%    0%  0.2us( 2.9us)    0us                       62  100%    0%    0%  unix_sock_destructor+0x28
 0.00%    0%  4.8us( 5.2us)    0us                        2  100%    0%    0%  unmap_fixup+0x134
 0.00%    0%  1.4us(  83us)    0us                      179  100%    0%    0%  unmap_fixup+0x8c
 0.00%    0%  0.9us( 1.9us)    0us                       33  100%    0%    0%  unmap_fixup+0xa8
 0.00%    0%  0.5us( 1.3us)    0us                       34  100%    0%    0%  unmap_fixup+0xb8
 0.00%    0%  0.1us(  70us)    0us                     2332  100%    0%    0%  vma_merge+0x54
  3.1%    0%  188us(  25ms)    0us                     1665  100%    0%    0%  zap_page_range+0x4c

- - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK READS   HOLD    MAX  RDR BUSY PERIOD      WAIT
  UTIL  CON    MEAN   RDRS   MEAN(  MAX )   MEAN(  MAX )( %CPU)     TOTAL NOWAIT SPIN  NAME

       0.15%                                14us( 112us)(0.01%)    606953 99.8% 0.15%  *TOTAL*

 0.00%    0%   1.8us     1  1.8us( 1.8us)    0us                        1  100%    0%  [0xdaa5ce88]
          0%                                 0us                        1  100%    0%    inet_select_addr+0x3c

 0.00%    0%   0.9us     1  0.9us( 3.6us)    0us                       30  100%    0%  [0xdac7fd54]
          0%                                 0us                       30  100%    0%    ip_route_output_key+0x7c

 0.00%    0%   9.1us     1  9.1us(  30us)    0us                        2  100%    0%  [0xe305b184]
          0%                                 0us                        2  100%    0%    copy_files+0x158

 0.00%    0%   0.4us     1  0.4us( 0.6us)    0us                        3  100%    0%  arp_tbl+0xc4
          0%                                 0us                        3  100%    0%    neigh_lookup+0x40

 0.00%    0%   0.6us     1  0.6us( 2.0us)    0us                       17  100%    0%  binfmt_lock
          0%                                 0us                       17  100%    0%    search_binary_handler+0x38

 0.00%    0%   1.1us     1  1.1us( 4.2us)    0us                      129  100%    0%  chrdevs_lock
          0%                                 0us                      129  100%    0%    get_chrfops+0x28

 0.00%    0%   0.4us     1  0.4us( 7.1us)    0us                       60  100%    0%  fasync_lock
          0%                                 0us                       60  100%    0%    kill_fasync+0x18

 0.00%    0%   4.5us     1  4.5us(  24us)    0us                       21  100%    0%  fib_hash_lock
          0%                                 0us                       21  100%    0%    fn_hash_lookup+0x10

 0.20%    0%   0.4us     2  3.3us(  18ms)    0us                     6168  100%    0%  gendisk_lock
          0%                                 0us                     6168  100%    0%    get_gendisk+0x10

 0.00%    0%   0.7us     1  0.7us( 5.9us)    0us                      110  100%    0%  hash_table_lock
          0%                                 0us                      110  100%    0%    get_hash_table+0x60

 0.00%    0%   1.6us     1  1.6us(  13us)    0us                       15  100%    0%  inetdev_lock
          0%                                 0us                        3  100%    0%    arp_process+0x18
          0%                                 0us                        1  100%    0%    fib_validate_source+0x48
          0%                                 0us                        1  100%    0%    inet_select_addr+0x18
          0%                                 0us                       10  100%    0%    ip_route_input_slow+0x18

  187%    0%  27.5us??  11  673us(  20ms)    0us                    40974  100%    0%  sem_ids+0x24
          0%                                 0us                    20795  100%    0%    semctl_main+0x5c
          0%                                 0us                    12212  100%    0%    sys_semop+0x110
          0%                                 0us                     7967  100%    0%    sys_semop+0x474

 0.01%    0%   3.1us     1  3.1us( 386us)    0us                      295  100%    0%  shm_ids+0x24
          0%                                 0us                       85  100%    0%    shm_close+0x5c
          0%                                 0us                       45  100%    0%    shm_mmap+0x64
          0%                                 0us                       45  100%    0%    shm_open+0x48
          0%                                 0us                       45  100%    0%    sys_shmat+0xb8
          0%                                 0us                       45  100%    0%    sys_shmat+0x304
          0%                                 0us                       15  100%    0%    sys_shmctl+0x2c8
          0%                                 0us                       15  100%    0%    sys_shmget+0xb8

  3.5%    0%1916.9us     2 2134us(  25ms)    0us                      215  100%    0%  tasklist_lock
          0%                                 0us                        2  100%    0%    count_active_tasks+0xc
          0%                                 0us                       33  100%    0%    exit_notify+0x18
          0%                                 0us                        1  100%    0%    exit_notify+0xf4
          0%                                 0us                       15  100%    0%    exit_notify+0x288
          0%                                 0us                       17  100%    0%    kill_something_info+0xdc
          0%                                 0us                        1  100%    0%    proc_pid_lookup+0x11c
          0%                                 0us                        2  100%    0%    session_of_pgrp+0x14
          0%                                 0us                       15  100%    0%    sys_setpgid+0x3c
          0%                                 0us                       45  100%    0%    sys_setsid+0x10
          0%                                 0us                       68  100%    0%    sys_wait4+0x8c
          0%                                 0us                       16  100%    0%    will_become_orphaned_pgrp+0x14

 0.00%    0%   0.8us     1  0.8us( 3.7us)    0us                       30  100%    0%  tcp_hashinfo+0x100
          0%                                 0us                       30  100%    0%    tcp_v4_rcv+0x24c

 0.00%    0%   2.3us     1  2.3us( 6.5us)    0us                       33  100%    0%  udp_hash_lock
          0%                                 0us                       33  100%    0%    udp_v4_mcast_deliver+0x10

  485% 0.24%   0.5us     7  131us(  18ms)   14us( 112us)(0.01%)    395940 99.8% 0.24%  xtime_lock
       0.24%                                14us( 112us)(0.01%)    395940 99.8% 0.24%    do_gettimeofday+0x14

          0%                                 0us                       33  100%    0%  copy_files+0x100
          0%                                 0us                       32  100%    0%  do_fcntl+0x10c
          0%                                 0us                       33  100%    0%  do_fork+0x38c
          0%                                 0us                      503  100%    0%  do_select+0x24
          0%                                 0us                    62301  100%    0%  fget+0x1c
          0%                                 0us                    25045  100%    0%  ip_output+0x64
          0%                                 0us                    26114  100%    0%  ip_route_input+0x88
          0%                                 0us                    19804  100%    0%  net_rx_action+0x44
          0%                                 0us                       31  100%    0%  path_init+0x40
          0%                                 0us                     1088  100%    0%  path_lookup+0x30
          0%                                 0us                      941  100%    0%  sock_def_readable+0x14
          0%                                 0us                       29  100%    0%  sock_def_wakeup+0x10
          0%                                 0us                       15  100%    0%  sys_getcwd+0x38
          0%                                 0us                       15  100%    0%  tcp_v4_hnd_req+0xa8
          0%                                 0us                    26072  100%    0%  tcp_v4_rcv+0x1b0
          0%                                 0us                       31  100%    0%  unix_write_space+0x14
          0%                                 0us                      823  100%    0%  vfs_follow_link+0x40

- - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK WRITES     HOLD           WAIT (ALL)           WAIT (WW) 
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )( %CPU)   MEAN(  MAX )     TOTAL NOWAIT SPIN(  WW )  NAME

        3.9%  5.7us( 472us)   76us(3418us)(0.01%)  2.8us( 9.2us)      5342 96.1%  3.5%(0.43%)  *TOTAL*

 0.00%    0%  3.0us( 3.0us)    0us                   0us                 1  100%    0%(   0%)  [0xdad66bf4]
 0.00%    0%  3.0us( 3.0us)    0us                   0us                 1  100%    0%(   0%)    rt_intern_hash+0x64

 0.00%    0%  0.3us( 1.2us)    0us                   0us                30  100%    0%(   0%)  [0xdba4eae4]
 0.00%    0%  0.1us( 0.3us)    0us                   0us                15  100%    0%(   0%)    tcp_check_req+0x274
 0.00%    0%  0.4us( 1.2us)    0us                   0us                15  100%    0%(   0%)    tcp_v4_synq_add+0x68

 0.00%    0%  0.5us( 0.8us)    0us                   0us                 2  100%    0%(   0%)  dn_lock
 0.00%    0%  0.5us( 0.8us)    0us                   0us                 2  100%    0%(   0%)    fcntl_dirnotify+0x94

 0.00%    0%  1.9us( 9.4us)    0us                   0us                48  100%    0%(   0%)  fasync_lock
 0.00%    0%  3.0us( 9.4us)    0us                   0us                29  100%    0%(   0%)    do_fcntl+0x218
 0.00%    0%  0.1us( 0.3us)    0us                   0us                19  100%    0%(   0%)    fasync_helper+0x68

 0.01%  7.0%  9.1us(  96us) 1847us(3418us)(0.01%)  7.4us( 7.4us)       114 93.0%  6.1%(0.88%)  tasklist_lock
 0.00%  3.0%  2.4us( 4.6us) 2352us(2352us)(0.00%)    0us                33 97.0%  3.0%(   0%)    do_fork+0x5a4
 0.01% 18.2%   27us(  96us) 1517us(3418us)(0.01%)  7.4us( 7.4us)        33 81.8% 15.2%( 3.0%)    exit_notify+0x1ac
 0.00%    0%  0.2us( 0.7us)    0us                   0us                15  100%    0%(   0%)    exit_notify+0x2e0
 0.00%  3.0%  1.5us( 7.4us) 3320us(3320us)(0.00%)    0us                33 97.0%  3.0%(   0%)    release_task+0xa0

 0.00%    0%  0.9us( 7.6us)    0us                   0us               124  100%    0%(   0%)  unix_table_lock
 0.00%    0%  1.3us( 7.6us)    0us                   0us                62  100%    0%(   0%)    unix_create1+0xf8
 0.00%    0%  0.4us( 2.4us)    0us                   0us                62  100%    0%(   0%)    unix_release_sock+0x14

 0.00%    0%  240us( 472us)    0us                   0us                 2  100%    0%(   0%)  vmlist_lock
 0.00%    0%  6.7us( 6.7us)    0us                   0us                 1  100%    0%(   0%)    get_vm_area+0x3c
 0.00%    0%  472us( 472us)    0us                   0us                 1  100%    0%(   0%)    vfree+0x58

 0.27% 10.0%   13us(  63us)  5.6us(  75us)(0.00%)  2.6us( 9.2us)      2002 90.0%  8.9%( 1.1%)  xtime_lock
 0.02% 15.0%  1.7us(  11us)  5.8us(  75us)(0.00%)  2.1us( 5.8us)      1001 85.0% 13.7%( 1.3%)    timer_bh+0x10
 0.25%  5.0%   25us(  63us)  5.1us(  34us)(0.00%)  3.2us( 9.2us)      1001 95.0%  4.1%(0.90%)    timer_interrupt+0x10

 0.00%    0%  1.0us( 1.9us)    0us                   0us                 2  100%    0%(   0%)  copy_files+0x12c
 0.00%    0%  0.2us( 0.9us)    0us                   0us               328  100%    0%(   0%)  do_fcntl+0x148
 0.00%    0%  0.3us( 0.3us)    0us                   0us                 2  100%    0%(   0%)  expand_fd_array+0x88
 0.00%    0%  0.2us( 4.8us)    0us                   0us               697  100%    0%(   0%)  fd_install+0x20
 0.00%    0%  0.3us( 1.0us)    0us                   0us                17  100%    0%(   0%)  flush_old_exec+0x230
 0.00%    0%  0.1us( 0.4us)    0us                   0us                15  100%    0%(   0%)  flush_old_exec+0x29c
 0.01%    0%  0.8us(  85us)    0us                   0us               792  100%    0%(   0%)  get_unused_fd+0x24
 0.00%    0%  1.2us( 2.6us)    0us                   0us                15  100%    0%(   0%)  inet_accept+0xcc
 0.00%    0%  3.8us(  83us)    0us                   0us                30  100%    0%(   0%)  locate_fd+0x14
 0.00%    0%  1.1us( 2.6us)    0us                   0us                30  100%    0%(   0%)  sys_chdir+0x88
 0.00%    0%  0.3us( 5.5us)    0us                   0us               799  100%    0%(   0%)  sys_close+0x1c
 0.00%    0%  0.1us( 0.8us)    0us                   0us               125  100%    0%(   0%)  sys_open+0x84
 0.00%    0%  0.4us( 0.8us)    0us                   0us                14  100%    0%(   0%)  tcp_close+0x498
 0.00%    0%  1.1us( 2.1us)    0us                   0us                14  100%    0%(   0%)  tcp_unhash+0x60
 0.00%    0%  0.6us( 2.0us)    0us                   0us                15  100%    0%(   0%)  tcp_v4_syn_recv_sock+0x1a8
 0.01%    0%  9.6us( 120us)    0us                   0us                62  100%    0%(   0%)  unix_release_sock+0x34
 0.00%    0%  0.3us( 3.7us)    0us                   0us                62  100%    0%(   0%)  unix_release_sock+0x54
_________________________________________________________________________________________________________________________
Number of read locks found=17
