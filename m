Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTFIVsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTFIVsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:48:16 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:495 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262153AbTFIVsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:48:09 -0400
Date: Mon, 9 Jun 2003 18:02:55 -0400
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 12% improvement in fork load from mm3 to mm4
Message-ID: <20030609220255.GA8524@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> autoconf build test creates about 1.2 million processes in
> 35 minutes.  On quad xeon, there was an improvement of
> ~ 12% between 2.5.70-mm3 and 2.5.70-mm4.
> 
>               Avg of 3 runs
> 2.5.70-mm3    829.0
> 2.5.70-mm4    737.9

profile shows the biggest change is in do_page_fault.


                    2.5.70-mm4 2.5.70-mm3
                 total  478507  521921
          default_idle  229230  231410
         do_page_fault   53727  103744
         pte_alloc_one   22227   21114
           system_call   21589   21750
         kunmap_atomic   17231   17091
               copy_mm   14913   13690
          copy_process   14514   12789
        flush_tlb_page   10946   11092
           sigprocmask    9478    9038
          release_task    7553    7243
           exit_notify    5923    5257
            copy_files    5473    5143
          do_sigaction    5249    5200
    sys_rt_sigprocmask    4831    4596
   current_kernel_time    4729    4428
           kmap_atomic    4566    4309
              schedule    4430    3903
       dup_task_struct    3741    3281
 get_signal_to_deliver    2255    2177
               do_exit    2096    1985
         schedule_tail    2002    1852
         ret_from_intr    1511    2298
      sys_rt_sigaction    1473    1367
          flush_tlb_mm    1419    1060
              old_mmap    1186    1096
             sys_wait4    1115    1332
           setup_frame     982     550
        del_timer_sync     963     968
      do_flush_tlb_all     950     879
               do_fork     912     768
             sys_mmap2     906     844
               mm_init     889     909
          syscall_exit     888     951
             __wake_up     886     814
 flush_signal_handlers     855     758
wake_up_forked_process     845     826
                 mmput     842     879
      put_files_struct     818     899
      .text.lock.fault     808    1489
      release_x86_irqs     754     505
         handle_signal     677     424
      wait_task_zombie     654     684
      setup_sigcontext     569     285
      count_open_files     525     399
           copy_thread     474     407
              mm_alloc     473     483
          syscall_call     453     524
     remove_wait_queue     449     463
            error_code     446     713
    restore_sigcontext     435     286
         sys_sigreturn     431     373
      init_new_context     424     327
        get_jiffies_64     412     344
        add_wait_queue     388     325
        eligible_child     374     378
            mm_release     369     316

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

