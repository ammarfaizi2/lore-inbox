Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265807AbUFWToO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265807AbUFWToO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 15:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266618AbUFWToO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 15:44:14 -0400
Received: from smtp2.eldosales.com ([63.78.12.18]:31241 "EHLO
	tweeter.eldosales.com") by vger.kernel.org with ESMTP
	id S265807AbUFWTni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 15:43:38 -0400
Posted-Date: Wed, 23 Jun 2004 12:43:35 -0700
Subject: Re: I/O Confirmation/Problem under 2.6/2.4
From: comsatcat <comsatcat@earthlink.net>
Reply-To: comsatcat@earthlink.net
To: linux-kernel@vger.kernel.org
In-Reply-To: <E1BdCmu-0000s6-00@calista.eckenfels.6bone.ka-ip.net>
References: <E1BdCmu-0000s6-00@calista.eckenfels.6bone.ka-ip.net>
Content-Type: text/plain
Message-Id: <1088019818.1614.33.camel@solaris.skunkware.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 23 Jun 2004 12:43:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is that peak or saturated load? you may want to try to only fill the write
> back cache of the controller, to not get affected by slow raidness or disks.
> 
Saturated, just doing a simple dd out to a 2gig file.

> The raid5 is not very good in speeding up random reads or sequential writes.
> Perhaps you want to try stripping on level 0.
> 
We need the data integrity and the storage so 0/1 isn't an option and 0
definantly isn't.

> What is the IO Bus you are talking about? Single PCI Bus?

PCI-x 133MHz (card is running at 66MHz).


> Have you tried an alternative operating system?
> 
I've tried Red Hat AS 3 and Gentoo 2004.1


> You may want to try it without a filesystem and perhaps even with a faster
> raid configuration like stripping.
> 
Have actually done both for tests.  writing to the device w/o FS returns
about the same rate.  Raid 0 is a bit faster then 5, but not by more
then a couple of MB.


> how does your vmstat and iostat look like? How many ram and cpu you are
> talking about? is it an smp kernel?
> 
Ram is 2GB, CPU is Dual 3.2GHz Xeons hyperthread (thus 4 cpu's to OS),
smp is enabled.  iostat is very spotty, here is output from iostat:

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s
avgrq-sz avgqu-sz   await  svctm  %util
rd/c0d0      0.00 84389.83  0.00  0.00    0.00 680576.27     0.00
340288.14     0.00   760.19    0.00   0.00 102.54
rd/c0d0      0.00   0.00  0.00  0.00    0.00    0.00     0.00    
0.00     0.00 31860.75    0.00   0.00  96.34
rd/c0d0      0.00 38713.00  0.00  0.00    0.00 312152.00     0.00
156076.00     0.00 29827.95    0.00   0.00 100.00
rd/c0d0      0.00 11048.00  0.00  0.00    0.00 89088.00     0.00
44544.00     0.00 13318.73    0.00   0.00 100.00
rd/c0d0      0.00 12948.00  0.00  0.00    0.00 104448.00     0.00
52224.00     0.00 13405.94    0.00   0.00 100.00
rd/c0d0      0.00 9344.00  0.00  0.00    0.00 75360.00     0.00
37680.00     0.00 13488.18    0.00   0.00 100.00
rd/c0d0      0.00 9178.00  0.00  0.00    0.00 74032.00     0.00
37016.00     0.00 29379.11    0.00   0.00 100.00
rd/c0d0      0.00 12962.00  0.00  0.00    0.00 104560.00     0.00
52280.00     0.00 13653.53    0.00   0.00 100.00
rd/c0d0      0.00 9363.00  0.00  0.00    0.00 75512.00     0.00
37756.00     0.00 13737.13    0.00   0.00 100.00
rd/c0d0      0.00 11321.00  0.00  0.00    0.00 91288.00     0.00
45644.00     0.00 29128.95    0.00   0.00 100.00
rd/c0d0      0.00 9902.00  0.00  0.00    0.00 79872.00     0.00
39936.00     0.00 13901.66    0.00   0.00 100.00
rd/c0d0      0.00 10140.00  0.00  0.00    0.00 81784.00     0.00
40892.00     0.00 13984.07    0.00   0.00 100.00
rd/c0d0      0.00 8773.00  0.00  0.00    0.00 70768.00     0.00
35384.00     0.00 28883.74    0.00   0.00 100.00
rd/c0d0      0.00 13709.00  0.00  0.00    0.00 110592.00     0.00
55296.00     0.00 14150.42    0.00   0.00 100.00
rd/c0d0      0.00 10143.00  0.00  0.00    0.00 81808.00     0.00
40904.00     0.00 14240.10    0.00   0.00 100.00
rd/c0d0      0.00 11047.00  0.00  0.00    0.00 89088.00     0.00
44544.00     0.00 28629.28    0.00   0.00 100.00
rd/c0d0      0.00 10790.00  0.00  0.00    0.00 87040.00     0.00
43520.00     0.00 14403.05    0.00   0.00 100.00


And here is vmstat output:

procs                      memory      swap          io    
system         cpu

 1  1      0 833460  33768 595768    0    0     0 459360  160   371  0
51 49  0
 0  3      0 668604  33928 759864    0    0     0 35196  140    31  0 30
10 60
 1  2      0 611132  33980 813932    0    0     0 54944  160    48  0
13  3 84
 0  3      0 568668  34016 851236    0    0     0 43520  143    54  0 
7  0 93
 0  3      0 534652  34056 888740    0    0     0 40448  145    60  0 
7  0 93
 1  2      0 473476  34096 933548    0    0     0 56320  145    73  0 
9  0 91
 0  3      0 445868  34132 970332    0    0     0 32256  139    56  0 
6  0 94
 0  3      0 396756  34176 1015048    0    0     0 43520  142    60  0 
8  0 92
 0  3      0 352124  34220 1059988    0    0     0 44700  145    54  0 
9  0 91
 2  1      0 308348  34264 1101852    0    0     0 50140  139    70  0 
8  0 92
 0  3      0 253488  34312 1153080    0    0     0 42272  140    63  0
10  0 90
 0  3      0 228168  34344 1185468    0    0     0 31848  142    54  0 
6  0 94
 0  3      0 190080  34384 1225076    0    0     0 40856  140    57  0 
8  0 92
 1  2      0 130820  34428 1271444    0    0     0 55912  138    71  0 
9  0 91
 0  3      0  90352  34468 1313104    0    0     0 35328  140    57  0
11  2 88
 1  2      0  65652  34540 1375600    0    0     0 47772  146    61  0
10  0 90
 0  4      0  58060  34580 1416852    0    0     0 37280  142    41  0 
9  0 91
 0  4      0 100292  34580 1416852    0    0     0 36496  139    57  0 
1  0 98
 0  3      0 145160  34580 1416852    0    0     0 55248  141    18  0 
1 49 50
 0  3      0 187804  34580 1416852    0    0     0 40960  143    14  0 
1 50 49


Thanks,
Ben

