Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbTELSOY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTELSOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:14:24 -0400
Received: from air-2.osdl.org ([65.172.181.6]:39392 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262538AbTELSOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 14:14:18 -0400
Message-Id: <200305121826.h4CIQuW09568@mail.osdl.org>
Date: Mon, 12 May 2003 11:26:53 -0700 (PDT)
From: markw@osdl.org
Subject: OSDL DBT-2 AS vs. Deadline 2.5.69-mm3 2.5.69-mm2
To: linux-kernel@vger.kernel.org
cc: akpm@digeo.com, axboe@suse.de, piggin@cyberone.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're still working on fixing up the aacraid driver to avoid bounce
buffers, but here is data on 2.5.69-mm3 (and 2.5.69-mm2) for a before
picture.  I also have some tests queued up on STP for 2.5.69-mm3 where I
set the TCQ depth to 2.  Hopefully I will have results for those tests
later today.


METRICS OVER LAST 20 MINUTES:
--------------- -------- ----- ---- -------- -----------------------------------
Kernel          Elevator NOTPM CPU% Blocks/s URL                                
--------------- -------- ----- ---- -------- -----------------------------------
2.5.69-mm3      as        1214 94.0   9352.0 http://khack.osdl.org/stp/271973/  
2.5.69-mm3      deadline  1148 91.9   9097.0 http://khack.osdl.org/stp/271975/  

FUNCTIONS SORTED BY TICKS:
-- ------------------------- ------- ------------------------- -------
 # as 2.5.69-mm3             ticks   deadline 2.5.69-mm3       ticks  
-- ------------------------- ------- ------------------------- -------
 1 default_idle              5748957 default_idle              6152491
 2 bounce_copy_vec             91208 bounce_copy_vec             85515
 3 schedule                    50436 schedule                    49036
 4 do_softirq                  33556 do_softirq                  32467
 5 __make_request              28193 __blk_queue_bounce          25887
 6 __blk_queue_bounce          27210 scsi_request_fn             20311
 7 scsi_request_fn             25400 __make_request              18444
 8 scsi_end_request            19051 scsi_end_request            13991
 9 try_to_wake_up              11901 try_to_wake_up              11457
10 dio_bio_end_io              11000 dio_bio_end_io


METRICS OVER LAST 20 MINUTES:
--------------- -------- ----- ---- -------- -----------------------------------
Kernel          Elevator NOTPM CPU% Blocks/s URL                                
--------------- -------- ----- ---- -------- -----------------------------------
2.5.69-mm2      as        1185 93.2   9006.7 http://khack.osdl.org/stp/271863/  
2.5.69-mm2      deadline  1142 92.4   8839.4 http://khack.osdl.org/stp/271864/  

FUNCTIONS SORTED BY TICKS:
-- ------------------------- ------- ------------------------- -------
 # as 2.5.69-mm2             ticks   deadline 2.5.69-mm2       ticks  
-- ------------------------- ------- ------------------------- -------
 1 default_idle              6187082 default_idle              6061459
 2 bounce_copy_vec             85400 bounce_copy_vec             87995
 3 schedule                    50100 schedule                    47648
 4 do_softirq                  32726 do_softirq                  31920
 5 __make_request              27378 __blk_queue_bounce          25986
 6 __blk_queue_bounce          25901 scsi_request_fn             22411
 7 scsi_request_fn             24656 __make_request              18982
 8 scsi_end_request            18070 scsi_end_request            14279
 9 try_to_wake_up              11702 try_to_wake_up              10800
10 dio_bio_end_io              10565 dio_bio_end_io              10228


--
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x 32 (office)
(503)-626-2436      (fax)
http://www.osdl.org/archive/markw/
