Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268562AbUHLNfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268562AbUHLNfz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 09:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268566AbUHLNfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 09:35:55 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:10817 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268562AbUHLNfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 09:35:36 -0400
Message-ID: <f0cc3e3e04081206354300a561@mail.gmail.com>
Date: Thu, 12 Aug 2004 23:35:35 +1000
From: Omar Kilani <omar.kilani@gmail.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Subject: Re: Performance Degradation: 2.6.8-rc4-bk1 vs RHEL 2.4.21-15.0.3
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <295911442.20040812150922@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <f0cc3e3e040812054511f253aa@mail.gmail.com> <295911442.20040812150922@dns.toxicfilms.tv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej,

On Thu, 12 Aug 2004 15:09:22 +0200, Maciej Soltysiak
<solt@dns.toxicfilms.tv> wrote:
> Hi,
> 
> Just a wild guess, please try the same tests with 2.6 kernels with
> echo 0 > /proc/sys/net/ipv4/tcp_window_scaling

This halves all my performance values.

I've just tried 2.6.8-rc4-mm1 with the same results.

I also tested the 2.6.8-rc4-mm1 kernel on a dual P4 Xeon 3.2GHz with
2MB Cache (with HT, so 4 logical processors) using 15K RPM U320
Fujitsu SCSI drives.

[root@minbar root]# hdparm -T -t /dev/sda

/dev/sda:
 Timing buffer-cache reads:   1852 MB in  2.00 seconds = 927.07 MB/sec
 Timing buffered disk reads:  218 MB in  3.02 seconds =  72.29 MB/sec

[root@minbar root]# ./bw_tcp 127.0.0.1
0.065536 333.85 MB/sec

Ran this 5 times with no real difference in value.

[root@minbar root]# ab -n 100000 -c 2 http://localhost/index.html
This is ApacheBench, Version 2.0.40-dev <$Revision: 1.141 $> apache-2.0
Copyright (c) 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Copyright (c) 1998-2002 The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient)
Completed 10000 requests
Completed 20000 requests
Completed 30000 requests
Completed 40000 requests
Completed 50000 requests
Completed 60000 requests
Completed 70000 requests
Completed 80000 requests
Completed 90000 requests
Finished 100000 requests


Server Software:        Apache/2.0.50
Server Hostname:        localhost
Server Port:            80

Document Path:          /index.html
Document Length:        51200 bytes

Concurrency Level:      2
Time taken for tests:   43.787872 seconds
Complete requests:      100000
Failed requests:        0
Write errors:           0
Total transferred:      852032704 bytes
HTML transferred:       825032704 bytes
Requests per second:    2283.74 [#/sec] (mean)
Time per request:       0.876 [ms] (mean)
Time per request:       0.438 [ms] (mean, across all concurrent requests)
Transfer rate:          19002.13 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:     0    0   0.1      0      12
Waiting:        0    0   0.0      0       1
Total:          0    0   0.1      0      12

Percentage of the requests served within a certain time (ms)
  50%      0
  66%      0
  75%      0
  80%      0
  90%      0
  95%      0
  98%      0
  99%      0
 100%     12 (longest request)

Ran this 5 times with no real difference in performance.

So a single 2.8GHz P4 HT with a 2.4 kernel has better performance than
a dual Xeon 3.2GHz HT with a 2.6 kernel. I think the SCSI drives
eliminate the IDE results as a factor, so this looks like it's a net
loopback performance issue. Maybe. :)
 
> I am curious if it might be related to my problems with networking.
> turning of TCP WS tcp_window_scaling helps my problems.
> 
> Regards,
> Maciej

Regards,
Omar Kilani
