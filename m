Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSEVXam>; Wed, 22 May 2002 19:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSEVXal>; Wed, 22 May 2002 19:30:41 -0400
Received: from rj.SGI.COM ([192.82.208.96]:38286 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S312938AbSEVXaj>;
	Wed, 22 May 2002 19:30:39 -0400
Date: Thu, 23 May 2002 09:30:10 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jan Kara <jack@suse.cz.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Quota patches
Message-ID: <20020523093009.T180298@wobbly.melbourne.sgi.com>
In-Reply-To: <20020520135530.GB9209@atrey.karlin.mff.cuni.cz> <87bsb86k4r.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi there,

On Thu, May 23, 2002 at 04:46:28AM +0900, OGAWA Hirofumi wrote:
> What do you think of the following patches for kernel without
> quota support? We already have weak symbol for sys_quotactl(). 
> 
> --- linux-bk/fs/Makefile        Wed May 22 01:17:48 2002
> +++ linux-2.5.17/fs/Makefile    Thu May 23 03:23:30 2002
> @@ -15,7 +15,7 @@
>                 namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
>                 dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
>                 filesystems.o namespace.o seq_file.o xattr.o libfs.o \
> -               fs-writeback.o quota.o
> +               fs-writeback.o
> 
>  ifneq ($(CONFIG_NFSD),n)
>  ifneq ($(CONFIG_NFSD),)
> @@ -81,7 +81,7 @@
> 
>  obj-$(CONFIG_BINFMT_ELF)       += binfmt_elf.o
> 
> -obj-$(CONFIG_QUOTA) += dquot.o
> +obj-$(CONFIG_QUOTA) += dquot.o quota.o
>  obj-$(CONFIG_QFMT_V1) += quota_v1.o
>  obj-$(CONFIG_QFMT_V2) += quota_v2.o
> 

On Wed, May 22, 2002 at 09:57:00PM +0200, Jan Kara wrote:
>   I know this but this file is also needed by XFS people so it isn't
> so easy.  But as XFS stuff is not currently in kernel the change is


A change to the patch like this would make this work for us too:

replacing:
-obj-$(CONFIG_QUOTA) += dquot.o
+obj-$(CONFIG_QUOTA) += dquot.o quota.o

with just:
+obj-$(CONFIG_QUOTACTL) += quota.o


Needs to be fleshed out a little bit, of course - both CONFIG_QUOTA
and CONFIG_XFS_QUOTA (from the XFS patches) would need fs/Config.in
changes to add the new $CONFIG_QUOTACTL dependency, but that should
just about do the trick I think.

cheers.

-- 
Nathan
