Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWCQEsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWCQEsj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 23:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWCQEsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 23:48:39 -0500
Received: from ns.suse.de ([195.135.220.2]:41705 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751294AbWCQEsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 23:48:38 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 15:47:12 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 13] md: Introduction
Message-ID: <20060317154017.15880.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following are 13 patches for md in 2.6.last (created against 2.6.16-rc6-mm1).
They are NOT appropriate for 2.6.16 but should be OK for .17.  Please include
them in -mm.

The first three are assorted bug fixes, none really serious

The remainder implement raid5 reshaping.  Currently the only shape change
that is supported is added a device, but it is envisioned that 
changing the chunksize and layout will also be supported, as well
as changing the level (e.g. 1->5, 5->6).

The reshape process naturally has to move all of the data in the
array, and so should be used with caution.  It is believed to work,
and some testing does support this, but wider testing would be great
for increasing my confidence.

You will need a version of mdadm newer than 2.3.1 to make use of raid5
growth.  This is because mdadm need to take a copy of a 'critical
section' at the start of the array incase there is a crash at an
awkward moment.  On restart, mdadm will restore the critical section
and allow reshape to continue.

I hope to release a 2.4-pre by early next week - it still needs a
little more polishing.

NeilBrown


 [PATCH 001 of 13] md: Add '4' to the list of levels for which bitmaps are supported.
 [PATCH 002 of 13] md: Fix the 'failed' count for version-0 superblocks.
 [PATCH 003 of 13] md: Update status_resync to handle LARGE devices.

 [PATCH 004 of 13] md: Split disks array out of raid5 conf structure so it is easier to grow.
 [PATCH 005 of 13] md: Allow stripes to be expanded in preparation for expanding an array.
 [PATCH 006 of 13] md: Infrastructure to allow normal IO to continue while array is expanding.
 [PATCH 007 of 13] md: Core of raid5 resize process
 [PATCH 008 of 13] md: Final stages of raid5 expand code.
 [PATCH 009 of 13] md: Checkpoint and allow restart of raid5 reshape
 [PATCH 010 of 13] md: Only checkpoint expansion progress occasionally.
 [PATCH 011 of 13] md: Split reshape handler in check_reshape and start_reshape.
 [PATCH 012 of 13] md: Make 'reshape' a possible sync_action action.
 [PATCH 013 of 13] md: Support suspending of IO to regions of an md array.
