Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267352AbUHMT6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267352AbUHMT6a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUHMT4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:56:25 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:9811 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267334AbUHMTtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:49:49 -0400
Date: Fri, 13 Aug 2004 21:52:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [11/12] kbuild: Use POSIX headers for ntoh functions
Message-ID: <20040813195210.GK10556@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040813192804.GA10486@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813192804.GA10486@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/10 22:11:50+02:00 sam@mars.ravnborg.org 
#   kbuild: Use POSIX headers for ntoh functions
#   
#   From: Benno <benjl@cse.unsw.edu.au>
#   When compiling Linux on Mac OSX I had trouble with scripts/sumversion.c.
#   It includes <netinet/in.h> to obtain to definitions of htonl and ntohl.
#   
#   On Mac OSX these are found in <arpa/inet.h>. After checking the POSIX
#   specification it appears that this is the correct place to get
#   the definitons for these functions.
#   
#   (http://www.opengroup.org/onlinepubs/009695399/functions/htonl.html)
#   
#   Using this header also appears to work on Linux (at least with
#   Glibc-2.3.2).
#   
#   It seems clearer to me to go with the POSIX standard than implementing
#   #if __APPLE__ style macros, but if such an approach is preferred I can
#   supply patches for that instead.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/mod/sumversion.c
#   2004/08/10 22:11:33+02:00 sam@mars.ravnborg.org +1 -1
#   Use correct POSIX header for ntoh functions
# 
# scripts/basic/fixdep.c
#   2004/08/10 22:11:33+02:00 sam@mars.ravnborg.org +1 -1
#   Use correct POSIX header for ntoh functions
# 
diff -Nru a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
--- a/scripts/basic/fixdep.c	2004-08-13 21:07:40 +02:00
+++ b/scripts/basic/fixdep.c	2004-08-13 21:07:40 +02:00
@@ -104,7 +104,7 @@
 #include <stdio.h>
 #include <limits.h>
 #include <ctype.h>
-#include <netinet/in.h>
+#include <arpa/inet.h>
 
 #define INT_CONF ntohl(0x434f4e46)
 #define INT_ONFI ntohl(0x4f4e4649)
diff -Nru a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
--- a/scripts/mod/sumversion.c	2004-08-13 21:07:40 +02:00
+++ b/scripts/mod/sumversion.c	2004-08-13 21:07:40 +02:00
@@ -1,4 +1,4 @@
-#include <netinet/in.h>
+#include <arpa/inet.h>
 #include <stdint.h>
 #include <ctype.h>
 #include <errno.h>
