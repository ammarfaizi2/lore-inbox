Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWF3AQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWF3AQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWF3AQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:16:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:11461 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751319AbWF3AQu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:16:50 -0400
Subject: [RFC][Update 0/16]extents and 48bit ext3/4 patches
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 29 Jun 2006 17:16:47 -0700
Message-Id: <1151626608.6601.66.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Here is the updated ext3/4 patches to support 48bit ext4 filesystem.

http://ext2.sourceforge.net/48bitext3/patches/latest/

Changes since last post includes

- bug fixes in 64bit JBD changes, which breaks non-extents 32 bit ext3
filesystem
- sync up on disk super block structure with e2fsprogs
- add initial handing of uninitialized extents
- removed 32 bit ext3 bug fixes patches from this series as they are
folded to current linus git tree.


Patches against 2.6.17-git13, tested on both 32 bit and 64 bit arch,
survived fsx test on 32bit ext3(mounted w/o extent, with CONFIG_LBD
enabled) and 48 bit ext4(mounted with extents).

Appreciate any comments and feedbacks.

Thanks,

Mingming

-------------------------------------
patch series:

#------------------------
# base extent support (32bit)
#------------------------
ext3-extents.patch
#------------------------
# 48bit ext3 patches
#-------------------------
# 64 bit in-kernel block number support
#
#sector_t type format string for all arch
sector_fmt.patch
#support >32 bit fs block type in kernel (convert ext3_fsblk_t to sector_t)
ext3_fsblk_sector_t.patch
#
#48 bit extent map patches
#
ext3-extents-48bit.patch
ext3-extents-ext3_fsblk_t.patch
ext3-unitialized-extent-handling.patch
#
# 64bit JBD support
#
64bit_jbd_core.patch
jbd-avoid-blk-overflow-write-journal-metadata-tag.patch
jbd-read-32bit-tag-fix.patch
jbd-cleanup-journal_tag_bytes.patch
sector_t-jbd.patch
jbd-revoke-32bit-shift-fix.patch
#
# 48 bit on-disk xttar support
#
ext3_48bit_i_file_acl.patch
#
# 64bit on-disk sb metadata changes
#
64bit-metadata.patch
64bit-incompat-flag-change.patch
ext3-sb-struc-sync-with-e2fsprog.patch


