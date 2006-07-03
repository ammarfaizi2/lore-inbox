Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWGCI1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWGCI1S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 04:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWGCI1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 04:27:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51915 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750949AbWGCI1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 04:27:17 -0400
Date: Mon, 3 Jul 2006 01:27:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 7/8] inode-diet: Use a union for i_blocks and i_size,
 i_rdev and i_devices
Message-Id: <20060703012711.1bbf3af8.akpm@osdl.org>
In-Reply-To: <20060703010023.720991000@candygram.thunk.org>
References: <20060703005333.706556000@candygram.thunk.org>
	<20060703010023.720991000@candygram.thunk.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Jul 2006 20:53:40 -0400
"Theodore Ts'o" <tytso@mit.edu> wrote:

> The i_blocks and i_size fields are only used for regular files.  So we
> move them into the union, along with i_rdev and i_devices, which are
> only used by block or character devices.

It appears that device nodes in tmpfs tripped this up.

audit(1151888221.911:3): policy loaded auid=4294967295
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
audit(1151913428.996:4): avc:  denied  { audit_write } for  pid=396 comm="hwclock" capability=29 scontext=system_u:system_r:hwclock_t:s0 tcontext=system_u:system_r:hwclock_t:s0 tclass=capability
------------[ cut here ]------------
kernel BUG at mm/shmem.c:693!
invalid opcode: 0000 [#1]
4K_STACKS 
last sysfs file: /block/ram0/removable
Modules linked in: generic ext3 jbd ide_disk ide_core
CPU:    0
EIP:    0060:[<c0151d59>]    Not tainted VLI
EFLAGS: 00010202   (2.6.17-mm6 #3) 
EIP is at shmem_delete_inode+0x89/0xa4
eax: c04408e0   ebx: f7c5915c   ecx: f7c59300   edx: c0384ae0
esi: f7c5915c   edi: f7f25540   ebp: f7cafd14   esp: f7f0cec8
ds: 007b   es: 007b   ss: 0068
Process MAKEDEV (pid: 417, ti=f7f0c000 task=c1d13aa0 task.ti=f7f0c000)
Stack: f7c5915c c0151cd0 f7caa694 c01695c9 f7c5915c f7c70f14 c01690af f7c70f14 
       c01684ba 00000000 f7c70f14 c0162180 f7c70f14 c1c59000 c1c56000 00000000 
       f7cafd14 f7cafd14 f7ff2c40 01c9c1ec 00000004 c1c56005 00000010 00000000 
Call Trace:
 [<c0151cd0>] shmem_delete_inode+0x0/0xa4
 [<c01695c9>] generic_delete_inode+0x9d/0xf5
 [<c01690af>] iput+0x64/0x66
 [<c01684ba>] dput+0xfb/0x113
 [<c0162180>] sys_renameat+0x163/0x1b4
 [<c0168405>] dput+0x46/0x113
 [<c01621f8>] sys_rename+0x27/0x2b
 [<c0102ac5>] sysenter_past_esp+0x56/0x79
Code: 3c 00 00 00 00 e8 bb e1 ff ff 8b 56 f8 8d 4e f8 39 ca 74 0e 8b 41 04 89 42 04 89 10 89 49 04 89 4e f8 83 be e8 00 00 00 00 74 08 <0f> 0b b5 02 56 72 2e c0 83 7f 08 00 74 03 ff 47 0c 5b 89 f0 5e 
EIP: [<c0151d59>] shmem_delete_inode+0x89/0xa4 SS:ESP 0068:f7f0cec8
 
