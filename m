Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268933AbUIMUM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268933AbUIMUM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268947AbUIMUMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:12:07 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:41398 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268933AbUIMUKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:10:25 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.9-rc1-mm5: Oops related to reiserfs, other stuff
Date: Mon, 13 Sep 2004 22:11:44 +0200
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409132211.44109.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

There is a problem in 2.6.9-rc1-mm5 related to the reiserfs handling of ACLs.  
Namely, if a reiserfs partition is mounted with "-o acl", any attempt to 
create a file on it results in an Oops similar to this one:

Unable to handle kernel paging request at fffffffffffffff3 RIP:
<ffffffff8020f9f4>{reiserfs_cache_default_acl+164}
PML4 103027 PGD 170a067 PMD 0
Oops: 0002 [1]
CPU 0
Modules linked in: usbserial parport_pc lp parport joydev sg sd_mod sr_mod 
scsi_mod cpufreq_userspace powernow_k8 thermal processor fan snd_d
Pid: 18656, comm: kdm Not tainted 2.6.9-rc1-mm5
RIP: 0010:[<ffffffff8020f9f4>] 
<ffffffff8020f9f4>{reiserfs_cache_default_acl+164}
RSP: 0018:00000100143b3db8  EFLAGS: 00010286
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000002
RDX: 000001001bf3cc68 RSI: ffffffff804272c0 RDI: 000001001bf3cc30
RBP: 000001001bf3cc78 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000006 R11: ffffffff803c6d32 R12: fffffffffffffff3
R13: 0000000000008180 R14: 0000010019a5b868 R15: 000000000000000a
FS:  0000002a95ec24c0(0000) GS:ffffffff80551b40(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: fffffffffffffff3 CR3: 0000000000101000 CR4: 00000000000006e0
Process kdm (pid: 18656, threadinfo 00000100143b2000, task 000001000b512a10)
Stack: 000001001bf3c120 000001001bf3cc78 0000000000008180 ffffffff801e99c6
       0000000000000000 0000010019a5b868 0000000000000000 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff801e99c6>{reiserfs_create+102} 
<ffffffff801a39ad>{vfs_create+237}
       <ffffffff801a6480>{open_namei+432} <ffffffff8018ddd7>{filp_open+39}
       <ffffffff8018da94>{get_unused_fd+180} <ffffffff8018de4c>{sys_open+76}
       <ffffffff80110c02>{system_call+126}

Code: 41 ff 0c 24 0f 94 c0 84 c0 74 08 4c 89 e7 e8 19 00 f6 ff 89
RIP <ffffffff8020f9f4>{reiserfs_cache_default_acl+164} RSP <00000100143b3db8>
CR2: fffffffffffffff3

This happens 100% of the time, and the workaround is not to mount reiserfs 
with "-o acl", of course.

Also, in the output of dmesg I've got the following line:

udev[10682]: segfault at 0000000000000138 rip 0000000000405818 rsp 
0000007fbffff470 error 4

(this does not seem to be reproducible, however) and the following error 
message from the USB subsystem:

usb usb2: string descriptor 0 read error: -113

(repeated 8 times, occurs always at startup).

The kernel is booted with the following command line: root=/dev/hdc6 vga=792 
resume=/dev/hdc3 pci=routeirq nmi_watchdog=0 console=ttyS0,57600

The .config is available at: 
http://www.sisk.pl/kernel/040913/2.6.9-rc1-mm5.config

The full output of dmesg is available at: 
http://www.sisk.pl/kernel/040913/2.6.9-rc1-mm5-dmesg.log

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
