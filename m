Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWAXD65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWAXD65 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 22:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWAXD65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 22:58:57 -0500
Received: from ns2.suse.de ([195.135.220.15]:16566 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964988AbWAXD6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 22:58:32 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 24 Jan 2006 14:58:27 +1100
Message-Id: <1060124035827.28824@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 5] md: Make sure array geometry changes persist with version-1 superblocks.
References: <20060124145516.28734.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


super_1_sync only updates fields in the superblock that might
have changed.
'raid_disks' and 'size' could have changed, but this information
doesn't get updated.... until this patch.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    3 +++
 1 file changed, 3 insertions(+)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-01-24 13:32:25.000000000 +1100
+++ ./drivers/md/md.c	2006-01-24 13:42:29.000000000 +1100
@@ -1162,6 +1162,9 @@ static void super_1_sync(mddev_t *mddev,
 
 	sb->cnt_corrected_read = atomic_read(&rdev->corrected_errors);
 
+	sb->raid_disks = cpu_to_le32(mddev->raid_disks);
+	sb->size = cpu_to_le64(mddev->size);
+
 	if (mddev->bitmap && mddev->bitmap_file == NULL) {
 		sb->bitmap_offset = cpu_to_le32((__u32)mddev->bitmap_offset);
 		sb->feature_map = cpu_to_le32(MD_FEATURE_BITMAP_OFFSET);
