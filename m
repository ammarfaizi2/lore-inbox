Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278903AbRJVUna>; Mon, 22 Oct 2001 16:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278902AbRJVUnU>; Mon, 22 Oct 2001 16:43:20 -0400
Received: from mail1.home.nl ([213.51.129.225]:18885 "EHLO mail1.home.nl")
	by vger.kernel.org with ESMTP id <S278882AbRJVUmE>;
	Mon, 22 Oct 2001 16:42:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: elko <elko@home.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] updated preempt-kernel
Date: Mon, 22 Oct 2001 22:43:17 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <1003562833.862.65.camel@phantasy> <01102014441400.00692@ElkOS>
In-Reply-To: <01102014441400.00692@ElkOS>
X-Owner: ElkOS
MIME-Version: 1.0
Message-Id: <0110222243171D.05096@ElkOS>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 October 2001 14:44, elko wrote:
> On Saturday 20 October 2001 09:27, Robert Love wrote:
> > Testers Wanted:
--[snip]--
> Any other testing you can think of ??

Some more tests with 2.4.12-ac3-vmpatch-freeswap-preempt:

I started the following command:
$> tree -d / 

The first time, this went really quick, the second time though,
the system would freeze every now and then, output to the konsole
(kde) stopped for a moment; I could hear /dev/hda spinning like
crazy (and making some grinding sounds; very desperate; old disk?).

I let this finish, everything OK.

Now I started this command from my $HOME (3,7G; 81947 files):
$> find . | xargs slocate | sort | uniq -c | head -1

Useless I know, but it can make your system scream ;)


This is some info on the system:
--[snip]--
[elko@ElkOS elko]$ dmesg | egrep "clock |Mem"
Memory: 577440k/589824k available \
(1177k kernel code, 12000k reserved, \
347k data, 236k init, 0k highmem)
..... CPU clock speed is 852.0020 MHz.
..... host bus clock speed is 100.2353 MHz.

[elko@ElkOS elko]$ df
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda1             387M   79M  288M  22% /
/dev/hda5             387M   35M  332M  10% /tmp
/dev/hda6             387M  122M  245M  33% /var
/dev/hda8             2.7G  1.4G  1.1G  55% /usr
/dev/hdc1              19G   10G  7.7G  57% /home
/dev/hdd6             3.2G  1.2G  1.9G  39% /mnt/lfs
 
[elko@ElkOS elko]$ cat /proc/swaps
Filename                        Type            Size    Used    Priority
/dev/hda7                       partition       104380  104380  -1
/dev/hdd5                       partition       1465592 473372  -2
--[snip]--


First, it's a bit jumpy:
--[snip]--
[elko@ElkOS elko]$ free -m
             total       used       free     shared    buffers     cached
Mem:           564        561          2          0          0         14
-/+ buffers/cache:        545         18
Swap:         1533        492       1040

[elko@ElkOS elko]$ free -m
             total       used       free     shared    buffers     cached
Mem:           564        140        423          0          0         14
-/+ buffers/cache:        126        438
Swap:         1533         85       1448

[elko@ElkOS elko]$ free -m
             total       used       free     shared    buffers     cached
Mem:           564        561          2          0          0         11
-/+ buffers/cache:        549         14
Swap:         1533        500       1032
--[snip]--


There's some nice *idle* time that top reports:
--[snip]--
[elko@ElkOS elko]$ top
  9:48pm  up 1 day,  5:27,  3 users,  load average: 4.20, 4.24, 3.46
103 processes: 96 sleeping, 7 running, 0 zombie, 0 stopped
CPU states: 36.8% user, 39.8% system, 23.4% nice, 847133.3% idle
Mem:  577676K av, 574612K used,   3064K free,      0K shrd,    576K buff
Swap: 1569972K av, 1158692K used, 411280K free                 12476K 
cached
 
  PID USER PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
23732 elko 20   0 1354M 308M   532 R    307M 40.3 54.6   1:43 slocate
  991 elko 20  15 15080  13M   672 R N     0 25.9  2.4 771:52 setiathome 
992 elko   18  16 15208  13M   772 R N     0 13.1  2.4 771:39 setiathome
    5 root 20   0     0    0     0 RW      0  9.8  0.0   0:33 kswapd
  899 elko 11   0  2752 2000  1412 S       0  6.8  0.3 117:54 gkrellm
23756 elko 15   0  1468 1468  1224 R       0  1.5  0.2   0:00 top
  800 root  9   0 48584 4132  3100 R       0  1.1  0.7  16:43 X
--[snip]--


And again:
--[snip]--
10:09pm  up 1 day,  5:48,  3 users,  load average: 4.04, 3.33, 3.11
103 processes: 99 sleeping, 4 running, 0 zombie, 0 stopped
CPU states: 47.1% user, 17.6% system, 35.4% nice, 850488.3% idle
--[snip]--


I stopped the test here:
--[snip]--
[elko@ElkOS elko]$ free -m
             total       used       free     shared    buffers     cached
Mem:           564        561          2          0          0         13
-/+ buffers/cache:        547         16
Swap:         1533       1177        355
--[snip]--


1 eyeblink later:
--[snip]--
[elko@ElkOS elko]$ free -m
             total       used       free     shared    buffers     cached
Mem:           564         74        489          0          0         12
-/+ buffers/cache:         61        503
Swap:         1533         83       1449
--[snip]--


So it seems that a lot of swap is perfectly released
the instant it isn't needed anymore (not everything,
since I started with (almost) no swap used in the first
place).

What I can report further, is that keyboard/mouse response
(^C in konsole) would sometimes not react, but 3 to 5 seconds
later, the action would be taken (^C, move mouse):

I'm running the same test now, and I'm seeing the same results,
system freezes (while I'm typing this), and a few seonds later,
response is back, and swap drops down to ~zero, keystrokes are
cached correctly though, just had another freeze, kept typing..
.. .. and here are my characters :^) and swap is freed again:
--[snip]--
[elko@ElkOS elko]$ free -m
             total       used       free     shared    buffers     cached
Mem:           564        462        101          0          0         12
-/+ buffers/cache:        450        113
Swap:         1533         85       1447
--[snip]--


This is nice to see happening when things slow down:
--[snip]--
[elko@ElkOS elko]$ free -m
             total       used       free     shared    buffers     cached
Mem:           564        561          2          0          0         12
-/+ buffers/cache:        547         16
 
[elko@ElkOS elko]$ free -m
             total       used       free     shared    buffers     cached
Mem:           564         82        481          0          0         13
-/+ buffers/cache:         68        495
Swap:         1533         81       1451
--[snip]--


My current conclusion: this combination of kernel and patches
is the  most responsive I've ever used, normally, when I run
these command's, my systems would freeze to the point I had
to give them the VNP.


I'll kick it some more though ;/

-- 
ElkOS: 10:39pm up 1 day, 6:18, 3 users, load average: 2.27, 2.67, 3.14
bofhX: Mailer-daemon is busy burning your message in hell.

