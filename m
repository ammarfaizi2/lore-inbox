Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285074AbRLUUAD>; Fri, 21 Dec 2001 15:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285084AbRLUT7x>; Fri, 21 Dec 2001 14:59:53 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:39333 "EHLO
	hawk.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S285074AbRLUT7t>; Fri, 21 Dec 2001 14:59:49 -0500
Date: Fri, 21 Dec 2001 15:02:57 -0500
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de
Subject: Effect of changing normal memory zone size and dbench on 2.4.17rc2aa2
Message-ID: <20011221150257.A1168@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel:		2.4.17rc2aa2

Test:		Change highmem settings - run dbench 32, 128.

Conclusion:	More "normal" memory gives better dbench throughput 
		on box with 1024MB ram.

I noticed the 3.5 GB User Address Space setting in the 
Andrea Arcangeli's 2.4.17rc2aa2 and thought maybe it was
a way to have 1GB (or more) RAM and not use highmem.  It
obviously has a different purpose, but it led me to run
dbench to see how throughput changes when highmem is a 
larger or smaller portion of memory.

highmem
-------
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y

This configuration had excellent numbers.  Highmem is 128M.

Memory: 1029848k/1048512k available (1053k kernel code, 18276k reserved, 260k data, 240k init, 131008k highmem)

dbench
Throughput 82.4374 MB/sec (NB=103.047 MB/sec  824.374 MBit/sec)  32 procs
Throughput 42.1931 MB/sec (NB=52.7413 MB/sec  421.931 MBit/sec)  128 procs


3.5 gb user address space
-------------------------
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_05GB=y

Here Highmem is 640MB.  Throughput for dbench 32 is 31% lower than normal highmem.
dbench 128 throughput was 42% lower.

Memory: 1029848k/1048512k available (1053k kernel code, 18276k reserved, 260k data, 240k init, 655296k highmem)

dbench
Throughput 56.9061 MB/sec (NB=71.1327 MB/sec  569.061 MBit/sec)  32 procs
Throughput 24.4228 MB/sec (NB=30.5285 MB/sec  244.228 MBit/sec)  128 procs


nohighmem
---------
CONFIG_NOHIGHMEM=y

With nohighmem, total memory drops to 896MB.  Nonetheless, dbench 32 was
9% higher.  The dbench 128 throughput was < 1% lower, which is not 
significant for this test.

Memory: 901804k/917504k available (1049k kernel code, 15312k reserved, 259k data, 236k init, 0k highmem)

dbench
Throughput 90.0235 MB/sec (NB=112.529 MB/sec  900.235 MBit/sec)  32 procs
Throughput 41.805 MB/sec (NB=52.2563 MB/sec  418.05 MBit/sec)  128 procs


Hardware:
1333 Athlon
1024 MB RAM
1027 MB swap

P.S. Andrea, enjoy your holidays!

-- 
Randy Hron

