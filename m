Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWEVD53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWEVD53 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbWEVD5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:57:03 -0400
Received: from xenotime.net ([66.160.160.81]:8919 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751199AbWEVD41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:56:27 -0400
Date: Sun, 21 May 2006 20:57:48 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, sfr@canb.auug.org.au
Subject: [PATCH 9/14/] Doc. sources: expose dnotify
Message-Id: <20060521205748.ce510aa0.rdunlap@xenotime.net>
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

Documentation/dnotify.txt:
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
 Documentation/dnotify.txt       |   38 +-------------------------------------
 Documentation/dnotify_example.c |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 37 deletions(-)

--- linux-2617-rc4g9-docsrc-split.orig/Documentation/dnotify.txt
+++ linux-2617-rc4g9-docsrc-split/Documentation/dnotify.txt
@@ -60,40 +60,4 @@ Configuration
 Dnotify is controlled via the CONFIG_DNOTIFY configuration option.  When
 disabled, fcntl(fd, F_NOTIFY, ...) will return -EINVAL.
 
-Example
--------
-
-	#define _GNU_SOURCE	/* needed to get the defines */
-	#include <fcntl.h>	/* in glibc 2.2 this has the needed
-					   values defined */
-	#include <signal.h>
-	#include <stdio.h>
-	#include <unistd.h>
-	
-	static volatile int event_fd;
-	
-	static void handler(int sig, siginfo_t *si, void *data)
-	{
-		event_fd = si->si_fd;
-	}
-	
-	int main(void)
-	{
-		struct sigaction act;
-		int fd;
-		
-		act.sa_sigaction = handler;
-		sigemptyset(&act.sa_mask);
-		act.sa_flags = SA_SIGINFO;
-		sigaction(SIGRTMIN + 1, &act, NULL);
-		
-		fd = open(".", O_RDONLY);
-		fcntl(fd, F_SETSIG, SIGRTMIN + 1);
-		fcntl(fd, F_NOTIFY, DN_MODIFY|DN_CREATE|DN_MULTISHOT);
-		/* we will now be notified if any of the files
-		   in "." is modified or new files are created */
-		while (1) {
-			pause();
-			printf("Got event on fd=%d\n", event_fd);
-		}
-	}
+Example:  see Documentation/dnotify_example.c
--- /dev/null
+++ linux-2617-rc4g9-docsrc-split/Documentation/dnotify_example.c
@@ -0,0 +1,34 @@
+#define _GNU_SOURCE	/* needed to get the defines */
+#include <fcntl.h>	/* in glibc 2.2 this has the needed
+				   values defined */
+#include <signal.h>
+#include <stdio.h>
+#include <unistd.h>
+
+static volatile int event_fd;
+
+static void handler(int sig, siginfo_t *si, void *data)
+{
+	event_fd = si->si_fd;
+}
+
+int main(void)
+{
+	struct sigaction act;
+	int fd;
+	
+	act.sa_sigaction = handler;
+	sigemptyset(&act.sa_mask);
+	act.sa_flags = SA_SIGINFO;
+	sigaction(SIGRTMIN + 1, &act, NULL);
+	
+	fd = open(".", O_RDONLY);
+	fcntl(fd, F_SETSIG, SIGRTMIN + 1);
+	fcntl(fd, F_NOTIFY, DN_MODIFY|DN_CREATE|DN_MULTISHOT);
+	/* we will now be notified if any of the files
+	   in "." is modified or new files are created */
+	while (1) {
+		pause();
+		printf("Got event on fd=%d\n", event_fd);
+	}
+}


---
