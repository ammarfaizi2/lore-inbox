Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030721AbWF0HIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030721AbWF0HIT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030717AbWF0HGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:06:18 -0400
Received: from ns.suse.de ([195.135.220.2]:23939 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030712AbWF0HGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:06:06 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:05:54 +1000
Message-Id: <1060627070554.26058@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 009 of 12] md: Require CAP_SYS_ADMIN for (re-)configuring md devices via sysfs.
References: <20060627170010.25835.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The ioctl requires CAP_SYS_ADMIN, so sysfs should too.
Note that we don't require CAP_SYS_ADMIN for reading
attributes even though the ioctl does.  There is no reason
to limit the read access, and much of the information is
already available via /proc/mdstat

cc: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    4 ++++
 1 file changed, 4 insertions(+)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-06-27 12:17:33.000000000 +1000
+++ ./drivers/md/md.c	2006-06-27 12:17:33.000000000 +1000
@@ -1928,6 +1928,8 @@ rdev_attr_store(struct kobject *kobj, st
 
 	if (!entry->store)
 		return -EIO;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
 	return entry->store(rdev, page, length);
 }
 
@@ -2861,6 +2863,8 @@ md_attr_store(struct kobject *kobj, stru
 
 	if (!entry->store)
 		return -EIO;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
 	rv = mddev_lock(mddev);
 	if (!rv) {
 		rv = entry->store(mddev, page, length);
