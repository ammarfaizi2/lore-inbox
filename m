Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSGCCNi>; Tue, 2 Jul 2002 22:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSGCCNh>; Tue, 2 Jul 2002 22:13:37 -0400
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:15756 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S314395AbSGCCNg>; Tue, 2 Jul 2002 22:13:36 -0400
Date: Tue, 2 Jul 2002 22:20:51 -0400
To: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: sync slowness. ext3 on VIA vt82c686b
Message-ID: <20020703022051.GA2669@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I copy a file(13Megs) from /home/ to /tmp/, sync takes almost 2 minutes. 
When I copy the same file to /usr/local/, sync returns almost right away.  Both 
filesystems are ext3 and are on the same harddrive.  When sync is running, 
the harddrive light stays on but I don't hear it doing anything. dmesg doesn't 
show any errors either. Below is the `time` output for each command.  If you 
need anymore information  let me know..

The CPU is a PIII866 with 512MB RAM.

$ uname -a
Linux dev-01 2.4.19-pre10-ac2 #3 Sun Jun 30 18:56:04 EDT 2002 i686 unknown

$ hdparm /dev/hda
/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1868/255/63, sectors = 30015216, start = 0
 busstate     =  1 (on)

$ cat /proc/mounts
/dev/hda1 /	ext3 rw,noatime 0 0
/dev/hda2 /home	ext3 rw,noatime 0 0
/dev/hda3 /usr	ext3 rw,noatime 0 0

$ df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda1             387M  162M  205M  45% /
/dev/hda2             3.4G  2.1G  1.1G  65% /home
/dev/hda3              10G  6.3G  3.4G  65% /usr

$ cat /proc/ide/via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.34
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xc000
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       PIO       PIO
Address Setup:       30ns     120ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          30ns     600ns     120ns     600ns
Transfer Rate:   66.6MB/s   3.3MB/s  16.6MB/s   3.3MB/s

$ ls -al mozilla-i686-pc-linux-gnu-sea.tar.gz
-rw-rw-r--    1 khromy   khromy        13M Jul  2 07:42
mozilla-i686-pc-linux-gnu-sea.tar.gz

* time output when I copy to /usr/local

$ time cp mozilla-i686-pc-linux-gnu-sea.tar.gz /usr/local/
0.00user 0.19system 0:00.18elapsed 102%CPU (0avgtext+0avgdata 0maxresident)k

$ time sync
0.00user 0.00system 0:00.00elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k

$ time rm /usr/local/mozilla-i686-pc-linux-gnu-sea.tar.gz
0.00user 0.00system 0:00.00elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k

* time output when I copy to /tmp

$ time cp mozilla-i686-pc-linux-gnu-sea.tar.gz /tmp/
0.01user 0.24system 0:00.25elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k

$ time sync
0.00user 0.05system 1:39.14elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k

$ time rm /tmp/mozilla-i686-pc-linux-gnu-sea.tar.gz
0.00user 0.05system 0:00.05elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
