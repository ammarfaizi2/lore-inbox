Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129585AbQLFIzi>; Wed, 6 Dec 2000 03:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbQLFIz2>; Wed, 6 Dec 2000 03:55:28 -0500
Received: from 213-123-74-204.btconnect.com ([213.123.74.204]:11524 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129585AbQLFIzR>;
	Wed, 6 Dec 2000 03:55:17 -0500
Date: Wed, 6 Dec 2000 08:26:53 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test12-pre6
In-Reply-To: <Pine.GSO.4.21.0012060303540.14974-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0012060824360.906-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, Alexander your patch conflicts (well, not strictly but causes
patch(1) to spew warnings) with the one I just wanted to send to Linus 10
minutes ago... maybe you could merge it into yours and re-send to Linus?

Mine is obvious, see below (vfs_permission does have enough to fail with
EROFS on a readonly fs for files/directories/symlinks and truncate(2) is
undefined beyond them):

--- linux/fs/open.c	Thu Oct 26 16:11:21 2000
+++ work/fs/open.c	Wed Dec  6 06:24:43 2000
@@ -110,10 +110,6 @@
 	if (error)
 		goto dput_and_out;
 
-	error = -EROFS;
-	if (IS_RDONLY(inode))
-		goto dput_and_out;
-
 	error = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 		goto dput_and_out;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
