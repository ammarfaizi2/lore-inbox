Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265639AbTGIEfU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 00:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265653AbTGIEfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 00:35:20 -0400
Received: from franka.aracnet.com ([216.99.193.44]:6330 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265639AbTGIEfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 00:35:10 -0400
Date: Tue, 08 Jul 2003 21:49:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 892] New: kernel BUG at include/linux/list.h:148!
Message-ID: <53240000.1057726175@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=892

           Summary: kernel BUG at include/linux/list.h:148!
    Kernel Version: 2.5.74-mm2
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: ramon.rey@hispalinux.es


Distribution: 
Debian GNU/Linux Sid

Hardware Environment:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP]
(rev 47)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master
IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 02)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
00:13.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS

Software Environment:
libc6 2.3.1
xfree86 4.3
gnome 2.2

While running Xine, with no special options, I get this


kernel BUG at include/linux/list.h:148!
invalid operand: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c01185d9>]    Not tainted VLI
EFLAGS: 00010003
EIP is at remove_wait_queue+0x59/0x80
eax: cd785e34   ebx: cdc9e000   ecx: cd785e34   edx: cdc9feb0
esi: cdc9fea4   edi: 00000246   ebp: c6fa7640   esp: cdc9fe6c
ds: 007b   es: 007b   ss: 0068
Process syslogd (pid: 1270, threadinfo=cdc9e000 task=ce428120)
Stack: cd785e34 cdc9fea4 cdc9e000 c0194a85 cd785e30 c12d4aa0 00000000 ce428120 
       c0116f60 00000000 00000000 bffff000 cf5fb760 c121b6c8 00000000 ce428120 
       c0116f60 cd785e34 cd785e34 cd5d5005 000056ed 00000001 c6fa7640 cdc9ff70 
Call Trace:
 [<c0194a85>] devfs_d_revalidate_wait+0x145/0x160
 [<c0116f60>] default_wake_function+0x0/0x20
 [<c0116f60>] default_wake_function+0x0/0x20
 [<c01574e4>] do_lookup+0x44/0x80
 [<c015796e>] link_path_walk+0x44e/0x840
 [<c01585ea>] open_namei+0x8a/0x3a0
 [<c01494ec>] filp_open+0x2c/0x60
 [<c0149979>] sys_open+0x39/0x80
 [<c0108f67>] syscall_call+0x7/0xb

Code: 20 00 c7 46 0c 00 01 10 00 57 9d ff 4b 14 8b 43 08 a8 08 75 04 5b 5e 5f c3
5b 5e 5f e9 31 e9 ff ff 0f 0b 95 00 b2 cf 24 c0 eb cb <0f> 0b 94 00 b2 cf 24 c0
eb b9 90 90 90 90 90 90 90 90 90 90 90 
 <6>note: syslogd[1270] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c0116ee0>] schedule+0x3e0/0x400
 [<c013c6ee>] unmap_vmas+0x1ce/0x220
 [<c01400e2>] exit_mmap+0x62/0x180
 [<c011898e>] mmput+0x6e/0xe0
 [<c011c48d>] do_exit+0x10d/0x420
 [<c0109a60>] do_invalid_op+0x0/0xa0
 [<c0109814>] die+0xd4/0xe0
 [<c0109af1>] do_invalid_op+0x91/0xa0
 [<c01185d9>] remove_wait_queue+0x59/0x80
 [<c0130e19>] do_generic_mapping_read+0x119/0x400
 [<c0162d4e>] update_atime+0x6e/0xc0
 [<c01313b8>] __generic_file_aio_read+0x1d8/0x220
 [<c01091cd>] error_code+0x2d/0x40
 [<c01185d9>] remove_wait_queue+0x59/0x80
 [<c0194a85>] devfs_d_revalidate_wait+0x145/0x160
 [<c0116f60>] default_wake_function+0x0/0x20
 [<c0116f60>] default_wake_function+0x0/0x20
 [<c01574e4>] do_lookup+0x44/0x80
 [<c015796e>] link_path_walk+0x44e/0x840
 [<c01585ea>] open_namei+0x8a/0x3a0
 [<c01494ec>] filp_open+0x2c/0x60
 [<c0149979>] sys_open+0x39/0x80
 [<c0108f67>] syscall_call+0x7/0xb


 <6>note: xine[2691] exited with preempt_count 1

