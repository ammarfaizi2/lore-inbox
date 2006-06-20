Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965088AbWFTGjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbWFTGjA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbWFTGi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:38:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:27290 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965088AbWFTGi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:38:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HXmpwuXfWHgGZ3w/ppHg5cxNGoMAT1nSPWLiA9oevhas0iVOh9Ig8kJdr0P02+AbtNRXrEpAUckJdn9qMX5zHFSe0WAZXI2lnSQ6w+3rnjatgZExWDLmxceKcYEST9kzHtIaq6hN++T5o12tD0/jjiNyxKKndbHK1AzaziPfw+U=
Message-ID: <3aa654a40606192338v751150fp5645d1d2943316ea@mail.gmail.com>
Date: Mon, 19 Jun 2006 23:38:58 -0700
From: "Avuton Olrich" <avuton@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: XFS crashed twice, once in 2.6.16.20, next in 2.6.17, reproducable
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
In-Reply-To: <20060620161006.C1079661@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com>
	 <20060620161006.C1079661@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/06, Nathan Scott <nathans@sgi.com> wrote:
> On Mon, Jun 19, 2006 at 12:44:58AM -0700, Avuton Olrich wrote:
> > ..
> > Hello, when trying to recursively delete a directory (same directory
> > twice) from my 500gb hard drive I get a problem. It crashed first in
> > 2.6.16.20, then I upgraded to try to get rid of the issue. This one is
> > from 2.6.17:
>
> How reproducible is it?  Is it reproducible even after xfs_repair?

Happens every time I try to remove that inode (directory). xfs_repair
ends with a fatal error:

Phase 6 - check inode connectivity...
        - resetting contents of realtime bitmap and summary inodes
        - ensuring existence of lost+found directory
        - traversing filesystem starting at / ...
rebuilding directory inode 128

fatal error -- can't read block 16777216 for directory inode 1507133580

> If so, can you try Mandy's patch below, to see if it is addressing
> the root cause of your problem?  If problems persist, a reproducible
> test case would be wonderful, if one can be found..

I'm sorry, the patch doesn't change anything. It never makes it though
the xfs_repair due to the above error. If there's any information I
can get for you please let me know.

I'm not sure if it changes anything, but here's the message after the patch:
xfs_da_do_buf: bno 16777216
dir: inode 1507133580
Filesystem "sda1": XFS internal error xfs_da_do_buf(1) at line 2119 of
file /usr/src/linux-stable-cold/fs/xfs/xfs_da_btree.c.  Caller
0xb01d9b63
 <b01d9720> xfs_da_do_buf+0x40e/0x7c7  <b01d9b63> xfs_da_read_buf+0x30/0x35
 <b01e43d9> xfs_dir2_leafn_lookup_int+0x2f3/0x453  <b01d9b63>
xfs_da_read_buf+0x30/0x35
 <b01e2ba5> xfs_dir2_node_removename+0x288/0x483  <b01e2ba5>
xfs_dir2_node_removename+0x288/0x483
 <b01ddbd3> xfs_dir2_removename+0xce/0xd5  <b020ff61> kmem_zone_alloc+0x4d/0x98
 <b020d0f3> xfs_remove+0x2ac/0x444  <b0215e83> xfs_vn_unlink+0x17/0x3b
 <b016190c> mntput_no_expire+0x11/0x7e  <b01575f1> link_path_walk+0xaf/0xb9
 <b011e734> __capable+0xc/0x1f  <b0155827> generic_permission+0x93/0xcc
 <b01558f8> permission+0x98/0xa4  <b0155da0> may_delete+0x32/0xe9
 <b0156243> vfs_unlink+0x6d/0xa3  <b0157c7a> do_unlinkat+0x92/0x125
 <b0159a0d> sys_getdents64+0x9c/0xa6  <b0102b67> sysenter_past_esp+0x54/0x75
Filesystem "sda1": XFS internal error xfs_trans_cancel at line 1150 of
file /usr/src/linux-stable-cold/fs/xfs/xfs_trans.c.  Caller 0xb020d262
 <b0204b4c> xfs_trans_cancel+0x59/0xe5  <b020d262> xfs_remove+0x41b/0x444
 <b020d262> xfs_remove+0x41b/0x444  <b0215e83> xfs_vn_unlink+0x17/0x3b
 <b016190c> mntput_no_expire+0x11/0x7e  <b01575f1> link_path_walk+0xaf/0xb9
 <b011e734> __capable+0xc/0x1f  <b0155827> generic_permission+0x93/0xcc
 <b01558f8> permission+0x98/0xa4  <b0155da0> may_delete+0x32/0xe9
 <b0156243> vfs_unlink+0x6d/0xa3  <b0157c7a> do_unlinkat+0x92/0x125
 <b0159a0d> sys_getdents64+0x9c/0xa6  <b0102b67> sysenter_past_esp+0x54/0x75
xfs_force_shutdown(sda1,0x8) called from line 1151 of file
/usr/src/linux-stable-cold/fs/xfs/xfs_trans.c.  Return address =
0xb0218b6c
Filesystem "sda1": Corruption of in-memory data detected.  Shutting
down filesystem: sda1
Please umount the filesystem, and rectify the problem(s)
xfs_force_shutdown(sda1,0x1) called from line 338 of file
/usr/src/linux-stable-cold/fs/xfs/xfs_rw.c.  Return address =
0xb0218b6c


-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
