Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbTISVNc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 17:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbTISVNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 17:13:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:63421 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261734AbTISVNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 17:13:30 -0400
Message-Id: <200309192113.h8JLDQU15903@mail.osdl.org>
Date: Fri, 19 Sep 2003 14:13:23 -0700 (PDT)
From: markw@osdl.org
Subject: OSDL DBT-2 AS vs. Deadline 2.6.0-test5-mm3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another profile comparison between the deadline and AS elevator with
2.6.0-test5-mm3.  It looks like the deadline elevator is doing slightly
more i/o, overall using slightly less processor time.  Otherwise it's
only about a 2% difference in the end result according to the NOTPM
column.

These results are from a 4-way system with 4GB of memory.

METRICS OVER LAST 20 MINUTES:
--------------- -------- ----- ---- -------- -----------------------------------
Kernel          Elevator NOTPM CPU% Blocks/s URL                                
--------------- -------- ----- ---- -------- -----------------------------------
2.6.0-test5-mm3 as        1338 91.3  10000.5 http://khack.osdl.org/stp/280185/  
2.6.0-test5-mm3 deadline  1366 91.0  10033.2 http://khack.osdl.org/stp/280187/  

FUNCTIONS SORTED BY TICKS:
-- ------------------------- ------- ------------------------- -------
 # as 2.6.0-test5-mm3        ticks   deadline 2.6.0-test5-mm3  ticks  
-- ------------------------- ------- ------------------------- -------
 1 default_idle              5782689 default_idle              5718679
 2 schedule                    57644 schedule                    50635
 3 scsi_request_fn             30697 do_softirq                  25740
 4 __make_request              26061 scsi_request_fn             23486
 5 do_softirq                  26040 __make_request              19235
 6 scsi_end_request            13169 try_to_wake_up              11406
 7 try_to_wake_up              12028 dio_bio_end_io              10867
 8 dio_bio_end_io              10805 scsi_end_request             9113
 9 do_anonymous_page            8108 do_anonymous_page            8089
10 ipc_lock                     7295 ipc_lock                     7598
11 sysenter_past_esp            6664 sys_semtimedop               6107
12 sys_semtimedop               4947 sysenter_past_esp            5220
13 direct_io_worker             4358 direct_io_worker             4412
14 __might_sleep                4185 __might_sleep                4301
15 __copy_to_user_ll            3813 blk_run_queue                3901
16 blk_run_queue                3589 dio_await_one                3676
17 __mod_timer                  3580 __copy_to_user_ll            3592
18 kmem_cache_alloc             3480 __mod_timer                  3519
19 dio_await_one                3446 kmem_cache_alloc             3466
20 get_request                  3123 get_request                  3215

-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton, OR 97005
(503) 626-2455 x 32 (office)
(503) 626-2436      (fax)
