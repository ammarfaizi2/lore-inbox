Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWEVD5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWEVD5a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbWEVD46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:56:58 -0400
Received: from xenotime.net ([66.160.160.81]:8663 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751184AbWEVD41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:56:27 -0400
Date: Sun, 21 May 2006 20:57:46 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, linuxram@us.ibm.com
Subject: [PATCH 8/14/] Doc. sources: expose smount
Message-Id: <20060521205746.978f42ed.rdunlap@xenotime.net>
In-Reply-To: <20060521203349.40b40930.rdunlap@xenotime.net>
References: <20060521203349.40b40930.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Documentation/sharedsubtree.txt:
Expose example and tool source files in the Documentation/ directory in
their own files instead of being buried (almost hidden) in readme/txt files.

This will make them more visible/usable to users who may need
to use them, to developers who may need to test with them, and
to janitors who would update them if they were more visible.

Also, if any of these possibly should not be in the kernel tree at
all, it will be clearer that they are here and we can discuss if
they should be removed.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/sharedsubtree.txt |   81 +---------------------------------------
 Documentation/smount.c          |   72 +++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 78 deletions(-)

--- linux-2617-rc4g9-docsrc-split.orig/Documentation/sharedsubtree.txt
+++ linux-2617-rc4g9-docsrc-split/Documentation/sharedsubtree.txt
@@ -140,85 +140,10 @@ replicas continue to be exactly same.
 3) smount command
 
 	Currently the mount command is not aware of shared subtree features.
-	Work is in progress to add the support in mount ( util-linux package ).
-	Till then use the following program.
+	Work is in progress to add the support in mount (util-linux package).
+	Until then use the following program: see Documentation/smount.c
 
-	------------------------------------------------------------------------
-	//
-	//this code was developed my Miklos Szeredi <miklos@szeredi.hu>
-	//and modified by Ram Pai <linuxram@us.ibm.com>
-	// sample usage:
-	//              smount /tmp shared
-	//
-	#include <stdio.h>
-	#include <stdlib.h>
-	#include <unistd.h>
-	#include <sys/mount.h>
-	#include <sys/fsuid.h>
-
-	#ifndef MS_REC
-	#define MS_REC		0x4000	/* 16384: Recursive loopback */
-	#endif
-
-	#ifndef MS_SHARED
-	#define MS_SHARED		1<<20	/* Shared */
-	#endif
-
-	#ifndef MS_PRIVATE
-	#define MS_PRIVATE		1<<18	/* Private */
-	#endif
-
-	#ifndef MS_SLAVE
-	#define MS_SLAVE		1<<19	/* Slave */
-	#endif
-
-	#ifndef MS_UNBINDABLE
-	#define MS_UNBINDABLE		1<<17	/* Unbindable */
-	#endif
-
-	int main(int argc, char *argv[])
-	{
-		int type;
-		if(argc != 3) {
-			fprintf(stderr, "usage: %s dir "
-			"<rshared|rslave|rprivate|runbindable|shared|slave"
-			"|private|unbindable>\n" , argv[0]);
-			return 1;
-		}
-
-		fprintf(stdout, "%s %s %s\n", argv[0], argv[1], argv[2]);
-
-		if (strcmp(argv[2],"rshared")==0)
-			type=(MS_SHARED|MS_REC);
-		else if (strcmp(argv[2],"rslave")==0)
-			type=(MS_SLAVE|MS_REC);
-		else if (strcmp(argv[2],"rprivate")==0)
-			type=(MS_PRIVATE|MS_REC);
-		else if (strcmp(argv[2],"runbindable")==0)
-			type=(MS_UNBINDABLE|MS_REC);
-		else if (strcmp(argv[2],"shared")==0)
-			type=MS_SHARED;
-		else if (strcmp(argv[2],"slave")==0)
-			type=MS_SLAVE;
-		else if (strcmp(argv[2],"private")==0)
-			type=MS_PRIVATE;
-		else if (strcmp(argv[2],"unbindable")==0)
-			type=MS_UNBINDABLE;
-		else {
-			fprintf(stderr, "invalid operation: %s\n", argv[2]);
-			return 1;
-		}
-		setfsuid(getuid());
-
-		if(mount("", argv[1], "dontcare", type, "") == -1) {
-			perror("mount");
-			return 1;
-		}
-		return 0;
-	}
-	-----------------------------------------------------------------------
-
-	Copy the above code snippet into smount.c
+	Build/make:
 	gcc -o smount smount.c
 
 
--- /dev/null
+++ linux-2617-rc4g9-docsrc-split/Documentation/smount.c
@@ -0,0 +1,72 @@
+//
+// this code was developed my Miklos Szeredi <miklos@szeredi.hu>
+// and modified by Ram Pai <linuxram@us.ibm.com>
+// sample usage:
+//              smount /tmp shared
+//
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/mount.h>
+#include <sys/fsuid.h>
+
+#ifndef MS_REC
+#define MS_REC		0x4000	/* 16384: Recursive loopback */
+#endif
+
+#ifndef MS_SHARED
+#define MS_SHARED		1<<20	/* Shared */
+#endif
+
+#ifndef MS_PRIVATE
+#define MS_PRIVATE		1<<18	/* Private */
+#endif
+
+#ifndef MS_SLAVE
+#define MS_SLAVE		1<<19	/* Slave */
+#endif
+
+#ifndef MS_UNBINDABLE
+#define MS_UNBINDABLE		1<<17	/* Unbindable */
+#endif
+
+int main(int argc, char *argv[])
+{
+	int type;
+	if (argc != 3) {
+		fprintf(stderr, "usage: %s dir "
+		"<rshared|rslave|rprivate|runbindable|shared|slave"
+		"|private|unbindable>\n" , argv[0]);
+		return 1;
+	}
+
+	fprintf(stdout, "%s %s %s\n", argv[0], argv[1], argv[2]);
+
+	if (strcmp(argv[2],"rshared")==0)
+		type=(MS_SHARED|MS_REC);
+	else if (strcmp(argv[2],"rslave")==0)
+		type=(MS_SLAVE|MS_REC);
+	else if (strcmp(argv[2],"rprivate")==0)
+		type=(MS_PRIVATE|MS_REC);
+	else if (strcmp(argv[2],"runbindable")==0)
+		type=(MS_UNBINDABLE|MS_REC);
+	else if (strcmp(argv[2],"shared")==0)
+		type=MS_SHARED;
+	else if (strcmp(argv[2],"slave")==0)
+		type=MS_SLAVE;
+	else if (strcmp(argv[2],"private")==0)
+		type=MS_PRIVATE;
+	else if (strcmp(argv[2],"unbindable")==0)
+		type=MS_UNBINDABLE;
+	else {
+		fprintf(stderr, "invalid operation: %s\n", argv[2]);
+		return 1;
+	}
+	setfsuid(getuid());
+
+	if (mount("", argv[1], "dontcare", type, "") == -1) {
+		perror("mount");
+		return 1;
+	}
+	return 0;
+}


---
