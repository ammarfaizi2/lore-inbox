Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbTDROTQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 10:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263051AbTDROTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 10:19:16 -0400
Received: from pool-141-154-201-162.bos.east.verizon.net ([141.154.201.162]:48257
	"EHLO lhotse") by vger.kernel.org with ESMTP id S263050AbTDROTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 10:19:14 -0400
From: Seth Chandler <sethbc@gentoo.org>
Reply-To: sethbc@gentoo.org
To: Andrew Morton <akpm@digeo.com>, Andrei Ivanov <andrei.ivanov@ines.ro>
Subject: Re: 2.5.67-mm4
Date: Fri, 18 Apr 2003 10:31:09 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Christoph Hellwig <hch@lst.de>
References: <20030418014536.79d16076.akpm@digeo.com> <Pine.LNX.4.50L0.0304181216180.1931-200000@webdev.ines.ro> <20030418022606.56357df4.akpm@digeo.com>
In-Reply-To: <20030418022606.56357df4.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304181031.09836.sethbc@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'd like to note this was a problem when i was building a bk pull last 
night...

seth

On Friday 18 April 2003 05:26, Andrew Morton wrote:
> Andrei Ivanov <andrei.ivanov@ines.ro> wrote:
> > :(
> >
> > make -f scripts/Makefile.build obj=fs/devfs
> >   gcc -Wp,-MD,fs/devfs/.base.o.d -D__KERNEL__ -Iinclude -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -pipe -mpreferred-stack-boundary=2 -march=athlon
> > -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
> > -DKBUILD_BASENAME=base -DKBUILD_MODNAME=devfs -c -o fs/devfs/base.o
> > fs/devfs/base.c
> > fs/devfs/base.c: In function `devfsd_notify':
> > fs/devfs/base.c:1426: too many arguments to function `devfsd_notify_de'
> > fs/devfs/base.c: In function `devfs_register':
> > fs/devfs/base.c:1460: warning: too few arguments for format
> > make[2]: *** [fs/devfs/base.o] Error 1
> > make[1]: *** [fs/devfs] Error 2
> > make: *** [fs] Error 2
>
> Like this I guess.
>
>
> diff -puN fs/devfs/base.c~devfs-build-fix fs/devfs/base.c
> --- 25/fs/devfs/base.c~devfs-build-fix	2003-04-18 02:21:47.000000000 -0700
> +++ 25-akpm/fs/devfs/base.c	2003-04-18 02:22:11.000000000 -0700
> @@ -1423,7 +1423,7 @@ static int devfsd_notify_de (struct devf
>  static void devfsd_notify (struct devfs_entry *de,unsigned short type)
>  {
>  	devfsd_notify_de(de, type, de->mode, current->euid,
> -			 current->egid, &fs_info, 0);
> +			 current->egid, &fs_info);
>  }
>
>
> @@ -1457,7 +1457,8 @@ devfs_handle_t devfs_register (devfs_han
>      struct devfs_entry *de;
>
>      if (flags)
> -	printk(KERN_ERR "%s called with flags != 0, please fix!\n");
> +	printk(KERN_ERR "%s called with flags != 0, please fix!\n",
> +			__FUNCTION__);
>
>      if (name == NULL)
>      {
>
> _
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
