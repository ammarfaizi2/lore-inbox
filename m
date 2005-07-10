Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVGJUBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVGJUBX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVGJT70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:59:26 -0400
Received: from mta02.mail.t-online.hu ([195.228.240.51]:7878 "EHLO
	mta02.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S262094AbVGJT7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:59:21 -0400
Subject: [PATCH 2/3] kconfig: kxgettext: EOL fix
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Content-Type: text/plain
Date: Sun, 10 Jul 2005 21:59:19 +0200
Message-Id: <1121025559.3008.8.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The end of line character doesn't exist on end of help in all case,
check it first.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>

---

 kxgettext.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -Nru linux-2.6.13-rc2/scripts/kconfig/kxgettext.c
linux-2.6.13-rc2-i18n-kconfig/scripts/kconfig/kxgettext.c
--- linux-2.6.13-rc2/scripts/kconfig/kxgettext.c	2005-07-09
12:16:04.000000000 +0200
+++ linux-2.6.13-rc2-i18n-kconfig/scripts/kconfig/kxgettext.c	2005-07-09
13:38:48.000000000 +0200
@@ -14,6 +14,11 @@
 {
 	char *bfp = bf;
 	int multiline = strchr(text, '\n') != NULL;
+	int eol = 0;
+	int textlen = strlen(text);
+
+	if ((textlen > 0) && (text[textlen-1] == '\n'))
+		eol = 1;
 
 	*bfp++ = '"';
 	--len;
@@ -43,7 +48,7 @@
 		--len;
 	}
 
-	if (multiline)
+	if (multiline && eol)
 		bfp -= 3;
 
 	*bfp++ = '"';


