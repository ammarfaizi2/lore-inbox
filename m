Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313293AbSDDSTw>; Thu, 4 Apr 2002 13:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313297AbSDDSTm>; Thu, 4 Apr 2002 13:19:42 -0500
Received: from cobae1.consultronics.on.ca ([205.210.130.26]:59783 "EHLO
	cobae1.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S313293AbSDDSTj> convert rfc822-to-8bit; Thu, 4 Apr 2002 13:19:39 -0500
Date: Thu, 4 Apr 2002 13:19:26 -0500
From: Greg Louis <glouis@dynamicro.on.ca>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: mini [PATCH] 2.4.19-pre5-ac1 compile error
Message-ID: <20020404181925.GA25301@athame.dynamicro.on.ca>
Reply-To: Greg Louis <glouis@dynamicro.on.ca>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I needed this patch to prevent this:

gcc -D__KERNEL__ -I/usr/src/expt/linux-2.4.19p5a1/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686   -DKBUILD_BASENAME=do_mounts -c -o init/do_mounts.o
init/do_mounts.c
init/do_mounts.c: In function andle_initrd':
init/do_mounts.c:670: CHED_YIELD' undeclared (first use in this
function)
init/do_mounts.c:670: (Each undeclared identifier is reported only once
init/do_mounts.c:670: for each function it appears in.)
init/do_mounts.c: At top level:
init/do_mounts.c:324: warning: ount_nfs_root' defined but not used
make: *** [init/do_mounts.o] Error 1

--- linux-2.4.19pre5/init/do_mounts.c.orig	2002-04-04 13:05:05.000000000 -0500
+++ linux-2.4.19pre5/init/do_mounts.c	2002-04-04 13:05:05.000000000 -0500
@@ -667,8 +667,7 @@
 	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
 		while (pid != wait(&i)) {
-			current->policy |= SCHED_YIELD;
-			schedule();
+			yield();
 		}
 	}
 


-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |
