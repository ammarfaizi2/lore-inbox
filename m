Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132585AbRDLGx6>; Thu, 12 Apr 2001 02:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132685AbRDLGxs>; Thu, 12 Apr 2001 02:53:48 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:55713 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132585AbRDLGxg>;
	Thu, 12 Apr 2001 02:53:36 -0400
Message-ID: <3AD550F0.8058FAA@mandrakesoft.com>
Date: Thu, 12 Apr 2001 02:53:36 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
Cc: Andreas Dilger <adilger@turbolinux.com>, kowalski@datrix.co.za,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Fwd: Re: memory usage - dentry_cacheg
In-Reply-To: <Pine.GSO.4.21.0104120110210.18135-100000@weyl.math.psu.edu>
Content-Type: multipart/mixed;
 boundary="------------4F4986E4763062C15AF567C0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4F4986E4763062C15AF567C0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alexander Viro wrote:
> We _have_ VM pressure there. However, such loads had never been used, so
> there's no wonder that system gets unbalanced under them.
> 
> I suspect that simple replacement of goto next; with continue; in the
> fs/dcache.c::prune_dcache() may make situation seriously better.

Awesome.  With the obvious patch attached, some local ramfs problems
disappeared, and my browser and e-mail program are no longer swapped out
when doing a kernel build.

Thanks :)

-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
--------------4F4986E4763062C15AF567C0
Content-Type: text/plain; charset=us-ascii;
 name="dcache.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dcache.patch"

Index: fs/dcache.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/fs/dcache.c,v
retrieving revision 1.1.1.16
diff -u -r1.1.1.16 dcache.c
--- fs/dcache.c	2001/03/13 04:23:27	1.1.1.16
+++ fs/dcache.c	2001/04/12 06:51:56
@@ -340,7 +340,7 @@
 		if (dentry->d_flags & DCACHE_REFERENCED) {
 			dentry->d_flags &= ~DCACHE_REFERENCED;
 			list_add(&dentry->d_lru, &dentry_unused);
-			goto next;
+			continue;
 		}
 		dentry_stat.nr_unused--;
 

--------------4F4986E4763062C15AF567C0--

