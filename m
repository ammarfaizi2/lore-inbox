Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265549AbUBIXsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUBIXou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:44:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:3782 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265549AbUBIXn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:43:56 -0500
Subject: DBT-3 PostgreSQL performance on 2.6
From: Mary Edie Meredith <maryedie@osdl.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Open Source Development Lab
Message-Id: <1076370235.3193.644.camel@ibm-e.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 09 Feb 2004 15:43:55 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At OSDL we compared the performance of 2.4.24 versus 2.6 base 
kernels using one of our database workloads, DBT3, on PostgreSQL. 
(This models a Decision Support type of database, aka 'DSS').  
We used the deadline scheduler on 2.6 kernels. 

DBT-3 has a single stream phase and a multi-stream phase. In the 
single stream phase a single query runs on the system, whereas 
the multi-stream phase has an active query per CPU. So we are 
talking about always a small number of active processes. 
This workload does not swap on either kernel. It consumes a 
great deal of memory, and drives a lot of 8k IO's to the disk, 
mostly read IO.

The 2.6 kernels performed better than 2.4.24 for the single stream test,
but worse for the multi-stream test for both 4-CPU and 8-CPU systems. 

Here is the 8-way data (all numbers are percent improvements 
relative to 2.4.24):

8-way
kernel   single   multi
2.4.24   base     base
2.6.2     1.3     -4.26
2.6.1-mm5 0.29    -12.38
2.6.1     6.78    -7.02
2.6.0    7.04     -15.15  

Since PostgreSQL does not support direct I/O, we are currently
investigating the possibility that system defaults (e.g. vm 
tuning parameters like dirty_expire_centisec) are not optimal
for this workload. Other suggestions welcome.

For more data (4-way, AS scheduler, latest 4-way and 8-way runs) see
http://developer.osdl.org/maryedie/DBT3_PGSQL/investigation.html

For the complete report describing the system layout and workload see:
http://developer.osdl.org/maryedie/DBT3_PGSQL/Study_DBT3_PGSQL_wkld.html

-- 
Mary Edie Meredith <maryedie@osdl.org>
Test and Performance Group
Open Source Development Lab

