Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277223AbRJDUyB>; Thu, 4 Oct 2001 16:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277224AbRJDUxv>; Thu, 4 Oct 2001 16:53:51 -0400
Received: from rj.SGI.COM ([204.94.215.100]:43437 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S277223AbRJDUxr>;
	Thu, 4 Oct 2001 16:53:47 -0400
Message-Id: <200110042051.f94Kp0Q08771@stout.americas.sgi.com>
Date: Thu, 4 Oct 2001 15:51:01 -0500
From: Eric Sandeen <sandeen@sgi.com>
Subject: Re: 2.4.11-pre2-xfs
In-Reply-To: Message from Andrey Nekrasov <andy@spylog.ru>    of "Thu, 04 Oct 2001 14:15:13 +0400." <20011004141513.A5421@spylog.ru>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, it works for me...

[root@iotest ramdisk]# uname -a
Linux iotest 2.4.11-pre2-xfs #1 SMP Thu Oct 4 14:17:48 CDT 2001 i686 unknown
[root@iotest /root]# free
             total       used       free     shared    buffers     cached
Mem:       1028964      56752     972212          0       2092      24800
-/+ buffers/cache:      29860     999104
Swap:       530136          0     530136
[root@iotest /root]# modprobe rd rd_size=600000 rd_blocksize=512
[root@iotest /root]# mkfs.xfs -q -f /dev/ram
[root@iotest /root]# mount /dev/ram /mnt/ramdisk/
[root@iotest /root]# cd /mnt/ramdisk/
[root@iotest ramdisk]# /root/tiobench-0.3.1/tiotest -c -f 110
Tiotest results for 4 concurrent io threads:

,----------------------------------------------------------------------.
| Item                  | Time     | Rate         | Usr CPU | Sys CPU  |
+-----------------------+----------+--------------+----------+---------+
| Write         440 MBs |    5.3 s |  83.600 MB/s |   2.3 %  | 193.4 % |
| Random Write   16 MBs |    0.2 s | 103.333 MB/s |   0.0 %  | 198.4 % |
| Read          440 MBs |    3.9 s | 114.117 MB/s | 146.5 %  |  52.9 % |
| Random Read    16 MBs |    0.1 s | 107.574 MB/s | 151.5 %  |  41.3 % |
`----------------------------------------------------------------------'

Andrey Nekrasov <andy@spylog.ru> wrote:

> Hello.
>
> 1. hardware Intel ISP1100 (BX/1GB RAM/IDE DISK)
> 2. kernel 2.4.11-pre2-xfs, with highmem support
>
> 3. create ramdisk 512Mb and run "tiotest -c -f 110"
> 4.
>
> __alloc_pages: 0-order allocation failed (gfp=0x3d0/0) from c0127fe9

--
Eric Sandeen      XFS for Linux     http://oss.sgi.com/projects/xfs
sandeen@sgi.com   SGI, Inc.


