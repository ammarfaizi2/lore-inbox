Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbTIVVVb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 17:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTIVVVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 17:21:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:49575 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263301AbTIVVV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 17:21:29 -0400
Message-Id: <200309222121.h8MLLNU24573@mail.osdl.org>
Date: Mon, 22 Sep 2003 14:21:20 -0700 (PDT)
From: markw@osdl.org
Subject: DBT-2 STP Results History for 2.6.0-test
To: linux-kernel@vger.kernel.org, linstab@osdl.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DBT-2 is an on-line transaction processing (OLTP) workload based on the
TPC-C.  The following 2.6 history of results are from a 4-way system
with 4GB of memory using the AS elevator.  From 2.6.0-test5 to
2.6.0-test5-mm3, it looks like we have improved with about 500 more
blocks/s I/O with slightly less processor time.

The metric, NOTPM, is the number of "New Order" database transactions
per minute over a 20 minute run (bigger is better).  The "New Order
transactions" represent about 45% of the transactions of the workload
and is one of the five transactions in the workload.


Kernel               Metric Change (%)  URL                                
-------------------- ------ ----------  ----------------------------------------
linux-2.6.0-test2      1234        N/A  http://khack.osdl.org/stp/279891/  
linux-2.6.0-test3      1295        4.9  http://khack.osdl.org/stp/279890/  
linux-2.6.0-test5      1266       -2.2  http://khack.osdl.org/stp/280243/  
2.6.0-test5-mm3        1338        5.7  http://khack.osdl.org/stp/280185/


Some additional profile data between 2.6.0-test5 and 2.6.0-test5-mm3:

METRICS OVER LAST 20 MINUTES:
--------------- -------- ----- ---- -------- -----------------------------------
Kernel          Elevator NOTPM CPU% Blocks/s URL                                
--------------- -------- ----- ---- -------- -----------------------------------
2.6.0-test5     as        1266 92.0   9529.6 http://khack.osdl.org/stp/280243/  
2.6.0-test5-mm3 as        1338 91.3  10000.5 http://khack.osdl.org/stp/280185/  

FUNCTIONS SORTED BY TICKS:
-- ------------------------- ------- ------------------------- -------
 # as 2.6.0-test5            ticks   as 2.6.0-test5-mm3        ticks  
-- ------------------------- ------- ------------------------- -------
 1 default_idle              5853820 default_idle              5782689
 2 schedule                    55145 schedule                    57644
 3 scsi_request_fn             29290 scsi_request_fn             30697
 4 __make_request              24824 __make_request              26061
 5 do_softirq                  24069 do_softirq                  26040
 6 scsi_end_request            13250 scsi_end_request            13169
 7 dio_bio_end_io              10078 try_to_wake_up              12028
 8 try_to_wake_up              10054 dio_bio_end_io              10805
 9 do_anonymous_page            7595 do_anonymous_page            8108
10 sysenter_past_esp            6484 ipc_lock                     7295
11 ipc_lock                     6187 sysenter_past_esp            6664
12 sys_semtimedop               5352 sys_semtimedop               4947
13 direct_io_worker             4568 direct_io_worker             4358
14 dio_await_one                3963 __might_sleep                4185
15 __copy_to_user_ll            3899 __copy_to_user_ll            3813
16 __mod_timer                  3637 blk_run_queue                3589
17 __might_sleep                3533 __mod_timer                  3580
18 blk_run_queue                3424 kmem_cache_alloc             3480
19 kmem_cache_alloc             3031 dio_await_one                3446
20 fget_light                   3007 get_request                  3123


-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton, OR 97005
(503) 626-2455 x 32 (office)
(503) 626-2436      (fax)
