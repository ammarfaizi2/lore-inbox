Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269934AbTGPAJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 20:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269940AbTGPAJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 20:09:27 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:58554 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269934AbTGPAJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 20:09:18 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: 2.6.0-test1, tcq, xfs corruption
Date: Tue, 15 Jul 2003 18:33:50 -0400
User-Agent: KMail/1.5.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307151833.50627.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is to confirm corruption with the xfs filesystem on a tcq-enabled kernel 
with queue depth 8 (enabled by accident actually). Previously I have 
experienced massive fs corruption on queue depth 8 tcq kernels with reiser,
described here (no replies..):

http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/1307.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/1396.html

Is there interest in more testing from me using my old reiserfs root fs?
Please reply one way or the other, as I need my hard drive space back.  

Here's xfs oops data:

0x0: 84 24 80 00 00 00 50 51 53 e8 2e 03 00 00 83 c4 
Filesystem "hda8": XFS internal error xfs_da_do_buf(2) at line 2281 of file 
fs/x                                                               
fs/xfs_da_btree.c.  Caller 0xc0203c47
Call Trace:
 [<c0203609>] xfs_da_do_buf+0x439/0x9c0
 [<c0203c47>] xfs_da_read_buf+0x57/0x60
 [<c0203c47>] xfs_da_read_buf+0x57/0x60
 [<c0241429>] pagebuf_get+0xb9/0x140
 [<c020195e>] xfs_da_node_lookup_int+0x7e/0x340
 [<c0203c47>] xfs_da_read_buf+0x57/0x60
 [<c020cba7>] xfs_dir2_leafn_lookup_int+0x397/0x5d0
 [<c020cba7>] xfs_dir2_leafn_lookup_int+0x397/0x5d0
 [<c0142fc6>] cache_grow+0x146/0x240
 [<c0201ace>] xfs_da_node_lookup_int+0x1ee/0x340
 [<c020e75f>] xfs_dir2_node_lookup+0x3f/0xc0
 [<c02061b8>] xfs_dir2_lookup+0x138/0x150
 [<c02203c5>] xfs_ichgtime+0x105/0x107
 [<c0238e38>] xfs_setattr+0xb8/0xee0
 [<c023587c>] xfs_dir_lookup_int+0x4c/0x130
 [<c023b200>] xfs_lookup+0x50/0x90
 [<c0248767>] linvfs_lookup+0x67/0xa0
 [<c0162cb8>] real_lookup+0xc8/0xf0
 [<c0162f46>] do_lookup+0x96/0xb0
 [<c016340f>] link_path_walk+0x4af/0x8e0
 [<c0164223>] open_namei+0x83/0x410
 [<c01549fe>] filp_open+0x3e/0x70
 [<c0154ebb>] sys_open+0x5b/0x90
 [<c010b29b>] syscall_call+0x7/0xb

Note on filesystems:
I've had massive corruption on reiser, limited corruption on xfs, 
and very minor corruption on ext3. I hope this is helpful.

I am continuing to run an xfs system on a tcq-enabled kernel with 32 depth 
queue, as this seems to be fine most of the time, except for an oops/lockup 
when waking from standby (I've posted another bug report).

