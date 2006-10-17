Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWJQV3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWJQV3q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWJQV3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:29:42 -0400
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63]:1931 "HELO
	smtp009.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750710AbWJQV1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:27:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=kkGXFnDpvzjaVw0a5i3m+mMaMDTlF551+Qkp7O5Z7PK87z0Fjc8O8WvqgP6zQTir9/Z7/wxspVZsxR9TQilo/sJwhZ0+5Gb7P1M9ds3gf4jMiseQGvztRQu8LSJy0qtaa8f2Kg1ju02vMRh1vrnsTRIxDJd+jgBjlY/ja2ibhRs=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 03/10] uml: fix prototypes
Date: Tue, 17 Oct 2006 23:27:09 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061017212709.26445.54420.stgit@americanbeauty.home.lan>
In-Reply-To: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix prototypes in user.h - was needed when including user.h in kernelspace, as
we did in previous patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/user.h |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/user.h b/arch/um/include/user.h
index acadce3..6921f3e 100644
--- a/arch/um/include/user.h
+++ b/arch/um/include/user.h
@@ -6,6 +6,10 @@
 #ifndef __USER_H__
 #define __USER_H__
 
+/* Both on kernelspace and userspace this will provide the size_t definition. It should, at
+ * least. But on userspace it won't hurt surely. */
+#include <linux/types.h>
+
 extern void panic(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 extern int printk(const char *fmt, ...)
@@ -13,9 +17,8 @@ extern int printk(const char *fmt, ...)
 extern void schedule(void);
 extern int in_aton(char *str);
 extern int open_gdb_chan(void);
-/* These use size_t, however unsigned long is correct on both i386 and x86_64. */
-extern unsigned long strlcpy(char *, const char *, unsigned long);
-extern unsigned long strlcat(char *, const char *, unsigned long);
+extern size_t strlcpy(char *, const char *, size_t);
+extern size_t strlcat(char *, const char *, size_t);
 
 #endif
 
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
