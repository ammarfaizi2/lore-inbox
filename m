Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267720AbSLGF7q>; Sat, 7 Dec 2002 00:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267726AbSLGF7p>; Sat, 7 Dec 2002 00:59:45 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:17024 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267720AbSLGF7o> convert rfc822-to-8bit; Sat, 7 Dec 2002 00:59:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] max bomb segment tuning with read latency 2 patch in  contest
Date: Sat, 7 Dec 2002 17:09:48 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200212071620.05503.conman@kolivas.net> <3DF18D38.F493636C@digeo.com>
In-Reply-To: <3DF18D38.F493636C@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212071709.50023.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>Con Kolivas wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Here are some io_load contest benchmarks with 2.4.20 with the read
>> latency2 patch applied and varying the max bomb segments from 1-6 (SMP
>> used to save time!)
>>
>> io_load:
>> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>> 2.4.20 [5]              164.9   45      31      21      4.55
>> 2420rl2b1 [5]           93.5    81      18      22      2.58
>> 2420rl2b2 [5]           88.2    87      16      22      2.44
>> 2420rl2b4 [5]           87.8    84      17      22      2.42
>> 2420rl2b6 [5]           100.3   77      19      22      2.77
>
>If the SMP machine is using scsi then that tends to make the elevator
>changes less effective.  Because the disk sort-of has its own internal
>elevator which in my testing on a Fujitsu disk has the same ill-advised
>design as the kernel's elevator: it treats reads and writes in a similar
>manner.

These are ide disks, in the same format as those used in the UP machine, so it 
still should be showing the same effect? I think higher numbers in UP would 
increase the resolution more for these results - apart from that is there any 
disadvantage to doing it in SMP? If you think it's worth running them in UP 
mode I'll do that.

>
>Setting the tag depth to zero helps heaps.
>
>But as you're interested in `desktop responsiveness' you should be
>mostly testing against IDE disks.  Their behavour tends to be quite
>different.
>
>If you can turn on write caching on the SCSI disks that would change
>the picture too.
>
>> io_other:
>> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>> 2.4.20 [5]              89.6    86      17      21      2.47
>> 2420rl2b1 [3]           48.1    156     9       21      1.33
>> 2420rl2b2 [3]           50.0    149     9       21      1.38
>> 2420rl2b4 [5]           51.9    141     10      21      1.43
>> 2420rl2b6 [5]           52.1    142     9       20      1.44
>>
>> There seems to be a limit to the benefit of decreasing max bomb segments.
>> It does not seem to have a significant effect on io load on another hard
>> disk (although read latency2 is overall much better than vanilla).
>
>hm.  I'm rather surprised it made much difference at all to io_other,
>because you shouldn't have competing reads and writes against either
>disk??

Some of the partitions are mounted on that other disk as well so occasionally 
it is involved in the kernel compile.

/dev/hda8 on / type ext3 (rw)
none on /proc type proc (rw)
/dev/hda1 on /boot type ext3 (rw)
none on /dev/pts type devpts (rw,mode=0620)
/dev/hda7 on /home type ext3 (rw)
/dev/hda5 on /tmp type ext3 (rw)
/dev/hdb5 on /usr type ext3 (rw)
/dev/hdb1 on /var type ext3 (rw)

The testing is done from /dev/hda7 and io_load writes to /dev/hda7, io_other 
writes to /dev/hdb1

Unfortunately this is the way the osdl machine was set up for me. I should 
have been more specific in my requests but I didnt realise they were doing 
this. There isn't really that much spare space on the two drives to shuffle 
the partitioning around and contest can use huge amounts of space during 
testing :\

>The problem with io_other should be tickling is where `gcc' tries to
>allocate a page but ends up having to write out someone else's data,
>and gets stuck sleeping on the disk queue due to the activity of
>other processes.  (This doesn't happen much on a 4G machine, but it'll
>happen a lot on a 256M machine).
>
>But that's a write-latency problem, not a read-latency one.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE98ZCsF6dfvkL3i1gRAtAJAKCipF5dOAp2g+ICRuV4xagT/qsvZgCfWhaN
eZsoUGwt5RjlGbZJiD+nYZI=
=OVHE
-----END PGP SIGNATURE-----
