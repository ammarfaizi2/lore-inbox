Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVDAACv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVDAACv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 19:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVDAAAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 19:00:53 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:29881 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S262088AbVCaX70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:59:26 -0500
Message-Id: <5.1.0.14.2.20050401093516.029d3e58@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 01 Apr 2005 09:59:16 +1000
To: linux-os@analogic.com
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Low file-system performance for 2.6.11 compared to 2.4.26
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0503311129360.4710@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:34 AM 1/04/2005, linux-os wrote:
>For those interested, some file-system tests and a test-tools
>are attached.

in high-performance-I/O-testing i perform regularly, i notice no slowdown 
in 2.6 compared to 2.4.

looking at your test-tools, i would hardly call your workload anywhere near 
'realistic' in terms of its I/O patterns.

a few suggestions / constructive comments:

  (1) 100 processes each performing i/o in the pattern of write 8MB, 
fsync(), wait, read 8MB, wait, delete probably isn't realistic
  (2) you don't mention whether you're performing testing on ext2 or ext3
  (3) you also don't mention what i/o scheduled is being used
  (4) your benchmark doesn't measure 'fairness' between processes
  (5) your benchmark sleeps for a random amount of time at various parts

it is well known that in 2.4 kernels, processes can 'hog' the i/o channel - 
which may result in higher overall throughput but at the detriment of being 
'fair' to the rest of the system.  you should address point (4) above.

can you modify your program to present the time-taken-per-process?
if i'm a betting man, i'd say that 2.6 will be a lot more 'fair' compared 
to 2.4.

default settings for 2.6 likely also means that there is a lot less data 
outstanding in the buffer-cache.
2.6's fsync() behavior is also quite different to that of 2.4.
also note that if you're using a journalled filesystem, fsync() likely does 
different things ...

you don't seed rand, so the random numbers out of rand() aren't actually 
random.
it probably doesn't matter so much since we're only talking microseconds 
here (up to 0.511 msec) - but given 2.4 kernels will have HZ of 100 and 2.6 
will have HZ of 1000, you're clearly going to get a different end result - 
perhaps with 2.6 resulting in a busy-wait from usleep().


cheers,

lincoln.
