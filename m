Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261918AbSIYF45>; Wed, 25 Sep 2002 01:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261919AbSIYF45>; Wed, 25 Sep 2002 01:56:57 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:8328 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S261918AbSIYF44>; Wed, 25 Sep 2002 01:56:56 -0400
From: jordan.breeding@attbi.com
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] fix /dev/cdroms on 2.5.38-bk current
Date: Wed, 25 Sep 2002 06:02:04 +0000
X-Mailer: AT&T Message Center Version 1 (Aug 12 2002)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NextPart_Webmail_9m3u9jl4l_23406_1032933724"
Message-Id: <20020925060206.FGZU16629.rwcrmhc51.attbi.com@rwcrwbc58>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NextPart_Webmail_9m3u9jl4l_23406_1032933724
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hello,

  Currently 2.5.38-bk ends up creating all devfs based
cdrom entries in /dev/cdroms/cdroms, this should actually
only be /dev/cdroms.  This patch fixes it for me at least.

Jordan Breeding

--NextPart_Webmail_9m3u9jl4l_23406_1032933724
Content-Type: application/octet-stream; name="patch-cdrom-fix-2.5.38-1"
Content-Transfer-Encoding: 7bit

--- linux-2.5.38/fs/partitions/check.c	2002-09-23 21:55:43.000000000 -0500
+++ linux-2.5.38-bk/fs/partitions/check.c	2002-09-24 22:53:00.000000000 -0500
@@ -348,7 +348,7 @@
 		cdroms = devfs_mk_dir (NULL, "cdroms", NULL);
 
 	dev->number = devfs_alloc_unique_number(&cdrom_numspace);
-	sprintf(vname, "cdroms/cdrom%d", dev->number);
+	sprintf(vname, "cdrom%d", dev->number);
 	if (dev->de) {
 		int pos;
 		devfs_handle_t slave;

--NextPart_Webmail_9m3u9jl4l_23406_1032933724--
