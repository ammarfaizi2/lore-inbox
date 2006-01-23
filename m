Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWAWPw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWAWPw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 10:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWAWPw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 10:52:59 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:31466 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751479AbWAWPw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 10:52:58 -0500
Subject: [PATCH] ext2: print xip mount option in ext2_show_options
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: cotte@freenet.de
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: schwidefsky@de.ibm.com
Content-Type: text/plain
Organization: IBM Deutschland Entwicklung
Date: Mon, 23 Jan 2006 16:52:33 +0100
Message-Id: <1138031553.5581.5.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ext2: print xip mount option in ext2_show_options

In case we have CONFIG_FS_XIP, ext2_show_options shows
"xip" if EXT2_MOUNT_XIP mount flag is set.

Signed-off-by: Carsten Otte <cotte@de.ibm.com>
--
diff -u -w -u -r1.35 super.c
--- fs/ext2/super.c	4 Jan 2006 12:22:02 -0000	1.35
+++ fs/ext2/super.c	23 Jan 2006 15:14:11 -0000
@@ -221,6 +221,11 @@
 		seq_puts(seq, ",grpquota");
 #endif
 
+#if defined(CONFIG_EXT2_FS_XIP)
+	if (sbi->s_mount_opt & EXT2_MOUNT_XIP)
+		seq_puts(seq, ",xip");
+#endif
+
 	return 0;
 }
 


