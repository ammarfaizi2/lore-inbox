Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265734AbTIEURu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265765AbTIEURu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:17:50 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:46097
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S265734AbTIEURS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:17:18 -0400
Date: Fri, 5 Sep 2003 13:17:22 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: markw@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: OSDL DBT-2 AS vs. Deadline 2.6.0-test4-mm3
Message-ID: <20030905201722.GC19041@matchmail.com>
Mail-Followup-To: markw@osdl.org, linux-kernel@vger.kernel.org
References: <200309051828.h85IRxo16644@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309051828.h85IRxo16644@mail.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 11:27:56AM -0700, markw@osdl.org wrote:
> FUNCTIONS SORTED BY LOAD:
> -- ------------------------- ------- ------------------------- -------
>  # as 2.6.0-test4-mm3        ticks   deadline 2.6.0-test4-mm3  ticks  
> -- ------------------------- ------- ------------------------- -------
>  1 default_idle              5746007 default_idle              5764451
>  2 schedule                    53609 schedule                    52174
>  3 scsi_request_fn             29340 
>                                      do_softirq                  25905
>  4 __make_request              25949 scsi_request_fn             23549
>  5 do_softirq                  25560 __make_request              20325
>  6 scsi_end_request            16524 try_to_wake_up              11723
>  7 try_to_wake_up              11939 scsi_end_request            11340
>  8 dio_bio_end_io              11253 dio_bio_end_io              10950
>  9 do_anonymous_page            8234 do_anonymous_page            8110
> 10 ipc_lock                     7366 ipc_lock                     6706
> 11 sys_semtimedop               5493 sys_semtimedop               5152
> 12 sysenter_past_esp            5080 sysenter_past_esp            5064
> 13 direct_io_worker             5065 direct_io_worker             4732
> 14 dio_await_one                4084 dio_await_one                3779
> 15 __copy_to_user_ll            3643 __mod_timer                  3571
> 16 __mod_timer                  3582 blk_run_queue                3521
> 17 blk_run_queue                3411 __copy_to_user_ll            3495
> 18 __might_sleep                3316 __might_sleep                3277
> 19 kmem_cache_alloc             3225 kmem_cache_alloc             3054
> 20 semctl_main                  3072 semctl_main                  3016
> 

Looking at this quickly, scsi_request_fn, __make_request, and
scsi_end_request are show the most additional cost on AS.  As well as
__copy_to_user_ll and ipc_lock.
