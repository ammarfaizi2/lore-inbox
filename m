Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131528AbRAHVoW>; Mon, 8 Jan 2001 16:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129573AbRAHVoM>; Mon, 8 Jan 2001 16:44:12 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:44183 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S131434AbRAHVoH>;
	Mon, 8 Jan 2001 16:44:07 -0500
Date: Mon, 8 Jan 2001 22:46:29 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.2.19pre6aa1 degraded performance for me...
Message-ID: <Pine.LNX.4.30.0101082228230.4529-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...compared to 2.2.18pre19.

I use the IDE patch for my CMD648 card, and also 0.90 RAID.

What I have now (2.2.19pre6aa1+ide-1221):
[root@iq /root]# hdparm /dev/hd[aceg]

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  1 (on)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    = 16 (on)
 geometry     = 13240/16/63, sectors = 13345920, start = 0

/dev/hdc:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  1 (on)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    = 16 (on)
 geometry     = 35324/16/63, sectors = 35606592, start = 0

/dev/hde:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  1 (on)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    = 16 (on)
 geometry     = 39560/16/63, sectors = 39876480, start = 0

/dev/hdg:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  1 (on)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    = 16 (on)
 geometry     = 39560/16/63, sectors = 39876480, start = 0

[root@iq /root]# free -o
             total       used       free     shared    buffers     cached
Mem:        392808     389948       2860          0      15732     177004
Swap:       308432          0     308432
[root@iq /root]# cat /proc/swaps
Filename                        Type            Size    Used    Priority
/dev/hda2                       partition       102812  0       0
/dev/hde2                       partition       102812  0       0
/dev/hdg2                       partition       102808  0       0
[root@iq /root]# smbstatus|grep -E '
[[:digit:]]+.[[:digit:]]+.[[:digit:]]+.[[:digit:]]+'|cut -c
30-39|sort|uniq|wc -l
     41
[root@iq /root]# ifspeed 1
1.578717MB/s 0000000000000000000000>
1.758066MB/s 0000000000000000000000000>
1.526362MB/s 000000000000000000000>
1.530314MB/s 000000000000000000000>
1.659107MB/s 00000000000000000000000>
1.722287MB/s 000000000000000000000000>
1.542517MB/s 0000000000000000000000>
1.585877MB/s 0000000000000000000000>
1.417126MB/s 00000000000000000000>
1.496284MB/s 000000000000000000000>
1.442938MB/s 00000000000000000000>
1.743159MB/s 0000000000000000000000000>
1.716102MB/s 000000000000000000000000>
1.765166MB/s 0000000000000000000000000>
1.509863MB/s 000000000000000000000>
1.638345MB/s 00000000000000000000000>
1.953884MB/s 0000000000000000000000000000>
1.723031MB/s 000000000000000000000000>
1.917233MB/s 000000000000000000000000000>
1.474753MB/s 000000000000000000000>

(I have just sent ifspeed to this list)

So sustained througput on eth0 (Digital DE500) below 2MBytes/s currently.
used to be >5MBytes/s with this many users (they are either changing and
reading dirs, or reading or writing >500MBytes files, so speed,
bandwidth, throughput would be essential)

What I had w/2.2.18pre19 (+raid+ide):
~80MB more in cache and ~80MB swapped out (eg. currently unused notes
server and squid) There is enough of swap over 3 disks (like the
raid), so I did not bother disabling squid and notes, since - I thought -
they would only take up some swap unused.

Unfortunatelly not so.

Anybody has ideas of some /proc tuning maybe able to help my situation?

( currently I use:
# Enable more files and inodes to be used
echo '65536' > /proc/sys/fs/file-max
echo '262144' > /proc/sys/fs/inode-max
echo "10240 61000" > /proc/sys/net/ipv4/ip_local_port_range
echo "134217728" > /proc/sys/kernel/shmmax
echo "300" > /proc/sys/net/ipv4/tcp_keepalive_time
)
-- 
SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
