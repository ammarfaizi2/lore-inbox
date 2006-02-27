Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751770AbWB0Wag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbWB0Wag (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWB0Waf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:30:35 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:58498 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751770AbWB0Wae
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:30:34 -0500
Message-Id: <20060227223326.328333000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:07 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jeff Mahoney <jeffm@suse.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 07/39] [PATCH] reiserfs: disable automatic enabling of reiserfs inode attributes
Content-Disposition: inline; filename=reiserfs-disable-automatic-enabling-of-reiserfs-inode-attributes.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

[PATCH] reiserfs: disable automatic enabling of reiserfs inode attributes

Unfortunately, the reiserfs_attrs_cleared bit in the superblock flag can
lie.  File systems have been observed with the bit set, yet still contain
garbage in the stat data field, causing unpredictable results.

This patch backs out the enable-by-default behavior.

It eliminates the changes from: d50a5cd860ce721dbeac6a4f3c6e42abcde68cd8,
and ef5e5414e7a83eb9b4295bbaba5464410b11e030.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 fs/reiserfs/super.c |    2 --
 1 files changed, 2 deletions(-)

--- linux-2.6.15.4.orig/fs/reiserfs/super.c
+++ linux-2.6.15.4/fs/reiserfs/super.c
@@ -1130,8 +1130,6 @@ static void handle_attrs(struct super_bl
 					 "reiserfs: cannot support attributes until flag is set in super-block");
 			REISERFS_SB(s)->s_mount_opt &= ~(1 << REISERFS_ATTRS);
 		}
-	} else if (le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared) {
-		REISERFS_SB(s)->s_mount_opt |= (1 << REISERFS_ATTRS);
 	}
 }
 

--
