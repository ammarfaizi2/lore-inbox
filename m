Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965220AbVIOH3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbVIOH3u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbVIOH3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:29:50 -0400
Received: from gwbw.xs4all.nl ([213.84.100.200]:37521 "EHLO
	laptop.blackstar.nl") by vger.kernel.org with ESMTP id S965220AbVIOH3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:29:48 -0400
Subject: 2.6.14-rc1 - kernel BUG at fs/ntfs/aops.c:403
From: Bas Vermeulen <bvermeul@blackstar.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 15 Sep 2005 09:29:22 +0200
Message-Id: <1126769362.5358.3.camel@laptop.blackstar.nl>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-14.WB1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a kernel BUG when mounting my (dirty) NTFS volume.

Sep 12 18:54:47 laptop kernel: [4294708.961000] NTFS volume version 3.1.
Sep 12 18:54:47 laptop kernel: [4294708.961000] NTFS-fs error (device
sda2): load_system_files(): Volume is dirty.  Mounting read-only.  Run
chkdsk and mount in Windows.
Sep 12 18:54:47 laptop kernel: [4294709.063000] ------------[ cut
here ]------------
Sep 12 18:54:47 laptop kernel: [4294709.063000] kernel BUG at
fs/ntfs/aops.c:403!
Sep 12 18:54:47 laptop kernel: [4294709.063000] invalid operand: 0000
[#1]
Sep 12 18:54:47 laptop kernel: [4294709.063000] PREEMPT 
Sep 12 18:54:47 laptop kernel: [4294709.063000] Modules linked in:
nls_iso8859_1 yenta_socket rsrc_nonstatic uhci_hcd floppy
Sep 12 18:54:47 laptop kernel: [4294709.063000] CPU:    0
Sep 12 18:54:47 laptop kernel: [4294709.063000] EIP:    0060:
[<c0269d8f>]    Not tainted VLI
Sep 12 18:54:47 laptop kernel: [4294709.063000] EFLAGS: 00010203
(2.6.13-g2da65feb) 
Sep 12 18:54:47 laptop kernel: [4294709.063000] EIP is at ntfs_readpage
+0x2bf/0x2d0
Sep 12 18:54:47 laptop kernel: [4294709.063000] eax: 00000070   ebx:
c13dfb40   ecx: 00000020   edx: deede2bc
Sep 12 18:54:47 laptop kernel: [4294709.063000] esi: 00000000   edi:
c13dfb40   ebp: deede220   esp: df2b1c14
Sep 12 18:54:47 laptop kernel: [4294709.063000] ds: 007b   es: 007b
ss: 0068
Sep 12 18:54:47 laptop kernel: [4294709.063000] Process mount (pid:
2041, threadinfo=df2b0000 task=df830550)
Sep 12 18:54:47 laptop kernel: [4294709.063000] Stack: deede360 00000000
c13dfb40 df2b0000 deede35c c014576a 00000000 00000000 
Sep 12 18:54:47 laptop kernel: [4294709.063000]        c13dfb40 c13dfb40
c13dfb40 c13dfb40 00000000 c13dfb40 deede35c c014734c 
Sep 12 18:54:47 laptop kernel: [4294709.063000]        000000d0 c0269ad0
00000000 00000000 deede35c 00000000 00000000 c0271fb5 
Sep 12 18:54:47 laptop kernel: [4294709.063000] Call Trace:
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c014576a>]
add_to_page_cache+0x5a/0xb0
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c014734c>]
read_cache_page+0xac/0x270
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c0269ad0>]
ntfs_readpage+0x0/0x2d0
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c0271fb5>]
ntfs_lookup_inode_by_name+0x5d5/0xe50
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c0275749>]
ntfs_read_locked_inode+0x749/0xf10
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c0284c84>]
check_windows_hibernation_status+0x54/0x2f0
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c02749f0>]
ntfs_init_locked_inode+0x0/0x100
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c0286524>]
load_system_files+0x7e4/0xd40
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c0287bf2>]
ntfs_fill_super+0x242/0x7e0
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c016cc01>]
get_sb_bdev+0xb1/0x110
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c02881c9>]
ntfs_get_sb+0x19/0x1e
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c02879b0>]
ntfs_fill_super+0x0/0x7e0
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c016ce9a>]
do_kern_mount+0x9a/0x170
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c018423b>]
do_new_mount+0x6b/0xc0
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c018496f>] do_mount
+0x1cf/0x1e0
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c0181613>] iput
+0x53/0x70
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c0184749>]
copy_mount_options+0x59/0xb0
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c0184d09>] sys_mount
+0x79/0xb0
Sep 12 18:54:47 laptop kernel: [4294709.063000]  [<c010302b>]
sysenter_past_esp+0x54/0x75
Sep 12 18:54:47 laptop kernel: [4294709.063000] Code: ff 83 c1 80 75 0e
be f3 ff ff ff 89 74 24 1c e9 1e ff ff ff 0f 0b 8d 01 ce 2a 75 c0 eb e8
0f 0b 94 01 ce 2a 75 c0 e9 43 ff ff ff <0f> 0b 93 01 ce 2a 75 c0 e9 2b
ff ff ff 8d 74 26 00 55 57 56 53 

Not sure what's the cause, it started after the last NTFS code update.

-- 
Bas Vermeulen <bvermeul@blackstar.nl>

