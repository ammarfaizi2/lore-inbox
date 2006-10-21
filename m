Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1766644AbWJUScl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766644AbWJUScl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766650AbWJUScl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:32:41 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:56057 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1766644AbWJUSck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:32:40 -0400
Date: Sat, 21 Oct 2006 11:34:06 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] raid: fix printk format warnings
Message-Id: <20061021113406.535d8243.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix printk format warnings, seen on powerpc64:
drivers/md/raid1.c:1479: warning: long long unsigned int format, long unsigned int arg (arg 4)
drivers/md/raid10.c:1475: warning: long long unsigned int format, long unsigned int arg (arg 4)

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---

 drivers/md/raid1.c  |    4 ++--
 drivers/md/raid10.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -Naurp linux-2619-rc2g4/drivers/md/raid1.c~raid_printk linux-2619-rc2g4/drivers/md/raid1.c
--- linux-2619-rc2g4/drivers/md/raid1.c~raid_printk	2006-10-21 11:16:30.066109000 -0700
+++ linux-2619-rc2g4/drivers/md/raid1.c	2006-10-21 11:20:57.288004000 -0700
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
diff -Naurp linux-2619-rc2g4/drivers/md/raid10.c~raid_printk linux-2619-rc2g4/drivers/md/raid10.c
--- linux-2619-rc2g4/drivers/md/raid10.c~raid_printk	2006-10-20 17:38:02.799707000 -0700
+++ linux-2619-rc2g4/drivers/md/raid10.c	2006-10-21 11:21:13.430834000 -0700
@@ -1470,8 +1470,8 @@ static void fix_read_error(conf_t *conf,
 					       "raid10:%s: read error corrected"
 					       " (%d sectors at %llu on %s)\n",
 					       mdname(mddev), s,
-					       (unsigned long long)sect+
-					            rdev->data_offset,
+					       (unsigned long long)(sect +
+					            rdev->data_offset),
 					       bdevname(rdev->bdev, b));
 
 				rdev_dec_pending(rdev, mddev);


---
