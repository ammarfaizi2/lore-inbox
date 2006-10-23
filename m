Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751647AbWJWHI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWJWHI7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbWJWHIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:08:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:27339 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751653AbWJWHIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:08:13 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 23 Oct 2006 17:08:06 +1000
Message-Id: <1061023070806.29272@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 4] md: Fix printk format warnings, seen on powerpc64:
References: <20061023170347.29132.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

drivers/md/raid1.c:1479: warning: long long unsigned int format, long unsigned int arg (arg 4)
drivers/md/raid10.c:1475: warning: long long unsigned int format, long unsigned int arg (arg 4)

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid1.c  |    4 ++--
 ./drivers/md/raid10.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff .prev/drivers/md/raid1.c ./drivers/md/raid1.c
--- .prev/drivers/md/raid1.c	2006-10-23 16:36:08.000000000 +1000
+++ ./drivers/md/raid1.c	2006-10-23 16:36:08.000000000 +1000
@@ -1474,8 +1474,8 @@ static void fix_read_error(conf_t *conf,
 					       "raid1:%s: read error corrected "
 					       "(%d sectors at %llu on %s)\n",
 					       mdname(mddev), s,
-					       (unsigned long long)sect +
-					           rdev->data_offset,
+					       (unsigned long long)(sect +
+					           rdev->data_offset),
 					       bdevname(rdev->bdev, b));
 				}
 			}

diff .prev/drivers/md/raid10.c ./drivers/md/raid10.c
--- .prev/drivers/md/raid10.c	2006-10-23 16:34:54.000000000 +1000
+++ ./drivers/md/raid10.c	2006-10-23 16:36:08.000000000 +1000
@@ -1470,8 +1470,8 @@ static void fix_read_error(conf_t *conf,
 					       "raid10:%s: read error corrected"
 					       " (%d sectors at %llu on %s)\n",
 					       mdname(mddev), s,
-					       (unsigned long long)sect+
-					            rdev->data_offset,
+					       (unsigned long long)(sect+
+					            rdev->data_offset),
 					       bdevname(rdev->bdev, b));
 
 				rdev_dec_pending(rdev, mddev);
