Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTKMSHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 13:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbTKMSHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 13:07:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:57559 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264389AbTKMSHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 13:07:11 -0500
Subject: Re: Nick's scheduler v18
From: Mary Edie Meredith <maryedie@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jenny@osdl.org
In-Reply-To: <3FAFC8C6.8010709@cyberone.com.au>
References: <3FAFC8C6.8010709@cyberone.com.au>
Content-Type: text/plain
Organization: Open Source Development Lab
Message-Id: <1068746827.1750.1358.camel@ibm-e.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Nov 2003 10:07:07 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick,

We ran your patch on STP against one of our database workloads (DBT3 on
postgreSQL which uses file system rather than raw).

The test was able to compile, successfully start up the database,
successfully load the database from source file, successfully run the
power test (single stream update/query/delete).   

It failed, however at the next stage, where it starts 8 streams of query
and one stream of updates/deletes where it ran for approximately 40
minutes (usually takes over an hour to complete).  The updates appear to
have completed and only queries were active at the time of failure.  See
the error message below from the database log.

The queries did produce results and the query streams appear to have
failed at the same time.  


.config is at:

http://khack.osdl.org/stp/282959/environment/kernel-config

iostat,vmstat data at this location:
http://khack.osdl.org/stp/282959/results/

from the database log (normal until the line beginning with "PANIC")
...
LOG:  removing transaction log file 000000010000004D
LOG:  removing transaction log file 0000000100000050
PANIC:  fdatasync of log file 1, segment 81 failed: Input/output error
LOG:  statement:  update time_statistics set e_time=current_timestamp where task_name='PERF1.THRUPUT.QS6.Q11';
LOG:  server process (pid 23182) was terminated by signal 6
LOG:  terminating any other active server processes
WARNING:  Message from PostgreSQL backend:
	The Postmaster has informed me that some other backend
	died abnormally and possibly corrupted shared memory.
	I have rolled back the current transaction and am
	going to terminate your database system connection and exit.
	Please reconnect to the database system and repeat your query.
... 

Jenny searched the postgreSQL site for this error and so far can't find
any more details about it.  We are puzzled by the error on the log when
at the time there should not have been any actual updates.  We will
forward this question to the PostreSQL folks.  


On Mon, 2003-11-10 at 09:20, Nick Piggin wrote:
> http://www.kerneltrap.org/~npiggin/v18/
> 
> Nothing exciting for desktop users. High end performance is now starting
> to get better.
> 
> Has an (unimportant) accounting fix that shouldn't really be here, but
> doesn't look like it will get in before 2.6.0.
> 
> Average of 5 kernel compiles (make -j) on a 16-way 512KB cache NUMAQ gives
>          bk14  bk14-v18
> real    83.5s     81.7s
> user   987.6s    992.5s
> sys    158.0s    142.3s
> 
> Volanomark looks much better than mainline.
> 
> More testing welcome.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Mary Edie Meredith <maryedie@osdl.org>
Open Source Development Lab

