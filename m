Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWCQN2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWCQN2a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWCQN2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:28:30 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:60887 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932083AbWCQN23
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:28:29 -0500
Date: Fri, 17 Mar 2006 18:58:26 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: theonetruekenny@yahoo.com
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: AIO performance
Message-ID: <20060317132826.GA3726@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kenny,

In browsing lkml archives today I came across your query about
AIO performance and conclusions from our 2003 paper. I am sorry, I
missed your post at that time (it may be a good idea to cc
linux-aio@kvack.org on AIO related queries in addition to lkml).

The results in the 2003 paper were based on a specific microbenchmark,
but (as mentioned later in the conclusion) it couldn't capture the
impact of well designed AIO usage which can actually improve the overall
efficiency of an application. In my own experience later, and following
further performance tuning of AIO, I found the case of streaming
random AIO reads and writes to be the most interesting, as it can provide
throughput gains while simplifying the coordination model. This is the
pattern seen under some database workloads.

There is in fact a more recent reference you could look at, which is
a follow-on paper at OLS 2004 on Linux 2.6 AIO Performance and Robustness,
(http://www.linuxsymposium.org/proceedings/reprints/Reprint-Bhattacharya-OLS2004.pdf)
where we published some real application performance numbers as well
as microbenchmark results for streaming AIO reads/writes using aio-stress
(instead of rawiobench). You may find that interesting. AIO resulted in
close to 10% performance gain for our database benchmark run, but more
significantly as we observed, a single page cleaner thread using AIO was
able to drive around 40% more writes than 55 page cleaner threads without AIO.

I hope that helps.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

