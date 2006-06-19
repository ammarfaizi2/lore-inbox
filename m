Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWFSHpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWFSHpA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 03:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWFSHpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 03:45:00 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:54652 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932173AbWFSHo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 03:44:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SV2PfUu9Lio3E4H5XhNGHORSq0BwPo+dd7QjSsxG+VSDuXFfAD+EYx4q47vUAQnaLKYStpOlIVXoP3aA/NwrtUCKwbPtL3dLmm197X08w9GL0bjjHEevTpG7wvN5fQbkeBw+wePh9S8UJtKaPs2tcUT2hXhmoDFV4zRSrN5zjXA=
Message-ID: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com>
Date: Mon, 19 Jun 2006 00:44:58 -0700
From: "Avuton Olrich" <avuton@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
Subject: XFS crashed twice, once in 2.6.16.20, next in 2.6.17, reproducable
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Didn't make it to the linux-xfs list, it's not working so I'll try by
sending it both to the LKML and linux-xfs again.

Hello, when trying to recursively delete a directory (same directory
twice) from my 500gb hard drive I get a problem. It crashed first in
2.6.16.20, then I upgraded to try to get rid of the issue. This one is
from 2.6.17:

xfs_da_do_buf: bno 16777216
dir: inode 1507133580
Filesystem "sda1": XFS internal error xfs_da_do_buf(1) at line 2119 of
file /usr/src/linux-stable-cold/fs/xfs/xfs_da_btree.c.  Caller 0xb01
d9b63
 <b01d9720> xfs_da_do_buf+0x40e/0x7c7  <b01d9b63> xfs_da_read_buf+0x30/0x35
 <b01e43d5> xfs_dir2_leafn_lookup_int+0x2f3/0x453  <b01d9b63>
xfs_da_read_buf+0x30/0x35
 <b01e2ba5> xfs_dir2_node_removename+0x288/0x47f  <b01e2ba5>
xfs_dir2_node_removename+0x288/0x47f
 <b01ddbd3> xfs_dir2_removename+0xce/0xd5  <b020ff5d> kmem_zone_alloc+0x4d/0x98
 <b020d0ef> xfs_remove+0x2ac/0x444  <b0215e7f> xfs_vn_unlink+0x17/0x3b
 <b020a32b> xfs_lookup+0x6e/0x78  <b011e734> __capable+0xc/0x1f
 <b0155827> generic_permission+0x93/0xcc  <b01558f8> permission+0x98/0xa4
 <b0155da0> may_delete+0x32/0xe9  <b0156243> vfs_unlink+0x6d/0xa3
 <b0157c7a> do_unlinkat+0x92/0x125  <b0159a0d> sys_getdents64+0x9c/0xa6
 <b0102b67> sysenter_past_esp+0x54/0x75
Filesystem "sda1": XFS internal error xfs_trans_cancel at line 1150 of
file /usr/src/linux-stable-cold/fs/xfs/xfs_trans.c.  Caller 0xb020d2
5e
 <b0204b48> xfs_trans_cancel+0x59/0xe5  <b020d25e> xfs_remove+0x41b/0x444
 <b020d25e> xfs_remove+0x41b/0x444  <b0215e7f> xfs_vn_unlink+0x17/0x3b
 <b020a32b> xfs_lookup+0x6e/0x78  <b011e734> __capable+0xc/0x1f
 <b0155827> generic_permission+0x93/0xcc  <b01558f8> permission+0x98/0xa4
 <b0155da0> may_delete+0x32/0xe9  <b0156243> vfs_unlink+0x6d/0xa3
 <b0157c7a> do_unlinkat+0x92/0x125  <b0159a0d> sys_getdents64+0x9c/0xa6
 <b0102b67> sysenter_past_esp+0x54/0x75
xfs_force_shutdown(sda1,0x8) called from line 1151 of file
/usr/src/linux-stable-cold/fs/xfs/xfs_trans.c.  Return address =
0xb0218b68
Filesystem "sda1": Corruption of in-memory data detected.  Shutting
down filesystem: sda1

While trying to xfs_repair I get the following:
fatal error -- can't read block 16777216 for directory inode 1507133580

Badblocks has been run on this machine and it was sucessful.

I did find an old thread with this, but no solution:
http://oss.sgi.com/archives/xfs/2005-02/msg00067.html

config:
http://olricha.homelinux.net:8080/config.gz

Thanks for any help. If I can help at all please let me know.
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
