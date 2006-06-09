Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbWFIBU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbWFIBU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 21:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbWFIBU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 21:20:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:38019 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965072AbWFIBU5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 21:20:57 -0400
Subject: [RFC 0/13] extents and 48bit ext3
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 08 Jun 2006 18:20:54 -0700
Message-Id: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current ext3 filesystem is limited to 8TB(4k block size), this is
practically not enough for the increasing need of bigger storage as
disks in a few years (or even now).

To address this need, there are co-effort from RedHat, ClusterFS, IBM
and BULL to move ext3 from 32 bit filesystem to 48 bit filesystem,
expanding ext3 filesystem limit from 8TB today to 1024 PB. The 48 bit
ext3 is build on top of extent map changes for ext3, originally from
Alex Tomas. In short, the new ext3 on-disk extents format is:

On disk extents format:
/*
  * this is extent on-disk structure
  * it's used at the bottom of the tree
  */
struct ext3_extent {
        __le32  ee_block;       /* first logical block extent covers */
        __le16  ee_len;         /* number of blocks covered by extent */
        __le16  ee_start_hi;    /* high 16 bits of physical block */
        __le32  ee_start;       /* low 32 bigs of physical block */
};

A series of patches have been posted to ext2-devel list in last month
and have been reviewed.  This is updated full series of patches to
support 48 bit ext3 based on extent map. Patches are against 2.6.17-rc6
kernel, and could be found at
http://ext2.sourceforge.net/48bitext3/patches/patches-2.6.17-
rc6-06082006/

[patch 1/13] percpu_counter_longlong.patch
percpu count data type changes to support 64 bit ext3 free blocks count

[patch 2/13] ext3_check_sector_t_overflow.patch
sector_t overflow check for 32bit/48bit ext3 at mount/resize time

[patch 3/13] ext3_fsblk_t_fixes.patch
Define ext3 filesystem and group block types (ext3_fsblk_t,
ext3_grpblk_t, and fix in-kernel ext3 block types (from int type to
ext3_fsblk_t) to support 32bit ext3.

[patch 4/13] ext3_convert_blks_to_fsblk_t.patch
convert the rest of ext3 filesystem blocks to ext3_fsblk_t

patches 1-4 are currently in mm tree

[patch 5/13] sector_fmt.patch
sector_t type format string for all arch.

[patch 6/13] ext3_fsblk_sector_t.patch
support >32bit bit fs block type in kernel (convert ext3_fsblk_t to
sector_t)

[patch 7/13] 64bit_jbd_core.patch
Core 64 bit JBD changes

[patch 8/13] sector_t-jbd.patch
JBD layer in-kernel block variables type fixes to support >32
bit block number and convert to sector_t type.

#extent map patches
[patch 9/13] ext3-extents.patch
core extent map support

[patch 10/13] ext3-extents-48bit.patch
Add full 48 bit physical block support based on extents.

[patch 11/13] ext3-extents-ext3_fsblk_t.patch
convert block types in extents to ext3_fsblk_t

[patch 12/13]ext3_48bit_i_file_acl.pat
48 bit on-disk i_file_acl to support xttar for 48 bit ext3

[patch 13/13] 64bit-metadata
On-disk and in-kernel super block changes to support >32
bit free blocks numbers.


Appreciate any comments and feedbacks!

Mingming

