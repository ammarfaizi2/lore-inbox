Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264435AbUEDPZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264435AbUEDPZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 11:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264439AbUEDPZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 11:25:27 -0400
Received: from painless.aaisp.net.uk ([217.169.20.17]:47582 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S264435AbUEDPZO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 11:25:14 -0400
Message-ID: <4097B82B.50101@rgadsdon2.giointernet.co.uk>
Date: Tue, 04 May 2004 16:35:07 +0100
From: Robert Gadsdon <robert@rgadsdon2.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7b) Gecko/20040320
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.6-rc3-bk1 kernel BUG at net/core/skbuff.c:225!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following on 2.6.6-rc3 + bk1 patch:

----------------------------------------------------------------------
May  4 04:02:05 xxlinux logrotate: ALERT exited abnormally with [1]
May  4 04:22:22 xxlinux kernel: Warning: kfree_skb passed an skb still 
on a list (from f89e5b69).
May  4 04:22:22 xxlinux kernel: ------------[ cut here ]------------
May  4 04:22:22 xxlinux kernel: kernel BUG at net/core/skbuff.c:225!
May  4 04:22:22 xxlinux kernel: invalid operand: 0000 [#1]
May  4 04:22:22 xxlinux kernel: PREEMPT SMP
May  4 04:22:22 xxlinux kernel: CPU:    1
May  4 04:22:22 xxlinux kernel: EIP:    0060:[<c02d9164>]    Tainted: P
May  4 04:22:22 xxlinux kernel: EFLAGS: 00010286   (2.6.6-rc3)
May  4 04:22:22 xxlinux kernel: EIP is at __kfree_skb+0xb4/0xd0
May  4 04:22:22 xxlinux kernel: eax: 00000045   ebx: f8a1d96c   ecx: 
00000097   edx: c03949bc
May  4 04:22:22 xxlinux kernel: esi: 00000000   edi: 00000000   ebp: 
00000000   esp: f6b7bfd0
May  4 04:22:22 xxlinux kernel: ds: 007b   es: 007b   ss: 0068
May  4 04:22:22 xxlinux kernel: Process khpsbpkt (pid: 1292, 
threadinfo=f6b7a000 task=f6fac110)
May  4 04:22:22 xxlinux kernel: Stack: c037cda4 f89e5b69 d6a275d4 
f8a1d96c f89e5b69 cd39de80 00000091 f89e5af0
May  4 04:22:22 xxlinux kernel:        c0103ea5 00000000 00000000 00000000
May  4 04:22:22 xxlinux kernel: Call Trace:
May  4 04:22:22 xxlinux kernel:  [<f89e5b69>] hpsbpkt_thread+0x79/0x90 
[ieee1394]
May  4 04:22:22 xxlinux kernel:  [<f89e5b69>] hpsbpkt_thread+0x79/0x90 
[ieee1394]
May  4 04:22:22 xxlinux kernel:  [<f89e5af0>] hpsbpkt_thread+0x0/0x90 
[ieee1394]
May  4 04:22:22 xxlinux kernel:  [<c0103ea5>] kernel_thread_helper+0x5/0x10
May  4 04:22:22 xxlinux kernel:
May  4 04:22:22 xxlinux kernel: Code: 0f 0b e1 00 af af 37 c0 8b 54 24 
14 e9 51 ff ff ff 8d 74 26
May  4 04:22:22 xxlinux kernel:  <3>ieee1394: sbp2: 
sbp2util_node_write_no_wait failed.
May  4 04:22:22 xxlinux kernel:
May  4 04:22:52 xxlinux kernel: ieee1394: sbp2: aborting sbp2 command
May  4 04:22:52 xxlinux kernel: 0x28 00 04 69 27 5f 00 00 08 00
May  4 04:22:52 xxlinux kernel: ieee1394: sbp2: hpsb_node_write failed.
May  4 04:22:52 xxlinux kernel:
May  4 04:22:52 xxlinux kernel: ieee1394: sbp2: 
sbp2util_node_write_no_wait failed.
May  4 04:22:52 xxlinux kernel:
May  4 04:23:02 xxlinux kernel: ieee1394: sbp2: aborting sbp2 command
May  4 04:23:02 xxlinux kernel: 0x00 00 00 00 00 00
May  4 04:23:02 xxlinux kernel: ieee1394: sbp2: hpsb_node_write failed.
May  4 04:23:02 xxlinux kernel:
May  4 04:23:02 xxlinux kernel: ieee1394: sbp2: reset requested
May  4 04:23:02 xxlinux kernel: ieee1394: sbp2: Generating sbp2 fetch 
agent reset
May  4 04:23:02 xxlinux kernel: ieee1394: sbp2: hpsb_node_write failed.
May  4 04:23:02 xxlinux kernel:
May  4 04:23:02 xxlinux kernel: ieee1394: sbp2: 
sbp2util_node_write_no_wait failed.
May  4 04:23:02 xxlinux kernel:
May  4 04:23:12 xxlinux kernel: ieee1394: sbp2: aborting sbp2 command
May  4 04:23:12 xxlinux kernel: 0x00 00 00 00 00 00
May  4 04:23:12 xxlinux kernel: ieee1394: sbp2: hpsb_node_write failed.
May  4 04:23:12 xxlinux kernel:
May  4 04:23:12 xxlinux kernel: ieee1394: sbp2: reset requested
May  4 04:23:12 xxlinux kernel: ieee1394: sbp2: Generating sbp2 fetch 
agent reset
May  4 04:23:12 xxlinux kernel: ieee1394: sbp2: hpsb_node_write failed.
May  4 04:23:12 xxlinux kernel:
May  4 04:23:22 xxlinux kernel: ieee1394: sbp2: 
sbp2util_node_write_no_wait failed.
May  4 04:23:22 xxlinux kernel:
May  4 04:23:32 xxlinux kernel: ieee1394: sbp2: aborting sbp2 command
May  4 04:23:32 xxlinux kernel: 0x00 00 00 00 00 00
May  4 04:23:32 xxlinux kernel: ieee1394: sbp2: hpsb_node_write failed.
May  4 04:23:32 xxlinux kernel:
May  4 04:23:32 xxlinux kernel: ieee1394: sbp2: reset requested
May  4 04:23:32 xxlinux kernel: ieee1394: sbp2: Generating sbp2 fetch 
agent reset
May  4 04:23:32 xxlinux kernel: ieee1394: sbp2: hpsb_node_write failed.
May  4 04:23:32 xxlinux kernel:
May  4 04:23:42 xxlinux kernel: ieee1394: sbp2: 
sbp2util_node_write_no_wait failed.
May  4 04:23:42 xxlinux kernel:
May  4 04:23:52 xxlinux kernel: ieee1394: sbp2: aborting sbp2 command
May  4 04:23:52 xxlinux kernel: 0x00 00 00 00 00 00
May  4 04:23:52 xxlinux kernel: ieee1394: sbp2: hpsb_node_write failed.
May  4 04:23:52 xxlinux kernel:
May  4 04:23:52 xxlinux kernel: scsi: Device offlined - not ready after 
error recovery: host 1 channel 0 id 0 lun 0
May  4 04:23:52 xxlinux kernel: SCSI error : <1 0 0 0> return code = 0x50000
May  4 04:23:52 xxlinux kernel: end_request: I/O error, dev sdb, sector 
74000223
May  4 04:23:52 xxlinux kernel: scsi1 (0:0): rejecting I/O to offline device
May  4 04:23:52 xxlinux kernel: scsi1 (0:0): rejecting I/O to offline device
May  4 04:23:52 xxlinux kernel: Buffer I/O error on device sdb1, logical 
block 8847384
May  4 04:23:52 xxlinux kernel: lost page write due to I/O error on sdb1
May  4 04:23:52 xxlinux kernel: Buffer I/O error on device sdb1, logical 
block 8847385
May  4 04:23:52 xxlinux kernel: lost page write due to I/O error on sdb1
May  4 04:23:52 xxlinux kernel: Buffer I/O error on device sdb1, logical 
block 8847386
May  4 04:23:52 xxlinux kernel: lost page write due to I/O error on sdb1
May  4 04:23:52 xxlinux kernel: Buffer I/O error on device sdb1, logical 
block 8847387
May  4 04:23:52 xxlinux kernel: lost page write due to I/O error on sdb1
May  4 04:23:52 xxlinux kernel: Buffer I/O error on device sdb1, logical 
block 8847388
May  4 04:23:52 xxlinux kernel: lost page write due to I/O error on sdb1
May  4 04:23:52 xxlinux kernel: Buffer I/O error on device sdb1, logical 
block 8847389
May  4 04:23:52 xxlinux kernel: lost page write due to I/O error on sdb1
May  4 04:23:52 xxlinux kernel: scsi1 (0:0): rejecting I/O to offline device
May  4 04:23:52 xxlinux kernel: Buffer I/O error on device sdb1, logical 
block 8880138
May  4 04:23:52 xxlinux kernel: lost page write due to I/O error on sdb1
May  4 04:23:52 xxlinux kernel: scsi1 (0:0): rejecting I/O to offline device
May  4 04:23:52 xxlinux kernel: Buffer I/O error on device sdb1, logical 
block 8880141
May  4 04:23:52 xxlinux kernel: lost page write due to I/O error on sdb1
May  4 04:23:52 xxlinux kernel: Buffer I/O error on device sdb1, logical 
block 8880142
May  4 04:23:52 xxlinux kernel: lost page write due to I/O error on sdb1
May  4 04:23:52 xxlinux kernel: Buffer I/O error on device sdb1, logical 
block 8880143
May  4 04:23:52 xxlinux kernel: lost page write due to I/O error on sdb1
May  4 04:23:52 xxlinux kernel: scsi1 (0:0): rejecting I/O to offline device
May  4 04:23:53 xxlinux last message repeated 109 times
May  4 04:23:53 xxlinux kernel: Aborting journal on device sdb1.
May  4 04:23:53 xxlinux kernel: EXT3-fs error (device sdb1): 
ext3_readdir: directory #4620913 contains a hole at offset 0
May  4 04:23:53 xxlinux kernel: scsi1 (0:0): rejecting I/O to offline device
May  4 04:23:53 xxlinux kernel: ext3_abort called.
May  4 04:23:53 xxlinux kernel: EXT3-fs abort (device sdb1): 
ext3_journal_start: Detected aborted journal

< similar messages repeated for all 3 firewire disks, which were then 
'offline'.... >
------------------------------------------------------------------

2.6.6-rc3-bk1 had (apparently) been running OK for several days earlier...

.............................
Robert Gadsdon
.............................
