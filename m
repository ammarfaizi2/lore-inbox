Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271390AbTG2KmV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 06:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271393AbTG2KmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 06:42:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27074 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271390AbTG2KmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 06:42:15 -0400
Date: Tue, 29 Jul 2003 12:42:10 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: jcwren@jcwren.com, linux-kernel@vger.kernel.org
Subject: Re: Assorted 2.6.0-test2 build warnings
Message-ID: <20030729104209.GL28767@fs.tum.de>
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com> <20030727165831.05904792.davem@redhat.com> <200307280211590888.10957DD9@192.168.128.16> <200307272057.31859.jcwren@jcwren.com> <20030728151104.300ae225.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728151104.300ae225.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 03:11:04PM -0700, Randy.Dunlap wrote:
> On Sun, 27 Jul 2003 20:57:31 -0400 "J.C. Wren" <jcwren@jcwren.com> wrote:
> 
> | Assorted warnings building 2.6.0-test2, on an Athlon:
> | 
> |   CC      fs/ntfs/super.o
> | fs/ntfs/super.c: In function `is_boot_sector_ntfs':
> | fs/ntfs/super.c:375: warning: integer constant is too large for "long" type
> 
> Please see if the patch below fixes this one.
>...
> ~Randy
> 
> 
> patch_name:	ntfs_ulong.patch
> patch_version:	2003-07-28.14:29:57
> author:		Randy.Dunlap <rddunlap@osdl.org>
> description:	make a constant be UL;
> product:	Linux
> product_versions: 2.6.0-test2
> maintainer:	Anton Altaparmakov <aia21@cantab.net>
> diffstat:	=
>  fs/ntfs/layout.h |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff -Naurp ./fs/ntfs/layout.h~type ./fs/ntfs/layout.h
> --- ./fs/ntfs/layout.h~type	2003-07-27 10:02:48.000000000 -0700
> +++ ./fs/ntfs/layout.h	2003-07-28 14:05:20.000000000 -0700
> @@ -43,7 +43,7 @@
>  #define const_cpu_to_le64(x)	__constant_cpu_to_le64(x)
>  
>  /* The NTFS oem_id */
> -#define magicNTFS	const_cpu_to_le64(0x202020205346544e) /* "NTFS    " */
> +#define magicNTFS	const_cpu_to_le64(0x202020205346544eUL) /* "NTFS    " */
>...

s/UL/ULL/ (your patch fixed only 64 bit architectures)

The fix is already in Rusty's trivial patch.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

