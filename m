Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262564AbSIUQUy>; Sat, 21 Sep 2002 12:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263334AbSIUQUy>; Sat, 21 Sep 2002 12:20:54 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:34005
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S262564AbSIUQUx>; Sat, 21 Sep 2002 12:20:53 -0400
Date: Sat, 21 Sep 2002 12:25:59 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix to strchr() in lib/string.c
Message-ID: <Pine.LNX.4.44.0209211209390.15918-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The return value of strchr("foo",0) should be the start address of
"foo" + 3, not NULL.


--- linux/lib/string.c	Thu Aug  1 17:16:34 2002
+++ linux/lib/string.c	Sat Sep 21 12:21:54 2002
@@ -190,10 +190,11 @@
  */
 char * strchr(const char * s, int c)
 {
-	for(; *s != (char) c; ++s)
-		if (*s == '\0')
-			return NULL;
-	return (char *) s;
+	do {
+		if (*s == (char) c)
+			return (char *) s;
+	} while (*s++);
+	return NULL;
 }
 #endif
 

