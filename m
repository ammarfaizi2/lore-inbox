Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261856AbSIYAfk>; Tue, 24 Sep 2002 20:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSIYAfk>; Tue, 24 Sep 2002 20:35:40 -0400
Received: from holomorphy.com ([66.224.33.161]:15261 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261856AbSIYAfj>;
	Tue, 24 Sep 2002 20:35:39 -0400
Date: Tue, 24 Sep 2002 17:39:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38-mm2 dbench $N times
Message-ID: <20020925003952.GF3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20020924132031.GJ6070@holomorphy.com> <3D90A532.4B95C06B@digeo.com> <20020925001826.GM6070@holomorphy.com> <3D9103EB.FC13A744@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D9103EB.FC13A744@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Not sure. This is boot bay SCSI crud, but single-disk FC looks
>> *worse* for no obvious reason. Multiple disk tests do much better
>> (about matching the el-scruffo PC numbers above).
>> 

On Tue, Sep 24, 2002 at 05:31:39PM -0700, Andrew Morton wrote:
> dbench 16 on that sort of machine is a memory bandwidth test.
> And a dcache lock exerciser.  It basically doesn't touch the
> disk.  Something very bad is happening.
> Anton can get 3000 MByte/sec ;)

Hmm, this is odd (remember, dcache_rcu is in here):

c01053dc 9194801  60.668      poll_idle
c01175db 1752528  11.5633     .text.lock.sched
c0114c08 1281763  8.45717     load_balance
c0106408 388517   2.56346     .text.lock.semaphore
c0147a4e 272571   1.79844     .text.lock.file_table
c0115080 265006   1.74853     scheduler_tick
c0132374 227403   1.50042     generic_file_write_nolock
c0115434 187759   1.23885     do_schedule
c01233c8 167905   1.10785     run_timer_tasklet
c0114778 103077   0.68011     try_to_wake_up
c010603c 100121   0.660606    __down
c0111788 96062    0.633824    smp_apic_timer_interrupt
c011fa20 70840    0.467408    tasklet_hi_action
c011f700 63125    0.416504    do_softirq
c0131880 60640    0.400107    file_read_actor
c0145dd0 53872    0.355452    generic_file_llseek
c01473e0 45819    0.302317    get_empty_filp
c0175190 35814    0.236304    ext2_new_block
c01476ac 31657    0.208875    __fput
c0146354 26755    0.176532    vfs_write
c010d718 26627    0.175687    timer_interrupt
c01a2cd0 26426    0.174361    atomic_dec_and_lock
c0123294 23022    0.151901    update_one_process

