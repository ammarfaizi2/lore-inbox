Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUCHXnZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbUCHXnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:43:25 -0500
Received: from smtp05.web.de ([217.72.192.209]:5386 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261406AbUCHXnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:43:22 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix warning about duplicate 'const'
Date: Tue, 9 Mar 2004 00:43:18 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZUQTALwnphfQXII"
Message-Id: <200403090043.21043.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ZUQTALwnphfQXII
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

attached is a patch which fixes following wanings:

drivers/ide/ide-tape.c: In function `idetape_setup':
drivers/ide/ide-tape.c:4701: Warnung: duplicate `const'
drivers/video/matrox/matroxfb_g450.c: In function `g450_compute_bwlevel':
drivers/video/matrox/matroxfb_g450.c:129: Warnung: duplicate `const'
drivers/video/matrox/matroxfb_g450.c:130: Warnung: duplicate `const'
drivers/video/matrox/matroxfb_maven.c: In function `maven_compute_bwlevel':
drivers/video/matrox/matroxfb_maven.c:347: Warnung: duplicate `const'
drivers/video/matrox/matroxfb_maven.c:348: Warnung: duplicate `const'

This is done by removing the 'const' from the temporary variables of the min() 
and max() macros. For me it seems to have no negative impact, so please 
consider applying...

Best regards
   Thomas Schlichter

--Boundary-00=_ZUQTALwnphfQXII
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fix-duplicate-const-warning.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix-duplicate-const-warning.diff"

--- linux-2.6.4-rc2/include/linux/kernel.h.orig	2004-03-04 07:16:34.000000000 +0100
+++ linux-2.6.4-rc2/include/linux/kernel.h	2004-03-09 00:34:21.980935992 +0100
@@ -168,15 +168,15 @@ extern void dump_stack(void);
  * "unnecessary" pointer comparison.
  */
 #define min(x,y) ({ \
-	const typeof(x) _x = (x);	\
-	const typeof(y) _y = (y);	\
-	(void) (&_x == &_y);		\
+	typeof(x) _x = (x);	\
+	typeof(y) _y = (y);	\
+	(void) (&_x == &_y);	\
 	_x < _y ? _x : _y; })
 
 #define max(x,y) ({ \
-	const typeof(x) _x = (x);	\
-	const typeof(y) _y = (y);	\
-	(void) (&_x == &_y);		\
+	typeof(x) _x = (x);	\
+	typeof(y) _y = (y);	\
+	(void) (&_x == &_y);	\
 	_x > _y ? _x : _y; })
 
 /*

--Boundary-00=_ZUQTALwnphfQXII--

