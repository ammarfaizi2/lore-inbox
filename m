Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUFXJ1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUFXJ1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 05:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbUFXJ1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 05:27:44 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:375 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263740AbUFXJ1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 05:27:41 -0400
Message-ID: <40DA9E89.9020801@yahoo.com.au>
Date: Thu, 24 Jun 2004 19:27:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Yusuf Goolamabbas <yusufg@outblaze.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: finish_task_switch high in profiles in 2.6.7
References: <20040624091548.GA8264@outblaze.com>
In-Reply-To: <20040624091548.GA8264@outblaze.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yusuf Goolamabbas wrote:
> Hi, I have a fairly busy mailserver which also has a simple iptables
> ruleset (blocking some IP's) running 2.6.7 with the deadline i/o
> scheduler. vmstat was reporting that system time was around 80%. I did
> the following
> 
> readprofile -r ; sleep 240 ; readprofile -n -m /boot/System.map-`uname
> -r` | sort -rn -k 1,1 | head -22
> 
>  48036 total                                      0.2274
>   9684 finish_task_switch                        80.0331
>   6992 default_idle                             158.9091
>   6335 __wake_up                                 87.9861
>   5671 remove_wait_queue                         76.6351
>   4150 add_wait_queue                            59.2857
>   2459 sysenter_past_esp                         21.7611
>   1304 find_get_page                             21.0323
>   1160 __mod_timer                                4.1281
>    938 do_gettimeofday                            5.0430
>    756 del_timer_sync                             2.4787
>    753 del_timer                                  7.1714
>    599 handle_IRQ_event                           5.9900
>    570 do_page_fault                              0.4612
>    485 __do_softirq                               2.8529
>    476 do_sigaction                               0.9136
>    469 do_getitimer                               1.7055
>    464 do_setitimer                               0.9768
>    392 get_offset_tsc                            17.0435
>    340 current_kernel_time                        4.9275
>    293 in_group_p                                 2.4417
>    272 eligible_child                             1.4093
> 
> On a 2.6.5 box with a similar workload, the profile is as follows
> 
> 131202 total                                      0.3704
>  42080 fget                                     667.9365
>  12868 schedule                                   8.1084
>  11231 default_idle                             255.2500
>   9157 fput                                     436.0476
>   6642 remove_wait_queue                         89.7568
>   6076 __wake_up                                 93.4769
>   5056 page_remove_rmap                          13.4111
>   4144 add_wait_queue                            59.2000
>   2255 fget_light                                17.4806
>   2176 sysenter_past_esp                         19.2566
>   1271 kfree                                     11.6606
>   1148 kmem_cache_alloc                          14.9091
>    934 __kmalloc                                  6.6714
>    890 __mod_timer                                3.1673
>    768 del_timer_sync                             2.9538
>    717 buffered_rmqueue                           1.5621
>    715 kmem_cache_free                            8.2184
>    613 free_hot_cold_page                         2.4618
>    612 del_timer                                  5.8286
>    588 __find_get_block                           3.0466
>    588 do_page_fault                              0.4757
> 
> I am trying to determine where the system time is going and don't have
> much zen to begin with. Any assistance would be appreciated ?
> 

Is it an SMP system? What sort of workload is it? Does it use threads?
Check vmstat to see how much context switching is going on with each
kernel.

Thanks.
