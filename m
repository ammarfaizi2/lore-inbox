Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUFFQCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUFFQCx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUFFQCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:02:53 -0400
Received: from may.priocom.com ([213.156.65.50]:38138 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S263761AbUFFQCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:02:49 -0400
Subject: [PATCH] 2.6.6 memory allocation checks in
	cifs_parse_mount_options()
From: Yury Umanets <torque@ukrpost.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086537787.2793.61.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 06 Jun 2004 19:03:16 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds memory allocation checks in cifs_parse_mount_options().

 ./linux-2.6.6-modified/fs/cifs/connect.c |    4 ++++
 1 files changed, 4 insertions(+)

Signed-off-by: Yury Umanets <torque@ukrpost.net>

diff -rupN ./linux-2.6.6/fs/cifs/connect.c
./linux-2.6.6-modified/fs/cifs/connect.c
--- ./linux-2.6.6/fs/cifs/connect.c	Mon May 10 05:33:19 2004
+++ ./linux-2.6.6-modified/fs/cifs/connect.c	Wed Jun  2 14:36:40 2004
@@ -587,6 +587,8 @@ cifs_parse_mount_options(char *options, 
 			}
 			if ((temp_len = strnlen(value, 300)) < 300) {
 				vol->UNC = kmalloc(temp_len+1,GFP_KERNEL);
+				if (!vol->UNC)
+					return 1;
 				strcpy(vol->UNC,value);
 				if (strncmp(vol->UNC, "//", 2) == 0) {
 					vol->UNC[0] = '\\';
@@ -727,6 +729,8 @@ cifs_parse_mount_options(char *options, 
 		}
 		if ((temp_len = strnlen(devname, 300)) < 300) {
 			vol->UNC = kmalloc(temp_len+1,GFP_KERNEL);
+			if (!vol->UNC)
+				return 1;
 			strcpy(vol->UNC,devname);
 			if (strncmp(vol->UNC, "//", 2) == 0) {
 				vol->UNC[0] = '\\';



-- 
umka
-- 
umka

