Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317582AbSG2TCs>; Mon, 29 Jul 2002 15:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317589AbSG2TCr>; Mon, 29 Jul 2002 15:02:47 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61635 "EHLO e1.ny.us.ibm.com.")
	by vger.kernel.org with ESMTP id <S317582AbSG2TCr>;
	Mon, 29 Jul 2002 15:02:47 -0400
Subject: Re: [PATCH] vfs_read/vfs_write small bug fix (2.5.29)
From: Paul Larson <plars@austin.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200207291825.g6TIPj026021@eng2.beaverton.ibm.com>
References: <200207291825.g6TIPj026021@eng2.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Jul 2002 14:02:26 -0500
Message-Id: <1027969346.11135.187.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 13:25, Badari Pulavarty wrote:
> Hi,
> 
> Here is a patch to fix small bug in for vfs_read/vfs_write.
> 
> Please apply.
This is actually one of the same issues I was looking at this morning. 
I noticed that the Linux Test Project tests pread02 and pwrite02 were
failing because of this.  However I also had to do some typecasting to
make it work correctly.  I'm not sure this is the best way to do it, but
without the typecasting, the tests still fail.

-Paul Larson

diff -Nru a/fs/read_write.c b/fs/read_write.c
--- a/fs/read_write.c	Mon Jul 29 14:48:45 2002
+++ b/fs/read_write.c	Mon Jul 29 14:48:45 2002
@@ -185,7 +185,7 @@
 		return -EBADF;
 	if (!file->f_op || !file->f_op->read)
 		return -EINVAL;
-	if (pos < 0)
+	if ((int)*pos < 0)
 		return -EINVAL;
 
 	ret = locks_verify_area(FLOCK_VERIFY_READ, inode, file, *pos, count);
@@ -210,7 +210,7 @@
 		return -EBADF;
 	if (!file->f_op || !file->f_op->write)
 		return -EINVAL;
-	if (pos < 0)
+	if ((int)*pos < 0)
 		return -EINVAL;
 
 	ret = locks_verify_area(FLOCK_VERIFY_WRITE, inode, file, *pos, count);

