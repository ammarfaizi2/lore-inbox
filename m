Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130008AbRANDpt>; Sat, 13 Jan 2001 22:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130667AbRANDpj>; Sat, 13 Jan 2001 22:45:39 -0500
Received: from d131.as5200.mesatop.com ([208.164.122.131]:60551 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S130572AbRANDp2>; Sat, 13 Jan 2001 22:45:28 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Sat, 13 Jan 2001 20:47:34 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
To: Karsten Hopp <Karsten.Hopp@redhat.de>
In-Reply-To: <01011318404000.18233@localhost.localdomain> <20010114040550.A13315@bochum.redhat.de>
In-Reply-To: <20010114040550.A13315@bochum.redhat.de>
Subject: Re: Linux 2.4.0-ac9
MIME-Version: 1.0
Message-Id: <01011320473400.00928@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 January 2001 20:05, Karsten Hopp wrote:
> You need to enable CONFIG_SWAPFS.
> Those functions are enclosed by #ifdef CONFIG_SWAPFS and #endif, but
> the references to them aren't.
>
>   Karsten
>
> On Sat, Jan 13, 2001 at 06:40:40PM -0700, Steven Cole wrote:
> > I got the following error while building 2.4.0-ac9:
> >
> > shmem.c:971: `shmem_readlink' undeclared here (not in a function)
> > shmem.c:971: initializer element is not constant
> > shmem.c:971: (near initialization for
> > `shmem_symlink_inode_operations.readlink')
> > shmem.c:972: `shmem_follow_link' undeclared here (not in a function)
> > shmem.c:972: initializer element is not constant
> > shmem.c:972: (near initialization for
> > `shmem_symlink_inode_operations.follow_link')
> > shmem.c:973: initializer element is not constant
> > shmem.c:973: (near initialization for `shmem_symlink_inode_operations')
> > shmem.c:973: initializer element is not constant
> > shmem.c:973: (near initialization for `shmem_symlink_inode_operations')
> > make[2]: *** [shmem.o] Error 1
> >

Yes, enabling CONFIG_SWAPFS works just fine:

[scole@localhost scole]$ uname -a
Linux localhost.localdomain 2.4.0-ac9 #2 Sat Jan 13 20:23:00 MST 2001 i686 
unknown

Here is a little patch which also fixes the symptoms of the build problem, and
makes a kernel 1510 bytes smaller (without CONFIG_SWAPFS).  Someone more 
knowlegable than I will have to verify its correctness.  

This patch is against 2.4.0-ac9.

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
