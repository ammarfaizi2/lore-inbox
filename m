Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262881AbSKJB0w>; Sat, 9 Nov 2002 20:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262882AbSKJB0w>; Sat, 9 Nov 2002 20:26:52 -0500
Received: from lsanca2-ar27-4-3-067-005.lsanca2.dsl-verizon.net ([4.3.67.5]:32901
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S262881AbSKJB0u>; Sat, 9 Nov 2002 20:26:50 -0500
Date: Sat, 9 Nov 2002 17:33:26 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.46: access permission filesystem
In-Reply-To: <87adko581z.fsf@goat.bogus.local>
Message-ID: <Pine.LNX.4.44.0211091728140.3608-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2002, Olaf Dietsche wrote:

> This *untested* patch adds a new permission managing file system.
> Furthermore, it adds two modules, which make use of this file system.

Hi.

I've just applied this to 2.5.46, and I'm building accessfs as modules.

During boot (my scripts do a probe for the accessfs modules), I get:

====

Debug: sleeping function called from illegal context at mm/slab.c:1304
Call Trace:
 [<c0115fa6>] __might_sleep+0x56/0x60
 [<c0130da1>] kmem_flagcheck+0x21/0x50
 [<d0963319>] .rodata.str1.1+0xc9/0xd8 [userports]
 [<c013169b>] kmalloc+0x4b/0x130
 [<d096331c>] .rodata.str1.1+0xcc/0xd8 [userports]
 [<c0130da1>] kmem_flagcheck+0x21/0x50
 [<d0963319>] .rodata.str1.1+0xc9/0xd8 [userports]
 [<d0961320>] accessfs_rootdir+0x0/0x34 [accessfs]
 [<d0960409>] accessfs_node_init+0x29/0xc0 [accessfs]
 [<d0961320>] accessfs_rootdir+0x0/0x34 [accessfs]
 [<d0961320>] accessfs_rootdir+0x0/0x34 [accessfs]
 [<d096331c>] .rodata.str1.1+0xcc/0xd8 [userports]
 [<d0960554>] accessfs_mkdir+0x44/0x80 [accessfs]
 [<d0961320>] accessfs_rootdir+0x0/0x34 [accessfs]
 [<d0963319>] .rodata.str1.1+0xc9/0xd8 [userports]
 [<d0963319>] .rodata.str1.1+0xc9/0xd8 [userports]
 [<d0961320>] accessfs_rootdir+0x0/0x34 [accessfs]
 [<d0960611>] accessfs_make_dirpath_Rf12799b4+0x81/0xd0 [accessfs]
 [<d0961320>] accessfs_rootdir+0x0/0x34 [accessfs]
 [<d0963319>] .rodata.str1.1+0xc9/0xd8 [userports]
 [<d096331c>] .rodata.str1.1+0xcc/0xd8 [userports]
 [<d0961320>] accessfs_rootdir+0x0/0x34 [accessfs]
 [<d0963111>] init_module+0x11/0xe0 [userports]
 [<d0963319>] .rodata.str1.1+0xc9/0xd8 [userports]
 [<d0963060>] accessfs_ip_prot_sock+0x0/0x50 [userports]
 [<c01195b5>] sys_init_module+0x535/0x620
 [<d0963404>] .kmodtab+0x0/0xc [userports]
 [<d0963060>] accessfs_ip_prot_sock+0x0/0x50 [userports]
 [<c0108bbf>] syscall_call+0x7/0xb

There is already a security framework initialized, register_security 
failed.

====

The proc/access/net/ip/bind ports appear ok and I can change permissions 
on them. (although I haven't tested to see if their permissions actually 
have effect).

I also get

Debug: sleeping function called from illegal context at mm/slab.c:1304
Call Trace:
 [<c0115fa6>] __might_sleep+0x56/0x60
 [<c0130da1>] kmem_flagcheck+0x21/0x50
 [<c0131585>] kmem_cache_alloc+0x15/0xe0
 [<c028fca0>] ip_local_deliver_finish+0x0/0x150
 [<c02a925f>] tcp_v4_checksum_init+0x7f/0x110
 [<c0131b10>] kfree+0x1d0/0x220
 [<c0155050>] alloc_inode+0x30/0x170
 [<c0155a75>] get_new_inode_fast+0x15/0xd0
 [<c012c6e6>] file_read_actor+0x86/0x100
 [<c0155e92>] iget_locked+0xa2/0xb0
 [<c01315d9>] kmem_cache_alloc+0x69/0xe0
 [<d0961340>] accessfs_rootdir+0x20/0x34 [accessfs]
 [<d09602a2>] accessfs_lookup+0x42/0xa0 [accessfs]
 [<c0154349>] d_alloc+0x19/0x180
 [<c014ab9a>] real_lookup+0x5a/0xe0
 [<c014ae50>] do_lookup+0xb0/0x200
 [<c012cde5>] filemap_nopage+0x115/0x270
 [<c0109526>] apic_timer_interrupt+0x1a/0x20
 [<c014b54b>] link_path_walk+0x5ab/0x8f0
 [<c014a8ae>] getname+0x5e/0xa0
 [<c014bc84>] __user_walk+0x24/0x40
 [<c0147964>] vfs_lstat+0x14/0x50
 [<c0147e91>] sys_lstat64+0x11/0x30
 [<c0113560>] do_page_fault+0x0/0x465
 [<c01095a1>] error_code+0x2d/0x38
 [<c0108bbf>] syscall_call+0x7/0xb

followed by:

Debug: sleeping function called from illegal context at mm/slab.c:1304
Call Trace:
 [<c0115fa6>] __might_sleep+0x56/0x60
 [<c0130da1>] kmem_flagcheck+0x21/0x50
 [<d09a63f5>] .rodata.str1.1+0x1e5/0x1f8 [usercaps]
 [<c013169b>] kmalloc+0x4b/0x130
 [<c0129d79>] do_no_page+0x39/0x2b0
 [<d09a69c0>] caps+0x0/0x160 [usercaps]
 [<c0130da1>] kmem_flagcheck+0x21/0x50
 [<d09a63f5>] .rodata.str1.1+0x1e5/0x1f8 [usercaps]
 [<d09a63fb>] .rodata.str1.1+0x1eb/0x1f8 [usercaps]
 [<d0960409>] accessfs_node_init+0x29/0xc0 [accessfs]
 [<d09a63f5>] .rodata.str1.1+0x1e5/0x1f8 [usercaps]
 [<d09a63fb>] .rodata.str1.1+0x1eb/0x1f8 [usercaps]
 [<d09a69c0>] caps+0x0/0x160 [usercaps]
 [<d09604f7>] accessfs_mknod+0x57/0x70 [accessfs]
 [<d09a63f5>] .rodata.str1.1+0x1e5/0x1f8 [usercaps]
 [<d09a69c0>] caps+0x0/0x160 [usercaps]
 [<d09a6190>] init_module+0x70/0xc0 [usercaps]
 [<d09a63f5>] .rodata.str1.1+0x1e5/0x1f8 [usercaps]
 [<d09a69c0>] caps+0x0/0x160 [usercaps]
 [<c01195b5>] sys_init_module+0x535/0x620
 [<d09a64e4>] .kmodtab+0x0/0xc [usercaps]
 [<d09a6060>] accessfs_capable+0x0/0x40 [usercaps]
 [<c0108bbf>] syscall_call+0x7/0xb

There is already a security framework initialized, register_security 
failed.

The directory /proc/access/capabilities appears, but it has no contents.

Ben

-- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
http://www.hawaga.org.uk/ben/

