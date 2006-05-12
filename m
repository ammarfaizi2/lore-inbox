Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWELGHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWELGHo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWELGHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:07:43 -0400
Received: from ns2.suse.de ([195.135.220.15]:11207 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750861AbWELGHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:07:43 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 12 May 2006 16:07:25 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       Paul Clements <paul.clements@steeleye.com>
Subject: [PATCH 000 of 8] md/bitmap: Introduction - rework management of bitmap files.
Message-ID: <20060512160121.7872.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought it was time to review the md/bitmap code - partly because I
wasn't comfortable with how it was handling writing to files.  The more
I learnt about the VM/VFS, the more I realised it was wrong....

I found plenty to do...

The last patch in this series of 8 is the big one.  It substantially
changes the way bitmap files are handled.  The key change is that it
now works more like swapfile: bmap() is used to find where the blocks
are and write goes direct to storage bypassing the filesystem.

These are *not* for 2.6.17, but should be ok for when 2.6.18 opens.

I've done some testing and it seems to work OK, but it is a big change
and more testing wouldn't be a bad thing :-)

 [PATCH 001 of 8] md/bitmap: Fix online removal of file-backed bitmaps
 [PATCH 002 of 8] md/bitmap: Remove bitmap writeback daemon.
 [PATCH 003 of 8] md/bitmap: Cleaner separation of page attribute handlers in md/bitmap.
 [PATCH 004 of 8] md/bitmap: Use set_bit etc for bitmap page attributes.
 [PATCH 005 of 8] md/bitmap: Remove unnecessary page reference manipulations from md/bitmap code.
 [PATCH 006 of 8] md/bitmap: Remove dead code from md/bitmap.
 [PATCH 007 of 8] md/bitmap: Tidy up i_writecount handling in md/bitmap
 [PATCH 008 of 8] md/bitmap: Change md/bitmap file handling to use bmap to file blocks.
