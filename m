Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUDCAKh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 19:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUDCAKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 19:10:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:52457 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261451AbUDCAKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 19:10:32 -0500
Date: Fri, 2 Apr 2004 16:10:22 -0800
From: Mark Wong <markw@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.5-rc3-mm4
Message-ID: <20040402161022.A26902@osdlab.pdx.osdl.net>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>
References: <20040401020512.0db54102.akpm@osdl.org> <200404021904.i32J4M215682@mail.osdl.org> <20040402115601.24912093.akpm@osdl.org> <406DFABD.8070400@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <406DFABD.8070400@yahoo.com.au>; from nickpiggin@yahoo.com.au on Sat, Apr 03, 2004 at 09:43:57AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2004 at 09:43:57AM +1000, Nick Piggin wrote:
> Andrew Morton wrote:
> > markw@osdl.org wrote:
> > 
> >>I reran DBT-2 to with ext2 and ext3 (in case you were still interested)
> >> on my 4-way Xeon system with 60+ drives:
> >> 	http://developer.osdl.org/markw/fs/dbt2_project_results.html
> >>
> >> Aside from the from the drop you're already aware of since 2.6.3, it
> >> looks like DBT-2 takes another smaller hit after 2.6.5-rc3-mm2.  Here's
> >> a brief summary from the link above:
> > 
> > 
> > The profile is interesting:
> > 
> > 3671973 poll_idle                                63309.8793
> >  77750 __copy_from_user_ll                      637.2951
> >  64788 generic_unplug_device                    487.1278
> >  62968 DAC960_LP_InterruptHandler               336.7273
> >  53908 finish_task_switch                       361.7987
> >  52947 __copy_to_user_ll                        441.2250
> >  29419 dm_table_unplug_all                      439.0896
> >  25947 __make_request                            17.9938
> >  18564 dm_table_any_congested                   199.6129
> >  13785 update_queue                             104.4318
> >  13498 try_to_wake_up                            20.3590
> >  12736 __wake_up                                114.7387
> >  12560 kmem_cache_alloc                         163.1169
> >  12221 .text.lock.sched                          40.7367
> > 
> > - There's a ton of idle time there.
> > 
> > - The CPU scheduler is hurting.  Nick and Ingo are patching up a storm to
> >   fix a similar problem which Jeremy Higdon is observing at 200,000
> >   IOs/sec.  This will get better.
> 
> Versus this for 2.6.3:
> 
> 12825181 poll_idle                                221123.8103
> 219606 schedule                                 126.7201
> 194233 __copy_from_user_ll                      1541.5317
> 191707 __copy_to_user_ll                        1597.5583
> 149704 DAC960_LP_InterruptHandler               800.5561
> 120972 generic_unplug_device                    822.9388
>   87891 __make_request                            60.9931
>   49207 try_to_wake_up                            74.5561
>   42647 do_anonymous_page                         65.5100
> 
> Which looks like it is taking a lot longer (is it the same test?)
> It is difficult to tell how idle each one is due to lack of total
> ticks reported, but, copy_to/from_user is 3% the amount of idle
> time in 2.6.3, while being 3.5% the amount of idle time in your
> profile.

Whoops, I changed when the sample is take.  This 2.6.3 results samples
when the test is ramping up, while all the subsequent tests are sampling
after the test ramps up.  I can redo this one.

> So 2.6.3 could be relatively more idle than -mm.
> 
> Do we know what the 2.6.3 regression is caused by? Or is it
> likely to be the CPU scheduler?

Yeah, I did tests previously to determine what might be the cause and Andrew
believes it's the CPU scheduler.
