Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264327AbSIVQVf>; Sun, 22 Sep 2002 12:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264380AbSIVQVf>; Sun, 22 Sep 2002 12:21:35 -0400
Received: from p508E9036.dip.t-dialin.net ([80.142.144.54]:38393 "EHLO
	minerva.local.lan") by vger.kernel.org with ESMTP
	id <S264327AbSIVQVe>; Sun, 22 Sep 2002 12:21:34 -0400
From: Martin Loschwitz <madkiss@madkiss.org>
Date: Sun, 22 Sep 2002 18:26:38 +0200
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] make check.c compile in 2.5.38 with DevFS
Message-ID: <20020922162638.GA404@minerva.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch was necessary for me to get fs/partitions/check.c
compiling with DevFS.

diff -ruN linux-2.5.38/fs/partitions/check.c linux-2.5.38-new/fs/partitions/check.c
--- linux-2.5.38/fs/partitions/check.c  2002-09-22 06:25:06.000000000 +0200
+++ linux-2.5.38-new/fs/partitions/check.c      2002-09-22 17:43:58.000000000 +0200
@@ -362,7 +362,7 @@
                pos = devfs_generate_path(dev->disk_de, rname+3, sizeof(rname)-3);
                if (pos >= 0) {
                        strncpy(rname + pos, "../", 3);
-                       devfs_mk_symlink(devfs_handle, vname,
+                       devfs_mk_symlink(cdroms, vname,
                                         DEVFS_FL_DEFAULT,
                                         rname + pos, &slave, NULL);
                        devfs_auto_unregister(dev->de, slave);

-- 
  .''`.   Name: Martin Loschwitz
 : :'  :  E-Mail: madkiss@madkiss.org
 `. `'`   www: http://www.madkiss.org/ 
   `-     Use Debian GNU/Linux - http://www.debian.org    
