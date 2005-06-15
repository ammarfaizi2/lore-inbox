Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVFOWM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVFOWM2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVFOWJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:09:46 -0400
Received: from mail.dif.dk ([193.138.115.101]:38106 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261634AbVFOWJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:09:02 -0400
Date: Thu, 16 Jun 2005 00:14:21 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Hannu Savolainen <hannu@opensound.com>,
       Matthias Urlichs <matthias@urlichs.de>,
       Nick Holloway <Nick.Holloway@pyrites.org.uk>, Martin Mares <mj@ucw.cz>,
       Hans Lermen <lermen@elserv.ffm.fgan.de>,
       Werner Almesberger <werner@almesberger.net>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] trivial warning fix and whitespace cleanup for
 arch/i386/boot/compressed/misc.c
Message-ID: <Pine.LNX.4.62.0506160002020.3842@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a trivial patch to fix two tiny gcc -W warnings:
arch/i386/boot/compressed/misc.c:213: warning: comparison between signed and unsigned
arch/i386/boot/compressed/misc.c:223: warning: comparison between signed and unsigned
In both cases the automatic variable 'i' of type int is compared to a 
function argument of type 'size_t' and then used as array index. Since the 
array index can never sanely be negative an unsigned type makes sense, and 
it further makes sense to then use the same type for the local automatic 
variable as the type it's compared to.  This patch fixes the warning by 
changing the type of 'i' to size_t, and it also makes a small whitespace 
cleanup by breaking two statements on same line (in the same functions) 
into two sepperate lines to improve readability.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 arch/i386/boot/compressed/misc.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6.12-rc6-mm1-orig/arch/i386/boot/compressed/misc.c	2005-06-12 15:58:34.000000000 +0200
+++ linux-2.6.12-rc6-mm1/arch/i386/boot/compressed/misc.c	2005-06-16 00:00:56.000000000 +0200
@@ -207,20 +207,22 @@ static void putstr(const char *s)
 
 static void* memset(void* s, int c, size_t n)
 {
-	int i;
+	size_t i;
 	char *ss = (char*)s;
 
-	for (i=0;i<n;i++) ss[i] = c;
+	for (i = 0; i < n; i++)
+		ss[i] = c;
 	return s;
 }
 
 static void* memcpy(void* __dest, __const void* __src,
 			    size_t __n)
 {
-	int i;
+	size_t i;
 	char *d = (char *)__dest, *s = (char *)__src;
 
-	for (i=0;i<__n;i++) d[i] = s[i];
+	for (i = 0; i < __n; i++)
+		d[i] = s[i];
 	return __dest;
 }
 


