Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWG1AcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWG1AcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 20:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWG1AcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 20:32:05 -0400
Received: from cantor.suse.de ([195.135.220.2]:32135 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750765AbWG1AcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 20:32:04 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 28 Jul 2006 10:31:20 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 2] knfsd: Don't allow bad file handles to cause extX to go readonly
Message-ID: <20060728102713.15132.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, and file handle with a bad inode number in it can cause
ext2 to go to readonly (as it looks like a corrupted filesystem)
and could allow remote access to ext3 special files like the journal.

These patches give ext2/3 their own get_dentry method which checks the
inode number early before other bits of the code can be freaked out by
it.

These are revised versions of earlier patches.  Rather than exporting
export_iget, we open code it and simplify it slightly.  This avoids
and extra module dependancy.

NeilBrown

To follow:
 [PATCH 001 of 2] knfsd: Have ext2 reject file handles with bad inode numbers early.
 [PATCH 002 of 2] knfsd: Make ext3 reject filehandles referring to invalid inode numbers
