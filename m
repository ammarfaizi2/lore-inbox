Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVFIQps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVFIQps (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 12:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVFIQpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 12:45:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:29621 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261986AbVFIQpD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 12:45:03 -0400
Cc: zaitcev@redhat.com
Subject: [PATCH] USB: fix ub issues
In-Reply-To: <11183354931589@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 9 Jun 2005 09:44:53 -0700
Message-Id: <1118335493872@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] USB: fix ub issues

This smoothes two imperfections:
- Increase number of LUNs per device from 4 to 9. The best solution
  would be to remove this limit altogether, but that has to wait until
  the time when more than 26 hosts are allowed.
- Replace mdelay with msleep in a probing routine.

Signed-off-by: Pete Zaitcev <zaitcev@yahoo.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 9f793d2c77ec5818679e4747c554d9333cecf476
tree 47904d2099435d4527432479e869311be7c6515b
parent 03e49d40ea3436cae0fe43708f11584130ee4a0c
author Pete Zaitcev <zaitcev@redhat.com> Mon, 06 Jun 2005 13:54:59 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 09 Jun 2005 01:38:11 -0700

 drivers/block/ub.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ub.c b/drivers/block/ub.c
--- a/drivers/block/ub.c
+++ b/drivers/block/ub.c
@@ -51,7 +51,7 @@
  * This many LUNs per USB device.
  * Every one of them takes a host, see UB_MAX_HOSTS.
  */
-#define UB_MAX_LUNS   4
+#define UB_MAX_LUNS   9
 
 /*
  */
@@ -2100,7 +2100,7 @@ static int ub_probe(struct usb_interface
 			nluns = rc;
 			break;
 		}
-		mdelay(100);
+		msleep(100);
 	}
 
 	for (i = 0; i < nluns; i++) {
zaitcev@redhat.com
[PATCH] USB: fix ub issues
[PATCH] USB: fix ub issues

This smoothes two imperfections:
- Increase number of LUNs per device from 4 to 9. The best solution
  would be to remove this limit altogether, but that has to wait until
  the time when more than 26 hosts are allowed.
- Replace mdelay with msleep in a probing routine.

Signed-off-by: Pete Zaitcev <zaitcev@yahoo.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 9f793d2c77ec5818679e4747c554d9333cecf476
tree 47904d2099435d4527432479e869311be7c6515b
parent 03e49d40ea3436cae0fe43708f11584130ee4a0c
author Pete Zaitcev <zaitcev@redhat.com> Mon, 06 Jun 2005 13:54:59 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 09 Jun 2005 01:38:11 -0700

 drivers/block/ub.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ub.c b/drivers/block/ub.c
--- a/drivers/block/ub.c
+++ b/drivers/block/ub.c
@@ -51,7 +51,7 @@
  * This many LUNs per USB device.
  * Every one of them takes a host, see UB_MAX_HOSTS.
  */
-#define UB_MAX_LUNS   4
+#define UB_MAX_LUNS   9
 
 /*
  */
@@ -2100,7 +2100,7 @@ static int ub_probe(struct usb_interface
 			nluns = rc;
 			break;
 		}
-		mdelay(100);
+		msleep(100);
 	}
 
 	for (i = 0; i < nluns; i++) {

