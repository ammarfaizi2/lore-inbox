Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbULWG6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbULWG6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 01:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbULWG6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 01:58:55 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:34036 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261171AbULWG6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 01:58:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=EFmN94S5GymEMPE7VojmpEWcc6znRPmSOArowM/mimbxoOy/xZEu3jw5c/WbO1a6ZHPqOIyESwYsMIqoVnkH7DlfplbBt2CPRS3NzQC6085XqzRg4Tt0FuAZr/Xlq6LaNdYDnNRKQ+ngQ/d5rGtonpsVpjkmEiaR+9X9gFguOdg=
Message-ID: <11f564b9041222225638905557@mail.gmail.com>
Date: Thu, 23 Dec 2004 12:26:48 +0530
From: Paramveer Singh <kernel.mail@gmail.com>
Reply-To: Paramveer Singh <kernel.mail@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21 opteron 32 Gig RAM has 10k block writes/sec on running posgresql 7.4.6 disk i/o intensive app
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

we are using a RedHat AS3 U3 box (2.4.21-4.ELsmp) to run a very
intensive database app which does a _huge_ number of inserts durnig
the data generation phase. However, we are noticing a unexpected
performance drops with user cpu utilization numbers falling to near 0.

most of the cpu is used up in iowait. 
CPU states:  cpu    user    nice  system    irq  softirq  iowait    idle
          total    2.0%    0.0%    7.6%   0.0%     0.0%  362.4%   27.2%

/proc/slabinfo showed huge numbers in buffer_head. The line was:
buffer_head       4908452 4962249    200 260854 261171    1 : 16000 4000

some lines from vmstat 1
procs                      memory      swap          io     system         cpu
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy wa id
 4  2  10104 8585908 109820 19090508    0    0    37  1160  282  1421 
8  4 67 22
 1  4  10104 8585908 109824 19090684    0    0     0  4940 1359  4762 
4  1 42 52
 0  3  10104 8585908 109824 19091084    0    0     0  5296 1442 17178
13  4 40 43
 8  1  10104 8585908 109824 19092068    0    0     0  2856 1437 34481
33  6 30 32
 1  3  10104 8585908 109832 19093620    0    0     0  9012 1538 28554
35  7 34 25
 0  3  10104 8585908 109832 19094004    0    0     0  6120 1552  3059 
6  2 47 45
 0  3  10104 8585908 109836 19094012    0    0     0  6188 1502   332 
0  0 70 30
 0  3  10104 8585908 109836 19094020    0    0     0  6436 1548   865 
0  1 67 32
 2  3  10104 8585908 109836 19094332    0    0     0  5980 1404  9322
10  3 52 36
 0  3  10104 8585908 109840 19094332    0    0     0  5252 1492   190 
0  0 74 25

Interestingly, the swap is not being used at all
free output:
Swap:      2040212      10104    2030108


the box is 
Quad AMD Opteron 1.8Ghz 
Tyan Mother board S4882UG2NR 
with Rack Chassis, 12 X 1 Hot swap bays, power supply +  RPS Support
32Gb DDr sdram @ 266
8 X 80Gb SATA Hot Swap Hard Drive, 7200 RPM
Adaptec  SATA RAID controller

I tried to google but found some kswapd related bugs in AS3 which were
fixed in U3. We upgraded even though this does not seem to be a kswapd
error. I am gussing I have used some inappropriate numbers while
setting up the box.

Would someone be kind to point me in a direction where I can find more
information?

thanks a lot!
ps
