Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269884AbUJHLii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269884AbUJHLii (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269853AbUJHLiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:38:00 -0400
Received: from holomorphy.com ([207.189.100.168]:18646 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269867AbUJHLhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:37:17 -0400
Date: Fri, 8 Oct 2004 04:37:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Guy Cardwell <gcardwel@motorola.com>, linux-kernel@vger.kernel.org
Subject: [hugetlb] initialize sb->s_maxbytes
Message-ID: <20041008113705.GK9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is included near-verbatim (reformatted) from a hugetlb
feature request made of me. The request is perfectly reasonable and
represents fixing what could probably be called a bug.

Apologies to Guy if cc:'ing on lkml threads is too verbose for him
(there is at least an autoresponder, but hopefully that gets filtered).

akpm, please apply.


On Thu, Sep 30, 2004 at 05:30:29PM -0700, Cardwell Guy-PT2501 wrote:
> Please excuse the intrusion and kindly refer me elsewhere if this
> question is inappropriate. My name is Guy Cardwell and I'm working
> for Motorola in the area of biometrics.   Though I'm not a kernel
> hacker by trade, I've some experience and I'd like a pointer from you
> if I can get it.
> A fingerprint search / match system I am working on has recently been
> modified to use Linux and hugetlbfs to hold very large ram resident
> databases of fingerprints.
> One of the limitations I've run into is that as of kernel version
> 2.4.21, hugetblfs appears not to support the creation of files larger
> than 2GB.  hugetlbfs_vmtruncate() checks against the s_maxbytes
> member of the super block and returns EFBIG if the requested file
> size is too large.
> I think that s_maxbytes is getting its default value of MAX_NON_LFS
> from alloc_super() and hugetlbfs_fill_super() doesn't override that value.
> I looked over the rest of the hugetlbfs code, and I don't see a
> problem elsewhere with supporting huge files.  I created a patch that
> adds the line s_maxbytes=MAX_LFS_FILESIZE; to hugetlbfs_fill_super(), 
> and that appears to do the trick in the kernel I built (i386, by the 
> way).  Does this seem right?  Should this be a "real" kernel patch?
> Any suggestions / help are much appreciated.
> Regards,
> Guy Cardwell
> Senior Research Engineer
> Motorola ISD

Signed-off-by: Guy Cardwell <gcardwel@motorola.com>
Signed-off-by: William Irwin <wli@holomorphy.com>


Index: mm3-2.6.9-rc3/fs/hugetlbfs/inode.c
===================================================================
--- mm3-2.6.9-rc3.orig/fs/hugetlbfs/inode.c	2004-10-07 04:05:37.248782565 -0700
+++ mm3-2.6.9-rc3/fs/hugetlbfs/inode.c	2004-10-08 04:28:28.180572765 -0700
@@ -653,6 +653,7 @@
 	sbinfo->free_blocks = config.nr_blocks;
 	sbinfo->max_inodes = config.nr_inodes;
 	sbinfo->free_inodes = config.nr_inodes;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_blocksize = HPAGE_SIZE;
 	sb->s_blocksize_bits = HPAGE_SHIFT;
 	sb->s_magic = HUGETLBFS_MAGIC;
