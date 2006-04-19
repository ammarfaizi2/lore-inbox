Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWDSMCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWDSMCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 08:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWDSMCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 08:02:34 -0400
Received: from main.gmane.org ([80.91.229.2]:53899 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750708AbWDSMCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 08:02:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Martin Honermeyer <maze@strahlungsfrei.de>
Subject: Re: [Fwd: Re: 3w-9xxx status in kernel]
Date: Wed, 19 Apr 2006 14:04:19 +0200
Message-ID: <e258sa$5n1$1@sea.gmane.org>
References: <1145445387.3085.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mail.school-scout.de
Mail-Copies-To: maze@strahlungsfrei.de
User-Agent: KNode/0.10.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> -------- Forwarded Message --------
>> From: Martin Honermeyer <maze@strahlungsfrei.de>
>> To: linux-kernel@vger.kernel.org
>> Subject: Re: 3w-9xxx status in kernel
>> Date: Wed, 19 Apr 2006 13:02:42 +0200
>> 
>> Hi,
>> 
>> same problem over here. Why does the newest kernel contain an old version
>> of the 3w-9xxx driver?
> 
> because nobody bothered to submit it??

Okay, now I know how it works.

> 
>> 
>> We are having performance problems using a 9550SX controller. Read
>> throughput (measured with hdparm)
> 
> hdparm is not a good measurement tool at all for performance.
> At least use something like tiobench (tiobench.sf.net)

Thanks for the hint. Here is tiobench output:

$ tiobench
No size specified, using 2000 MB
Run #1: /usr/bin/tiotest -t 8 -f 250 -r 500 -b 4096 -d . -TTT


Unit information
================
File size = megabytes
Blk Size  = bytes
Rate      = megabytes per second
CPU%      = percentage of CPU used during the test
Latency   = milliseconds
Lat%      = percent of requests that took longer than X seconds
CPU Eff   = Rate divided by CPU% - throughput per cpu load

Sequential Reads
                              File  Blk   Num                   Avg     
Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency   
Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ ---------
-----------  -------- -------- -----
2.6.15-19-amd64-xeon          2000  4096    1   46.63 7.159%     0.083     
484.49   0.00000  0.00000   651
2.6.15-19-amd64-xeon          2000  4096    2   34.65 10.11%     0.223     
386.04   0.00000  0.00000   343
2.6.15-19-amd64-xeon          2000  4096    4   15.14 8.629%     1.016    
1128.07   0.00000  0.00000   175
2.6.15-19-amd64-xeon          2000  4096    8   23.56 23.09%     1.209    
2051.28   0.00020  0.00000   102

Random Reads
                              File  Blk   Num                   Avg     
Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency   
Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ ---------
-----------  -------- -------- -----
2.6.15-19-amd64-xeon          2000  4096    1    3.76 0.626%     1.037      
99.77   0.00000  0.00000   601
2.6.15-19-amd64-xeon          2000  4096    2    4.88 1.654%     1.545      
97.82   0.00000  0.00000   295
2.6.15-19-amd64-xeon          2000  4096    4    5.40 3.389%     2.673     
208.84   0.00000  0.00000   159
2.6.15-19-amd64-xeon          2000  4096    8    6.51 11.20%     4.013     
261.38   0.00000  0.00000    58

Sequential Writes
                              File  Blk   Num                   Avg     
Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency   
Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ ---------
-----------  -------- -------- -----
2.6.15-19-amd64-xeon          2000  4096    1   13.05 6.946%     0.274   
34488.77   0.00098  0.00039   188
2.6.15-19-amd64-xeon          2000  4096    2    6.99 14.91%     0.432   
57601.25   0.00352  0.00039    47
2.6.15-19-amd64-xeon          2000  4096    4    7.10 53.92%     1.360   
69873.41   0.00957  0.00176    13
2.6.15-19-amd64-xeon          2000  4096    8    7.07 78.44%     2.813   
71698.67   0.02441  0.00684     9

Random Writes
                              File  Blk   Num                   Avg     
Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency   
Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ ---------
-----------  -------- -------- -----
2.6.15-19-amd64-xeon          2000  4096    1    0.44 0.142%     0.010      
11.50   0.00000  0.00000   306
2.6.15-19-amd64-xeon          2000  4096    2    0.43 0.324%     0.009       
0.07   0.00000  0.00000   131
2.6.15-19-amd64-xeon          2000  4096    4    0.42 1.979%     0.031       
0.50   0.00000  0.00000    21
2.6.15-19-amd64-xeon          2000  4096    8    0.41 4.640%     0.077       
1.33   0.00000  0.00000     9


I am especially scared of the high CPU usage in sequential writes! Btw: this
server sits idle at the moment. Just some webserver processes running!

Specs:
Dual-Xeon 3 GHz, Ubuntu Dapper 64bit with 2.6.15 Ubuntu kernel.


Martin


