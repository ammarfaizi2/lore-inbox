Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUA0EIH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 23:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUA0EIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 23:08:07 -0500
Received: from hera.cwi.nl ([192.16.191.8]:46984 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261774AbUA0EIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 23:08:02 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 27 Jan 2004 05:07:50 +0100 (MET)
Message-Id: <UTC200401270407.i0R47oi29367.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@osdl.org
Subject: Re: [uPATCH] refuse plain ufs mount
Cc: akpm@osdl.org, gotom@debian.or.jp, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Linus Torvalds <torvalds@osdl.org>

    > But you see, it wasn't the user at all, and it wasn't a ufs filesystem.
    > It is kernel probing that causes error messages. That is unwanted.
    > So, your version is wrong.

    Yes. 

    However, I think the _real_ bug is that we have reiserfs near the tail of 
    filesystems to try.

    Can you test that alternate patch instead? 

Funny how we alternate - when I choose the pure, theoretical point of view
you prefer practice, when I prefer practice you become pure.

This time you prefer practice: the list of filesystems is full of garbage
and good filesystems should be near the top.
I prefer theory: the kernel should not probe at all, so everybody who
forgets rootfstype= gets what he deserves.

Be that as it may - below a patch as I suppose you had in mind.
I don't like it very much. Ordering constraints in makefiles are bad.

Have not compiled or tested.
You can apply it I suppose, but after doing so my earlier patch is still
meaningful. Maybe you should also apply that (and the Doc update).

Andries


diff -u --recursive --new-file -X /linux/dontdiff a/fs/Makefile b/fs/Makefile
--- a/fs/Makefile	2003-12-18 03:58:57.000000000 +0100
+++ b/fs/Makefile	2004-01-27 04:51:33.000000000 +0100
@@ -48,6 +48,7 @@
 obj-$(CONFIG_EXT3_FS)		+= ext3/ # Before ext2 so root fs can be ext3
 obj-$(CONFIG_JBD)		+= jbd/
 obj-$(CONFIG_EXT2_FS)		+= ext2/
+obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
 obj-$(CONFIG_CRAMFS)		+= cramfs/
 obj-$(CONFIG_RAMFS)		+= ramfs/
 obj-$(CONFIG_HUGETLBFS)		+= hugetlbfs/
@@ -84,7 +85,6 @@
 obj-$(CONFIG_AUTOFS_FS)		+= autofs/
 obj-$(CONFIG_AUTOFS4_FS)	+= autofs4/
 obj-$(CONFIG_ADFS_FS)		+= adfs/
-obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
 obj-$(CONFIG_UDF_FS)		+= udf/
 obj-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs/
 obj-$(CONFIG_JFS_FS)		+= jfs/
