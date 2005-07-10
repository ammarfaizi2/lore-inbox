Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVGJT7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVGJT7W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVGJT6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:58:40 -0400
Received: from mta02.mail.t-online.hu ([195.228.240.51]:62149 "EHLO
	mta02.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S262091AbVGJT5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:57:00 -0400
Subject: [PATCH 1/3] kconfig: kxgettext: message fix
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Content-Type: text/plain
Date: Sun, 10 Jul 2005 21:56:50 +0200
Message-Id: <1121025410.3008.6.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The gettext doesn't handle the {CONFIG}:00000 markers as sources. 
I added a simple comment prefix for them.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>

---

 kxgettext.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff -Nru linux-2.6.13-rc2/scripts/kconfig/kxgettext.c
linux-2.6.13-rc2-i18n-kconfig/scripts/kconfig/kxgettext.c
--- linux-2.6.13-rc2/scripts/kconfig/kxgettext.c	2005-07-09
12:16:04.000000000 +0200
+++ linux-2.6.13-rc2-i18n-kconfig/scripts/kconfig/kxgettext.c	2005-07-09
13:43:01.000000000 +0200
@@ -179,7 +179,11 @@
 {
 	struct file_line *fl = self->files;
 
-	printf("\n#: %s:%d", fl->file, fl->lineno);
+	putchar('\n');
+	if (self->option != NULL)
+		printf("# %s:00000\n", self->option);
+
+	printf("#: %s:%d", fl->file, fl->lineno);
 	fl = fl->next;
 
 	while (fl != NULL) {
@@ -187,9 +191,6 @@
 		fl = fl->next;
 	}
 
-	if (self->option != NULL)
-		printf(", %s:00000", self->option);
-
 	putchar('\n');
 }
 


