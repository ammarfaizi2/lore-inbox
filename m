Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVAMKnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVAMKnX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 05:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVAMKmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 05:42:11 -0500
Received: from mail.suse.de ([195.135.220.2]:61590 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261566AbVAMKky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:40:54 -0500
Date: Thu, 13 Jan 2005 11:31:43 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Tridgell <tridge@samba.org>
Subject: [RESEND][PATCH 0/9] Ext3: extended attribute sharing fixes and in-inode EAs
Message-Id: <1105549936.694778@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

it seems this patchset did not make it through to LKML, so I'm trying to resend.

This set of patches contains cleanups and fixes to the mbcache and ext2/ext3 xattr code, and adds completely reworks Alex Tomas's in-inode attribute patch. I did a fair amount of review and testing on all the patches; Andrew Tridgell did some testing as well. As far as I can tell the patches are ready for direct merging. Alternatively the fixes could be merged while the in-inode attribute support could go into -mm; either way won't make much difference for me. Please comment.

In order for the patches to apply, please first revert Alex's in-inode-ea patch. The patch was not ready for merging yet. I could retrofit the rewrite on top of Alex's patch, but this would cause a lot of work, and would benefit the code quality in no way.

Alex's patch was merged in this changeset:
http://linux.bkbits.net:8080/linux-2.6/cset@41db7b23z5xP6bWuxXwEgBu1AxyStQ?nav=index.html|ChangeSet@-4w


All the patches contain decsriptions. The bugfix patches in this set are:

revert-old-ea-in-inode.diff
  A reverse diff of Alex's patch.

mbcache-cleanup.diff
  A small mbcache cleanup.

mbcache-bug.diff
  Convert the mbcache to protect cache entries readers/writer
  style. This fixes an attribute sharing race.

xattr-credits.diff
  Don't use journal_release_buffer in ext3 xattrs; it's unsafe.

ext3_xattr_release_block.diff
  Factor our common xattr code.

remove-XATTR_INDEX_MAX.diff
  Minor cleaup.


The patches for in-inode attribute support are:

xattr-cleanup.diff
  Prepare xattr code for in-inode xattrs.
  
fix-get_inode_loc.diff
  Hide ext3_get_inode_loc in_mem optimization from users;
  the optimization applies differently with in-inode xattrs.

ea-in-inode.diff
  In-inode attribute support. This is the original patch from Alex
  heavily cleaned up.


Please apply the patches in this order:
  revert-old-ea-in-inode.diff
  mbcache-cleanup.diff
  mbcache-bug.diff
  xattr-credits.diff
  ext3_xattr_release_block.diff
  remove-XATTR_INDEX_MAX.diff
  xattr-cleanup.diff
  fix-get_inode_loc.diff
  ea-in-inode.diff


Regards, 
--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

