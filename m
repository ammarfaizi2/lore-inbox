Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263603AbTCUNXl>; Fri, 21 Mar 2003 08:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263606AbTCUNXl>; Fri, 21 Mar 2003 08:23:41 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:35013 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S263603AbTCUNXj>; Fri, 21 Mar 2003 08:23:39 -0500
Date: Fri, 21 Mar 2003 14:34:41 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Norbert Wolff <norbert_wolff@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Some Warning from gcc-3.4-cvs for 2.5.65
Message-ID: <20030321133441.GA6979@wohnheim.fh-wedel.de>
References: <20030321141512.25497721.norbert_wolff@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030321141512.25497721.norbert_wolff@t-online.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 March 2003 14:15:12 +0000, Norbert Wolff wrote:
> 
> Here are some Warning got when compiling Linux 2.6.65 (devfs not configured)
> with the latest gcc-3.4 CVS :
> 
> include/linux/devfs_fs_kernel.h: In function `devfs_remove':
> include/linux/devfs_fs_kernel.h:101: warning: varargs function cannot be
> 		inline
> 
> Possible Fix :
> 
> 	Replace inline-func with macro
> 
> --- devfs_fs_kernel.h.orig	2003-03-21 13:28:24.000000000 +0000
> +++ devfs_fs_kernel.h	2003-03-21 13:30:28.000000000 +0000
> @@ -97,9 +97,9 @@
>  {
>      return NULL;
>  }
> -static inline void devfs_remove(const char *fmt, ...)
> -{
> -}
> +
> +#define devfs_remove(x, ...) do { ; } while (0) 
> +
>  static inline int devfs_generate_path (devfs_handle_t de, char *path,
>  				       int buflen)
>  {
> 
> ---
> 
> include/linux/kallsyms.h: In function `__check_printsym_format':
> include/linux/kallsyms.h:38: warning: varargs function cannot be inline
> 
> > /* This macro allows us to keep printk typechecking */
> > static void __check_printsym_format(const char *fmt, ...)
> >__attribute__((format(printf,1,2)));
> > static inline void __check_printsym_format(const char *fmt, ...)
> > {
> > }
> 
> I think the inline-attribute should be simply removed to quiet this Warning.

Quiting a warning is not a good reason for patches. If the warning is
bogus, the compiler should get fixed, not the kernel.
In this case the compiler should, inlined or not, optimize the call to
an empty function into nothing and shut up.

Jörn

-- 
Good warriors cause others to come to them and do not go to others.
-- Sun Tzu
