Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271388AbRH1PRt>; Tue, 28 Aug 2001 11:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271371AbRH1PR3>; Tue, 28 Aug 2001 11:17:29 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:18700 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S271349AbRH1PRT>; Tue, 28 Aug 2001 11:17:19 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix the bug of umsdos related to change of filldir_t
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 29 Aug 2001 00:16:25 +0900
Message-ID: <87g0acgqpi.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.104
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Fales <psfales@lucent.com> writes:

> On Mon, Aug 20, 2001 at 04:24:08AM +0900, OGAWA Hirofumi wrote:
> > Hi,
> > 
> > Peter Fales <psfales@lucent.com> writes:
> > 
> > > My UMSDOS file system stopped working when I switch from 2.4.8 to 
> > > 2.4.9.  I can mount the partition as "msdos" or even "vfat" but if
> > > I use "umsdos" there are no files visible.  Has anyone else seen this?
> > 
> > Probably I think it related to change of filldir_t.
> > This problem fixed with the following patch?
>
> Yes.  It works!  Thanks!  Will that change go into the official
> kernel??

Please apply the following patch.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN linux-2.4.10-pre1/fs/umsdos/dir.c umsdos_off_t-2.4.10-pre1/fs/umsdos/dir.c
--- linux-2.4.10-pre1/fs/umsdos/dir.c	Sat Feb 10 04:29:44 2001
+++ umsdos_off_t-2.4.10-pre1/fs/umsdos/dir.c	Tue Aug 28 22:51:23 2001
@@ -67,7 +67,7 @@
 static int umsdos_dir_once (	void *buf,
 				const char *name,
 				int len,
-				off_t offset,
+				loff_t offset,
 				ino_t ino,
 				unsigned type)
 {
diff -urN linux-2.4.10-pre1/fs/umsdos/ioctl.c umsdos_off_t-2.4.10-pre1/fs/umsdos/ioctl.c
--- linux-2.4.10-pre1/fs/umsdos/ioctl.c	Thu Apr 19 03:49:13 2001
+++ umsdos_off_t-2.4.10-pre1/fs/umsdos/ioctl.c	Tue Aug 28 22:51:23 2001
@@ -28,7 +28,7 @@
 				     void *buf,
 				     const char *name,
 				     int name_len,
-				     off_t offset,
+				     loff_t offset,
 				     ino_t ino,
 				     unsigned type)
 {
diff -urN linux-2.4.10-pre1/fs/umsdos/rdir.c umsdos_off_t-2.4.10-pre1/fs/umsdos/rdir.c
--- linux-2.4.10-pre1/fs/umsdos/rdir.c	Sat Feb 10 04:29:44 2001
+++ umsdos_off_t-2.4.10-pre1/fs/umsdos/rdir.c	Tue Aug 28 22:51:23 2001
@@ -32,7 +32,7 @@
 static int rdir_filldir (	void *buf,
 				const char *name,
 				int name_len,
-				off_t offset,
+				loff_t offset,
 				ino_t ino,
 				unsigned int d_type)
 {

