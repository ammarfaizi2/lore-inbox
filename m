Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275675AbRJAWm3>; Mon, 1 Oct 2001 18:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275672AbRJAWmT>; Mon, 1 Oct 2001 18:42:19 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:250 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S275669AbRJAWmI>;
	Mon, 1 Oct 2001 18:42:08 -0400
Importance: Normal
Subject: Significant Performance Gain Due to Jonathan Lahr's io_request_lock Patch
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFE9B541BF.AFBEDAF0-ON85256AD8.007C5E74@raleigh.ibm.com>
From: "Peter Wong" <wpeter@us.ibm.com>
Date: Mon, 1 Oct 2001 17:42:17 -0500
X-MIMETrack: Serialize by Router on D04NM203/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/01/2001 06:42:20 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In August I reported that there was a 40% performance gain on a
heavy database workload using Jens Axboe's zero-bounce highmem
I/O patch and my IPS patch running 2.4.5 on a 4-way machine.

This time I want to report the performance gain using the above two
patches and Jonathan Lahr's io_request_lock patch running 2.4.6 on
an 8-way machine.

With Jens' patch and my patch, the total elapsed time for processing
the queries was cut by 34%.

With the above two patches as the baseline, Jonathan's
io_request_lock patch cut the total elapsed time by an additional 36%.

The CPU utilization corresponding to the bounce patches was
25% (user), 63% (kernel) and 12% (idle).

With Jonathan's patch added, the CPU utilization became
40% (user), 29% (kernel) and 31% (idle).

We can see that there was a significant drop in kernel time and an
increase in idle time. In addition, I did not detect any system
problems using Jonathan's patch during a lengthy period of heavy
query processing.

Jonathan's io_request_lock patch can be found at
     http://lse.sourceforge.net/io/.


Regards,
Peter

Wai Yee Peter Wong
IBM Linux Technology Center, Performance Analysis
email: wpeter@us.ibm.com
Office: (512) 838-9272, T/L 678-9272; Fax: (512) 838-4663

