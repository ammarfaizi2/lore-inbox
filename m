Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTIOCWN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 22:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTIOCWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 22:22:12 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:23008 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262425AbTIOCWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 22:22:06 -0400
Date: Sun, 14 Sep 2003 22:25:08 -0400
To: kernel@kolivas.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] tbench 8x  2.6.0-test5 v test5-mm1
Message-ID: <20030915022508.GA26687@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 8 x P3 700Mhz

> tbench 192

> 2.6.0-test5:    Throughput 224.949 MB/sec 192 procs
> 2.6.0-test5-mm1:        Throughput 329.827 MB/sec 192 procs

> It seems the tbench likes the interactivity tweaks.

4 x P3 700Mhz likes the scheduler tweaks too.
The 8 way box has about 2x throughput of 4 way.

It appears between test2-mm2 and test3-mm2 a big throughput jump
took place.  Average below is MB/second for 5 runs.  +/- gives
an idea of max variation between runs.  (+/- = (high - low) / 2)
The variation between runs is smaller in recent -mm, which may 
imply more consistency.

tbench-1.3 192 processes                  Average      +/- MB/sec
2.6.0-test1-bk2                             114.8             6.9
2.6.0-test2-bk5                             115.3             4.7
2.6.0-test2-mm1                             113.2            10.9
2.6.0-test2-mm2                             123.2             1.9
2.6.0-test3                                 114.5             8.8
2.6.0-test3-mm2                             151.1             0.7
2.6.0-test3-mm2-gcc-3.3.1                   152.8             1.2
2.6.0-test3-mm2-gcc-3.3.1-Os                147.0             1.6
2.6.0-test3-mm2-gcc-3.3.1-Os-falign=2       147.7             1.9
2.6.0-test4                                 115.0             5.4
2.6.0-test4-mm4                             148.0             2.6
2.6.0-test5                                 113.2             6.2

For fun, test3-mm2 was tested with gcc-2.96, and gcc-3.3.1
with a couple different optimization settings.

This is the readprofile difference between 2.6.0-test4-mm4
and 2.6.0-test5.  schedule, __wake_up, and mod_timer and
__mod_timer are where some of the biggest differences occured.

tbench profile
		           test4-mm4     test5
                   total     788882    1174599
                schedule     200531     249842
            default_idle     137447     117369
               __wake_up     110705     253144
             __mod_timer      77932     211737
         local_bh_enable      62582      57927
           __might_sleep      59081          0
         do_gettimeofday      36704      43132
              do_softirq      27731      30611
               mod_timer      20784      71059
          get_offset_tsc      15790      18543
         prepare_to_wait      14032      25463
             sched_clock      10398          0
        schedule_timeout       5051       6756
             finish_wait       3831      17514
               del_timer       1587       1793
              sys_gettid       1269       1811
            add_timer_on        948          0
                    kmap        723        329
             kmap_atomic        464        188
                  kunmap        421        495
                cpu_idle        152         37
           do_page_fault        138        154
           pte_alloc_one         98         59
                 copy_mm         60         38
            copy_process         58         41
          eligible_child         48        102
               sys_wait4         41         23
                pgd_ctor         37         19
         dup_task_struct         32          9
            release_task         24         51
             exit_notify         22         33
              copy_files         16          8
           kunmap_atomic         15        430
   get_signal_to_deliver         14         10
     current_kernel_time         13         14
          flush_tlb_page          8         24
                 do_exit          8         11
     group_send_sig_info          8          5
            do_sigaction          6          5
           schedule_tail          5          4
  wake_up_forked_process          4          6
                  _stext          4          4
               sys_mmap2          4          4
                   mmput          4          3
          del_timer_sync          4          0
        wait_task_zombie          3          3
        count_open_files          3          0
        init_new_context          3          0
        put_files_struct          3          0
                  mmgrab          2          8
               get_wchan          2          6
        handle_IRQ_event          2          6
            flush_tlb_mm          2          5
        release_x86_irqs          2          4
             next_thread          2          0
           sys_setitimer          2          0
           sys_sigreturn          1          0
        .text.lock.fault          1          0
      sys_rt_sigprocmask          1          0
             system_call          0      58012
            syscall_exit          0       6713
            syscall_call          0        677
            work_resched          0        292
          __cond_resched          0         15
              mm_release          0          4
           handle_signal          0          4
                 mm_init          0          3
               free_task          0          3
               ksoftirqd          0          3
             restore_all          0          3
           ret_from_intr          0          3

Zeros above are when one kernel did not have that
function in readprofile's top 60.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

