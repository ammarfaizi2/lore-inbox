Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWDDRmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWDDRmX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 13:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWDDRmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 13:42:23 -0400
Received: from p78-65.acedsl.com ([66.114.78.65]:62947 "EHLO
	karlson.dmitriev.net") by vger.kernel.org with ESMTP
	id S1750772AbWDDRmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 13:42:23 -0400
Date: Tue, 4 Apr 2006 14:24:07 -0400 (EDT)
From: NetComrade <netcomrade@bookexchange.net>
To: linux-kernel@vger.kernel.org
Subject: what's my kernel doing?
Message-ID: <Pine.LNX.4.21.0604041416470.27773-100000@karlson.dmitriev.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have a 4CPU AMD (v40z) machine running RedHat 4.0 (2.6.9-11.ELsmp), and
I noticed high CPU utilization especially on the system side:

[root@mars ~]# mpstat 5
Linux 2.6.9-11.ELsmp (mars)     04/04/2006

01:37:32 PM  CPU   %user   %nice %system %iowait    %irq   %soft   %idle
intr/s
01:37:37 PM  all   38.50    0.00   50.95    0.00    0.30    3.20    7.05
6750.80
01:37:42 PM  all   41.91    0.00   53.10    0.00    0.30    3.10    1.60
6884.60
01:37:47 PM  all   39.97    0.00   53.08    0.00    0.25    3.05    3.65
6672.65


Initially I thought it was a huge file system cache that system was
scanning a lot. 

[VCRS@mars admin]$free
             total       used       free     shared    buffers     cached
Mem:      16032636   12539720    3492916          0     244440   11640608
-/+ buffers/cache:     654672   15377964
Swap:      8385920         28    8385892

However, I unmounted/umounted the oracle file system in directio mode the
cache didn't go away, so it must be some root disk cache.. (there also
used to be a parameter to control pagecache up to kernel 2.6
(/proc/sys/vm/pagecache), but it seems to be gone now, couldn't find an
equivalent nor the reason it is gone)

Then I installed the 'profiler', which I can barely understand, but
there's a difference between sun & mars (identical machines, both running
oracle databases). It seems weird that some usb process is taking up so
much cpu, however on sun (which doesn't have a similar system utilization)
it's near the 'top' too, just at a much lower percentage.

If anyone here could give me better advice on how to go about this problem
(high system cpu utilization), or point me to some resources, I'd really
appreciate it.


[root@sun ~]# opreport|head
CPU: AMD64 processors, speed 2592.7 MHz (estimated)
Counted CPU_CLK_UNHALTED events (Cycles outside of halt state) with a unit
mask of 0x00 (No unit mask) count 100000
CPU_CLK_UNHALT...|
  samples|      %|
------------------
  1567396 54.8034 oracle
   904729 31.6335 vmlinux
   136014  4.7557 libc-2.3.4.so
    33860  1.1839 e1000
    26277  0.9188 vxfs

[root@sun ~]# opreport -l
/usr/lib/debug/lib/modules/2.6.9-5.EL/vmlinux|head
CPU: AMD64 processors, speed 2592.7 MHz (estimated)
Counted CPU_CLK_UNHALTED events (Cycles outside of halt state) with a unit
mask of 0x00 (No unit mask) count 100000
samples  %        symbol name
113702   11.3522  usbfs_add_bus
80084     7.9957  get_user_pages
53515     5.3430  init_8259A
40519     4.0455  sys_access
28709     2.8663  load_elf32_binary
26368     2.6326  setscheduler
23848     2.3810  __ide_dma_write


Oh yeah, 2.6.9-5EL was the only 'kernel-debug' rpm I could find.


[root@mars tmp]# opreport|head
CPU: AMD64 processors, speed 2592.66 MHz (estimated)
Counted CPU_CLK_UNHALTED events (Cycles outside of halt state) with a unit
mask of 0x00 (No unit mask) count 100000
CPU_CLK_UNHALT...|
  samples|      %|
------------------
 23361362 66.3184 vmlinux
  9122930 25.8982 oracle
  1102906  3.1309 no-vmlinux
   539234  1.5308 libc-2.3.4.so
   183650  0.5213 e1000

[root@mars tmp]# opreport -l
/usr/lib/debug/lib/modules/2.6.9-5.EL/vmlinux|head
CPU: AMD64 processors, speed 2592.66 MHz (estimated)
Counted CPU_CLK_UNHALTED events (Cycles outside of halt state) with a unit
mask of 0x00 (No unit mask) count 100000
samples  %        symbol name
8155421  34.4932  usbfs_add_bus
4776837  20.2035  get_user_pages
2954158  12.4945  sys_access
1702339   7.2000  setscheduler
779719    3.2978  sys_fchdir
367546    1.5545  sys_open
260518    1.1019  init_8259A





































Please let me know which list would be appropriate for a question like
this, if this list is for kernel development only.

Thanks,
andrey

