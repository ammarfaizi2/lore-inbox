Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261824AbSJEBMx>; Fri, 4 Oct 2002 21:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261841AbSJEBMx>; Fri, 4 Oct 2002 21:12:53 -0400
Received: from p001.as-l031.contactel.cz ([212.65.234.193]:24192 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S261824AbSJEBMv>;
	Fri, 4 Oct 2002 21:12:51 -0400
Date: Sat, 5 Oct 2002 03:17:49 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: "frode@freenix.no" <frode@freenix.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40 (several issues): kernel BUG! at slab.c:1292, imm/ppa IOMega ZIP drivers modules ".o" not found, XFS won't link, depmod complains on
Message-ID: <20021005011749.GN1408@ppc.vc.cvut.cz>
References: <3D9E23E2.8000400@freenix.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9E23E2.8000400@freenix.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 01:27:30AM +0200, frode@freenix.no wrote:
> I just downloaded the linux-2.5.40 tarball.
> FAT: Using codepage cp437
> FAT: Using IO charset iso8859-1
> FAT: Using codepage cp437
> FAT: Using IO charset iso8859-1
> FAT: Using codepage cp437
> FAT: Using IO charset iso8859-1
> Adding 262136k swap on /swapfile.  Priority:-2 extents:519
> ------------[ cut here ]------------
> kernel BUG at slab.c:1292!
> invalid operand: 0000

It is probably time to send it to Linus once more...
						Petr Vandrovec

diff -urdN linux/fs/fat/inode.c linux/fs/fat/inode.c
--- linux/fs/fat/inode.c	2002-10-05 00:55:46.000000000 +0200
+++ linux/fs/fat/inode.c	2002-10-05 01:00:15.000000000 +0200
@@ -228,8 +228,6 @@
 	save = 0;
 	savep = NULL;
 	while ((this_char = strsep(&options,",")) != NULL) {
-		if (!*this_char)
-			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			save = *value;
 			savep = value;
@@ -351,7 +349,7 @@
 			strncpy(cvf_options,value,100);
 		}
 
-		if (this_char != options) *(this_char-1) = ',';
+		if (options) *(options-1) = ',';
 		if (value) *savep = save;
 		if (ret == 0)
 			break;
diff -urdN linux/fs/vfat/namei.c linux/fs/vfat/namei.c
--- linux/fs/vfat/namei.c	2002-10-05 00:56:02.000000000 +0200
+++ linux/fs/vfat/namei.c	2002-10-05 01:00:15.000000000 +0200
@@ -117,8 +117,6 @@
 	savep = NULL;
 	ret = 1;
 	while ((this_char = strsep(&options,",")) != NULL) {
-		if (!*this_char)
-			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			save = *value;
 			savep = value;
@@ -154,8 +152,8 @@
 			else
 				ret = 0;
 		}
-		if (this_char != options)
-			*(this_char-1) = ',';
+		if (options)
+			*(options-1) = ',';
 		if (value) {
 			*savep = save;
 		}
