Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268286AbUH2TrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268286AbUH2TrP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 15:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268289AbUH2TrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 15:47:15 -0400
Received: from hig2.hig.no ([128.39.140.8]:10654 "EHLO hig2.hig.no")
	by vger.kernel.org with ESMTP id S268286AbUH2TrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 15:47:13 -0400
Date: Sun, 29 Aug 2004 21:21:44 +0200
From: =?iso-8859-15?Q?Vegard_W=E6rp?= <vegarwa@online.no>
To: vegarwa@online.no
Subject: [PATCH] BeFS: load default nls if none is specified in mount options
Message-ID: <opsdideir8f6sr3p@yoda>
User-Agent: Opera M2/7.54 (Linux, build 751)
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Aug 2004 19:47:14.0191 (UTC) FILETIME=[FB62B1F0:01C48E00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Makes the BeOS File Systen driver load the default nls
if none is specified in the "iocharset" mount option.


Signed-off-by: Vegard Wærp <vegarwa@online.no>


diff -urN a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
--- a/fs/befs/linuxvfs.c        2004-08-29 20:51:21.000000000 +0200
+++ b/fs/befs/linuxvfs.c        2004-08-29 20:59:45.583725680 +0200
@@ -857,10 +857,14 @@
                  befs_sb->nls = load_nls(befs_sb->mount_opts.iocharset);
                  if (!befs_sb->nls) {
                          befs_warning(sb, "Cannot load nls %s"
-                                    "loding default nls",
+                                    " loading default nls",
                                       befs_sb->mount_opts.iocharset);
                          befs_sb->nls = load_nls_default();
                  }
+       /* load default nls if none is specified  in mount options */
+       } else {
+               befs_debug(sb, "Loading default nls");
+               befs_sb->nls = load_nls_default();
          }

          return 0;

