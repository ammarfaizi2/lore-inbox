Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAXJq2>; Wed, 24 Jan 2001 04:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAXJqS>; Wed, 24 Jan 2001 04:46:18 -0500
Received: from hermes.mixx.net ([212.84.196.2]:8198 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129383AbRAXJqH>;
	Wed, 24 Jan 2001 04:46:07 -0500
From: Daniel Phillips <phillips@innominate.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Compile dnotify example w/o glibc 2.2 headers
Date: Wed, 24 Jan 2001 10:27:54 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01012410434304.16618@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<plug>dnotify is cool, check it out</plug>

If you want to compile the example in Documentation/dnotify.txt and
you don't have glibc 2.2 headers installed you have 3 choices:

  1) Upgrade to glibc 2.2
  2) Hunt for the missing symbols in the 2.4 source tree
  3) Apply this patch

Option (1) is recommended of course, but if you're lazy (like me)
then...

--- 2.4.0/Documentation/dnotify.txt~	Mon Jan 22 16:04:32 2001
+++ 2.4.0/Documentation/dnotify.txt	Mon Jan 22 16:04:25 2001
@@ -63,6 +63,17 @@
 	#include <stdio.h>
 	#include <unistd.h>
 	
+	#ifndef F_NOTIFY 	/* pre-glibc 2.2? */
+	#define F_NOTIFY	1026
+	#define DN_ACCESS	0x00000001	/* File accessed */
+	#define DN_MODIFY	0x00000002	/* File modified */
+	#define DN_CREATE	0x00000004	/* File created */
+	#define DN_DELETE	0x00000008	/* File removed */
+	#define DN_RENAME	0x00000010	/* File renamed */
+	#define DN_ATTRIB	0x00000020	/* File changed attibutes */
+	#define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
+	#endif
+
 	static volatile int event_fd;
 	
 	static void handler(int sig, siginfo_t *si, void *data)

-- 
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
