Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293639AbSCKISE>; Mon, 11 Mar 2002 03:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293638AbSCKIRy>; Mon, 11 Mar 2002 03:17:54 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:35547 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S293639AbSCKIRr>; Mon, 11 Mar 2002 03:17:47 -0500
Date: Mon, 11 Mar 2002 10:01:50 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Few questions about 2.5.6-pre3
Message-ID: <Pine.LNX.4.44.0203110947110.19020-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone come across the following bootime bugs?

2.5.6-pre3 UP:

  init_idle(current, smp_processor_id());
        /*
         *      We count on the initial thread going ok
         *      Like idlers init is an unlocked kernel thread, which will
         *      make syscalls (and thus be locked).
         */
        smp_init();
			<=== [1]
        /* Do the rest non-__init'ed, we're now alive */
        rest_init();

[1] If i don't put a busy loop or a printk there the machine pukes in 
do_page_fault when we try and down_read(&mm->mmap_sem); The dump shows 
that current is an invalid pointer and has crazy PID and other fields.

2.5.6-pre3 SMP:

This one is a funny one, it dies *right* after mtrr_init, and even if i 
put a BUG() after mtrr_init, it never gets executed. This one happens to 
die in the scheduler when we try and release_kernel_lock(prev, 
smp_processor_id()) It already is released so we trigger an Oops in 
spinlock.h:107

Thanks,
	Zwane Mwaikambo


