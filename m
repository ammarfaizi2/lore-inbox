Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTKIXQq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 18:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbTKIXQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 18:16:46 -0500
Received: from mta02.alltel.net ([166.102.165.144]:55784 "EHLO
	mta02-srv.alltel.net") by vger.kernel.org with ESMTP
	id S261168AbTKIXQn (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 18:16:43 -0500
Date: Sun, 9 Nov 2003 18:16:24 -0500 (EST)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: Linux-kernel@vger.kernel.org
Subject: slab corruption in test9 (NFS related?)
Message-ID: <Pine.LNX.4.58.0311091815460.872@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forwarding to LKML as per Neil Brown.


---------- Forwarded message ----------
Date: Sun, 9 Nov 2003 17:21:47 -0500 (EST)
From: Burton Windle <bwindle@fint.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>, neilb@cse.unsw.edu.au
Subject: nfsd caused slab corruption in test9

Hello. I'm not quite sure whom to send this to, so my appologizes if you
aren't the right people.

Two linux boxes, both running Debian Testing, both x86 with 2.6.0-test9.
The nfs client was running the nhfsstone stress test against an ext3 NFS
exported share. After about an hour (I forgot it was running), the console on the
server woke up and spit this out:


Slab corruption: start=c9df6bcc, expend=c9df6c8b, problemat=c9df6bcc
Last user: [<c017f87e>](d_callback+0x1e/0x40)
Data: 6A**********************************************************************************************************************************************************************************************A5
Next: 71 F0 2C .7E F8 17 C0 A5 C2 0F 17 00 00 00 00 08 00 00 00 3C 4B 24 1D 00 00 00 00 0A 00 00 00 slab error in check_poison_obj(): cache
`dentry_cache': object was modified after freeing Call Trace:
 [<c0143653>] check_poison_obj+0xf3/0x180
 [<c0181d19>] d_alloc+0x19/0x360
 [<c01457da>] kmem_cache_alloc+0x13a/0x180
 [<c0181d19>] d_alloc+0x19/0x360
 [<c0174a3e>] cached_lookup+0x5e/0x80
 [<c0175ebb>] __lookup_hash+0x5b/0xa0
 [<c0175f10>] lookup_hash+0x10/0x20
 [<c0175f75>] lookup_one_len+0x55/0x80
 [<c01e7d05>] nfsd_lookup+0xa5/0x5e0
 [<c01f020b>] nfsd3_proc_lookup+0x8b/0x100
 [<c01e5147>] nfsd_dispatch+0xc7/0x1a0
 [<c0313a7f>] svc_process+0x49f/0x640
 [<c01e4c47>] nfsd+0x307/0x740
 [<c01e4940>] nfsd+0x0/0x740
 [<c0107429>] kernel_thread_helper+0x5/0x1c

# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_DEBUG_SPINLOCK=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_INFO is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y

Linux version 2.6.0-test9 (root@morpheus) (gcc version 3.3.2 20030908
(Debian prerelease)) #2 Sat Oct 25 19:33:41 EDT 2003


Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      implemented
e2fsprogs              1.35-WIP
nfs-utils              1.0.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.12
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0


--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461

