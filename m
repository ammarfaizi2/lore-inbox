Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285946AbRLHVFZ>; Sat, 8 Dec 2001 16:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285951AbRLHVFP>; Sat, 8 Dec 2001 16:05:15 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:63901 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285946AbRLHVFA>;
	Sat, 8 Dec 2001 16:05:00 -0500
Date: Sat, 8 Dec 2001 16:04:59 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for idiocy in mount_root cleanups.
In-Reply-To: <Pine.LNX.4.33.0112080957530.16918-100000@athlon.transmeta.com>
Message-ID: <Pine.GSO.4.21.0112081604060.7302-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	OK, for the time being we can simply go with

diff -urN C1-pre7/init/do_mounts.c C1-pre7-fix/init/do_mounts.c
--- C1-pre7/init/do_mounts.c	Fri Dec  7 20:48:43 2001
+++ C1-pre7-fix/init/do_mounts.c	Sat Dec  8 15:54:46 2001
@@ -351,7 +351,8 @@
 		mount("devfs", ".", "devfs", 0, NULL);
 retry:
 	for (p = fs_names; *p; p += strlen(p)+1) {
-		err = mount(name,"/root",p,root_mountflags,root_mount_data);
+		int err;
+		err = sys_mount(name,"/root",p,root_mountflags,root_mount_data);
 		switch (err) {
 			case 0:
 				goto done;

Is that OK with you?

