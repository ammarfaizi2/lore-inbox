Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSEVTqz>; Wed, 22 May 2002 15:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316711AbSEVTqy>; Wed, 22 May 2002 15:46:54 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:14345 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S316705AbSEVTqx>; Wed, 22 May 2002 15:46:53 -0400
To: Jan Kara <jack@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Nathan Scott <nathans@wobbly.melbourne.sgi.com>
Subject: Re: Quota patches
In-Reply-To: <20020520135530.GB9209@atrey.karlin.mff.cuni.cz>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 23 May 2002 04:46:28 +0900
Message-ID: <87bsb86k4r.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jan Kara <jack@suse.cz> writes:

>   Hello,
> 
>   In following mails I'll send (because patches are big, I'll post them just
> diretly to Linus - others see ftp below) quota patches for 2.5.15 (patches
> apply well on 2.5.16 too). Currently they implement:
>   * new quota format (allows 32 uids, accounting in bytes -> mainly for
>     Reiserfs)
>   * needed infrastructure for XFS quota
>   * quota statistics in /proc (we can drop Q_GETSTATS call; it's a lot
>     easier to change in future)
>   * implements correct syncing of quota
>   * introduces interface which allows usage of both quota formats in kernel
>   * implemented filesystem callback function on certain quota operations
>     (needed for journaled quota, Ext3)
>   * implements ioctl() for reporting occupied space in bytes (not just blocks)
> 
>   The patches can be downloaded at:
> ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/v2.5/2.5.15/
> 
>   Old quota tools should work with patches if you configure old quota interface
> in '.config'. There are also quota utilities capable of communicating with new
> generic interface. You can download them at:
> 
> http://www.sf.net/projects/linuxquota/
> 
> or you can checkout version from SourceForge CVS.
> 
>   Any comments & bugreports welcome.

What do you think of the following patches for kernel without
quota support? We already have weak symbol for sys_quotactl(). 

--- linux-bk/fs/Makefile        Wed May 22 01:17:48 2002
+++ linux-2.5.17/fs/Makefile    Thu May 23 03:23:30 2002
@@ -15,7 +15,7 @@
                namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
                dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
                filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-               fs-writeback.o quota.o
+               fs-writeback.o

 ifneq ($(CONFIG_NFSD),n)
 ifneq ($(CONFIG_NFSD),)
@@ -81,7 +81,7 @@

 obj-$(CONFIG_BINFMT_ELF)       += binfmt_elf.o

-obj-$(CONFIG_QUOTA) += dquot.o
+obj-$(CONFIG_QUOTA) += dquot.o quota.o
 obj-$(CONFIG_QFMT_V1) += quota_v1.o
 obj-$(CONFIG_QFMT_V2) += quota_v2.o

Regards.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
