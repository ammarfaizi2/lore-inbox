Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbTFYU0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbTFYU0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:26:52 -0400
Received: from h24-70-162-27.wp.shawcable.net ([24.70.162.27]:5570 "EHLO ubb")
	by vger.kernel.org with ESMTP id S265054AbTFYU0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:26:37 -0400
Message-Id: <v04003a44bb1fb082955b@[192.168.1.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Organisation: Judean People's Front; Department of Whips, Chains, Thumb-Screws, Six Tons of Whipping Cream, the Entire Soprano Section of the Mormon Tabernacle Choir and Guest Apperances of Eva Peron aka Eric Conspiracy Secret Laboratories
X-Disclaimer-1: This message has been edited from it's original form by members of the Eric Conspiracy.
X-Disclaimer-2: There is no Eric Conspiracy.
X-Not-For-Humans: aardvark@apia.dhs.org and zebra@apia.dhs.org are spamtraps.
Date: Wed, 25 Jun 2003 15:40:34 -0500
To: linux-kernel@vger.kernel.org
From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
Subject: Disk performance irregularity in 2.4.x
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello *,

I've been running 2.4.18 and 2.4.20 for a while on my server, and I've been
noticing a performance irregularity during read/write disk activity.

Usually the trigger is nothing more than reading and writing a constant
average of, say, 30-60K/s to disk. This will go normally most of the time,
but then, seemingly randomly, the machine will start writing to the disk at
a solid 0.5-1.0MB/s for 5 to 10 seconds while apparently not allowing any
other IO to take place (for example, my mp3s - playing on another machine
reading from the server via nfs - will stop playing for the duration of the
writeout). It can also be triggered more frequently by higher volume
read/writes (such as CVS activity).

I managed to catch one of these episodes in a vmstat trace just now during
some CVS activity. The first page is the base-level activity (1 second
intervals), then on the second page you can see the CVS activity starting
as the system starts reading from the disk. At about the bottom 1/3rd of
the second page the blackout starts as the kernel starts single-mindedly
writing data to disk, then on the 3rd page you can see where the normal CVS
activity resumes.

I am puzzled as to what is causing this, is it just bdflush tuning? Or is
something more bizzare going on? If it is bdflush tuning, what values do I
want to change?

Also, I have no idea where those 60000 extra context switches came from.

The main system drive is an IBM DeathStar 75GXP 60G wired up to the Promise
PCI card.


procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  82056   4416  52108 163596    0    0     0     0  230   293 11 14 75  0
 0  0  82056   4424  52108 163596    0    0     0     0  211   267 11 11 78  0
 0  0  82056   4416  52108 163596    0    0     0     0  313   303 27  8 65  0
 0  0  82056   4400  52124 163596    0    0     0    44  253   296 20 11 69  0
 1  0  82056   4416  52108 163612    0    0   128     0  235   275 16  7 77  0
 0  0  82056   4400  52108 163612    0    0     0     0  280   293 22 11 67  0
 0  0  82056   4408  52108 163612    0    0     0     0  218   267 12 10 78  0
 1  0  82056   4392  52124 163612    0    0     0    44  222   284  8 14 78  0
 0  0  82056   4392  52124 163612    0    0     0     0  293   317 23  9 68  0
 0  0  82056   4376  52104 163652    0    0   128     0  221   273 15 10 75  0
 0  0  82056   4376  52104 163652    0    0     0     0  282   290 25 12 63  0
 0  0  82056   4348  52132 163652    0    0     4    56  248   297 20 10 70  0
 0  0  82056   4476  52132 163524    0    0     0     0  306   291 20 14 66  0
 0  0  82056   4484  52132 163524    0    0     0     0  276   261 25 10 66  0
 0  0  82056   4864  52080 163192    0    0     0     0  323   335 26 12 62  0
 0  0  82056   4736  52080 163320    0    0   128     0  207   299  8 12 80  0
 2  0  82056   4688  52116 163320    0    0     4   210  524   407 32 19 49  0
 0  0  82056   4696  52116 163320    0    0     0     0  234   296 12 12 76  0
 2  0  82056   4572  52116 163448    0    0   128     0  232   301 19 10 70  0
 2  0  82056   4400  52080 163484    0    0   384     0  235   312 59 15 26  0
 1  0  82056   4832  52028 163308    0    0     0   189  351   338 30 19 52  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  82056   4824  52028 163308    0    0     0     0  230   276 15 10 75  0
 1  0  82056   4824  52028 163308    0    0     0     0  212   278 11 10 78  0
 3  0  82056   4828  52028 163308    0    0     0     0  310   294 29 11 60  0
 0  0  82056   4372  52068 163624    0    0   326   168  248   308 12 11 76  0
 0  0  82056   4472  52116 163296    0    0   104     0  267   373 21 12 67  0
 2  1  82056   4364  52156 163152    0    0   404     0  383   433 50 25 24  0
 6  0  82056   4476  52344 162428    0    0   440     0  430   497 61 31  8  0
 1  1  82056   4468  52432 162252    0   12   352  1047 1748   903 63 34  3  0
 3  1  82056   4380  52448 162320    0  128   540   128  337   452 68 26  6  0
 1  1  82056   4456  52752 162320    0  120   320   120  372   512 35 21 44  0
 3  1  82056   4452  52920 162096    0    4   300     4  380   473 41 23 36  0
 0  1  82056   4404  53204 161732    0    0   396  1556  381   453 29 25 45  0
 3  0  82056   4356  53492 160876    0    0   328     0  379   482 25 35 40  0
 2  1  82056   4412  53668 160352    0    0   292     0  419   524 33 25 42  0
 1  1  82056   4420  53868 159744    0    0   232     0  346   413 29 33 38  0
 1  3  82056   4408  54196 159256    0    0   312  2636  478   493 22 25 52  0
 0  2  82056   4400  54148 159308    0    0   132  1644  451   331 24 11 64  0
 1  1  82056   4428  54148 159308    0    0   128   964  414   316 11 15 74  0
 3  1  82056   4424  54108 159352    0    0   260   716  373   348 27 12 61  0
 1  2  82056   4400  54132 159352    0    0     0  1480  401   331 45 12 43  0
 1  2  82056   4392  54068 159416    0    0   128  1452  427   311 12 13 75  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  1  82056   4388  54068 159416    0    0     0  1060  533   391 25 16 59  0
 0  2  82056   4384  54068 159416    0    0     0   820  383   304 11 12 77  0
 0  4  82056   4392  54056 159432    0    0   256   632  328   296  8 12 80  0
 0  5  82056   4384  54060 159432    0    0     0   644  291   283  6 10 84  0
 4  3  82056   4388  54064 159432    0    0     0   604  741 36406 23 20 57  0
 5  1  82056   4472  54380 158804    0    0   700    32 1979 27335 58 42  0  0
 1  1  82056   4468  54644 158396    0    0   348   324  638   683 46 26 28  0
 1  1  82056   4408  54884 157908    0    0   372     0  412   559 26 24 50  0
 1  1  82056   4436  55204 157204    0    0   384     0  360   495 21 27 52  0
 2  1  82056   4432  55436 156728    0    0   524     0  435   553 32 30 39  0
 0  1  82056   4460  55764 155792    0    0   380   884  396   533 21 27 52  0

ubb:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 233.856
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 466.94

ubb:~$ lspci
00:00.0 Host bridge: ALi Corporation M1541 (rev 04)
00:01.0 PCI bridge: ALi Corporation M1541 PCI to AGP Controller (rev 04)
00:03.0 Bridge: ALi Corporation M7101 PMU
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
(rev c3
)
00:09.0 SCSI storage controller: Adaptec AHA-2940/2940W / AIC-7871
00:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 6c)
00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20267
(rev 02)
00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c1)
01:00.0 VGA compatible controller: Trident Microsystems 3DImage 9750 (rev f3)

ubb:~$ uname -a
Linux ubb 2.4.20 #3 Sat May 17 22:57:31 CDT 2003 i586 GNU/Linux

ubb:~$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  329609216 324751360  4857856        0 52637696 178589696
Swap: 262168576 84054016 178114560
MemTotal:       321884 kB
MemFree:          4744 kB
MemShared:           0 kB
Buffers:         51404 kB
Cached:         159960 kB
SwapCached:      14444 kB
Active:          93736 kB
Inactive:       188572 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       321884 kB
LowFree:          4744 kB
SwapTotal:      256024 kB
SwapFree:       173940 kB

ubb:~$ cat /proc/sys/vm/bdflush
30      500     0       0       500     3000    60      20      0

ubb:~$ mount
/dev/hda1 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda5 on /var type ext3 (rw,errors=remount-ro)
/dev/hda6 on /usr type ext3 (rw,errors=remount-ro)
/dev/hda7 on /home type ext3 (rw,errors=remount-ro)

ubb:~$ hdparm -Tt /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  4.04 seconds = 31.68 MB/sec
 Timing buffered disk reads:  64 MB in  5.47 seconds = 11.70 MB/sec



Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


