Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVFKIge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVFKIge (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 04:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVFKIgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 04:36:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:5316 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261659AbVFKHsx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:53 -0400
Subject: [PATCH] Remove the line_driver devfs_name field as it's no longer needed
In-Reply-To: <11184761123101@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:32 -0700
Message-Id: <11184761123233@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also fixes all drivers that set this field.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/drivers/line.c          |    1 -
 arch/um/drivers/ssl.c           |    1 -
 arch/um/drivers/stdio_console.c |    1 -
 arch/um/include/line.h          |    1 -
 4 files changed, 4 deletions(-)

--- gregkh-2.6.orig/arch/um/drivers/line.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/arch/um/drivers/line.c	2005-06-10 23:37:24.000000000 -0700
@@ -624,7 +624,6 @@
 
 	driver->driver_name = line_driver->name;
 	driver->name = line_driver->device_name;
-	driver->devfs_name = line_driver->devfs_name;
 	driver->major = line_driver->major;
 	driver->minor_start = line_driver->minor_start;
 	driver->type = line_driver->type;
--- gregkh-2.6.orig/arch/um/drivers/ssl.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/arch/um/drivers/ssl.c	2005-06-10 23:37:24.000000000 -0700
@@ -54,7 +54,6 @@
 static struct line_driver driver = {
 	.name 			= "UML serial line",
 	.device_name 		= "ttyS",
-	.devfs_name 		= "tts/",
 	.major 			= TTY_MAJOR,
 	.minor_start 		= 64,
 	.type 		 	= TTY_DRIVER_TYPE_SERIAL,
--- gregkh-2.6.orig/arch/um/drivers/stdio_console.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/arch/um/drivers/stdio_console.c	2005-06-10 23:37:24.000000000 -0700
@@ -60,7 +60,6 @@
 static struct line_driver driver = {
 	.name 			= "UML console",
 	.device_name 		= "tty",
-	.devfs_name 		= "vc/",
 	.major 			= TTY_MAJOR,
 	.minor_start 		= 0,
 	.type 		 	= TTY_DRIVER_TYPE_CONSOLE,
--- gregkh-2.6.orig/arch/um/include/line.h	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/arch/um/include/line.h	2005-06-10 23:37:24.000000000 -0700
@@ -17,7 +17,6 @@
 struct line_driver {
 	char *name;
 	char *device_name;
-	char *devfs_name;
 	short major;
 	short minor_start;
 	short type;

