Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVLTD0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVLTD0X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 22:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVLTD0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 22:26:23 -0500
Received: from mail17.bluewin.ch ([195.186.18.64]:29915 "EHLO
	mail17.bluewin.ch") by vger.kernel.org with ESMTP id S1750770AbVLTD0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 22:26:22 -0500
Date: Mon, 19 Dec 2005 22:25:31 -0500
To: akpm@osdl.org
Cc: vandrove@vc.cvut.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] matroxfb: simply return what i2c_add_driver() does
Message-ID: <20051220032531.GC24700@krypton>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

`insmod' will tell us when the module failed to load. We do no further
processing on the return from i2c_add_driver(), so just return that
instead of storing it.

Add __init/__exit annotations while we're at it.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>

---

 drivers/video/matrox/matroxfb_maven.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

5599955f4f42ebfd5b244563f2be24f9e60fe186
diff --git a/drivers/video/matrox/matroxfb_maven.c b/drivers/video/matrox/matroxfb_maven.c
index ad60bbb..d5275c7 100644
--- a/drivers/video/matrox/matroxfb_maven.c
+++ b/drivers/video/matrox/matroxfb_maven.c
@@ -1302,20 +1302,13 @@ static struct i2c_driver maven_driver={
 	.command	= maven_command,
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
0.99.9n
