Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUDPQ7F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbUDPQ7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:59:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:63683 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S263564AbUDPQ6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:58:21 -0400
Subject: DBT3-pgsql large performance improvement 2.6.6-rc1
From: Mary Edie Meredith <maryedie@osdl.org>
Reply-To: maryedie@osdl.org
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: OSDL
Message-Id: <1082134307.16437.461.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 16 Apr 2004 09:51:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Performance in DBT-3 (using PostgreSQL) has vastly
improved for _both in the "power" portion (single 
process/query) and in the "throughput" portion of 
the test (when the test is running multiple processes) 
on our 4-way(4GB) and 8-way(8GB) STP systems as 
compared 2.6.5  kernel results.

Using the default DBT-3 options (ie using LVM, ext2, 
PostgreSQL version 7.4.1) 

Note: Bigger numbers are better.

Kernel....Runid..CPUs.Power..%incP.Thruput %incT 
2.6.5     291308   4  97.08  base   120.46  base   
2.6.6-rc1 291876   4  146.11 50.5%  222.94 85.1%

Kernel....Runid..CPUs.Power..%incP..Thruput %incT
2.6.5     291346   8  101.08  base   138.95 base
2.6.6-rc1 291915   8  151.69  50.1%  273.69 97.0%

So the improvement is between 50% and 97%!

Profile 2.6.5 8way throughput phase:
http://khack.osdl.org/stp/291346/profile/after_throughput_test_1-tick.sort
Profile 2.6.6-r1 8way throughput phase:
http://khack.osdl.org/stp/291915/profile/after_throughput_test_1-tick.sort

What I notice is that radix_tree_lookup is in 
the top 20 in the 2.6.5 profile, but not in 
2.6.6-rc1.  Could theradix tree changes be 
responsible for this?

DBT-3 is a read mostly DSS workload and the throughput 
phase  is where we run multiple query streams (as 
many as we have CPUs).  In this workload, the database 
is stored on a file system, but it is small relative 
to the amount of memory (4GB and 8GB).  It almost 
completely caches in page cache early on.   So there 
is some physical IO in the first few minutes, but very 
little to none in the remainder. 


 

-- 
Mary Edie Meredith 
maryedie@osdl.org
503-626-2455 x42
Open Source Development Labs

