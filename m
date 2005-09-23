Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVIWVvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVIWVvK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 17:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVIWVvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 17:51:09 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:54841 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932074AbVIWVvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 17:51:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CagA6qJdwmnceS9+bf0sb9lHeJftaYxnZWKnxg13DRPtg/gRIoNu8VlfOPvl3T04wBAHZVs9oJUnxOMOlvOcNCXQ1oNBLmD6EJN++cyae6jiHz2IcFMz/r16Z+tdXtzaSFuA6/6IkyBHojID2e7HI5GnAuTey1HLXcB2RrNisuI=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] lib/string.c cleanup : remove pointless explicit casts
Date: Fri, 23 Sep 2005 23:53:14 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Oeser <ioe@informatik.tu-chemnitz.de>,
       Jason Thomas <jason@topic.com.au>,
       Matthew Hawkins <matt@mh.dropbear.id.au>
References: <200509232344.26044.jesper.juhl@gmail.com>
In-Reply-To: <200509232344.26044.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509232353.14357.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a few pointless explicit casts.
The first two hunks of the patch really belongs in patch 1, but I missed 
them on the first pass and instead of redoing all 3 patches I stuck them in 
this one.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 lib/string.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

--- linux-2.6.14-rc2-git3/lib/string.c-with-patch-2	2005-09-23 22:46:35.000000000 +0200
+++ linux-2.6.14-rc2-git3/lib/string.c	2005-09-23 23:05:19.000000000 +0200
@@ -36,7 +36,7 @@ int strnicmp(const char *s1, const char 
 	/* Yes, Virginia, it had better be unsigned */
 	unsigned char c1, c2;
 
-	c1 = 0;	c2 = 0;
+	c1 = c2 = 0;
 	if (len) {
 		do {
 			c1 = *s1;
@@ -148,7 +148,6 @@ char *strcat(char *dest, const char *src
 		dest++;
 	while ((*dest++ = *src++) != '\0')
 		;
-
 	return tmp;
 }
 EXPORT_SYMBOL(strcat);
@@ -447,7 +446,7 @@ EXPORT_SYMBOL(strsep);
  */
 void *memset(void *s, int c, size_t count)
 {
-	char *xs = (char *)s;
+	char *xs = s;
 
 	while (count--)
 		*xs++ = c;
@@ -468,8 +467,8 @@ EXPORT_SYMBOL(memset);
  */
 void *memcpy(void *dest, const void *src, size_t count)
 {
-	char *tmp = (char *)dest;
-	char *s = (char *)src;
+	char *tmp = dest;
+	char *s = src;
 
 	while (count--)
 		*tmp++ = *s++;
@@ -492,13 +491,15 @@ void *memmove(void *dest, const void *sr
 	char *tmp, *s;
 
 	if (dest <= src) {
-		tmp = (char *)dest;
-		s = (char *)src;
+		tmp = dest;
+		s = src;
 		while (count--)
 			*tmp++ = *s++;
 	} else {
-		tmp = (char *)dest + count;
-		s = (char *)src + count;
+		tmp = dest;
+		tmp += count;
+		s = src;
+		s += count;
 		while (count--)
 			*--tmp = *--s;
 	}
@@ -540,7 +541,7 @@ EXPORT_SYMBOL(memcmp);
  */
 void *memscan(void *addr, int c, size_t size)
 {
-	unsigned char *p = (unsigned char *)addr;
+	unsigned char *p = addr;
 
 	while (size) {
 		if (*p == c)


