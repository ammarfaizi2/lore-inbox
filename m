Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbUCCQe2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 11:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbUCCQe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 11:34:28 -0500
Received: from [195.23.16.24] ([195.23.16.24]:46482 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262508AbUCCQe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 11:34:26 -0500
Message-ID: <404608C0.7040008@grupopie.com>
Date: Wed, 03 Mar 2004 16:33:04 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Unable to handle kernel paging request
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this shortly after reconnecting a stale smb connection on a 2.6.4-rc1 
vanilla kernel:

(removed hostname and date information to make it less verbose)

04:03:31 SMB connection re-established (-5)
04:03:47 Unable to handle kernel paging request at virtual address c1f16f1c
04:03:47 printing eip:
04:03:47 c01fc2f8
04:03:47 ws15t1 syslog.alert klogd: *pde = 00007067
04:03:47 ws15t1 syslog.alert klogd: *pte = 01f16000
04:03:47 Oops: 0000 [#1]
04:03:47 PREEMPT DEBUG_PAGEALLOC
04:03:47 CPU:    0
04:03:47 EIP:    0060:[01fc2f8>]    Not tainted
04:03:47 EFLAGS: 00010246
04:03:47 EIP is at smb_add_request+0x238/0x520
04:03:47 eax: 00000000   ebx: c3a22000   ecx: c29a2e60   edx: c6940f78
04:03:47 esi: c1f16eec   edi: c29a2e60   ebp: c3a23dc4   esp: c3a23d74
04:03:47 ds: 007b   es: 007b   ss: 0068
04:03:47 Process bash (pid: 93, threadinfo=c3a22000 task=c3a319e0)
04:03:47 Stack: 0000000b c3cec000 c1f16eec c6dcfe00 c1f16ef8 00000000 00000040 
c1f16f24
04:03:47        c29a2df8 00000000 c3a319e0 c011eab0 00100100 00200200 00000401 
c3cec006
04:03:47        c29a2df8 00000002 c1f16eec c3cec000 c3a23df0 c01f3434 c2529f38 
00000000
04:03:47 Call Trace:
04:03:47  [011eab0>] default_wake_function+0x0/0x10
04:03:47  [01f3434>] smb_proc_getattr_trans2+0x84/0x100
04:03:47  [01f3734>] smb_proc_getattr_trans2_all+0x44/0xe0
04:03:47  [01f114c>] smb_init_dirent+0x4c/0x60
04:03:47  [01f1222>] smb_proc_getattr+0x32/0x50
04:03:47  [01f851c>] smb_refresh_inode+0x1c/0x100
04:03:47  [016d8ac>] __getblk+0x1c/0x40
04:03:47  [01bbc4a>] ext3_getblk+0xca/0x260
04:03:47  [01f86cc>] smb_revalidate_inode+0xcc/0x200
04:03:47  [011c826>] kernel_map_pages+0x16/0x50
04:03:47  [01f8bec>] smb_getattr+0x1c/0x50
04:03:47  [01f8bd0>] smb_getattr+0x0/0x50
04:03:47  [01783f1>] vfs_getattr+0x41/0xc0
04:03:47  [01789bf>] vfs_lstat+0x3f/0x60
04:03:47  [016adb0>] filp_dtor+0x0/0x190
04:03:47  [01789f4>] sys_lstat64+0x14/0x30
04:03:47  [010d12d>] do_IRQ+0x2dd/0x430
04:03:47  [016b193>] __fput+0x83/0xd0
04:03:47  [0109fef>] syscall_call+0x7/0xb
04:03:47
04:03:47 Code: 8b 46 30 c7 04 24 a0 da 41 c0 89 44 24 0c b8 58 a6 3f c0 89

The directory was mounted and was idle (no file activity at all) for about 20 
hours before this happened.

I also have the complete syslog (it is only 400 lines), meminfo and slabinfo 
from the same machine at the time of the dump, and I can post it if you find it 
useful.

This is a somewhat "embedded" system, using a transmeta crusoe processor at 
500MHz. The kernel configuration includes BlueZ modules, ethernet bridging and 
cardbus (yenta) support. These are the most uncommon features.

The samba server was version 2.2.2 (which is quite old), but the client is the 
latest kernel available.

I saw this only once and I don't believe this is going to be easy to reproduce.

After the dump the machine continued to operate normally (including acesing the 
samba mounted directory), except for the shell that was doing a tab completion 
on the directory name, that exited.

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

