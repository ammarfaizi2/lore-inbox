Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbUA3TwJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 14:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUA3TwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 14:52:09 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20165 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263953AbUA3TwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 14:52:03 -0500
Date: Fri, 30 Jan 2004 20:51:53 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, braam@clusterfs.com,
       intermezzo-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] fix a compile warning in InterMezzo file.c (fwd)
Message-ID: <20040130195153.GP3004@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.4.25-pre8.

Please apply
Adrian


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Fri, 5 Sep 2003 11:20:50 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: braam@clusterfs.com,
    intermezzo-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
    trivial@rustcorp.com.au
Subject: [2.4 patch] fix a compile warning in InterMezzo file.c

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

