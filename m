Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWBKLBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWBKLBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 06:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWBKLBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 06:01:09 -0500
Received: from mail15.bluewin.ch ([195.186.18.63]:21238 "EHLO
	mail15.bluewin.ch") by vger.kernel.org with ESMTP id S1751393AbWBKLBH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 06:01:07 -0500
Cc: Arthur Othieno <apgo@patchbomb.org>, vandrove@vc.cvut.cz,
       linux-kernel@vger.kernel.org
Subject: [PATCH] matroxfb: simply return what i2c_add_driver() does
In-Reply-To: 
X-Mailer: git-send-email
Date: Sat, 11 Feb 2006 06:00:34 -0500
Message-Id: <11396556342192-git-send-email-apgo@patchbomb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Arthur Othieno <apgo@patchbomb.org>
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Arthur Othieno <apgo@patchbomb.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

insmod will tell us when the module failed to load. We do no further
processing on the return from i2c_add_driver(), so just return what
i2c_add_driver() did, instead of storing it.

Add __init/__exit annotations while we're at it.

Signed-off-by: Arthur Othieno <apgo@patchbomb.org>

---

Andrew, originally sent 12/19/05. No notification from mm-commits of
patch being accepted/dropped. Assuming it got lost along the way? ;-)


 drivers/video/matrox/matroxfb_maven.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

3d7e2f6d53ac04029f02e1ce7b966f3521617447
diff --git a/drivers/video/matrox/matroxfb_maven.c b/drivers/video/matrox/matroxfb_maven.c
index 6019710..531a0c3 100644
--- a/drivers/video/matrox/matroxfb_maven.c
+++ b/drivers/video/matrox/matroxfb_maven.c
@@ -1297,20 +1297,13 @@ static struct i2c_driver maven_driver={
 	.detach_client	= maven_detach_client,
 };
 
-/* ************************** */
-
-static int matroxfb_maven_init(void) {
-	int err;
-
-	err = i2c_add_driver(&maven_driver);
-	if (err) {
-		printk(KERN_ERR "maven: Maven driver failed to register (%d).\n", err);
-		return err;
-	}
-	return 0;
+static int __init matroxfb_maven_init(void)
+{
+	return i2c_add_driver(&maven_driver);
 }
 
-static void matroxfb_maven_exit(void) {
+static void __exit matroxfb_maven_exit(void)
+{
 	i2c_del_driver(&maven_driver);
 }
 
-- 
1.1.5


