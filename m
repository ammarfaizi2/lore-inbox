Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWGJLOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWGJLOc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWGJLOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:14:32 -0400
Received: from fitch1.uni2.net ([130.227.52.101]:64462 "EHLO fitch1.uni2.net")
	by vger.kernel.org with ESMTP id S1751358AbWGJLOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:14:31 -0400
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2/9] -Wshadow: Fix warnings in mconf
Date: Mon, 10 Jul 2006 13:12:37 +0200
User-Agent: KMail/1.8.2
Cc: jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607101312.38149.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please see the mail titled 
 "[RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with -Wshadow"
 for an explanation of why I'm doing this)


Fix the following -Wshadow warnings in mconf : 

  scripts/kconfig/mconf.c:279: warning: declaration of 'filename' shadows a global declaration
  scripts/kconfig/mconf.c:261: warning: shadowed declaration is here
  scripts/kconfig/mconf.c:867: warning: declaration of 'filename' shadows a global declaration
  scripts/kconfig/mconf.c:261: warning: shadowed declaration is here

This makes  make all[no|mod|yes]config -Wshadow clean.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 scripts/kconfig/mconf.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.18-rc1-orig/scripts/kconfig/mconf.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc1/scripts/kconfig/mconf.c	2006-07-09 19:48:05.000000000 +0200
@@ -276,7 +276,7 @@ static void conf_save(void);
 static void show_textbox(const char *title, const char *text, int r, int c);
 static void show_helptext(const char *title, const char *text);
 static void show_help(struct menu *menu);
-static void show_file(const char *filename, const char *title, int r, int c);
+static void show_file(const char *fname, const char *title, int r, int c);
 
 static void cprint_init(void);
 static int cprint1(const char *fmt, ...);
@@ -864,7 +864,7 @@ static void show_help(struct menu *menu)
 	str_free(&help);
 }
 
-static void show_file(const char *filename, const char *title, int r, int c)
+static void show_file(const char *fname, const char *title, int r, int c)
 {
 	do {
 		cprint_init();
@@ -873,7 +873,7 @@ static void show_file(const char *filena
 			cprint("%s", title);
 		}
 		cprint("--textbox");
-		cprint("%s", filename);
+		cprint("%s", fname);
 		cprint("%d", r ? r : rows);
 		cprint("%d", c ? c : cols);
 	} while (exec_conf() < 0);



