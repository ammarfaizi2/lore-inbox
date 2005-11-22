Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbVKVNAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVKVNAE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 08:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbVKVNAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 08:00:04 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:46259 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S964935AbVKVNAB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 08:00:01 -0500
Date: Tue, 22 Nov 2005 13:59:59 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14 kswapd eating too much CPU
Message-ID: <20051122125959.GR16080@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

I have noticed that on my system kswapd eats too much CPU time every two
hours or so. This started when I upgraded this server to 2.6.14.2 (was 2.6.13.2
before), and added another 4 GB of memory (to the total of 8GB). The server
runs mainly FTP load (proftpd w/ sendfile()), with some other apps (Apache,
Qmail, etc). It is dual Opteron (Tyan S2882 board) with 8 ATA disks
on 3ware 7506 controller with SW raid volumes (RAID-1 and RAID-5),
with XFS and ext3 filesystems.

Here is the top(1) output when the kswapd problem occurs:

top - 13:45:34 up 8 days, 15:49,  2 users,  load average: 3.37, 3.49, 3.44
Tasks: 325 total,   4 running, 321 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.5% us, 75.6% sy,  0.8% ni, 20.3% id,  1.3% wa,  0.2% hi,  1.3% si
Mem:   8174528k total,  8151076k used,    23452k free,    49960k buffers
Swap: 14651256k total,      640k used, 14650616k free,  7562572k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
   16 root      15   0     0    0    0 R 96.4  0.0   1542:27 kswapd0
   15 root      15   0     0    0    0 D 52.0  0.0 833:48.37 kswapd1
 1056 rsyncd    35  19 11196 2608  928 R  3.0  0.0   0:42.29 rsync
 2082 named     18   0 72816  17m 1888 S  0.7  0.2  47:47.55 named
18484 ftp       20   5 10028 1556  788 S  0.7  0.0   0:00.02 proftpd
   26 root      10  -5     0    0    0 S  0.3  0.0 156:47.10 md5_raid5

It can be seen that one kswapd uses almost 100% of CPU,and the other one
about 50%. The MRTG graph of CPU usage can be seen at

http://www.linux.cz/stats/mrtg-rrd/cpu.html

(orange is the system+irq+softirq time, and red is non-idle (i.e.
user+sys+nice+irq+softirq, without idle and without iowait). The upgrade
of the kernel and memory has been done on Saturday, November 12th.

The peaks of the CPU system time happen every two horus or so. The peak
from ~5am is wider, because at that time various cron daily jobs are run
(updatedb, and so on).

	Any clues on what is going on here? Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> Specs are a basis for _talking_about_ things. But they are _not_ a basis <
> for implementing software.                              --Linus Torvalds <
