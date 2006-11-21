Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966410AbWKULWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966410AbWKULWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 06:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966961AbWKULWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 06:22:15 -0500
Received: from pascal-2.arago.de ([194.153.130.10]:54446 "EHLO mail.arago.de")
	by vger.kernel.org with ESMTP id S966410AbWKULWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 06:22:14 -0500
Date: Tue, 21 Nov 2006 12:22:09 +0100
From: Vassilios Kotoulas <willy@arago.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 46/61] fix Intel RNG detection
Message-ID: <20061121122209.N5023944@ohm.arago.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Dave Jones (davej@xxxxxxxxxx) wrote:
>> Since I pushed an update to our Fedora users based on 2.6.18.2, a few people
>> have reported they no longer have their RNG's detected.
>> Here's one report: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=215144

> Hmm, I wonder if the report is valid? Jan's patch would have the correct
> side effect of disabling false positives (for RNG identification).
> Be good to check that it actually used to work.
>
> Having said that, Jan the datasheet recommendation is looser than your
> implementation. It only recommends checking for manufacturer code,
> you check device code as well. Do you know of any scenarios where that
> would matter (I can't conceive of any)?

Hi,

sorry for the broken threading, I read this in the archives.

My RNG worked with the older kernel 2.6.18-1.2200.fc5
I booted this kernel and made the following tests:

hexdump -v /dev/hw_random

here is the beginning of the output:

0000000 a7ff 1dff b312 0be0 64c9 8f83 9082 7d94
0000010 ac03 c513 ac1b b502 b93e 8f34 1a05 d417
0000020 b9cc c5d5 345f e6f6 d84b 333c c156 9007
0000030 0539 b145 7fdc 071b ea10 9145 c395 5536
0000040 7942 f8a2 f07d a5ea 2c76 a934 742c 1288
0000050 925a f710 67e6 8f68 ece2 bb23 536d bebe
0000060 1ad3 ab94 ab7b 54c9 8ce3 adaa 7f79 edd7
0000070 4c5b 0a28 66ee bc8d 90ae 0515 353e dcf5

These Numbers seem random to me :)

rngtest produces the following output:

[root@kra:~] rngtest -t1 </dev/hw_random 
rngtest 2
Copyright (c) 2004 by Henrique de Moraes Holschuh
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

rngtest: starting FIPS tests...
rngtest: bits received from input: 60032
rngtest: FIPS 140-2 successes: 3
rngtest: FIPS 140-2 failures: 0
rngtest: FIPS 140-2(2001-10-10) Monobit: 0
rngtest: FIPS 140-2(2001-10-10) Poker: 0
rngtest: FIPS 140-2(2001-10-10) Runs: 0
rngtest: FIPS 140-2(2001-10-10) Long run: 0
rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
rngtest: input channel speed: (min=44.617; avg=48.397; max=51.079)Kibits/s
rngtest: FIPS tests speed: (min=62.129; avg=62.536; max=62.949)Mibits/s
rngtest: Program run time: 1211852 microseconds
rngtest: bits received from input: 120032
rngtest: FIPS 140-2 successes: 6
rngtest: FIPS 140-2 failures: 0
rngtest: FIPS 140-2(2001-10-10) Monobit: 0
rngtest: FIPS 140-2(2001-10-10) Poker: 0
rngtest: FIPS 140-2(2001-10-10) Runs: 0
rngtest: FIPS 140-2(2001-10-10) Long run: 0
rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
rngtest: input channel speed: (min=44.307; avg=46.440; max=51.079)Kibits/s
rngtest: FIPS tests speed: (min=59.980; avg=61.627; max=62.949)Mibits/s
rngtest: Program run time: 2525610 microseconds

I also updated the bugzilla report with these tests.
