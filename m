Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbTIEJU6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 05:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTIEJU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 05:20:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8900 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262394AbTIEJU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 05:20:56 -0400
Date: Fri, 5 Sep 2003 11:20:50 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: braam@clusterfs.com, intermezzo-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.4 patch] fix a compile warning in InterMezzo file.c
Message-ID: <20030905092050.GQ1374@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following warning in 2.4.23-pre3:

<--  snip  -->

...
gcc-2.95 -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.23-pre3-full/inclu
de -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix 
include -DKBUILD_BASENAME=file  -c -o file.o file.c
file.c: In function `presto_open_upcall':
file.c:64: warning: `rc' might be used uninitialized in this function
...

<--  snip  -->

The patch below (already included in 2.6) fixes this warning.

Please apply
Adrian

--- linux-2.4.23-pre3-full/fs/intermezzo/file.c.old	2003-09-05 09:42:49.000000000 +0200
+++ linux-2.4.23-pre3-full/fs/intermezzo/file.c	2003-09-05 11:16:37.000000000 +0200
@@ -61,7 +61,7 @@
 
 static int presto_open_upcall(int minor, struct dentry *de)
 {
-        int rc;
+        int rc = 0;
         char *path, *buffer;
         struct presto_file_set *fset;
         int pathlen;
