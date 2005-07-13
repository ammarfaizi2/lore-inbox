Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVGMRgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVGMRgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVGMReY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:34:24 -0400
Received: from mta02.mail.t-online.hu ([195.228.240.51]:7405 "EHLO
	mta02.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S262064AbVGMRdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:33:06 -0400
Subject: [PATCH 18/19] Kconfig I18N: LKC: whitespace removing
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
Date: Wed, 13 Jul 2005 19:33:04 +0200
Message-Id: <1121275984.2975.49.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes unnecessary whitespaces from end of help 
lines of Kconfig files. The size of .po files will smaller. 
This is a compatibility fix with TLKTP's .po files.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 scripts/kconfig/zconf.l |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletion(-)

diff -puN scripts/kconfig/zconf.l~kconfig-i18n-18-whitespace-fix scripts/kconfig/zconf.l
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/zconf.l~kconfig-i18n-18-whitespace-fix	2005-07-13 18:32:20.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/zconf.l	2005-07-13 18:32:20.000000000 +0200
@@ -57,6 +57,17 @@ void append_string(const char *str, int 
 	*text_ptr = 0;
 }
 
+void append_helpstring(const char *str, int size)
+{
+	while (size) {
+		if ((str[size-1] != ' ') && (str[size-1] != '\t'))
+			break;
+		size--;
+	}
+
+	append_string (str, size);
+}
+
 void alloc_string(const char *str, int size)
 {
 	text = malloc(size + 1);
@@ -225,7 +236,7 @@ n	[A-Za-z0-9_]
 		append_string("\n", 1);
 	}
 	[^ \t\n].* {
-		append_string(yytext, yyleng);
+		append_helpstring(yytext, yyleng);
 		if (!first_ts)
 			first_ts = last_ts;
 	}
_


