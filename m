Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288021AbSAQBXQ>; Wed, 16 Jan 2002 20:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288047AbSAQBXL>; Wed, 16 Jan 2002 20:23:11 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:43938 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S288040AbSAQBXB>; Wed, 16 Jan 2002 20:23:01 -0500
Date: Wed, 16 Jan 2002 20:26:40 -0500
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de
Subject: Re: Rik spreading bullshit about VM
Message-ID: <20020116202640.A485@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

About running the Andrea VM in 4M:
I booted in single user mode.

bash-2.05a# uname -a
Linux mountain 2.4.18pre2aa2 #1 Wed Jan 9 21:44:03 EST 2002 i586 unknown

bash-2.05a# dmesg| grep mem
Kernel command line: BOOT_IMAGE=2418p2aa2 ro root=1602 console=ttyS1,38400n8 single mem=4m
Memory: 2100k/4096k available (891k kernel code, 1608k reserved, 215k data, 196k init, 0k highmem)
Freeing unused kernel memory: 196k freed

Manually started syslogd, klogd and brought up the lo and eth0 interfaces and started sshd.
I can ssh into the box:

mountain:/$ ps aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.4  0.0  1288    0 ?        SW   19:24   0:06 init [S]
root         2  0.0  0.0     0    0 ?        SW   19:24   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  19:24   0:00 [ksoftirqd_CPU0]
root         4  0.1  0.0     0    0 ?        SW   19:24   0:02 [kswapd]
root         5  0.0  0.0     0    0 ?        SW   19:24   0:00 [bdflush]
root         6  0.0  0.0     0    0 ?        SW   19:24   0:00 [kupdated]
root         7  0.0  0.0     0    0 ?        SW   19:24   0:00 [kreiserfsd]
root        21  0.0  0.0  1288    0 ttyS1    SW   19:25   0:00 init [S]
root        22  0.0  0.0  2212    0 ttyS1    SW   19:25   0:00 bash
root        46  0.0  0.0  1444    0 ?        SW   19:37   0:00 /usr/sbin/syslogd -m0
root        49  0.0  0.0  1292    0 ?        SW   19:38   0:00 /usr/sbin/klogd -c3 -x -k /boot/System.map-2.4.18pre2aa2
root        63  0.0  0.0     0    0 ?        SW   19:47   0:00 [eth0]
root        68  0.5  0.0  2672    0 ?        SW   19:47   0:00 sshd
root        69  0.9  0.8  2756   20 ?        D    19:48   0:00 sshd
hrandoz     70  1.9  0.0  2192    0 pts/0    SW   19:48   0:01 -bash
hrandoz     75 40.0  4.1  2504   96 pts/0    R    19:49   0:00 ps aux

mountain:/$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:   2351104  2232320   118784        0   344064   249856
Swap: 156270592  1409024 154861568
MemTotal:         2296 kB
MemFree:           116 kB
MemShared:           0 kB
Buffers:           336 kB
Cached:            204 kB
SwapCached:         40 kB
Active:             68 kB
Inactive:          516 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:         2296 kB
LowFree:           116 kB
SwapTotal:      152608 kB
SwapFree:       151232 kB

hrandoz@mountain:/$ /sbin/swapon -s
Filename                        Type            Size    Used    Priority
/dev/hda3                       partition       152608  1372    -1


top:
  7:55pm  up 31 min,  1 user,  load average: 1.30, 0.71, 0.32
16 processes: 15 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:  0.1% user,  4.6% system,  0.0% nice, 95.1% idle
Mem:     2296K av,    2096K used,     200K free,       0K shrd,     316K buff
Swap:  152608K av,    1488K used,  151120K free                      96K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
   79 hrandoz   14   0   316  200   184 R     2.0  8.7   0:02 top
   69 root      18   0   352    0     0 SW    1.9  0.0   0:03 sshd
    1 root      20   0    56    0     0 SW    0.0  0.0   0:06 init
    2 root      20   0     0    0     0 SW    0.0  0.0   0:00 keventd
    3 root      20  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU0
    4 root      20   0     0    0     0 SW    0.0  0.0   0:03 kswapd
    5 root       3   0     0    0     0 SW    0.0  0.0   0:00 bdflush
    6 root      20   0     0    0     0 SW    0.0  0.0   0:00 kupdated
    7 root      20   0     0    0     0 SW    0.0  0.0   0:00 kreiserfsd
   21 root       9   0    56    0     0 SW    0.0  0.0   0:00 init
   22 root      20   0   296    0     0 SW    0.0  0.0   0:00 bash
   46 root      20   0   108    0     0 SW    0.0  0.0   0:00 syslogd
   49 root      20   0    72    0     0 SW    0.0  0.0   0:00 klogd
   63 root      20   0     0    0     0 SW    0.0  0.0   0:00 eth0
   68 root      20   0   276    0     0 SW    0.0  0.0   0:00 sshd
   70 hrandoz   20   0   276    0     0 SW    0.0  0.0   0:01 bash

bash-2.05a# df -kT
Filesystem    Type   1k-blocks      Used Available Use% Mounted on
/dev/hdc2 reiserfs     9768728   4194328   5574400  43% /
/dev/hdc3     ext2     8064432      4912   7649872   1% /opt/testing


Running 4M is interesting.  If I really wanted to run 4M, I'd use ash 
for the shell, and try uClibc instead of glibc. 

The test that really impresses me the most about 2.4.18pre2aa2 is what
I see on this test on an Athlon 1333 with 1024MB RAM:

simultaneously:
run continuous loop of mtest01 -p 85 -w  # allocate and write to 85% of VM
create and cpio 10 330 MB files
nice -19 setiathome &
listen to mp3blaster		# a few skips at the beginning, then smooth.

I've tested a bunch of kernels lately.  This is only what's sitting in /boot
since I last cleaned it out:

mountain:/boot$ ls vml*
vmlinuz                  vmlinuz-2.4.17rc2aa2-old  vmlinuz-2.4.18-pre3         
vmlinuz-2.4.18pre2       vmlinuz-2.4.18pre3ll      vmlinuz-2.5.1-dj11  
vmlinuz-2.5.2-pre10      vmlinuz-2.5.2-pre9        vmlinuz-2.4.17
vmlinuz-2.4.17rc2aa2-wli vmlinuz-2.4.18-pre4       vmlinuz-2.4.18pre2aa1
vmlinuz-2.4.18pre3pe     vmlinuz-2.5.1-dj13        vmlinuz-2.5.2-pre11
vmlinuz-2.5.2-pre9mingo  vmlinuz-2.4.17-rmap11a    vmlinuz-2.4.17rmap11b
vmlinuz-2.4.18pre1-mjc2nio vmlinuz-2.4.18pre2aa2   vmlinuz-2.4.18pre3pelb
vmlinuz-2.5.1-dj14       vmlinuz-2.5.2-pre5        vmlinuz.old
vmlinuz-2.4.17rc2aa2    vmlinuz-2.4.18-pre1        vmlinuz-2.4.18pre1mjc2
vmlinuz-2.4.18pre3-ac2  vmlinuz-2.5.1              vmlinuz-2.5.2
vmlinuz-2.5.2-pre6-mingo

IMHO, 2.4.18pre2aa2 is the best!

Some kernel test results at:
http://home.earthlink.net/~rwhron/kernel/k6-2-475.html

# from the 4M box
mountain:/boot$ uptime
  8:24pm  up   1:00,  1 user,  load average: 0.08, 0.04, 0.09

-- 
Randy Hron

