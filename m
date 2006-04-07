Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWDGOct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWDGOct (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWDGOcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:32:35 -0400
Received: from [151.97.230.9] ([151.97.230.9]:45020 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932351AbWDGOcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:24 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 03/17] uml: fix 2 harmless cast warnings for 64-bit
Date: Fri, 07 Apr 2006 16:30:54 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407143054.19201.89200.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix two harmless warnings in 64-bit compilation (the 2nd doesn't trigger for now
because of a missing __attribute((format)) for cow_printf, but next patches fix
that).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/cow_user.c      |    3 ++-
 arch/um/drivers/mconsole_kern.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/cow_user.c b/arch/um/drivers/cow_user.c
index a9afccf..0ec4052 100644
--- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -210,8 +210,9 @@ int write_cow_header(char *cow_file, int
 
 	err = -EINVAL;
 	if(strlen(backing_file) > sizeof(header->backing_file) - 1){
+		/* Below, %zd is for a size_t value */
 		cow_printf("Backing file name \"%s\" is too long - names are "
-			   "limited to %d characters\n", backing_file,
+			   "limited to %zd characters\n", backing_file,
 			   sizeof(header->backing_file) - 1);
 		goto out_free;
 	}
diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 28e3760..f8c6269 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -616,7 +616,7 @@ static void console_write(struct console
 		return;
 
 	while(1){
-		n = min((size_t)len, ARRAY_SIZE(console_buf) - console_index);
+		n = min((size_t) len, ARRAY_SIZE(console_buf) - console_index);
 		strncpy(&console_buf[console_index], string, n);
 		console_index += n;
 		string += n;
