Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268537AbUHLMv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268537AbUHLMv2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 08:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268531AbUHLMv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 08:51:27 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:21632 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268537AbUHLMpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 08:45:50 -0400
Message-ID: <f0cc3e3e040812054511f253aa@mail.gmail.com>
Date: Thu, 12 Aug 2004 22:45:50 +1000
From: Omar Kilani <omar.kilani@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Performance Degradation: 2.6.8-rc4-bk1 vs RHEL 2.4.21-15.0.3
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

List,

I'm doing some "benchmarking" using ApacheBench against a bunch of
different operating systems and kernel versions, and noticed what
appears (by appears I mean "this may be intended behavior that I am
not aware of") a severe performance degradation between 2.4 and 2.6.

In this case, I'm testing the same version of Apache (2.0.50) on the
same hardware, using my own distributions (one is 2.4 based and uses
the RHEL 2.4.21-15.0.3 kernel, the other is 2.6 based and uses
2.6.8-rc3, although 2.6.8-rc4-bk1 exhibits the same issues.)

Hardware: Pentium 4 2.8GHz HT (running the SMP kernel) with 512MB of
RAM, and an 80Gb WD HDD.

Some numbers:

2.4.21-2ts:

[root@rio root]# hdparm -T -t /dev/hda

/dev/hda:
 Timing buffer-cache reads:   2316 MB in  2.00 seconds = 1158.00 MB/sec
 Timing buffered disk reads:  176 MB in  3.01 seconds =  58.47 MB/sec

[root@rio i686-pc-linux-gnu]# ./bw_tcp -s
[root@rio i686-pc-linux-gnu]# ./bw_tcp 127.0.0.1
0.065536 1284.40 MB/sec
[root@rio i686-pc-linux-gnu]# ./bw_tcp 127.0.0.1
0.065536 828.20 MB/sec
[root@rio i686-pc-linux-gnu]# ./bw_tcp 127.0.0.1
0.065536 1346.99 MB/sec
[root@rio i686-pc-linux-gnu]# ./bw_tcp 127.0.0.1
0.065536 1372.90 MB/sec
[root@rio i686-pc-linux-gnu]# ./bw_tcp 127.0.0.1
0.065536 871.46 MB/sec

[root@rio root]# ab -n 100000 -c 2 http://localhost/index.html
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
Time taken for tests:   34.37600 seconds
Complete requests:      100000
Failed requests:        0
Write errors:           0
Total transferred:      852584179 bytes
HTML transferred:       825083904 bytes
Requests per second:    2937.93 [#/sec] (mean)
Time per request:       0.681 [ms] (mean)
Time per request:       0.340 [ms] (mean, across all concurrent requests)
Transfer rate:          24461.21 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       1
Processing:     0    0   0.0      0       5
Waiting:        0    0   0.0      0       2
Total:          0    0   0.0      0       5

Percentage of the requests served within a certain time (ms)
  50%      0
  66%      0
  75%      0
  80%      0
  90%      0
  95%      0
  98%      0
  99%      0
 100%      5 (longest request)

Multiple runs of ab produce similar results.

2.6.8-rc4-bk1:

[root@odin vm]# hdparm -T -t /dev/hda

/dev/hda:
 Timing buffer-cache reads:   2384 MB in  2.00 seconds = 1192.18 MB/sec
 Timing buffered disk reads:  124 MB in  3.01 seconds =  41.20 MB/sec

[root@odin i686-pc-linux-gnu]# ./bw_tcp -s
[root@odin i686-pc-linux-gnu]# ./bw_tcp 127.0.0.1
0.065536 404.62 MB/sec

(Ran this 5 times with no real difference between runs.)

[root@odin ~]# ab -n 100000 -c 2 http://localhost/index.html
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
Time taken for tests:   54.895184 seconds
Complete requests:      100000
Failed requests:        0
Write errors:           0
Total transferred:      852032704 bytes
HTML transferred:       825032704 bytes
Requests per second:    1821.65 [#/sec] (mean)
Time per request:       1.098 [ms] (mean)
Time per request:       0.549 [ms] (mean, across all concurrent requests)
Transfer rate:          15157.30 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.2      0      47
Processing:     0    0   0.6      0      55
Waiting:        0    0   0.2      0      54
Total:          0    0   0.6      0      55

Percentage of the requests served within a certain time (ms)
  50%      0
  66%      0
  75%      0
  80%      0
  90%      0
  95%      1
  98%      1
  99%      1
 100%     55 (longest request)

Multiple runs of ab produce the same results.

So it seems to me that IDE performance (chipset is ICH5) has
decreased, as well as net loopback performance, and this may be the
cause of the performance degradation.

Are there any known issues with either of these? What else could be
effecting these results?

Please Advise.

Regards,
Omar Kilani
