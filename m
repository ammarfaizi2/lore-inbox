Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVFUHPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVFUHPi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 03:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVFUHNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 03:13:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:55779 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261993AbVFUGa4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:30:56 -0400
Cc: gregkh@suse.de
Subject: [PATCH] devfs: Remove the line_driver devfs_name field as it's no longer needed
In-Reply-To: <11193354443124@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 23:30:44 -0700
Message-Id: <11193354443627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] devfs: Remove the line_driver devfs_name field as it's no longer needed

Also fixes all drivers that set this field.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d354272923879e42604925270dd950a94a5306c8
tree 7c15a33ce706887d2683a93380ee36691347c9a7
parent ea01c9408e24fdcd26b87d6f68cafdcdd19a791b
author Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 21:15:16 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 23:13:38 -0700

 arch/um/drivers/line.c          |    1 -
 arch/um/drivers/ssl.c           |    1 -
 arch/um/drivers/stdio_console.c |    1 -
 arch/um/include/line.h          |    1 -
 4 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -624,7 +624,6 @@ struct tty_driver *line_register_devfs(s
 
 	driver->driver_name = line_driver->name;
 	driver->name = line_driver->device_name;
-	driver->devfs_name = line_driver->devfs_name;
 	driver->major = line_driver->major;
 	driver->minor_start = line_driver->minor_start;
 	driver->type = line_driver->type;
diff --git a/arch/um/drivers/ssl.c b/arch/um/drivers/ssl.c
--- a/arch/um/drivers/ssl.c
+++ b/arch/um/drivers/ssl.c
@@ -54,7 +54,6 @@ static int ssl_remove(char *str);
 static struct line_driver driver = {
 	.name 			= "UML serial line",
 	.device_name 		= "ttyS",
-	.devfs_name 		= "tts/",
 	.major 			= TTY_MAJOR,
 	.minor_start 		= 64,
 	.type 		 	= TTY_DRIVER_TYPE_SERIAL,
diff --git a/arch/um/drivers/stdio_console.c b/arch/um/drivers/stdio_console.c
--- a/arch/um/drivers/stdio_console.c
+++ b/arch/um/drivers/stdio_console.c
@@ -60,7 +60,6 @@ static int con_remove(char *str);
 static struct line_driver driver = {
 	.name 			= "UML console",
 	.device_name 		= "tty",
-	.devfs_name 		= "vc/",
 	.major 			= TTY_MAJOR,
 	.minor_start 		= 0,
 	.type 		 	= TTY_DRIVER_TYPE_CONSOLE,
diff --git a/arch/um/include/line.h b/arch/um/include/line.h
--- a/arch/um/include/line.h
+++ b/arch/um/include/line.h
@@ -17,7 +17,6 @@
 struct line_driver {
 	char *name;
 	char *device_name;
-	char *devfs_name;
 	short major;
 	short minor_start;
 	short type;

