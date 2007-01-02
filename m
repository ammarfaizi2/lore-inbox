Return-Path: <linux-kernel-owner+w=401wt.eu-S964872AbXABMnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbXABMnW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbXABMnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:43:22 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:4265 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964872AbXABMnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:43:22 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Greg KH <gregkh@suse.de>
Subject: [PATCH] lib: kobject_put cleanup
Date: Tue, 2 Jan 2007 13:44:44 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021344.44258.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes redundant argument checks for kobject_put().

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 lib/kobject.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/lib/kobject.c linux-2.6.20-rc2-mm1-b/lib/kobject.c
--- linux-2.6.20-rc2-mm1-a/lib/kobject.c	2006-12-28 12:57:53.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/lib/kobject.c	2007-01-02 02:31:54.000000000 +0100
@@ -237,8 +237,7 @@ int kobject_add(struct kobject * kobj)
 	if (error) {
 		/* unlink does the kobject_put() for us */
 		unlink(kobj);
-		if (parent)
-			kobject_put(parent);
+		kobject_put(parent);
 
 		/* be noisy on error issues */
 		if (error == -EEXIST)
@@ -464,8 +463,7 @@ void kobject_cleanup(struct kobject * ko
 
 	if (s)
 		kset_put(s);
-	if (parent) 
-		kobject_put(parent);
+	kobject_put(parent);
 }
 
 static void kobject_release(struct kref *kref)


-- 
Regards,

	Mariusz Kozlowski
