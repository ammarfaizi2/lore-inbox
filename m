Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWDLAVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWDLAVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 20:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWDLAVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 20:21:45 -0400
Received: from mailfe08.tele2.fr ([212.247.154.236]:23734 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751142AbWDLAVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 20:21:44 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Wed, 12 Apr 2006 02:21:25 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] Enhancing accessibility of lxdialog
Message-ID: <20060412002125.GG5491@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For easily getting fairly good accessibility, TTY's cursor should
always be left at the focus location. This patch fixes the checklist by
just having the list refreshed after the dialog box (hence the cursor
position remains in the list).

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
index db07ae7..cf14b29 100644
--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -196,8 +196,8 @@
 
 	print_buttons(dialog, height, width, 0);
 
-	wnoutrefresh(list);
 	wnoutrefresh(dialog);
+	wnoutrefresh(list);
 	doupdate();
 
 	while (key != ESC) {
@@ -225,12 +225,11 @@
 					}
 					scroll--;
 					print_item(list, items[scroll * 3 + 1], status[scroll], 0, TRUE);
-					wnoutrefresh(list);
-
 					print_arrows(dialog, choice, item_no,
 						     scroll, box_y, box_x + check_x + 5, list_height);
 
-					wrefresh(dialog);
+					wnoutrefresh(dialog);
+					wrefresh(list);
 
 					continue;	/* wait for another key press */
 				} else
@@ -252,12 +251,12 @@
 					scroll++;
 					print_item(list, items[(scroll + max_choice - 1) * 3 + 1],
 						   status[scroll + max_choice - 1], max_choice - 1, TRUE);
-					wnoutrefresh(list);
 
 					print_arrows(dialog, choice, item_no,
 						     scroll, box_y, box_x + check_x + 5, list_height);
 
-					wrefresh(dialog);
+					wnoutrefresh(dialog);
+					wrefresh(list);
 
 					continue;	/* wait for another key press */
 				} else
@@ -271,8 +270,8 @@
 				choice = i;
 				print_item(list, items[(scroll + choice) * 3 + 1],
 					   status[scroll + choice], choice, TRUE);
-				wnoutrefresh(list);
-				wrefresh(dialog);
+				wnoutrefresh(dialog);
+				wrefresh(list);
 			}
 			continue;	/* wait for another key press */
 		}
@@ -306,8 +305,8 @@
 						print_item(list, items[(scroll + i) * 3 + 1],
 							   status[scroll + i], i, i == choice);
 				}
-				wnoutrefresh(list);
-				wrefresh(dialog);
+				wnoutrefresh(dialog);
+				wrefresh(list);
 
 				for (i = 0; i < item_no; i++)
 					if (status[i])
