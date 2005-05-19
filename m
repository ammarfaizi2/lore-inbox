Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVESVBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVESVBY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 17:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVESVBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 17:01:24 -0400
Received: from chaos.egr.duke.edu ([152.3.195.82]:32899 "EHLO
	chaos.egr.duke.edu") by vger.kernel.org with ESMTP id S261254AbVESVAh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 17:00:37 -0400
Date: Thu, 19 May 2005 17:00:22 -0400 (EDT)
From: Joshua Baker-LePain <jlb17@duke.edu>
X-X-Sender: jlb@chaos.egr.duke.edu
To: Gregory Brauer <greg@wildbrain.com>
cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Jakob Oestergaard <jakob@unthought.net>, Chris Wedgwood <cw@f00f.org>
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
In-Reply-To: <Pine.LNX.4.58.0505191537560.7094@chaos.egr.duke.edu>
Message-ID: <Pine.LNX.4.58.0505191650580.7094@chaos.egr.duke.edu>
References: <428511F8.6020303@wildbrain.com> <20050514184711.GA27565@taniwha.stupidest.org>
 <428B7D7F.9000107@wildbrain.com> <20050518175925.GA22738@taniwha.stupidest.org>
 <20050518195251.GY422@unthought.net> <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu>
 <428BA8E4.2040108@wildbrain.com> <Pine.LNX.4.58.0505191537560.7094@chaos.egr.duke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005 at 3:43pm, Joshua Baker-LePain wrote

> On Wed, 18 May 2005 at 1:43pm, Gregory Brauer wrote

> > We first saw the problem after 5 days in production, but since then
> > we took the server out of production and used the script
> > nfs_fsstress.sh located in this package:
> > 
> > http://prdownloads.sourceforge.net/ltp/ltp-full-20050505.tgz?download
> > 
> > We run the script on 5 client machines that are running RedHat 9
> > with kernel-smp-2.4.20-20.9 and nfs-utils-1.0.1-3.9.1.legacy and
> > are NFS mounting our 2.6 kernel server.  The longest time to OOPS
> 
> My clients are all RHEL3 (well, centos 3 actually).  I'll give the 
> nfs_fsstress scripts a shot.

Hrm.  That didn't take long.  I've got 6 clients (3 per interface) going 
with nfs_fsstress.sh, and I saw the following in the logs on the server 
after about 20 minutes.  Note, however, that I can still access the FS, 
both locally on the server and via NFS.  The scripts are still going, but 
some have already reported errors (obviously).

The server error:

May 19 16:47:10 norbert kernel: xfs_da_do_buf: bno 8388608
May 19 16:47:10 norbert kernel: dir: inode 2162706
May 19 16:47:10 norbert kernel: Filesystem "md0": XFS internal error xfs_da_do_buf(1) at line 2176 of file fs/xfs/xfs_da_btree.c.  Caller 0xf8c90148
May 19 16:47:10 norbert kernel:  [<f8c8fd5b>] xfs_da_do_buf+0x357/0x70d [xfs]
May 19 16:47:10 norbert kernel:  [<f8c90148>] xfs_da_read_buf+0x19/0x1e [xfs]
May 19 16:47:10 norbert kernel:  [<c013e67c>] buffered_rmqueue+0x17d/0x1a5
May 19 16:47:10 norbert kernel:  [<f8c90148>] xfs_da_read_buf+0x19/0x1e [xfs]
May 19 16:47:10 norbert kernel:  [<f8c8e7e7>] xfs_da_node_lookup_int+0x9d/0x2c0 [xfs]
May 19 16:47:10 norbert kernel:  [<f8c8e7e7>] xfs_da_node_lookup_int+0x9d/0x2c0 [xfs]
May 19 16:47:10 norbert kernel:  [<f8cc103e>] kmem_zone_alloc+0x3b/0x70 [xfs]
May 19 16:47:10 norbert kernel:  [<f8c98300>] xfs_dir2_node_lookup+0x34/0x96 [xfs]
May 19 16:47:10 norbert kernel:  [<f8c91a23>] xfs_dir2_lookup+0xde/0x107 [xfs]
May 19 16:47:10 norbert kernel:  [<c019e09d>] avc_has_perm_noaudit+0x8d/0xda
May 19 16:47:10 norbert kernel:  [<c019e09d>] avc_has_perm_noaudit+0x8d/0xda
May 19 16:47:10 norbert kernel:  [<f8cb8c1f>] xfs_dir_lookup_int+0x26/0xa8 [xfs]
May 19 16:47:10 norbert kernel:  [<f8cbd09b>] xfs_lookup+0x40/0x69 [xfs]
May 19 16:47:10 norbert kernel:  [<c016b6c2>] wake_up_inode+0x6/0x29
May 19 16:47:10 norbert kernel:  [<f8cc953d>] vfs_init_vnode+0x1e/0x22 [xfs]
May 19 16:47:10 norbert kernel:  [<f8cc910f>] linvfs_get_parent+0x43/0x75 [xfs]
May 19 16:47:10 norbert kernel:  [<c02c4022>] __cond_resched+0x14/0x39
May 19 16:47:10 norbert kernel:  [<c02c4022>] __cond_resched+0x14/0x39
May 19 16:47:10 norbert kernel:  [<c016941e>] d_alloc+0x197/0x1a1
May 19 16:47:10 norbert kernel:  [<c0169587>] d_alloc_anon+0xd1/0xee
May 19 16:47:10 norbert kernel:  [<c02c4022>] __cond_resched+0x14/0x39
May 19 16:47:10 norbert kernel:  [<f8b1c303>] find_exported_dentry+0x303/0x5e8 [exportfs]
May 19 16:47:10 norbert kernel:  [<c026f9c2>] skb_copy_datagram_iovec+0x4f/0x1e1
May 19 16:47:10 norbert kernel:  [<c026d423>] release_sock+0xf/0x4f
May 19 16:47:10 norbert kernel:  [<c0291ab6>] tcp_recvmsg+0x64a/0x681
May 19 16:47:10 norbert kernel:  [<c026d550>] sock_common_recvmsg+0x30/0x46
May 19 16:47:10 norbert kernel:  [<c026a230>] sock_recvmsg+0xef/0x10c
May 19 16:47:10 norbert kernel:  [<c028b67f>] dst_output+0x0/0x1a
May 19 16:47:10 norbert kernel:  [<c011b3ee>] recalc_task_prio+0x128/0x133
May 19 16:47:10 norbert kernel:  [<c011b481>] activate_task+0x88/0x95
May 19 16:47:10 norbert kernel:  [<c011b902>] try_to_wake_up+0x222/0x22d
May 19 16:47:10 norbert kernel:  [<c011cdbd>] __wake_up_common+0x36/0x51
May 19 16:47:11 norbert kernel:  [<c011ce01>] __wake_up+0x29/0x3c
May 19 16:47:11 norbert kernel:  [<f8b438d2>] svc_sock_enqueue+0x1d6/0x212 [sunrpc]
May 19 16:47:11 norbert kernel:  [<f8b4485d>] svc_tcp_recvfrom+0x304/0x376 [sunrpc]
May 19 16:47:11 norbert kernel:  [<f8c1beb5>] svc_expkey_lookup+0x1fc/0x330 [nfsd]
May 19 16:47:11 norbert kernel:  [<f8b1c88e>] export_decode_fh+0x61/0x6d [exportfs]
May 19 16:47:11 norbert kernel:  [<f8c17884>] nfsd_acceptable+0x0/0xba [nfsd]
May 19 16:47:11 norbert kernel:  [<f8b1c82d>] export_decode_fh+0x0/0x6d [exportfs]
May 19 16:47:11 norbert kernel:  [<f8c17cfa>] fh_verify+0x3bc/0x5bd [nfsd]
May 19 16:47:11 norbert kernel:  [<f8c17884>] nfsd_acceptable+0x0/0xba [nfsd]
May 19 16:47:11 norbert kernel:  [<f8c1ff2a>] nfsd3_proc_getattr+0x6f/0x77 [nfsd]
May 19 16:47:11 norbert kernel:  [<f8c21b06>] nfs3svc_decode_fhandle+0x0/0x8d [nfsd]
May 19 16:47:11 norbert kernel:  [<f8c165d7>] nfsd_dispatch+0xba/0x16f [nfsd]
May 19 16:47:11 norbert kernel:  [<f8b43446>] svc_process+0x420/0x6d6 [sunrpc]
May 19 16:47:11 norbert kernel:  [<f8c163b7>] nfsd+0x1cc/0x332 [nfsd]
May 19 16:47:11 norbert kernel:  [<f8c161eb>] nfsd+0x0/0x332 [nfsd]
May 19 16:47:11 norbert kernel:  [<c01041f1>] kernel_thread_helper+0x5/0xb
May 19 16:47:11 norbert kernel: nfsd: non-standard errno: -990


-- 
Joshua Baker-LePain
Department of Biomedical Engineering
Duke University
