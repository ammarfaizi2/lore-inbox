Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265510AbUGNPJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUGNPJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 11:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUGNPJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 11:09:36 -0400
Received: from f7.mail.ru ([194.67.57.37]:28685 "EHLO f7.mail.ru")
	by vger.kernel.org with ESMTP id S265510AbUGNPJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 11:09:34 -0400
From: Alexey Dobriyan <adobriyan@mail.ru>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix menuconfig partial inability to show help texts.
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.222.68.107]
Date: Wed, 14 Jul 2004 19:09:33 +0400
Reply-To: Alexey Dobriyan <adobriyan@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1BklO1-000Pqk-00.adobriyan-mail-ru@f7.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix menuconfig inability to show help texts when there is menu item with
letter "H" highlighted on the screen.

--- a/scripts/lxdialog/menubox.c
+++ b/scripts/lxdialog/menubox.c
@@ -71,7 +71,7 @@
 
     strncpy(menu_item, item, menu_width);
     menu_item[menu_width] = 0;
-    j = first_alpha(menu_item, "YyNnMm");
+    j = first_alpha(menu_item, "YyNnMmHh");
 
     /* Clear 'residue' of last item */
     wattrset (win, menubox_attr);
@@ -279,17 +279,17 @@
 
 	if (key < 256 && isalpha(key)) key = tolower(key);
 
-	if (strchr("ynm", key))
+	if (strchr("ynmh", key))
 		i = max_choice;
 	else {
         for (i = choice+1; i < max_choice; i++) {
-		j = first_alpha(items[(scroll+i)*2+1], "YyNnMm");
+		j = first_alpha(items[(scroll+i)*2+1], "YyNnMmHh");
 		if (key == tolower(items[(scroll+i)*2+1][j]))
                 	break;
 	}
 	if (i == max_choice)
        		for (i = 0; i < max_choice; i++) {
-			j = first_alpha(items[(scroll+i)*2+1], "YyNnMm");
+			j = first_alpha(items[(scroll+i)*2+1], "YyNnMmHh");
 			if (key == tolower(items[(scroll+i)*2+1][j]))
                 		break;
 		}

