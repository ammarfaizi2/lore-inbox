Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264418AbTCXVCI>; Mon, 24 Mar 2003 16:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264420AbTCXVCH>; Mon, 24 Mar 2003 16:02:07 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:48594 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264418AbTCXVCB>; Mon, 24 Mar 2003 16:02:01 -0500
Date: Mon, 24 Mar 2003 13:03:18 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: linux-kernel <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 494] New: Trying to mount a JFS partition fails with error after a power outage 
Message-ID: <541150000.1048539798@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=494

           Summary: Trying to mount a JFS partition fails with error after a
                    power outage
    Kernel Version: 2.4.18
            Status: NEW
          Severity: high
             Owner: shaggy@austin.ibm.com
         Submitter: kernel@quikbox.ca


Distribution: Redhat 8.0
Hardware Environment: P4 with 1.2 GB RAM & 1 EIDE HD. 
Problem Description: I created a JFS partition for /opt & had been using it for
about a week when there was a power outage. This is the 1st time I'd ever
rebooted after creating the partition. When it tried to mount the partition, I
got the following error on the screen:

JFS development version: $Name:  $
jfs_mount: Mount Failure: File System Dirty.
Mount JFS Failure: 22
jfs_mount failed w/return code = 22
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c0155138
*pde = 00000000
Oops: 0000
jfs ext3 jbd mousedev keybdev hid input ehci-hcd usbcore
CPU:    0
EIP:    0010:[<c0155138>]    Not tainted
EFLAGS: 00010246

EIP is at destroy_inode [kernel] 0x28 (2.4.18-27.8.0)
eax: 00000000   ebx: f7830b80   ecx: 00000000   edx: f7830b80
esi: f7830b80   edi: f7809000   ebp: 00000000   esp: f7971e84
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 128, stackpage=f7971000)
Stack: f7830b80 f7830b80 f7808300 f88bb5d7 f7830b80 f77fc080 00000000 c0147238
       fffffff0 c0301920 00000000 f7809000 c0145eb3 f7809000 f7813000 00000000
       00000002 00000303 c3a0b2c0 f7841680 c3ab52c0 c3ab7100 000001f0 0000003c
Call Trace: [<f88bb5d7>] jfs_read_super [jfs] 0x177 (0xf7971e90))
[<c0147238>] check_disk_change [kernel] 0x48 (0xf7971ea0))
[<c0145eb3>] get_sb_bdev [kernel] 0x1a3 (0xf7971eb4))
[<f88e4fb0>] jfs_fs_type [jfs] 0x0 (0xf7971ef8))
[<c0146221>] do_kern_mount [kernel] 0x121 (0xf7971f00))
[<f88e4fb0>] jfs_fs_type [jfs] 0x0 (0xf7971f04))
[<c0158c33>] do_add_mount [kernel] 0x93 (0xf7971f24))
[<c0158f60>] do_mount [kernel] 0x160 (0xf7971f44))
[<c0158da9>] copy_mount_options [kernel] 0x79 (0xf7971f74))
[<c0159381>] sys_mount [kernel] 0xb1 (0xf7971f94))
[<c0109147>] system_call [kernel] 0x33 (0xf7971fc0))


Code: 8b 48 04 85 c9 74 11 89 1c 24 ff 50 04 8b 5c 24 08 83 c4 0c

Steps to reproduce:
It now happens whenever I try to mount this partition, although I'm not sure if
I can reproduce the state of the partition, nor am I particularly inclined to
try. I ran fsck.jfs on it but that reported no problems.


