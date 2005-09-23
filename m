Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVIWVtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVIWVtH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 17:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVIWVtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 17:49:07 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:15790 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932073AbVIWVtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 17:49:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=srBhxYFTmFbrh8ULjmY2aoNGVwp2GUG/tbdvcxlTm1I27J+SdmrNlib8wFDAfNI6KHFExD1BlmO9IGEcldaqHht32E7awr8q2zjvhHy4cFHlTBxvyFwJpL3o6xk0u78AZRZhblg9ySdhDok1cRuc+gI/wMEjqxzzSxwbIBsIvLE=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] lib/string.c cleanup : remove pointless register keyword
Date: Fri, 23 Sep 2005 23:51:12 +0200
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
Message-Id: <200509232351.12730.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes a few pointless  register  keywords. register is merely a compiler 
hint that access to the variable should be optimized, but gcc (3.3.6 in my 
case) generates the exact same code with and without the keyword, and even 
if gcc did something different with register present I think it is doubtful 
we would want to optimize access to these variables - especially since this 
is generic library code and there are supposed to be optimized versions in 
asm/ for anything that really matters speed wise.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 lib/string.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.14-rc2-git3/lib/string.c-with-patch-1	2005-09-23 22:44:42.000000000 +0200
+++ linux-2.6.14-rc2-git3/lib/string.c	2005-09-23 22:45:35.000000000 +0200
@@ -219,7 +219,7 @@ EXPORT_SYMBOL(strlcat);
 #undef strcmp
 int strcmp(const char *cs, const char *ct)
 {
-	register signed char __res;
+	signed char __res;
 
 	while (1) {
 		if ((__res = *cs - *ct++) != 0 || !*cs++)
@@ -239,7 +239,7 @@ EXPORT_SYMBOL(strcmp);
  */
 int strncmp(const char *cs, const char *ct, size_t count)
 {
-	register signed char __res = 0;
+	signed char __res = 0;
 
 	while (count) {
 		if ((__res = *cs - *ct++) != 0 || !*cs++)


