Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262248AbSKHTUq>; Fri, 8 Nov 2002 14:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSKHTUq>; Fri, 8 Nov 2002 14:20:46 -0500
Received: from air-2.osdl.org ([65.172.181.6]:23721 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262248AbSKHTUp>;
	Fri, 8 Nov 2002 14:20:45 -0500
Date: Fri, 8 Nov 2002 11:22:38 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Douglas Gilbert <dougg@torque.net>
cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: [PATCH] Re: sscanf("-1", "%d", &i) fails, returns 0
In-Reply-To: <3DCBBCDA.3050203@torque.net>
Message-ID: <Pine.LNX.4.33L2.0211081118250.32726-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Nov 2002, Douglas Gilbert wrote:

| In lk 2.5.46-bk3 the expression in the subject line
| fails to write into "i" and returns 0. Drop the minus
| sign and it works.

Here's an unobstrusive patch to correct that.
Please apply.

-- 
~Randy



--- ./lib/vsprintf.c%signed	Mon Nov  4 14:30:49 2002
+++ ./lib/vsprintf.c	Fri Nov  8 11:20:03 2002
@@ -517,6 +517,7 @@
 {
 	const char *str = buf;
 	char *next;
+	char *dig;
 	int num = 0;
 	int qualifier;
 	int base;
@@ -638,12 +639,13 @@
 		while (isspace(*str))
 			str++;

-		if (!*str
-                    || (base == 16 && !isxdigit(*str))
-                    || (base == 10 && !isdigit(*str))
-                    || (base == 8 && (!isdigit(*str) || *str > '7'))
-                    || (base == 0 && !isdigit(*str)))
-			break;
+		dig = (*str == '-') ? (str + 1) : str;
+		if (!*dig
+                    || (base == 16 && !isxdigit(*dig))
+                    || (base == 10 && !isdigit(*dig))
+                    || (base == 8 && (!isdigit(*dig) || *dig > '7'))
+                    || (base == 0 && !isdigit(*dig)))
+				break;

 		switch(qualifier) {
 		case 'h':

