Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269892AbTGKLD7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 07:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269898AbTGKLD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 07:03:58 -0400
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:26265 "EHLO
	picard.csi-inc.com") by vger.kernel.org with ESMTP id S269892AbTGKLD4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 07:03:56 -0400
Message-ID: <022401c3479e$2b1cd2e0$c8de11cc@black>
From: "Mike Black" <mblack@csi-inc.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Pthread performance
Date: Fri, 11 Jul 2003 07:18:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a benchmark program for threads and found a major difference between a single CPU and dual CPU system.
Here's the code:
http://www-124.ibm.com/pipermail/pthreads-users/2002-April/000176.html
Is this showing context switches going between CPUs??
Wouldn't one expect the dual CPU to run twice as fast instead of ten times slower?
As you can see from the timing user time increases by a factor of 4 and system time by a factor of 10.
I seem to remember something about gettimeofday() possibly being a problem but couldn't find a reference to it.
Anybody have an explanation/fix for this?
I'm running 2.4.21 with glibc-2.3.2 

Single CPU (Athlon 2400):
Thread     Count Start Time   End Time  Reverses
------   ------- ----------   --------  --------
0         100000    0.00014    0.55257     99998
1         100000    0.00018    0.44839     99997
2         100000    0.00018    0.57385    100000
3         100000    0.00026    0.37884     99999
4         100000    0.00026    0.50911    100000
5         100000    0.00028    0.49115     99998
6         100000    0.00035    0.53783    100000
7         100000    0.00036    0.60039    100000
8         100000    0.00038    0.60346     81847
9         100000    0.45934    0.59906     99998
Total elapsed time is    0.60348 seconds
0.080u 0.530s 0:00.60 101.6%    0+0k 0+0io 136pf+0w
Dual CPU (Athlon 2000MP):
Thread     Count Start Time   End Time  Reverses
------   ------- ----------   --------  --------
0         100000    0.00024    2.35316    100000
1         100000    0.00031    2.65760    100000
2         100000    0.00036    2.61471    100000
3         100000    0.00048    2.59529    100000
4         100000    0.00055    2.65601    100000
5         100000    0.00060    2.70938     98040
6         100000    0.00065    2.68379    100000
7         100000    0.00075    2.71154     95341
8         100000    0.00082    2.69375    100000
9         100000    0.00089    2.71491     78796
Total elapsed time is    2.71494 seconds
0.380u 5.040s 0:02.71 200.0%    0+0k 0+0io 133pf+0w


Michael D. Black mblack@csi-inc.com
http://www.csi-inc.com/
http://www.csi-inc.com/~mike
Melbourne FL
Michael D. Black mblack@csi-inc.com
http://www.csi-inc.com/
http://www.csi-inc.com/~mike
321-676-2923, x203
Melbourne FL
