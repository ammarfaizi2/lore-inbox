Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWIHOHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWIHOHW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 10:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWIHOHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 10:07:22 -0400
Received: from mxsf05.cluster1.charter.net ([209.225.28.205]:64147 "EHLO
	mxsf05.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750942AbWIHOHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 10:07:20 -0400
X-IronPort-AV: i="4.08,232,1154923200"; 
   d="scan'208"; a="829621805:sNHT34227550"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17665.30996.679000.180156@smtp.charter.net>
Date: Fri, 8 Sep 2006 10:07:16 -0400
From: "John Stoffel" <john@stoffel.org>
To: linux-kernel@vger.kernel.org, linux-lvm@redhat.com,
       linux-raid@vger.kernel.org
CC: john@stoffel.org
Subject: 2.6.18-rc5-mm1 - bd_claim_by_disk oops
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got the following on 2.6.18-rc5-mm1 when trying to lvextend a test
logical volume that I had just created.  This came about because I
have been trying to expand some LVs on my system, which are based on a
VG ontop of an MD mirror pair.  It's an SMP box too if that means
anything.  

device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
device-mapper: table: 253:2: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
BUG: unable to handle kernel paging request at virtual address
6f72702e
 printing eip:
c018505b
*pde = 00000000
Oops: 0000 [#1]
4K_STACKS SMP 
last sysfs file: /block/dm-2/removable
Modules linked in: rfcomm l2cap bluetooth sbp2 i2c_piix4 ohci1394
evdev snd_ens1
371 snd_rawmidi snd_ac97_codec snd_ac97_bus i2c_core snd_pcm snd_timer
snd sound
core snd_page_alloc ieee1394 uhci_hcd ohci_hcd usb_storage
CPU:    1
EIP:    0060:[<c018505b>]    Not tainted VLI
EFLAGS: 00010292   (2.6.18-rc5-mm1 #1) 
EIP is at bd_claim_by_disk+0x9b/0x1c0
eax: e6622ba0   ebx: 6f72702e   ecx: c16decbc   edx: 6f72702e
esi: 00000000   edi: e4a11220   ebp: c16dec80   esp: c62e1ca4
ds: 007b   es: 007b   ss: 0068
Process lvextend (pid: 2926, ti=c62e1000 task=dccfa580
task.ti=c62e1000)
Stack: c047cefa c16dec8c c16dec80 e3e31920 d1130e80 c16dec80 c035f9c8
fffffff4 
       e128d160 00900000 e3e31920 c036040c f0a5915c c042bf66 c62e1d50
c62e1d4c 
       c0500f0c e128d160 f0a5915c f0a1b080 e128d0c0 00000000 00000001
c0500f0c 
Call Trace:
 [<c035f9c8>] open_dev+0x48/0x80
 [<c036040c>] dm_get_device+0x20c/0x480
 [<c0243537>] vsscanf+0x447/0x490
 [<c0360ca9>] linear_ctr+0x99/0x110
 [<c035ff0d>] dm_table_add_target+0x17d/0x2e0
 [<c0361e6a>] table_load+0xba/0x1d0
 [<c0362b9d>] ctl_ioctl+0x22d/0x2a0
 [<c028b594>] n_tty_receive_buf+0x324/0x1070
 [<c0361db0>] table_load+0x0/0x1d0
 [<c016c2d8>] do_ioctl+0x78/0x90
 [<c016c34c>] vfs_ioctl+0x5c/0x2b0
 [<c016c5dd>] sys_ioctl+0x3d/0x70
 [<c0102f33>] syscall_call+0x7/0xb
 =======================
Code: 3c 8b 13 0f 18 02 90 8d 4d 3c 39 cb 0f 84 24 01 00 00 8b 47 0c
3b 43 0c 75
 0f e9 ab 00 00 00 90 3b 43 0c 0f 84 a1 00 00 00 89 d3 <8b> 12 0f 18
02 90 39 cb
 75 eb e8 d6 a9 0b 00 85 c0 89 47 0c 0f 
EIP: [<c018505b>] bd_claim_by_disk+0x9b/0x1c0 SS:ESP 0068:c62e1ca4
 
