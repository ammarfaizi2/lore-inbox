Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVA3LjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVA3LjF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 06:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVA3LjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 06:39:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32264 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261681AbVA3Liq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 06:38:46 -0500
Date: Sun, 30 Jan 2005 12:38:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Blazejowski <diffie@gmail.com>, linux-kernel@vger.kernel.org,
       Nathan Scott <nathans@sgi.com>
Subject: Re: 2.6.11-rc2-mm2
Message-ID: <20050130113842.GE3185@stusta.de>
References: <9dda349205012923347bc6a456@mail.gmail.com> <20050129235653.1d9ba5a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129235653.1d9ba5a9.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 11:56:53PM -0800, Andrew Morton wrote:
> Paul Blazejowski <diffie@gmail.com> wrote:
> >
> > Kernel compile errors here, i think this might be XFS related...
> > 
> >  fs/built-in.o(.text+0x52a93): In function `linvfs_decode_fh':
> >  : undefined reference to `find_exported_dentry'
> >  make: *** [.tmp_vmlinux1] Error 1
> 
> bix:/home/akpm> grep EXPORT x
> CONFIG_XFS_EXPORT=y
> CONFIG_EXPORTFS=m
> 
> That isn't going to work.  Something like this, perhaps?
> 
> --- 25/fs/xfs/Kconfig~a	2005-01-29 23:55:53.643674392 -0800
> +++ 25-akpm/fs/xfs/Kconfig	2005-01-29 23:56:26.435689248 -0800
> @@ -22,7 +22,8 @@ config XFS_FS
>  
>  config XFS_EXPORT
>  	bool
> -	default y if XFS_FS && EXPORTFS
> +	depends on XFS_FS
> +	select EXPORTFS
>...

Since nothing selects XFS_EXPORT, XFS_EXPORT will _never_ be enabled 
with this patch.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

