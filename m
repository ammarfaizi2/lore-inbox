Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVIJSFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVIJSFo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 14:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVIJSEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 14:04:44 -0400
Received: from ppp-62-11-72-160.dialup.tiscali.it ([62.11.72.160]:32936 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932246AbVIJSEd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 14:04:33 -0400
Message-Id: <20050910174630.063774000@zion.home.lan>
References: <20050910174452.907256000@zion.home.lan>
Date: Sat, 10 Sep 2005 19:44:59 +0200
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: user-mode-linux-devel@lists.sourceforge.net
Subject: [patch 7/7] uml: retry host close() on EINTR
Content-Disposition: inline; filename=fix-close-eintr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When calling close() on the host, we must retry the operation when we get
EINTR.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/file.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -17,6 +17,7 @@
 #include <sys/uio.h>
 #include "os.h"
 #include "user.h"
+#include "user_util.h"
 #include "kern_util.h"
 
 static void copy_stat(struct uml_stat *dst, struct stat64 *src)
@@ -300,7 +301,7 @@ int os_connect_socket(char *name)
 
 void os_close_file(int fd)
 {
-	close(fd);
+	CATCH_EINTR(close(fd));
 }
 
 int os_seek_file(int fd, __u64 offset)

--
