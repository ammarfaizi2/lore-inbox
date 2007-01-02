Return-Path: <linux-kernel-owner+w=401wt.eu-S964854AbXABMfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbXABMfx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbXABMfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:35:53 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:1031 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964860AbXABMfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:35:52 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fs: proc module_put cleanup
Date: Tue, 2 Jan 2007 13:37:15 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021337.15596.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes redundant argument check for module_put().

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 fs/proc/inode.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/fs/proc/inode.c linux-2.6.20-rc2-mm1-b/fs/proc/inode.c
--- linux-2.6.20-rc2-mm1-a/fs/proc/inode.c	2006-12-28 12:57:47.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/fs/proc/inode.c	2007-01-02 02:25:44.000000000 +0100
@@ -60,8 +60,7 @@ static void proc_delete_inode(struct ino
 	/* Let go of any associated proc directory entry */
 	de = PROC_I(inode)->pde;
 	if (de) {
-		if (de->owner)
-			module_put(de->owner);
+		module_put(de->owner);
 		de_put(de);
 	}
 	clear_inode(inode);


-- 
Regards,

	Mariusz Kozlowski
