Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTFXWZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 18:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTFXWZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 18:25:35 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:23801 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262577AbTFXWZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 18:25:20 -0400
Date: Tue, 24 Jun 2003 15:28:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 849] New: [perf][tiobench] tiobench sequential write degrades in 2.5.72-bk2
Message-ID: <194570000.1056493684@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=849

           Summary: [perf][tiobench] tiobench sequential write degrades in
                    2.5.72-bk2
    Kernel Version: 2.5.72-bk2
            Status: NEW
          Severity: high
             Owner: akpm@digeo.com
         Submitter: slpratt@us.ibm.com


Hardware Environment: 8way 900mhz adaptec scsi drives

Software Environment: sles8.0 + 2.5 kernel

Problem Description:

tiobench sequential write throughput drops between 2.5.72-bk1 and 2.5.72-bk2 for
multi threaded IO.

                                 tolerance = 1.00 + 5.00% of 2.5.72-bk1
             2.5.72-bk1   2.5.72-bk2
    Theads      MBs/sec      MBs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1        43.27        42.90    -0.86        -0.37         3.16 
        16        11.86         4.35   -63.32        -7.51         1.59  * 
        64         3.95         2.50   -36.71        -1.45         1.20  * 


Results:Sequential Write CPU (Graph)
 
                                 tolerance = 1.00 + 3.00% of 2.5.72-bk1
             2.5.72-bk1   2.5.72-bk2
    Theads         %CPU         %CPU    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1       52.87%       50.78%    -3.95        -2.09         2.59 
        16       127.6%       49.03%   -61.58       -78.57         4.83  * 
        64       37.51%       22.15%   -40.95       -15.36         2.13  * 


http://ltcperf.ncsa.uiuc.edu/data/2.5.72-bk2/2.5.72-bk1-vs-2.5.72-bk2/
Folloow link for tiobench.ext3 summary report and full results.

Steps to reproduce:
tiobench  --dir /mnt/tmp --block 4096 --size 600 --numruns 10 --threads 16

