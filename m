Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292312AbSB0JuU>; Wed, 27 Feb 2002 04:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292304AbSB0JuL>; Wed, 27 Feb 2002 04:50:11 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:50186 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S292294AbSB0Jtx>; Wed, 27 Feb 2002 04:49:53 -0500
To: Todor Todorov <ttodorov@web.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.5-dj2 and vfat oopses (ksymoops output included)
In-Reply-To: <3C7C72C3.60906@web.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 27 Feb 2002 18:49:39 +0900
In-Reply-To: <3C7C72C3.60906@web.de>
Message-ID: <87zo1vi79o.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Todor Todorov <ttodorov@web.de> writes:

> Hello everyone,
> 
> trying to copy a file to a fat 32 partition, the kernel oopses. Here
> is the information
> % uname -r
>         2.5.5-dj2
> distro:
>         Debian GNU/Linux unstable
> machine:
>         Dell Inspiron 8000
> partition:
>         hda7, type c (FAT 32 LBA) on a 40 GB Toshiba HD
> fstab entry for the partition:
>         /dev/hda7   /mnt/data   vfat
> rw,quiet,uid=1000,gid=100,codepage=850  0  0

Thanks for good bug report. Probably, the following patch fix this
bug. Could you try the following patch?

--- linux-2.5.5-dj2/fs/nls/nls_cp850.c.orig	Wed Feb 27 16:55:36 2002
+++ linux-2.5.5-dj2/fs/nls/nls_cp850.c	Wed Feb 27 18:31:20 2002
@@ -296,6 +296,7 @@
 	uni2char:	uni2char,
 	char2uni:	char2uni,
 	charset2lower:	charset2lower,
+	charset2upper:	charset2upper,
 	owner:		THIS_MODULE,
 };

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
