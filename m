Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270712AbRHSTYh>; Sun, 19 Aug 2001 15:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270717AbRHSTY1>; Sun, 19 Aug 2001 15:24:27 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:44295 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S270712AbRHSTYN>; Sun, 19 Aug 2001 15:24:13 -0400
To: Peter Fales <psfales@lucent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UMSDOS problems in 2.4.9?
In-Reply-To: <20010818212401.A1814@lucent.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 20 Aug 2001 04:24:08 +0900
In-Reply-To: <20010818212401.A1814@lucent.com>
Message-ID: <874rr3rgyv.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.104
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Peter Fales <psfales@lucent.com> writes:

> My UMSDOS file system stopped working when I switch from 2.4.8 to 
> 2.4.9.  I can mount the partition as "msdos" or even "vfat" but if
> I use "umsdos" there are no files visible.  Has anyone else seen this?

Probably I think it related to change of filldir_t.
This problem fixed with the following patch?
--
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN linux-2.4.9/fs/umsdos/dir.c umsdos_off_t-2.4.9/fs/umsdos/dir.c
--- linux-2.4.9/fs/umsdos/dir.c	Sat Feb 10 04:29:44 2001
+++ umsdos_off_t-2.4.9/fs/umsdos/dir.c	Sun Aug 19 16:13:25 2001
@@ -67,7 +67,7 @@
 static int umsdos_dir_once (	void *buf,
 				const char *name,
 				int len,
-				off_t offset,
+				loff_t offset,
 				ino_t ino,
 				unsigned type)
 {
diff -urN linux-2.4.9/fs/umsdos/ioctl.c umsdos_off_t-2.4.9/fs/umsdos/ioctl.c
--- linux-2.4.9/fs/umsdos/ioctl.c	Thu Apr 19 03:49:13 2001
+++ umsdos_off_t-2.4.9/fs/umsdos/ioctl.c	Sun Aug 19 16:16:36 2001
@@ -28,7 +28,7 @@
 				     void *buf,
 				     const char *name,
 				     int name_len,
-				     off_t offset,
+				     loff_t offset,
 				     ino_t ino,
 				     unsigned type)
 {
diff -urN linux-2.4.9/fs/umsdos/rdir.c umsdos_off_t-2.4.9/fs/umsdos/rdir.c
--- linux-2.4.9/fs/umsdos/rdir.c	Sat Feb 10 04:29:44 2001
+++ umsdos_off_t-2.4.9/fs/umsdos/rdir.c	Sun Aug 19 16:16:34 2001
@@ -32,7 +32,7 @@
 static int rdir_filldir (	void *buf,
 				const char *name,
 				int name_len,
-				off_t offset,
+				loff_t offset,
 				ino_t ino,
 				unsigned int d_type)
 {

