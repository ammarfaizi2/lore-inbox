Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUDBVyc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 16:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbUDBVyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 16:54:32 -0500
Received: from webmail.sub.ru ([213.247.139.22]:18696 "HELO techno.sub.ru")
	by vger.kernel.org with SMTP id S261162AbUDBVy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 16:54:28 -0500
Subject: 2.6.4 : 100% CPU use on EIDE disk operarion, VIA chipset
From: Mikhail Ramendik <mr@ramendik.ru>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1080942861.1418.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-6aspMR) 
Date: Sat, 03 Apr 2004 01:54:22 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have an computer with an AMD Duron, and the motehrboard chipset is VIA
KT133. The hard drive is a Seagate Barracuda 7200.7 ; no other EIDE
devices are attached.

I run an RH9-based distro, and added a 2.6.4 kernel to it. The following
problem was tested with two kernel variants: 2.6.4+wolk2/0 with
preeemption enabled, and 2.6.4 plain from kernel.org with preemption
disabled. No difference.

I noticed performance problems with 2.6.4, and tracked them to strange
HDD behavior.

It turned out that on disk-intensive operation, the "system" CPU usage
skyrockets. With a mere "cp" of a large file to the same direstory
(tested with ext3fs and FAT32 file systems), it is 100% practically all
of the time !

On stock distro kernel (2.4.20) the CPU load in the same situation
varies from 0 to 15-20% with small peaks to about 40%.

"cp" actually takes less time on 2.6.4 (with a file of the same size).
However the CPU load is scary, and I suspect that it adversely affects
overall performance.

Besides, with default settings, the results of "hdparm -tT /dev/hda0"
are substandard on 2.6.4. The "Timing buffered disk reads" averages
about 38 MB/sec on 2.4.20, about 27 MB/sec on 2.6.4.

This changes after I set large read ahead: "hdparm -a8192 /dev/hda0" .
"Timing buffered disk reads" becomes about 45 MB/s. But the CPU load
does not change. The "cp" performance (time to copy a large file) also
does not change noticeably.

IANAKH (I am Not A Kernel Hacker), but I like kernel 2.6.x and would be
willing to run tests, and try various builds, to help pinpoint any
problem.

Here is some output that may be relevant:

# cat /proc/ide/via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.38
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
Highest DMA rate:                   UDMA66
BM-DMA base:                        0xd000
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       PIO       PIO
Address Setup:       30ns     120ns     120ns     120ns
Cmd Active:          90ns      90ns     480ns     480ns
Cmd Recovery:        30ns      30ns     480ns     480ns
Data Active:         90ns     330ns     330ns     330ns
Data Recovery:       30ns     270ns     270ns     270ns
Cycle Time:          30ns     600ns     600ns     600ns
Transfer Rate:   66.6MB/s   3.3MB/s   3.3MB/s   3.3MB/s

# hdparm /dev/hda 

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 8192 (on)    
 geometry     = 16383/255/63, sectors = 156301488, start = 0

(readahead was 256 before I changed it using hdparm -a)

Sincerely yours, and with big thanks to all the kernel authors,
Mikhail Ramendik
Moscow, Russia

P.S. I am not subscribed. I will watch the thread over the Web, but if I
need to provide additional info, or run some tests, or try any other
build of the kernel - please CC me for faster reaction.




