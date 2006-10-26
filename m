Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423250AbWJZLGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423250AbWJZLGO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 07:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423118AbWJZLGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 07:06:14 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:42175 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423250AbWJZLGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 07:06:13 -0400
Date: Thu, 26 Oct 2006 13:07:03 +0200
From: Michael Holzheu <holzheu@de.ibm.com>
To: penberg@cs.helsinki.fi
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, joern@wohnheim.fh-wedel.de,
       schwidefsky@de.ibm.com, ioe-lkml@rameria.de, minyard@acm.org
Subject: [PATCH] strstrip remove last blank fix
Message-Id: <20061026130703.6f8cc0bd.holzheu@de.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

strstrip() does not remove the last blank from strings which only consist
of blanks.

Example:
char string[] = "  ";
strstrip(string);

results in " ", but should produce an empty string!

The following patch solves this problem:

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>

---

 lib/string.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp linux-2.6.18/lib/string.c linux-2.6.18-strstrip-fix/lib/string.c
--- linux-2.6.18/lib/string.c	2006-06-19 14:03:20.000000000 +0200
+++ linux-2.6.18-strstrip-fix/lib/string.c	2006-10-25 18:36:08.000000000 +0200
@@ -320,7 +320,7 @@ char *strstrip(char *s)
 		return s;
 
 	end = s + size - 1;
-	while (end != s && isspace(*end))
+	while (end >= s && isspace(*end))
 		end--;
 	*(end + 1) = '\0';
 

