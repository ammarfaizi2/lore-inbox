Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTIYWe0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 18:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTIYWe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 18:34:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:37263 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262011AbTIYWeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 18:34:23 -0400
Message-Id: <200309252234.h8PMYI106613@mail.osdl.org>
Date: Thu, 25 Sep 2003 15:34:15 -0700 (PDT)
From: markw@osdl.org
Subject: OSDL DBT-2 AS vs. Deadline 2.6.0-test5-mm4
To: linux-kernel@vger.kernel.org, linstab@osdl.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DBT-2 is an on-line transaction processing (OLTP) workload, a fair use
implementation of the TPC-C.

Results between the two elevators differ by about 4.5%, with the AS
elevator having the edge this time.  Results between the AS and deadline
elevator are still pretty close.  I don't believe results have changed
dramatically since 2.6.0-test5-mm3 and I don't see any significant
changes in the profile, so things are still looking ok.


METRICS OVER LAST 20 MINUTES:
--------------- -------- ----- ---- -------- -----------------------------------
Kernel          Elevator NOTPM CPU% Blocks/s URL                                
--------------- -------- ----- ---- -------- -----------------------------------
2.6.0-test5-mm4 as        1382 91.6   9955.5 http://khack.osdl.org/stp/280312/  
2.6.0-test5-mm4 deadline  1321 90.9  10021.5 http://khack.osdl.org/stp/280314/  

FUNCTIONS SORTED BY TICKS:
-- ------------------------- ------- ------------------------- -------
 # as 2.6.0-test5-mm4        ticks   deadline 2.6.0-test5-mm4  ticks  
-- ------------------------- ------- ------------------------- -------
 1 default_idle              5643426 default_idle              5751035
 2 schedule                    53434 schedule                    52592
 3 scsi_request_fn             29810 do_softirq                  26151
 4 do_softirq                  25399 scsi_request_fn             24589
 5 __make_request              23210 __make_request              18191
 6 scsi_end_request            13485 try_to_wake_up              12158
 7 try_to_wake_up              12017 dio_bio_end_io              11051
 8 dio_bio_end_io              11206 scsi_end_request             9051
 9 do_anonymous_page            8097 do_anonymous_page            7993
10 ipc_lock                     6941 ipc_lock                     6949
11 sysenter_past_esp            5269 sysenter_past_esp            5347
12 sys_semtimedop               4784 sys_semtimedop               4924
13 __might_sleep                4280 direct_io_worker             4352
14 __copy_to_user_ll            4269 __might_sleep                4138
15 direct_io_worker             4202 __copy_to_user_ll            3566
16 __mod_timer                  3571 blk_run_queue                3524
17 dio_await_one                3502 dio_await_one                3514
18 blk_run_queue                3388 kmem_cache_alloc             3465
19 kmem_cache_alloc             3358 __mod_timer                  3366
20 __generic_file_aio_read      3104 __generic_file_aio_read      3114

-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton, OR 97005
(503) 626-2455 x 32 (office)
(503) 626-2436      (fax)
