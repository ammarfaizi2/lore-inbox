Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269207AbUINWv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269207AbUINWv4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267940AbUINWti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:49:38 -0400
Received: from rozz.csail.mit.edu ([128.30.2.16]:58055 "EHLO
	rozz.csail.mit.edu") by vger.kernel.org with ESMTP id S266200AbUINWor
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 18:44:47 -0400
Date: Tue, 14 Sep 2004 18:44:43 -0400
From: Noah Meyerhans <noahm@csail.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.8.1 XFS (or nfsd?) crash
Message-ID: <20040914224443.GG9861@locutus.csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.  Over this past weekend, a fileserver running kernel 2.6.8.1
locked up completely on two occasions.  The machine is a dual P4 with 2
GB of RAM and an external 2.2 terabyte filesystem attached via a QLogic
ISP 2300 fibre-channel card.

>From the crash dump, it looks like there's a problem with XFS when
creating new files, but I'm sure you all have much more experience at
deciphering crash dump output than I do.  The crash dump, along with
the preceeding few lines from dmesg, is attached.  I'd be happy to
provide more information as you need it, or if there's anything else
that maybe helpful to you, just let me know.

Thanks.
noah


pagebuf_get: failed to lookup pages
pagebuf_get: failed to lookup pages
pagebuf_get: failed to lookup pages
pagebuf_get: failed to lookup pages
pagebuf_get: failed to lookup pages
pagebuf_get: failed to lookup pages
pagebuf_get: failed to lookup pages
svc: unknown version (0)
svc: unknown version (0)
svc: unknown version (0)
svc: unknown version (0)
svc: unknown version (0)
svc: unknown version (0)
svc: unknown version (0)
svc: unknown version (0)
svc: unknown version (0)
svc: unknown version (0)
svc: unknown version (0)
svc: unknown version (0)
svc: unknown version (0)
Unable to handle kernel paging request at virtual address 01000004
 printing eip:

c013b123
*pde = 00000000
Oops: 0002 [#1]
SMP 
Modules linked in: nfsd exportfs lockd sunrpc ipv6 dm_mod
CPU:    0
EIP:    0060:[<c013b123>]    Not tainted
EFLAGS: 00010046   (2.6.8.1) 
EIP is at cache_alloc_refill+0xf2/0x20a
eax: 01000000   ebx: c2228080   ecx: ea79c000   edx: f7dfc7a8
esi: 0000000e   edi: ea79c018   ebp: c2228090   esp: f583f99c
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 741, threadinfo=f583e000 task=f7847730)
Stack: 00000001 f583f9b8 c01ff4a5 ea79c018 f7dfc7a8 f7dfc7b0 f7dfc7b8 00000296 
       f7fadc00 c2114ee0 e3003472 c013b407 f7dfc780 000000d0 f7fadc00 c02456a2 
       f7dfc780 000000d0 c01683e3 f7fadc00 00000000 f7fadc00 e3003472 c0168ed0 
Call Trace:
 [<c01ff4a5>] xfs_da_brelse+0xa3/0xbc
 [<c013b407>] kmem_cache_alloc+0x4b/0x4d
 [<c02456a2>] linvfs_alloc_inode+0x2d/0x3d
 [<c01683e3>] alloc_inode+0x1b/0x149
 [<c0168ed0>] get_new_inode_fast+0x27/0xda

 [<c0169301>] iget_locked+0x97/0xae
 [<c021628e>] xfs_iget+0x63/0x189
 [<c02317ba>] xfs_dir_lookup_int+0xb4/0x12b
 [<c0236e61>] xfs_lookup+0x50/0x88
 [<c02432de>] linvfs_lookup+0x67/0x9f
 [<c015e6f2>] __lookup_hash+0xa6/0xd6
 [<c015e741>] lookup_hash+0x1f/0x23
 [<c015e7ac>] lookup_one_len+0x67/0x74
 [<f8a2ecab>] compose_entry_fh+0x5a/0x111 [nfsd]
 [<f8a2f196>] encode_entry+0x434/0x55c [nfsd]
 [<c023e3ff>] pagebuf_free+0x81/0xd5
 [<c01ff4a5>] xfs_da_brelse+0xa3/0xbc
 [<c0205d09>] xfs_dir2_leaf_getdents+0x7d6/0xc3f
 [<c0240d61>] linvfs_readdir+0x1a1/0x23b
 [<c01623bc>] vfs_readdir+0x88/0xa0
 [<f8a2f2e5>] nfs3svc_encode_entry_plus+0x0/0x27 [nfsd]
 [<f8a261d9>] nfsd_readdir+0x9f/0x128 [nfsd]
 [<f8a2f2e5>] nfs3svc_encode_entry_plus+0x0/0x27 [nfsd]
 [<f8a05c2b>] svcauth_unix_accept+0x258/0x291 [sunrpc]
 [<f8a2c093>] nfsd3_proc_readdirplus+0xee/0x1d6 [nfsd]
 [<f8a2f2e5>] nfs3svc_encode_entry_plus+0x0/0x27 [nfsd]
 [<f8a206c0>] nfsd_dispatch+0xd9/0x1d6 [nfsd]

 [<f8a01ecd>] svc_process+0x4b0/0x611 [sunrpc]
 [<f8a20443>] nfsd+0x1ea/0x38e [nfsd]
 [<f8a20259>] nfsd+0x0/0x38e [nfsd]
 [<c0103da1>] kernel_thread_helper+0x5/0xb
Code: 89 50 04 89 02 c7 41 04 00 02 20 00 66 83 79 14 ff c7 01 00 
 
