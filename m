Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265617AbTGLNai (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 09:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbTGLNai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 09:30:38 -0400
Received: from franka.aracnet.com ([216.99.193.44]:55496 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265617AbTGLNag
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 09:30:36 -0400
Date: Sat, 12 Jul 2003 06:45:09 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 913] New: Segmentation fault when unmounting a smartmedia reader
Message-ID: <166550000.1058017509@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=913

           Summary: Segmentation fault when unmounting a smartmedia reader
    Kernel Version: 2.5.75-bk1
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: Nicolas.Mailhot@LaPoste.net


(see bug #912 for complete hardware/software environment, config files and so on)

After getting a screenshot of bug #912 today, when unmounting the smartmedia
card mount did a segmentat fault.

repeating the unmount command resulted in "foo is not mounted".

I've just found this trace in /var/log/messages that seems related. System
didn't seem affected and is still running nicely.


Jul 12 10:22:52 rousalka kernel: Unable to handle kernel NULL pointer
dereference at virtual address 000000d8
Jul 12 10:22:52 rousalka kernel:  printing eip:
Jul 12 10:22:52 rousalka kernel: c029d847
Jul 12 10:22:52 rousalka kernel: *pde = 00000000
Jul 12 10:22:52 rousalka kernel: Oops: 0002 [#1]
Jul 12 10:22:52 rousalka kernel: CPU:    0
Jul 12 10:22:52 rousalka kernel: EIP:    0060:[<c029d847>]    Not tainted
Jul 12 10:22:52 rousalka kernel: EFLAGS: 00210286
Jul 12 10:22:52 rousalka kernel: EIP is at scsi_device_put+0x7/0x60
Jul 12 10:22:52 rousalka kernel: eax: 00000000   ebx: 00000000   ecx: c17965c0 
 edx: ffffffff
Jul 12 10:22:52 rousalka kernel: esi: dfd7fb70   edi: dfd7fb70   ebp: d28cde84 
 esp: d28cde80
Jul 12 10:22:52 rousalka kernel: ds: 007b   es: 007b   ss: 0068
Jul 12 10:22:52 rousalka kernel: Process umount (pid: 5497, threadinfo=d28cc000
task=cd00e800)
Jul 12 10:22:52 rousalka kernel: Stack: 00000000 d28cde98 c02a7727 00000000
00000000 00000001 d28cded8 c017e07f
Jul 12 10:22:52 rousalka kernel:        d3a1f794 00000000 dfd7fbe4 d28cdec0
c0156591 dfd7fbe4 00000002 dfd7fb88
Jul 12 10:22:52 rousalka kernel:        c17965c0 d3a1f794 00000000 00000000
00000000 dfd7fbe4 d28cdf18 c017e03d
Jul 12 10:22:52 rousalka kernel: Call Trace:
Jul 12 10:22:52 rousalka kernel:  [<c02a7727>] sd_release+0x37/0x60
Jul 12 10:22:52 rousalka kernel:  [<c017e07f>] blkdev_put+0x2bf/0x330
Jul 12 10:22:52 rousalka kernel:  [<c0156591>] invalidate_inode_pages+0x21/0x30
Jul 12 10:22:52 rousalka kernel:  [<c017e03d>] blkdev_put+0x27d/0x330
Jul 12 10:22:52 rousalka kernel:  [<c0179914>] generic_shutdown_super+0x124/0x440
Jul 12 10:22:52 rousalka kernel:  [<c017ba7c>] kill_block_super+0x3c/0x50
Jul 12 10:22:52 rousalka kernel:  [<c0179151>] deactivate_super+0xd1/0x2b0
Jul 12 10:22:52 rousalka kernel:  [<c019b648>] free_vfsmnt+0x28/0x30
Jul 12 10:22:52 rousalka kernel:  [<c019cbfc>] sys_umount+0x3c/0x90
Jul 12 10:22:52 rousalka kernel:  [<c019cc69>] sys_oldumount+0x19/0x20
Jul 12 10:22:52 rousalka kernel:  [<c010a1ad>] sysenter_past_esp+0x52/0x71
Jul 12 10:22:52 rousalka kernel:
Jul 12 10:22:52 rousalka kernel: Code: ff 88 d8 00 00 00 8b 40 68 8b 80 8c 00 00
00 8b 00 85 c0 74


