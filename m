Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTKAJPN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 04:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbTKAJPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 04:15:13 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:7108 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S263732AbTKAJPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 04:15:04 -0500
From: age <ahuisman@cistron.nl>
Subject: Re: READAHEAD
Date: Sat, 01 Nov 2003 10:15:28 +0100
Organization: Cistron
Message-ID: <bnvtim$pi$1@news.cistron.nl>
References: <bnrdqi$uho$1@news.cistron.nl>	<20031030134407.0c97c86e.akpm@osdl.org>	<3FA25377.3050207@cistron.nl>	<20031031012846.48fa233c.akpm@osdl.org> <20031031012946.3adedc14.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: ncc1701.cistron.net 1067678102 818 62.216.17.166 (1 Nov 2003 09:15:02 GMT)
X-Complaints-To: abuse@cistron.nl
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> 
>>Please, just use time, cat, dd, etc.
>>
>> 	mount /dev/xxx /mnt/yyy
>> 	dd if=/dev/zero of=/mnt/yyy/x bs=1M count=1024
>> 	umount /dev/xxx
>> 	mount /dev/xxx /mnt/yyy
>> 	time cat /mnt/yyy/x > /dev/null
> 
> 
> And you can do the same against /dev/hdaN if you have a scratch
> partition; that would be interesting.


Hi Andrew,

Here are the new test results.


hdparm -a0
Timing buffered disk reads:   52 MB in  3.07 seconds =  16.94 MB/sec

wuuk:~# dd if=/dev/zero of=/home/test/test bs=1M count=34000
34000+0 records in
34000+0 records out
35651584000 bytes transferred in 922.018299 seconds (38666894 bytes/sec)

wuuk:~# time cat /home/test/test > /dev/null

real    33m21.785s
user    0m19.263s
sys     16m31.853s
wuuk:~# time rm /home/test/test

real    1m35.676s
user    0m0.001s
sys     0m6.679s

hdparm -a16
Timing buffered disk reads:  120 MB in  3.05 seconds =  39.39 MB/sec

wuuk:~# dd if=/dev/zero of=/home/test/test bs=1M count=34000
34000+0 records in
34000+0 records out
35651584000 bytes transferred in 920.669609 seconds (38723537 bytes/sec)

wuuk:~# time cat /home/test/test > /dev/null

real    22m4.180s
user    0m18.464s
sys     10m42.722s
wuuk:~# time rm /home/test/test

real    1m35.642s
user    0m0.003s
sys     0m6.635s

hdparm -a256
Timing buffered disk reads:  134 MB in  3.00 seconds =  44.61 MB/sec

wuuk:~# dd if=/dev/zero of=/home/test/test bs=1M count=34000
34000+0 records in
34000+0 records out
35651584000 bytes transferred in 920.412114 seconds (38734371 bytes/sec)

wuuk:~# time cat /home/test/test > /dev/null

real    13m24.228s
user    0m10.306s
sys     3m3.256s
wuuk:~# time rm /home/test/test

real    1m35.900s
user    0m0.002s
sys     0m6.695s

hdparm -a4096
Timing buffered disk reads:  168 MB in  3.01 seconds =  55.82 MB/sec

wuuk:~# dd if=/dev/zero of=/home/test/test bs=1M count=34000
34000+0 records in
34000+0 records out
35651584000 bytes transferred in 920.198902 seconds (38743346 bytes/sec)

wuuk:~# time cat /home/test/test > /dev/null

real    15m25.848s
user    0m10.716s
sys     3m5.103s
wuuk:~# time rm /home/test/test

real    1m36.205s
user    0m0.003s
sys     0m6.743s

I think you were right  :-)

groetjes,

Age Huisman













