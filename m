Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbUEBT6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUEBT6Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 15:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbUEBT6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 15:58:24 -0400
Received: from [213.171.41.46] ([213.171.41.46]:8979 "EHLO
	kaamos.homelinux.net") by vger.kernel.org with ESMTP
	id S263163AbUEBT6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 15:58:14 -0400
From: Alexey Kopytov <alexeyk@mysql.com>
To: linux-kernel@vger.kernel.org
Subject: Random file I/O regressions in 2.6
Date: Sun, 2 May 2004 23:57:59 +0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Organization: MySQL AB
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200405022357.59415.alexeyk@mysql.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I tried to compare random file I/O performance in 2.4 and 2.6 kernels and 
found some regressions that I failed to explain. I tested 2.4.25, 2.6.5-bk2 
and 2.6.6-rc3 with my own utility SysBench which was written to generate 
workloads similar to a database under intensive load. 

For 2.6.x kernels anticipatory, deadline, CFQ and noop I/O schedulers were
tested with AS giving the best results for this workload, but it's still about 
1.5 times worse than the results for 2.4.25 kernel.

The SysBench 'fileio' test was configured to generate the following workload:
16 worker threads are created, each running random read/write file requests in
blocks of 16 KB with a read/write ratio of 1.5. All I/O operations are evenly
distributed over 128 files with a total size of 3 GB. Each 100 requests, an
fsync() operations is performed sequentially on each file. The total number of
requests is limited by 10000.

The FS used for the test was ext3 with data=ordered.

Here are the results (values are number of seconds to complete the test):

2.4.25: 77.5377

2.6.5-bk2(noop): 165.3393
2.6.5-bk2(anticipatory): 118.7450
2.6.5-bk2(deadline): 130.3254
2.6.5-bk2(CFQ): 146.4286

2.6.6-rc3(noop): 164.9486
2.6.6-rc3(anticipatory): 125.1776
2.6.6-rc3(deadline): 131.8903
2.6.6-rc3(CFQ): 152.9280

I have published the results as well as the hardware and kernel setups at the
SysBench home page: http://sysbench.sourceforge.net/results/fileio/

Any comments or suggestions would be highly appreciated.

-- 
Alexey Kopytov, Software Developer
MySQL AB, www.mysql.com

Are you MySQL certified?  www.mysql.com/certification
