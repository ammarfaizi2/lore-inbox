Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275301AbRJUCdu>; Sat, 20 Oct 2001 22:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275398AbRJUCdl>; Sat, 20 Oct 2001 22:33:41 -0400
Received: from web20707.mail.yahoo.com ([216.136.226.180]:55057 "HELO
	web20707.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S275301AbRJUCd2>; Sat, 20 Oct 2001 22:33:28 -0400
Message-ID: <20011021023402.77126.qmail@web20707.mail.yahoo.com>
Date: Sat, 20 Oct 2001 19:34:02 -0700 (PDT)
From: D Campbell <dcampbel_slo@yahoo.com>
Subject: kswapd is CPU-hungry (kernel 2.4.2-2)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

after searching the archives i'm still a bit concerned
about the CPU usage of kswapd on a machine with lots of memory.

summary:  
kswapd at 66% CPU.  1G RAM.  ~800M taken by ramdisks.  no swap.

hardware:  
intel PIII-833 underclocked to 650
1G physical memory

memory config:
0.750 G ramdisk, ext2fs from an image, mounted as root
   64 M additional ramdisk, ramfs, mounted as /tmp
    8 M initrd, ext2fs from image, hangs around at /initrd

this should leave about 190M for applications and OS
to play with, even when /tmp is full.  it's running 
mysqld, sshd and a few simple data aquisition apps 
that use the SQL server.  no X, no sendmail, no
development envoronment.  intuitively, should be OK.

once booted, the machine runs with no physical drives
mounted.  there is no swap partition or file.

top reports kswapd taking about 2/3 of what should be
a fully loaded system.   

 12:15am  up 1 day,  6:20,  3 users,  load average: 4.04, 3.32, 2.92
58 processes: 54 sleeping, 4 running, 0 zombie, 0 stopped
CPU states:  0.0% user, 68.5% system, 31.3% nice,  0.0% idle
Mem:  1028808K av, 946404K used, 82404K free, 0K shrd, 794432K buff
Swap:       0K av,      0K used,     0K free            38256K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    4 root       9   0     0    0     0 SW   68.4  0.0  1155m kswapd  <-- 
 1265 root      20  19   244  244   168 R N  31.4  0.0 656:51 dnetc
    1 root       8   0   108  108    36 S     0.0  0.0   0:05 init

i understand that without swapspace, all kswapd
can do is knock bits of executables out of the program
memory so they have to be read again from the ramdisk.

nice idea, but in practice it's being done much more
aggressively than this user needs.  no need to spend
so much effort on keeping 80 M of RAM always free when 
nothing is likely to ask for that much.

the same kernel running on a more modest machine with
some real swap space is fine:

30 processes: 27 sleeping, 3 running, 0 zombie, 0 stopped
CPU states:  0.1% user,  0.3% system, 99.4% nice,  0.0% idle
Mem:   126568K av, 125072K used, 1496K free, 0K shrd, 16484K buff
Swap:    1976K av,      8K used, 1968K free           55392K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
11348 root      20  19   520  520   444 R N  99.4  0.4 13820m dnetc
23571 root      11   0  1004 1004   812 R     0.5  0.7   0:00 top

has bigram/bigramdisk been addressed any differently/better
in 2.4.12 or earlier?

is there anything i can read from the machine to help show
someone familiar with the vm code where it's being goofy?

is there something i can tweak to change kswapd's goals?
/proc/sys/vm/freepages is read-only (mode 444) but the
others are tweakable.

grazzi mucho.

Duncan.  ( will search archives for replies, cc is welcome. )

__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
