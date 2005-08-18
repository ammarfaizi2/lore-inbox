Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVHRStI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVHRStI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 14:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVHRStI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 14:49:08 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:30861 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932388AbVHRStG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 14:49:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QLPsjlDatmodWKloXIcKPc1Cb4eW/ghXqjzgBIC1XVZo94aQJE7zRY/pQ7F5nxfmrJESWXElA3nD/HS0E8AunYGsYQrtP/VMAQUeNWok1msPTDmddX2YtqAd3BFcp8Hu0t1TrMyguwqdQN4+EcJ51fV1CIya78DZG8ppiyi/fv8=
Message-ID: <dff3752705081811498984f5@mail.gmail.com>
Date: Thu, 18 Aug 2005 18:49:05 +0000
From: kristina clair <kclair@gmail.com>
To: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
In-Reply-To: <428D0D1E.9070607@wildbrain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <428511F8.6020303@wildbrain.com>
	 <20050518175925.GA22738@taniwha.stupidest.org>
	 <20050518195251.GY422@unthought.net>
	 <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu>
	 <428BA8E4.2040108@wildbrain.com>
	 <Pine.LNX.4.58.0505191537560.7094@chaos.egr.duke.edu>
	 <Pine.LNX.4.58.0505191650580.7094@chaos.egr.duke.edu>
	 <Pine.LNX.4.58.0505191740550.7094@chaos.egr.duke.edu>
	 <Pine.LNX.4.58.0505191746470.7094@chaos.egr.duke.edu>
	 <428D0D1E.9070607@wildbrain.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just come across this oops.  We're running gentoo with a 2.6.11
kernel, xfs + nfs + lvm (+hardware raid).

nfsd was not responding, and the load was at 27.  the machine was
responsive, other than nfsd.  everything had been responsive for at
least 9 months previous to this.

It seems like from what I've read of this thread, most of the other
reports have been from earlier kernel versions?  Is there any
recommended fix at this point?

Thanks,
Kristina

xfs_iget_core: ambiguous vns: vp/0xc54858a0, invp/0xd391aa08
------------[ cut here ]------------
kernel BUG at fs/xfs/support/debug.c:106!
invalid operand: 0000 [#1]
SMP
Modules linked in: iptable_filter ip_tables usbcore xfs dm_snapshot
3w_9xxx e1000
CPU:    0
EIP:    0060:[<f8dfaa81>]    Not tainted VLI
EFLAGS: 00010246   (2.6.11)
EIP is at cmn_err+0xa1/0xc0 [xfs]
eax: f8e0f284   ebx: f8dfdce0   ecx: c03d2890   edx: 00000293
esi: f8dfd3d7   edi: f8e0fb7e   ebp: 00000000   esp: f6e17b34
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 6689, threadinfo=f6e17000 task=f7fef530)
Stack: f8dfd3d7 f8dfd39e f8e0fb40 00000293 f6e17000 f8dfdce0 00000000 e7598760
       f8dc77e0 00000000 f8dfdce0 c54858a0 d391aa08 c3120bf4 482c5825 00000000
       f72d81c0 482c5825 f70afc00 c0172e7c f72d81bc 00000000 00000000 e7598760
Call Trace:
 [<f8dc77e0>] xfs_iget_core+0x4e0/0x630 [xfs]
 [<c0172e7c>] iget_locked+0xac/0xe0
 [<f8dc7aa4>] xfs_iget+0x174/0x1b0 [xfs]
 [<f8de67d8>] xfs_vget+0x78/0x100 [xfs]
 [<f8df9d63>] vfs_vget+0x43/0x50 [xfs]
 [<f8d8a321>] linvfs_get_dentry+0x51/0x90 [xfs]
 [<c01d6944>] find_exported_dentry+0x44/0x650
 [<c03006b4>] kfree_skbmem+0x24/0x30
 [<c03246a0>] tcp_recvmsg+0x2e0/0x730
 [<c031fed0>] dst_output+0x0/0x30
 [<c0300158>] sock_common_recvmsg+0x58/0x80
 [<c02fc6f3>] sock_recvmsg+0xf3/0x110
 [<c0364a7c>] schedule+0x39c/0xc00
 [<c0116d90>] default_wake_function+0x0/0x20
 [<c0114c38>] recalc_task_prio+0x88/0x150
 [<c0114d90>] activate_task+0x90/0xb0
 [<c0115302>] try_to_wake_up+0x252/0x280
 [<c0116df1>] __wake_up_common+0x41/0x70
 [<c0116e5e>] __wake_up+0x3e/0x60
 [<c01de475>] svc_expkey_lookup+0x3a5/0x410
 [<c035bab2>] svc_sock_enqueue+0x142/0x2a0
 [<f8d8a29a>] linvfs_decode_fh+0x5a/0x90 [xfs]
 [<c01d93a0>] nfsd_acceptable+0x0/0x110
 [<c01d96bc>] fh_verify+0x20c/0x5b0
 [<c01d93a0>] nfsd_acceptable+0x0/0x110
 [<c035efe5>] svcauth_unix_set_client+0xb5/0xd0
 [<c01daf1f>] nfsd_access+0x2f/0x100
 [<c01e28cc>] nfsd3_proc_access+0x8c/0xd0
 [<c01d7947>] nfsd_dispatch+0xd7/0x200
 [<c035b781>] svc_process+0x4b1/0x6a0
 [<c0116d90>] default_wake_function+0x0/0x20
 [<c01d76eb>] nfsd+0x1cb/0x350
 [<c01d7520>] nfsd+0x0/0x350
 [<c01009e5>] kernel_thread_helper+0x5/0x10
Code: b8 40 fb e0 f8 89 44 24 08 8b 04 ad a0 f2 e0 f8 89 44 24 04 e8
01 0a 32 c7 8b 54 24 0c b8 84 f2 e0
 f8 e8 93 b8 56 c7 85 ed 75 08 <0f> 0b 6a 00 be d3 df f8 83 c4 10 5b
5e 5f 5d c3 eb 0d 90 90 90
