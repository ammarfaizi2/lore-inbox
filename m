Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVKKEIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVKKEIN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 23:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVKKEIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 23:08:13 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:38042 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932342AbVKKEIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 23:08:13 -0500
Subject: Re: Update on Timer Frequencies
From: Steven Rostedt <rostedt@goodmis.org>
To: AndyLiebman@aol.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1131597313.14381.234.camel@localhost.localdomain>
References: <206.db80c15.30a174f6@aol.com>
	 <1131422329.14381.157.camel@localhost.localdomain>
	 <1131597313.14381.234.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 10 Nov 2005 23:08:08 -0500
Message-Id: <1131682088.10894.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 23:35 -0500, Steven Rostedt wrote:
> On Mon, 2005-11-07 at 22:58 -0500, Steven Rostedt wrote:
> > 
> 
> Running my logdev tools from:
> http://www.kihontech.com/logdev/logdev_tools_0.3.0.tar.bz2
> 
> ./logread /dev/logdev > 1000HZ.out  # with 1000HZ
> ./logread /dev/logdev > 100HZ.out # with 100HZ
> 
> These files can be found at:
> http://www.kihontech.com/tests/hz_times/
> 
> These show all the times that a context switch took place. This is a
> ring buffer, so it only captured the last 30 some seconds of the test.
> But that should be good enough.
> 
> with my analyze.pl script (also supplied at the website) I ran:
> 
> ./analyze.pl 1000HZ.out > 1000HZ.txt
> and again for 100HZ.
> 
> This calculates the times between the context switches and at the end
> produces an average.
> 
> (all times are in seconds)
> 
> For 100HZ:
> 
> [54543.530810] CPU:0 (testme:2539) -->> (find:2550)
>   diff: 0.000213
> [54543.546730] CPU:0 (find:2550) -->> (testme:2539)
>   diff: 0.015920
> count: 28974  total: 38.384180
> average: 0.001325

The above 100HZ test is invalid.  As shown in the times, it was run
after 54000 some seconds, which means that the file system was probably
already cached.  So I did fresh reboots and ran the test shortly after
bootup. 

The test results are again at http://www.kihontech.com/tests/hz_times/
but they are all with a *_2.* in the name.

Here are the times that were run for each test (100HZ vs 1000HZ and
preempt vs nopreempt).

1000HZ preempt:
Thu Nov 10 18:05:11 EST 2005
Thu Nov 10 18:13:01 EST 2005

real    7m49.741s
user    0m46.464s
sys     4m41.524s


1000HZ nopreempt:
Thu Nov 10 22:17:33 EST 2005
Thu Nov 10 22:25:15 EST 2005

real    7m42.339s
user    0m47.156s
sys     4m33.205s


100HZ preempt:
# time ./testme
Thu Nov 10 17:40:29 EST 2005
Thu Nov 10 17:48:12 EST 2005

real    7m42.418s
user    0m46.190s
sys     4m40.350s


100HZ nopreempt:
Thu Nov 10 17:52:15 EST 2005
Thu Nov 10 17:59:56 EST 2005

real    7m40.976s
user    0m44.840s
sys     4m34.510s

This seems to show that 100HZ with no preemption was the fastest, but
the times are too close, so it is of a difference of ~0.2% which is well
in the margin of error.  So this test really doesn't show much benefit
between the settings.

Tomorrow, I'll see if I can make a test that serves up web pages, and
see if that will show the benefits for servers and the settings for HZ
and preemption.

-- Steve


