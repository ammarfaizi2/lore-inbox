Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTGFPZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 11:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbTGFPZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 11:25:56 -0400
Received: from franka.aracnet.com ([216.99.193.44]:36754 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262373AbTGFPZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 11:25:43 -0400
Date: Sun, 06 Jul 2003 08:40:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bugme-new] [Bug 879] New: radeon fbdev oopses when watching a picture on the console with fbi 
Message-ID: <26120000.1057506003@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=879

           Summary: radeon fbdev oopses when watching a picture on the
                    console with fbi
    Kernel Version: 2.5.74-bk3
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: jmm@informatik.uni-bremen.de


Distribution: Debian testing
Hardware Environment: ATI Technologies Inc Radeon RV200 QW [Radeon 7500]
(prog-if 00 [VGA])
Software Environment: fbi 1.26 (http://bytesex.org/fbi.html
Problem Description: Displaying arbitraty pictures on the console with fbi leads
to the attached oopsen.

Steps to reproduce: $ fbi picture-file

 printing eip:
c02c0421
Oops: 0002 [#2]
CPU:    0
EIP:    0060:[<c02c0421>]    Not tainted
EFLAGS: 00010202
EIP is at _mmx_memcpy+0xe1/0x170
eax: 08058ee0   ebx: 00000001   ecx: 00000000   edx: 08058fe0
esi: dfe485c0   edi: 08058e20   ebp: d1613dec   esp: d1613ddc
ds: 007b   es: 007b   ss: 0068
Process fbi (pid: 512, threadinfo=d1612000 task=d5377980)
Stack: 08058e20 00000200 dfe48400 08058e20 d1613e40 c0366c75 08058fe0 dfe48400 
       00000200 c05613e0 dec57a00 d1613e9c c035ffea dffe0000 d1613e40 00000720 
       0000003b 00000001 c05613e0 0000000c 00000000 00000000 dffe0000 d1613e74 
Call Trace:
 [<c0366c75>] fb_copy_cmap+0x305/0x510
 [<c035ffea>] fbcon_cursor+0x27a/0x390
 [<c036379d>] fb_ioctl+0x15d/0x560
 [<c0163fe4>] dput+0x24/0x200
 [<c012a4e7>] in_group_p+0x27/0x30
 [<c015ad7c>] vfs_permission+0x7c/0x110
 [<c015ae3c>] permission+0x2c/0x50
 [<c0156fa2>] cdev_get+0x52/0xb0
 [<c0156b91>] chrdev_open+0xf1/0x230
 [<c0156aa0>] chrdev_open+0x0/0x230
 [<c014d040>] dentry_open+0x140/0x210
 [<c014cefb>] filp_open+0x5b/0x60
 [<c015f824>] sys_ioctl+0xf4/0x290
 [<c010923f>] syscall_call+0x7/0xb

Code: 0f 7f 42 20 0f 7f 4a 28 0f 7f 52 30 0f 7f 5a 38 4b 83 c2 40 
 <6>note: fbi[512] exited with preempt_count 2
Call Trace:
 [<c011ab9f>] __might_sleep+0x5f/0x80
 [<c013eeaa>] clear_page_tables+0xaa/0xb0
 [<c01418b9>] remove_shared_vm_struct+0x39/0xa0
 [<c014328b>] exit_mmap+0x12b/0x190
 [<c0117ee0>] do_page_fault+0x0/0x4c7
 [<c011b2a5>] mmput+0x65/0xc0
 [<c011ef36>] do_exit+0xd6/0x480
 [<c0117ee0>] do_page_fault+0x0/0x4c7
 [<c010a2e1>] die+0xe1/0xf0
 [<c011800e>] do_page_fault+0x12e/0x4c7
 [<c035ed33>] accel_clear+0x73/0x80
 [<c0117ee0>] do_page_fault+0x0/0x4c7
 [<c0109c49>] error_code+0x2d/0x38
 [<c02c0421>] _mmx_memcpy+0xe1/0x170
 [<c0366c75>] fb_copy_cmap+0x305/0x510
 [<c035ffea>] fbcon_cursor+0x27a/0x390
 [<c036379d>] fb_ioctl+0x15d/0x560
 [<c0163fe4>] dput+0x24/0x200
 [<c012a4e7>] in_group_p+0x27/0x30
 [<c015ad7c>] vfs_permission+0x7c/0x110
 [<c015ae3c>] permission+0x2c/0x50
 [<c0156fa2>] cdev_get+0x52/0xb0
 [<c0156b91>] chrdev_open+0xf1/0x230
 [<c0156aa0>] chrdev_open+0x0/0x230
 [<c014d040>] dentry_open+0x140/0x210
 [<c014cefb>] filp_open+0x5b/0x60
 [<c015f824>] sys_ioctl+0xf4/0x290
 [<c010923f>] syscall_call+0x7/0xb

agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode

