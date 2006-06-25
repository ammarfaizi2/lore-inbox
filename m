Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752313AbWFXPR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbWFXPR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 11:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbWFXPR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 11:17:28 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:30406 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1752297AbWFXPR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 11:17:28 -0400
Message-ID: <351162244.30759@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060625071036.241325936@localhost.localdomain>
Date: Sun, 25 Jun 2006 15:10:36 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Lubos Lunak <l.lunak@suse.cz>,
       Fengguang Wu <wfg@mail.ustc.edu.cn>
Subject: [PATCH 0/7] [RFC] iosched: make a difference between read/readahead requests
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

This patchset does two jobs:
	1) do io schedule differently on READ/READA requests.
		- to help improve I/O latency and throughput
	2) do notification/action on READA => READ events
		- to make the elevators better informed
		- to prevent the priority inversion problem
		- also brings some CPU overheads(*)

(*) Most overheads should be in functions deadline_kick_page() and
deadline_add_drq_fifo(). Optimizations should be possible.

The features are required when one is doing a lot of fadvise(WILLNEED) calls,
and do not want to interfere with normal I/Os. Servers that serve lots of
concurrent clients would benifit a lot, too.

The patches come in two groups:

1) explicitly schedule READA requests
Note: currently only the deadline elevator is touched.

[PATCH 1/7] iosched: introduce WRITEA                                                  
[PATCH 2/7] iosched: introduce parameter deadline.reada_expire                         
[PATCH 3/7] iosched: introduce deadline_add_drq_fifo()                                 
[PATCH 4/7] iosched: submit READA requests on possible readahead code path             

2) notify/act on pending reads
Naming issue: how about pending_read/need_page/... for kick_page?

[PATCH 5/7] iosched: introduce elv_kick_page()                                         
[PATCH 6/7] iosched: run elv_kick_page() on sync read                                  
[PATCH 7/7] iosched: introduce deadline_kick_page()                                    

Any comments are welcome, thanks.

Fengguang Wu
--
Dept. Automation                University of Science and Technology of China
