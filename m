Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUHMMlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUHMMlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 08:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbUHMMlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 08:41:20 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:2483 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265087AbUHMMki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 08:40:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16668.46785.163005.299256@spinky.blazemonger.com>
Date: Fri, 13 Aug 2004 08:40:33 -0400
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kfree_skb passed an skb still on a list (net/core/skbuff.c:225)
X-Mailer: VM 7.18 under Emacs 21.2.1
X-DJB-Valid: Yes
From: Daniel Barrett <dbarrett@blazemonger.com>
Reply-To: Daniel Barrett <dbarrett@blazemonger.com>
cc: Daniel Barrett <dbarrett@blazemonger.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

kfree_skb passed an skb still on a list, while copying samba-mounted
NTFS drive to local firewire (ieee1394) drive.

[2.] Full description of the problem/report:

While doing an rsync from a remote NTFS partition (Windows XP mounted
via samba) to a VFAT partition on a local firewire drive, this kernel
error occurred:

Aug 12 22:13:21 newbie kernel: Warning: kfree_skb passed an skb still on a list (from d040a200).
...
Aug 12 22:13:21 newbie kernel: kernel BUG at net/core/skbuff.c:225!
Aug 12 22:13:21 newbie kernel: invalid operand: 0000 [#1]

This killed the copy and left the firewire drive in an unmountable state.
I rebooted Linux and the drive was usable again.

This is SuSE Linux 9.1, kernel 2.6.5. I've seen other reports of
similar bugs in 2.6.7.

[3.] Keywords (i.e., modules, networking, kernel):

kernel, ieee1394, networking, samba, smb

[4.] Kernel version (from /proc/version):

Linux version 2.6.5-7.104-smp (geeko@buildhost) (gcc version 3.3.3 (SuSE Linux)) #1 SMP Wed Jul 28 16:42:13 UTC 2004

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

Aug 12 22:13:21 newbie kernel: Warning: kfree_skb passed an skb still on a list (from d040a200).
Aug 12 22:13:21 newbie kernel: ------------[ cut here ]------------
Aug 12 22:13:21 newbie kernel: kernel BUG at net/core/skbuff.c:225!
Aug 12 22:13:21 newbie kernel: invalid operand: 0000 [#1]
Aug 12 22:13:21 newbie kernel: SMP 
Aug 12 22:13:21 newbie kernel: CPU:    0
Aug 12 22:13:21 newbie kernel: EIP:    0060:[__kfree_skb+196/320]    Tainted: G  U
Aug 12 22:13:21 newbie kernel: EIP:    0060:[<c02ab484>]    Tainted: G  U
Aug 12 22:13:21 newbie kernel: EFLAGS: 00010292   (2.6.5-7.104-smp) 
Aug 12 22:13:21 newbie kernel: EIP is at __kfree_skb+0xc4/0x140
Aug 12 22:13:21 newbie kernel: eax: 00000045   ebx: fb06d128   ecx: 00000002   edx: c03840f8
Aug 12 22:13:21 newbie kernel: esi: f4c48000   edi: 00000000   ebp: 00000000   esp: f4c49fcc
Aug 12 22:13:21 newbie kernel: ds: 007b   es: 007b   ss: 0068
Aug 12 22:13:21 newbie kernel: Process khpsbpkt (pid: 3375, threadinfo=f4c48000 task=f4c4b950)
Aug 12 22:13:21 newbie kernel: Stack: c03653d0 d040a200 d040a200 f519e980 fb06d128 fb054374 fb061369 fb054300 
Aug 12 22:13:21 newbie kernel:        00000000 c0107005 00000000 00000000 00000000 
Aug 12 22:13:21 newbie kernel: Call Trace:
Aug 12 22:13:21 newbie kernel:  [__crc_acpi_get_parent+65401/3269820] hpsbpkt_thread+0x74/0x100 [ieee1394]
Aug 12 22:13:21 newbie kernel:  [<fb054374>] hpsbpkt_thread+0x74/0x100 [ieee1394]
Aug 12 22:13:21 newbie kernel:  [__crc_acpi_get_parent+65285/3269820] hpsbpkt_thread+0x0/0x100 [ieee1394]
Aug 12 22:13:21 newbie kernel:  [<fb054300>] hpsbpkt_thread+0x0/0x100 [ieee1394]
Aug 12 22:13:21 newbie kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Aug 12 22:13:21 newbie kernel:  [<c0107005>] kernel_thread_helper+0x5/0x10
Aug 12 22:13:21 newbie kernel: 
Aug 12 22:13:21 newbie kernel: Code: 0f 0b e1 00 5e 31 36 c0 8b 4c 24 0c e9 40 ff ff ff 89 d0 e8 
Aug 12 22:13:22 newbie kernel:  <3>ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:13:22 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:13:22 newbie last message repeated 7 times
Aug 12 22:13:52 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:13:52 newbie kernel: Write (10) 00 17 2d 4b 63 00 00 80 00 
Aug 12 22:13:52 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:14:22 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:14:22 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:14:22 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:14:22 newbie kernel: Write (10) 00 17 2d 4b e3 00 00 80 00 
Aug 12 22:14:22 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:14:52 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:14:52 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:14:52 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:14:52 newbie kernel: Write (10) 00 17 2d 4c 63 00 00 80 00 
Aug 12 22:14:52 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:15:22 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:15:22 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:15:22 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:15:22 newbie kernel: Write (10) 00 17 2d 4c e3 00 00 80 00 
Aug 12 22:15:22 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:15:52 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:15:52 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:15:52 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:15:52 newbie kernel: Write (10) 00 17 2d 4d e3 00 00 80 00 
Aug 12 22:15:52 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:16:22 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:16:22 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:16:22 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:16:22 newbie kernel: Write (10) 00 17 2d 4e 63 00 00 80 00 
Aug 12 22:16:22 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:16:52 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:16:52 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:16:52 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:16:52 newbie kernel: Write (10) 00 17 2d 4e e3 00 00 80 00 
Aug 12 22:16:52 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:17:22 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:17:22 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:17:22 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:17:22 newbie kernel: Write (10) 00 17 2d 4f 63 00 00 80 00 
Aug 12 22:17:22 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:17:52 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:17:52 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:17:52 newbie kernel: ieee1394: sbp2: reset requested
Aug 12 22:17:52 newbie kernel: ieee1394: sbp2: Generating sbp2 fetch agent reset
Aug 12 22:17:52 newbie kernel: ieee1394: sbp2: hpsb_node_write failed.
Aug 12 22:17:52 newbie kernel: 
Aug 12 22:17:52 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:18:22 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:18:22 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:18:22 newbie kernel: ieee1394: sbp2: reset requested
Aug 12 22:18:22 newbie kernel: ieee1394: sbp2: Generating sbp2 fetch agent reset
Aug 12 22:18:22 newbie kernel: ieee1394: sbp2: hpsb_node_write failed.
Aug 12 22:18:22 newbie kernel: 
Aug 12 22:18:32 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:19:00 newbie /USR/SBIN/CRON[6269]: (root) CMD (/usr/sbin/ntpdate clock-1.cs.cmu.edu > /dev/null) 
Aug 12 22:19:02 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:19:02 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:19:02 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:19:32 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:19:32 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:19:32 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:20:02 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:20:02 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:20:02 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:20:32 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:20:32 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:20:32 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:21:02 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:21:02 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:21:02 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:21:32 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:21:32 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:21:32 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:22:02 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:22:02 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:22:02 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:22:32 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:22:32 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:22:32 newbie kernel: ieee1394: sbp2: reset requested
Aug 12 22:22:32 newbie kernel: ieee1394: sbp2: Generating sbp2 fetch agent reset
Aug 12 22:22:32 newbie kernel: ieee1394: sbp2: hpsb_node_write failed.
Aug 12 22:22:32 newbie kernel: 
Aug 12 22:22:42 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:23:12 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:23:12 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:23:12 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:23:42 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:23:42 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:23:42 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:24:12 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:24:12 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:24:12 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:24:42 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:24:42 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:24:42 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:25:12 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:25:12 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:25:12 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:25:42 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:25:42 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:25:42 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:26:12 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:26:12 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:26:12 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:26:42 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:26:42 newbie kernel: Test Unit Ready 00 00 00 00 00 
Aug 12 22:26:42 newbie kernel: scsi: Device offlined - not ready after error recovery: host 4 channel 0 id 1 lun 0
Aug 12 22:26:42 newbie last message repeated 7 times
Aug 12 22:26:42 newbie kernel: SCSI error : <4 0 1 0> return code = 0x50000
Aug 12 22:26:42 newbie kernel: end_request: I/O error, dev sdc, sector 388844387
Aug 12 22:26:42 newbie kernel: Buffer I/O error on device sdc3, logical block 16505882
Aug 12 22:26:42 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:26:42 newbie kernel: Buffer I/O error on device sdc3, logical block 16505883
Aug 12 22:26:42 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:26:42 newbie kernel: Buffer I/O error on device sdc3, logical block 16505884
Aug 12 22:26:42 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:26:42 newbie kernel: Buffer I/O error on device sdc3, logical block 16505885
Aug 12 22:26:42 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:26:42 newbie kernel: Buffer I/O error on device sdc3, logical block 16505886
Aug 12 22:26:42 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:26:42 newbie kernel: Buffer I/O error on device sdc3, logical block 16505887
Aug 12 22:26:42 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:26:42 newbie kernel: Buffer I/O error on device sdc3, logical block 16505888
Aug 12 22:26:42 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:26:42 newbie kernel: Buffer I/O error on device sdc3, logical block 16505889
Aug 12 22:26:42 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:26:42 newbie kernel: Buffer I/O error on device sdc3, logical block 16505890
Aug 12 22:26:42 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:26:42 newbie kernel: Buffer I/O error on device sdc3, logical block 16505891
Aug 12 22:26:42 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:26:42 newbie kernel: SCSI error : <4 0 1 0> return code = 0x50000
Aug 12 22:26:42 newbie kernel: end_request: I/O error, dev sdc, sector 388844515
Aug 12 22:26:42 newbie kernel: SCSI error : <4 0 1 0> return code = 0x50000
Aug 12 22:26:42 newbie kernel: end_request: I/O error, dev sdc, sector 388844643
Aug 12 22:26:42 newbie kernel: SCSI error : <4 0 1 0> return code = 0x50000
Aug 12 22:26:42 newbie kernel: end_request: I/O error, dev sdc, sector 388844771
Aug 12 22:26:42 newbie kernel: SCSI error : <4 0 1 0> return code = 0x50000
Aug 12 22:26:42 newbie kernel: end_request: I/O error, dev sdc, sector 388845027
Aug 12 22:26:42 newbie kernel: SCSI error : <4 0 1 0> return code = 0x50000
Aug 12 22:26:42 newbie kernel: end_request: I/O error, dev sdc, sector 388845155
Aug 12 22:26:42 newbie kernel: SCSI error : <4 0 1 0> return code = 0x50000
Aug 12 22:26:42 newbie kernel: end_request: I/O error, dev sdc, sector 388845283
Aug 12 22:26:42 newbie kernel: SCSI error : <4 0 1 0> return code = 0x50000
Aug 12 22:26:42 newbie kernel: end_request: I/O error, dev sdc, sector 388845411
Aug 12 22:26:42 newbie kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Aug 12 22:27:12 newbie kernel: ieee1394: sbp2: aborting sbp2 command
Aug 12 22:27:12 newbie kernel: Write (10) 00 17 2d 4f e3 00 00 80 00 
Aug 12 22:27:12 newbie kernel: SCSI error : <4 0 1 0> return code = 0x50000
Aug 12 22:27:12 newbie kernel: end_request: I/O error, dev sdc, sector 388845539
Aug 12 22:27:12 newbie kernel: printk: 1014 messages suppressed.
Aug 12 22:27:12 newbie kernel: Buffer I/O error on device sdc3, logical block 16507034
Aug 12 22:27:12 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:27:12 newbie kernel: Buffer I/O error on device sdc3, logical block 16507035
Aug 12 22:27:12 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:27:12 newbie kernel: Buffer I/O error on device sdc3, logical block 16507036
Aug 12 22:27:12 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:27:12 newbie kernel: Buffer I/O error on device sdc3, logical block 16507037
Aug 12 22:27:12 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:27:12 newbie kernel: Buffer I/O error on device sdc3, logical block 16507038
Aug 12 22:27:12 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:27:12 newbie kernel: Buffer I/O error on device sdc3, logical block 16507039
Aug 12 22:27:12 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:27:12 newbie kernel: scsi4 (1:0): rejecting I/O to offline device
Aug 12 22:27:12 newbie last message repeated 112 times
Aug 12 22:27:12 newbie kernel: FAT: bread(block 4281) in fat_access failed
Aug 12 22:27:12 newbie kernel: scsi4 (1:0): rejecting I/O to offline device
Aug 12 22:27:12 newbie kernel: scsi4 (1:0): rejecting I/O to offline device
Aug 12 22:27:12 newbie kernel: FAT: bread(block 4281) in fat_access failed
Aug 12 22:27:12 newbie kernel: scsi4 (1:0): rejecting I/O to offline device
Aug 12 22:27:18 newbie last message repeated 65 times
Aug 12 22:27:18 newbie kernel: printk: 19431 messages suppressed.
Aug 12 22:27:18 newbie kernel: Buffer I/O error on device sdc3, logical block 16490000
Aug 12 22:27:18 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:27:18 newbie kernel: scsi4 (1:0): rejecting I/O to offline device
Aug 12 22:27:43 newbie last message repeated 533 times
Aug 12 22:27:43 newbie kernel: FAT: unable to read inode block for updating (i_pos 202639654)<3>scsi4 (1:0): rejecting I/O to offline device
Aug 12 22:27:43 newbie kernel: printk: 12393 messages suppressed.
Aug 12 22:27:43 newbie kernel: Buffer I/O error on device sdc3, logical block 16950768
Aug 12 22:27:43 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:27:43 newbie kernel: Buffer I/O error on device sdc3, logical block 16950769
Aug 12 22:27:43 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:27:43 newbie kernel: Buffer I/O error on device sdc3, logical block 16950770
Aug 12 22:27:43 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:27:43 newbie kernel: Buffer I/O error on device sdc3, logical block 16950771
Aug 12 22:27:43 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:27:43 newbie kernel: Buffer I/O error on device sdc3, logical block 16950772
Aug 12 22:27:43 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:27:43 newbie kernel: scsi4 (1:0): rejecting I/O to offline device
Aug 12 22:27:53 newbie last message repeated 2 times
Aug 12 22:27:53 newbie kernel: printk: 19 messages suppressed.
Aug 12 22:27:53 newbie kernel: Buffer I/O error on device sdc3, logical block 16113232
Aug 12 22:27:53 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:27:53 newbie kernel: Buffer I/O error on device sdc3, logical block 16113233
Aug 12 22:27:53 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:27:53 newbie kernel: scsi4 (1:0): rejecting I/O to offline device
Aug 12 22:28:28 newbie last message repeated 85 times
Aug 12 22:28:28 newbie kernel: printk: 8198 messages suppressed.
Aug 12 22:28:28 newbie kernel: Buffer I/O error on device sdc3, logical block 16291768
Aug 12 22:28:28 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:28:28 newbie kernel: Buffer I/O error on device sdc3, logical block 16291769
Aug 12 22:28:28 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:28:28 newbie kernel: Buffer I/O error on device sdc3, logical block 16291770
Aug 12 22:28:28 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:28:28 newbie kernel: Buffer I/O error on device sdc3, logical block 16291771
Aug 12 22:28:28 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:28:28 newbie kernel: Buffer I/O error on device sdc3, logical block 16291772
Aug 12 22:28:28 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:28:28 newbie kernel: Buffer I/O error on device sdc3, logical block 16291773
Aug 12 22:28:28 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:28:28 newbie kernel: Buffer I/O error on device sdc3, logical block 16291774
Aug 12 22:28:28 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:28:28 newbie kernel: scsi4 (1:0): rejecting I/O to offline device
Aug 12 22:29:03 newbie last message repeated 61 times
Aug 12 22:29:03 newbie kernel: printk: 5905 messages suppressed.
Aug 12 22:29:03 newbie kernel: Buffer I/O error on device sdc3, logical block 16241200
Aug 12 22:29:03 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:29:03 newbie kernel: Buffer I/O error on device sdc3, logical block 16241201
Aug 12 22:29:03 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:29:03 newbie kernel: Buffer I/O error on device sdc3, logical block 16241202
Aug 12 22:29:03 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:29:03 newbie kernel: Buffer I/O error on device sdc3, logical block 16241203
Aug 12 22:29:03 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:29:03 newbie kernel: Buffer I/O error on device sdc3, logical block 16241204
Aug 12 22:29:03 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:29:03 newbie kernel: Buffer I/O error on device sdc3, logical block 16241205
Aug 12 22:29:03 newbie kernel: lost page write due to I/O error on sdc3
Aug 12 22:29:03 newbie kernel: Buffer I/O error on device sdc3, logical block 16241206

...and later...

Aug 13 07:59:50 newbie kernel: scsi4 (1:0): rejecting I/O to offline device
Aug 13 07:59:50 newbie kernel: FAT bread failed in fat_clusters_flush
Aug 13 08:02:30 newbie kernel: smb_proc_readdir_long: error=-512, breaking


[6.] A small shell script or example program which triggers the
     problem (if possible)

/mnt/remote is an NTFS partition on a Windows XP box, mounted via samba,
size 27 GB.
/mnt/local is a VFAT partition on a firewire drive attached to the local
machine, empty.

# rsync --version
rsync  version 2.6.2  protocol version 28
# rsync -rtv /mnt/remote /mnt/local
[bug occurs after a while]

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux newbie 2.6.5-7.104-smp #1 SMP Wed Jul 28 16:42:13 UTC 2004 i686 i686 i386 GNU/Linux
 
Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.1.1
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.34
jfsutils               1.1.5
xfsprogs               2.6.3
quota-tools            3.11.
PPP                    2.4.2
isdn4k-utils           3.4
nfs-utils              1.0.6
Linux C Library        05 11:31 /lib/tls/libc.so.6
Dynamic linker (ldd)   2.3.3
Linux C++ Library      5.0.5
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         sbp2 usbserial parport_pc lp parport edd joydev sg st sr_mod nvram ehci_hcd uhci_hcd ohci1394 ieee1394 intel_mch_agp agpgart evdev snd_seq_oss snd_seq_midi_event snd_seq thermal snd_pcm_oss processor snd_mixer_oss fan button battery ac snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ipv6 ipt_REJECT ipt_multiport ipt_state ip_conntrack iptable_filter ip_tables usbcore e1000 binfmt_misc subfs nls_iso8859_1 nls_cp437 vfat fat nls_utf8 ntfs dm_mod ide_cd cdrom reiserfs sata_promise ata_piix libata sd_mod scsi_mod

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping	: 9
cpu MHz		: 3198.611
cache size	: 512 KB
physical id	: 0
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 6324.22

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping	: 9
cpu MHz		: 3198.611
cache size	: 512 KB
physical id	: 0
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 6389.76

[7.3.] Module information (from /proc/modules):

sbp2 26120 0 - Live 0xfa820000
usbserial 35952 0 - Live 0xfb0cc000
parport_pc 41024 1 - Live 0xfb0c0000
lp 15364 0 - Live 0xfb098000
parport 44232 2 parport_pc,lp, Live 0xfb0a6000
edd 13720 0 - Live 0xfb077000
joydev 14528 0 - Live 0xfb072000
sg 41632 0 - Live 0xfb08c000
st 44956 0 - Live 0xfb080000
sr_mod 21028 0 - Live 0xfb031000
nvram 13448 0 - Live 0xfb02c000
ehci_hcd 33412 0 - Live 0xfb068000
uhci_hcd 35728 0 - Live 0xfb042000
ohci1394 36484 0 - Live 0xfb038000
ieee1394 109752 2 sbp2,ohci1394, Live 0xfb04c000
intel_mch_agp 14352 1 - Live 0xfafd2000
agpgart 36140 1 intel_mch_agp, Live 0xfb011000
evdev 13952 0 - Live 0xfaf1d000
snd_seq_oss 38656 0 - Live 0xfafec000
snd_seq_midi_event 12032 1 snd_seq_oss, Live 0xfaf36000
snd_seq 65296 5 snd_seq_oss,snd_seq_midi_event, Live 0xfb000000
thermal 16648 0 - Live 0xfafc6000
snd_pcm_oss 65576 0 - Live 0xfafda000
processor 21312 1 thermal, Live 0xfafbf000
snd_mixer_oss 24448 1 snd_pcm_oss, Live 0xfafb8000
fan 8196 0 - Live 0xfaf32000
button 10384 0 - Live 0xfaf15000
battery 12804 0 - Live 0xfaf2d000
ac 8964 0 - Live 0xfaf19000
snd_intel8x0 39852 4 - Live 0xfaf22000
snd_ac97_codec 69636 1 snd_intel8x0, Live 0xfaf9c000
snd_pcm 112772 2 snd_pcm_oss,snd_intel8x0, Live 0xfaf7f000
snd_timer 32132 2 snd_seq,snd_pcm, Live 0xfaef9000
snd_page_alloc 16136 2 snd_intel8x0,snd_pcm, Live 0xfaeeb000
gameport 8832 1 snd_intel8x0, Live 0xfaef5000
snd_mpu401_uart 12672 1 snd_intel8x0, Live 0xfaef0000
snd_rawmidi 31140 1 snd_mpu401_uart, Live 0xfae41000
snd_seq_device 12808 3 snd_seq_oss,snd_seq,snd_rawmidi, Live 0xfaec7000
snd 70884 21 snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xfaf02000
soundcore 13536 1 snd, Live 0xfaec2000
ipv6 276348 23 - Live 0xfaf3a000
ipt_REJECT 10880 2 - Live 0xfae9e000
ipt_multiport 6272 4 - Live 0xfae32000
ipt_state 6144 1 - Live 0xfae2f000
ip_conntrack 37420 1 ipt_state, Live 0xfaecf000
iptable_filter 7040 1 - Live 0xfad33000
ip_tables 22400 4 ipt_REJECT,ipt_multiport,ipt_state,iptable_filter, Live 0xfae37000
usbcore 116572 5 usbserial,ehci_hcd,uhci_hcd, Live 0xfaea4000
e1000 88964 0 - Live 0xfae4a000
binfmt_misc 14856 1 - Live 0xfad4a000
subfs 12160 3 - Live 0xfadaa000
nls_iso8859_1 8320 1 - Live 0xfada6000
nls_cp437 9984 1 - Live 0xfad89000
vfat 19456 1 - Live 0xfad90000
fat 49824 1 vfat, Live 0xfad98000
nls_utf8 6272 2 - Live 0xfad36000
ntfs 94352 2 - Live 0xfad4f000
dm_mod 57472 0 - Live 0xfa99d000
ide_cd 42628 0 - Live 0xfa97f000
cdrom 42780 2 sr_mod,ide_cd, Live 0xfa973000
reiserfs 263504 5 - Live 0xfa9bc000
sata_promise 18308 0 - Live 0xfa91a000
ata_piix 11908 9 - Live 0xfa916000
libata 43648 2 sata_promise,ata_piix,[permanent], Live 0xfa949000
sd_mod 25088 11 - Live 0xfa90e000
scsi_mod 118340 7 sbp2,sg,st,sr_mod,sata_promise,libata,sd_mod, Live 0xfa92b000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0378-037a : parport0
037b-037f : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0400-041f : 0000:00:1f.3
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #02
  cf80-cf9f : 0000:02:01.0
    cf80-cf9f : e1000
d880-d8ff : 0000:03:04.0
  d880-d8ff : sata_promise
dc00-dc7f : 0000:03:03.0
df00-df3f : 0000:03:04.0
  df00-df3f : sata_promise
dfa0-dfaf : 0000:03:04.0
  dfa0-dfaf : sata_promise
e800-e8ff : 0000:00:1f.5
ee80-eebf : 0000:00:1f.5
ef00-ef1f : 0000:00:1d.0
  ef00-ef1f : uhci_hcd
ef20-ef3f : 0000:00:1d.1
  ef20-ef3f : uhci_hcd
ef40-ef5f : 0000:00:1d.2
  ef40-ef5f : uhci_hcd
ef60-ef6f : 0000:00:1f.2
  ef60-ef6f : libata
ef80-ef9f : 0000:00:1d.3
  ef80-ef9f : uhci_hcd
efa0-efa7 : 0000:00:1f.2
  efa0-efa7 : libata
efa8-efab : 0000:00:1f.2
  efa8-efab : libata
efac-efaf : 0000:00:1f.2
  efac-efaf : libata
efe0-efe7 : 0000:00:1f.2
  efe0-efe7 : libata
fc00-fc0f : 0000:00:1f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-7ff2ffff : System RAM
  00100000-0032cac4 : Kernel code
  0032cac5-003eb6ff : Kernel data
7ff30000-7ff3ffff : ACPI Tables
7ff40000-7ffeffff : ACPI Non-volatile Storage
7fff0000-7fffffff : reserved
80000000-800003ff : 0000:00:1f.1
ebf00000-efefffff : PCI Bus #01
  ec000000-edffffff : 0000:01:00.0
    ec000000-edffffff : vesafb
f4000000-f7ffffff : 0000:00:00.0
fd800000-fe8fffff : PCI Bus #01
  fe000000-fe7fffff : 0000:01:00.0
  fe8fc000-fe8fffff : 0000:01:00.0
fe900000-fe9fffff : PCI Bus #02
  fe9e0000-fe9fffff : 0000:02:01.0
    fe9e0000-fe9fffff : e1000
feac0000-feadffff : 0000:03:04.0
  feac0000-feadffff : sata_promise
feafe000-feafefff : 0000:03:04.0
  feafe000-feafefff : sata_promise
feaff800-feafffff : 0000:03:03.0
  feaff800-feafffff : ohci1394
febff400-febff4ff : 0000:00:1f.5
  febff400-febff4ff : Intel ICH5 - Controller
febff800-febff9ff : 0000:00:1f.5
  febff800-febff9ff : Intel ICH5 - AC'97
febffc00-febfffff : 0000:00:1d.7
  febffc00-febfffff : ehci_hcd
ffb80000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f4000000 (32-bit, prefetchable)
	Capabilities: [e4] #09 [2106]
	Capabilities: [a0] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fd800000-fe8fffff
	Prefetchable memory behind bridge: ebf00000-efefffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fe900000-fe9fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Expansion ROM at 0000c000 [disabled] [size=4K]
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at ef00 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at ef20 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at ef40 [size=32]

0000:00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at ef80 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at febffc00 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fea00000-feafffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at fc00 [size=16]
	Region 5: Memory at 80000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.2 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at efe0
	Region 1: I/O ports at efac [size=4]
	Region 2: I/O ports at efa0 [size=8]
	Region 3: I/O ports at efa8 [size=4]
	Region 4: I/O ports at ef60 [size=16]

0000:00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at 0400 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio Controller (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at e800
	Region 1: I/O ports at ee80 [size=64]
	Region 2: Memory at febff800 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at febff400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ec000000 (32-bit, prefetchable) [size=fe8c0000]
	Region 1: Memory at fe8fc000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1

0000:02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet Controller (LOM)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63750ns min), cache line size 04
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fe9e0000 (32-bit, non-prefetchable)
	Region 2: I/O ports at cf80 [size=32]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

0000:03:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at feaff800 (32-bit, non-prefetchable)
	Region 1: I/O ports at dc00 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:03:04.0 RAID bus controller: Promise Technology, Inc.: Unknown device 3373 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f5
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96 (1000ns min, 4500ns max), cache line size 91
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at df00
	Region 1: I/O ports at dfa0 [size=16]
	Region 2: I/O ports at d880 [size=128]
	Region 3: Memory at feafe000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at feac0000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3200822AS      Rev: 1.02
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3200822AS      Rev: 1.02
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi5 Channel: 00 Id: 01 Lun: 00
  Vendor: Maxtor   Model: OneTouch         Rev: 0200
  Type:   Direct-Access                    ANSI SCSI revision: 06

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:
