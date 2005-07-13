Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVGMRMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVGMRMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVGMRJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:09:45 -0400
Received: from mta04.mail.t-online.hu ([195.228.240.57]:60136 "EHLO
	mta04.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261293AbVGMRHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:07:32 -0400
Subject: [PATCH 2/19] Kconfig I18N: lxdialog: width fix
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <1121273456.2975.3.camel@spirit>
References: <1121273456.2975.3.camel@spirit>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 19:07:30 +0200
Message-Id: <1121274450.2975.12.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Width fix in checkbox.c . If the content of checkbox is too long the subwindow slips.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 scripts/lxdialog/checklist.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff -puN scripts/lxdialog/checklist.c~kconfig-i18n-02-lxdialog-witdh-fix scripts/lxdialog/checklist.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/checklist.c~kconfig-i18n-02-lxdialog-witdh-fix	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/checklist.c	2005-07-13 18:37:06.000000000 +0200
@@ -32,7 +32,8 @@ static void
 print_item (WINDOW * win, const char *item, int status,
 	    int choice, int selected)
 {
-    int i;
+    int i, item_width=list_width+check_x-item_x;
+    char list_item[item_width+1];
 
     /* Clear 'residue' of last item */
     wattrset (win, menubox_attr);
@@ -47,10 +48,13 @@ print_item (WINDOW * win, const char *it
     else
 	wprintw (win, "(%c)", status ? 'X' : ' ');
 
+    strncpy (list_item, item, item_width);
+    list_item[item_width] = 0;
+
     wattrset (win, selected ? tag_selected_attr : tag_attr);
-    mvwaddch(win, choice, item_x, item[0]);
+    mvwaddch(win, choice, item_x, list_item[0]);
     wattrset (win, selected ? item_selected_attr : item_attr);
-    waddstr (win, (char *)item+1);
+    waddstr (win, &list_item[1]);
     if (selected) {
     	wmove (win, choice, check_x+1);
     	wrefresh (win);
@@ -197,7 +201,7 @@ dialog_checklist (const char *title, con
     /* Find length of longest item in order to center checklist */
     check_x = 0;
     for (i = 0; i < item_no; i++) 
-	check_x = MAX (check_x, + strlen (items[i * 3 + 1]) + 4);
+	check_x = MAX (check_x, MIN(list_width, strlen (items[i * 3 + 1]) + 4));
 
     check_x = (list_width - check_x) / 2;
     item_x = check_x + 4;
_


