Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWARA2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWARA2e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWARA2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:28:16 -0500
Received: from [151.97.230.9] ([151.97.230.9]:14051 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S964976AbWARA1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:27:39 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 9/9] uml ubd code: fix a bit of whitespace
Date: Wed, 18 Jan 2006 01:19:50 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060118001949.14622.23014.stgit@zion.home.lan>
In-Reply-To: <20060117235659.14622.18544.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Correct a bit of whitespace problems while working here.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index e498f34..f93af66 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1200,15 +1200,16 @@ int open_ubd_file(char *file, struct ope
 	int fd, err, sectorsize, asked_switch, mode = 0644;
 
 	fd = os_open_file(file, *openflags, mode);
-	if(fd < 0){
-		if((fd == -ENOENT) && (create_cow_out != NULL))
+	if (fd < 0) {
+		if ((fd == -ENOENT) && (create_cow_out != NULL))
 			*create_cow_out = 1;
-                if(!openflags->w ||
-                   ((fd != -EROFS) && (fd != -EACCES))) return(fd);
+                if (!openflags->w ||
+                   ((fd != -EROFS) && (fd != -EACCES)))
+			return fd;
 		openflags->w = 0;
 		fd = os_open_file(file, *openflags, mode);
-		if(fd < 0)
-			return(fd);
+		if (fd < 0)
+			return fd;
         }
 
 	err = os_lock_file(fd, openflags->w);
@@ -1218,7 +1219,8 @@ int open_ubd_file(char *file, struct ope
 	}
 
 	/* Succesful return case! */
-	if(backing_file_out == NULL) return(fd);
+	if(backing_file_out == NULL)
+		return(fd);
 
 	err = read_cow_header(file_reader, &fd, &version, &backing_file, &mtime,
 			      &size, &sectorsize, &align, bitmap_offset_out);
@@ -1227,7 +1229,8 @@ int open_ubd_file(char *file, struct ope
 		       "errno = %d\n", file, -err);
 		goto out_close;
 	}
-	if(err) return(fd);
+	if(err)
+		return(fd);
 
 	asked_switch = path_requires_switch(*backing_file_out, backing_file, file);
 
@@ -1236,24 +1239,24 @@ int open_ubd_file(char *file, struct ope
 		printk("Switching backing file to '%s'\n", *backing_file_out);
 		err = write_cow_header(file, fd, *backing_file_out,
 				       sectorsize, align, &size);
-		if(err){
+		if (err) {
 			printk("Switch failed, errno = %d\n", -err);
 			goto out_close;
 		}
-	}
-	else {
+	} else {
 		*backing_file_out = backing_file;
 		err = backing_file_mismatch(*backing_file_out, size, mtime);
-		if(err) goto out_close;
+		if (err)
+			goto out_close;
 	}
 
 	cow_sizes(version, size, sectorsize, align, *bitmap_offset_out,
 		  bitmap_len_out, data_offset_out);
 
-        return(fd);
+        return fd;
  out_close:
 	os_close_file(fd);
-	return(err);
+	return err;
 }
 
 int create_cow_file(char *cow_file, char *backing_file, struct openflags flags,

