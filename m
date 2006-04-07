Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWDGOcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWDGOcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWDGOcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:32:24 -0400
Received: from [151.97.230.9] ([151.97.230.9]:31452 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932291AbWDGOcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:23 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 17/17] uml: avoid warnings for diffent names for an unsigned quadword
Date: Fri, 07 Apr 2006 16:31:29 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407143128.19201.32039.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Since on some 64-bit systems __u64 is rightfully defined to unsigned long and
GCC recognizes anyway unsigned long and unsigned long long as different, fix
some types back to being unsigned long long to avoid warnings and errors (for
prototype mismatch) on those systems.

Thanks to the report by Wesley Emeneker wesleyemeneker (at) google (dot) com

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/cow.h     |    2 +-
 arch/um/drivers/cow_sys.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/cow.h b/arch/um/drivers/cow.h
index 04e3958..dc36b22 100644
--- a/arch/um/drivers/cow.h
+++ b/arch/um/drivers/cow.h
@@ -46,7 +46,7 @@ extern int file_reader(__u64 offset, cha
 extern int read_cow_header(int (*reader)(__u64, char *, int, void *),
 			   void *arg, __u32 *version_out,
 			   char **backing_file_out, time_t *mtime_out,
-			   __u64 *size_out, int *sectorsize_out,
+			   unsigned long long *size_out, int *sectorsize_out,
 			   __u32 *align_out, int *bitmap_offset_out);
 
 extern int write_cow_header(char *cow_file, int fd, char *backing_file,
diff --git a/arch/um/drivers/cow_sys.h b/arch/um/drivers/cow_sys.h
index 94de4ea..7a5b4af 100644
--- a/arch/um/drivers/cow_sys.h
+++ b/arch/um/drivers/cow_sys.h
@@ -28,7 +28,7 @@ static inline int cow_seek_file(int fd, 
 	return(os_seek_file(fd, offset));
 }
 
-static inline int cow_file_size(char *file, __u64 *size_out)
+static inline int cow_file_size(char *file, unsigned long long *size_out)
 {
 	return(os_file_size(file, size_out));
 }
