Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313661AbSEEVW4>; Sun, 5 May 2002 17:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313675AbSEEVWz>; Sun, 5 May 2002 17:22:55 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:26264 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313661AbSEEVWy>;
	Sun, 5 May 2002 17:22:54 -0400
Date: Sun, 5 May 2002 17:22:53 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] do_mounts.c printk fix
Message-ID: <Pine.GSO.4.21.0205051719010.26532-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	D'uh.  Linus, 2.5 also needs that one.

BTW, folks - whoever had submitted "fixes" replacing /dev/root.old with
/old/dev/root.old several lines above that one are welcome to think
about the reasons why their patches removed "failed" from boot log.

diff -urN S19-pre8-change_floppy/init/do_mounts.c S19-pre8-current/init/do_mounts.c
--- S19-pre8-change_floppy/init/do_mounts.c	Fri May  3 19:41:09 2002
+++ S19-pre8-current/init/do_mounts.c	Sun May  5 16:35:44 2002
@@ -807,7 +807,7 @@
 			error = sys_ioctl(fd, BLKFLSBUF, 0);
 			close(fd);
 		}
-		printk(error ? "okay\n" : "failed\n");
+		printk(!error ? "okay\n" : "failed\n");
 	}
 #endif
 }

