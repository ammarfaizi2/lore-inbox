Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbRAOAWz>; Sun, 14 Jan 2001 19:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129825AbRAOAWq>; Sun, 14 Jan 2001 19:22:46 -0500
Received: from d228.as5200.mesatop.com ([208.164.122.228]:22154 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S129792AbRAOAWd>; Sun, 14 Jan 2001 19:22:33 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Sun, 14 Jan 2001 17:24:18 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Cc: ignaciomonge@navegalia.com, alan@lxorguk.ukuu.org.uk
Subject: [PATCH] 2.4.0-ac9 fix for mm/shmem.c build error without CONFIG_SWAPFS enabled
MIME-Version: 1.0
Message-Id: <01011417241800.16223@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 January 2001 02:56, Christoph Rohland wrote:
> Steven Cole <elenstev@mesatop.com> writes:
> > Here is a little patch which also fixes the symptoms of the build
> > problem, and makes a kernel 1510 bytes smaller (without
> > CONFIG_SWAPFS).  Someone more knowlegable than I will have to verify
> > its correctness.
>
> Thanks, this is correct. I did not test the symlink fixes w/o
> CONFIG_SWAPFS. My bad.

Here is the patch again for those who missed it in the 
Re: Linux 2.4.0-ac9 thread.

Steven

--- linux/mm/shmem.c.orig       Sat Jan 13 20:23:36 2001
+++ linux/mm/shmem.c    Sat Jan 13 20:27:32 2001
@@ -968,8 +968,10 @@
 
 static struct inode_operations shmem_symlink_inode_operations = {
        truncate:       shmem_truncate,
+#ifdef CONFIG_SWAPFS
        readlink:       shmem_readlink,
        follow_link:    shmem_follow_link,
+#endif
 };
 
 static struct file_operations shmem_dir_operations = {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
