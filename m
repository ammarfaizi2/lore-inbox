Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267510AbTBLOyy>; Wed, 12 Feb 2003 09:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267540AbTBLOyy>; Wed, 12 Feb 2003 09:54:54 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10475 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267510AbTBLOyx>; Wed, 12 Feb 2003 09:54:53 -0500
Date: Wed, 12 Feb 2003 16:04:35 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Kleikamp <shaggy@austin.ibm.com>, Andrew Morton <akpm@digeo.com>
Cc: James Lamanna <james.lamanna@appliedminds.com>,
       "'Linus Torvalds'" <torvalds@transmeta.com>,
       jfs-discussion@www-124.southbury.usf.ibm.com,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH - 2.5.60] JFS no longer compiles with gcc 2.95
Message-ID: <20030212150435.GL17128@fs.tum.de>
References: <20030210204651.GE17128@fs.tum.de> <022f01c2d14d$71b46550$39140b0a@amthinking.net> <20030211072741.GF17128@fs.tum.de> <200302120852.36636.shaggy@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302120852.36636.shaggy@austin.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 08:52:36AM -0600, Dave Kleikamp wrote:
> I'm not sure what's causing the problem, but Andrew Morton send me this 
> patch which gets rid of the problem for him.  The fmt string that 
> jfs_err() is invoked with is sufficient to identify the location, so 
> __FILE__ and __LINE__ are not really needed anyway.
> 
> Linus, please apply.
> 
> Thanks,
> Shaggy
> 
> diff -puN fs/jfs/jfs_debug.h~jfs-build-fix fs/jfs/jfs_debug.h
> --- 25/fs/jfs/jfs_debug.h~jfs-build-fix	2003-02-12 02:20:40.000000000 
> -0800
> +++ 25-akpm/fs/jfs/jfs_debug.h	2003-02-12 02:20:46.000000000 -0800
> @@ -89,8 +89,7 @@ extern void dump_mem(char *label, void *
>  /* error event message: e.g., i/o error */
>  #define jfs_err(fmt, arg...) do {			\
>  	if (jfsloglevel >= JFS_LOGLEVEL_ERR)		\
> -		printk(KERN_ERR "%s:%d " fmt "\n",	\
> -		       __FILE__, __LINE__, ## arg);	\
> +		printk(KERN_ERR fmt "\n", ## arg);	\
>  } while (0)
>  
>  /*

Ah, then it's a well-known 2.95 parser bug (sorry for not looking better
at it when sending my initial report). The following alternative patch
is sufficient to fix the compilation with 2.95 (it's your choice which
of the two patches you prefer):

--- linux-2.5.60-full/fs/jfs/jfs_debug.h.old	2003-02-12 15:59:14.000000000 +0100
+++ linux-2.5.60-full/fs/jfs/jfs_debug.h	2003-02-12 15:59:35.000000000 +0100
@@ -90,7 +90,7 @@
 #define jfs_err(fmt, arg...) do {			\
 	if (jfsloglevel >= JFS_LOGLEVEL_ERR)		\
 		printk(KERN_ERR "%s:%d " fmt "\n",	\
-		       __FILE__, __LINE__, ## arg);	\
+		       __FILE__ , __LINE__ , ## arg);	\
 } while (0)
 
 /*



> David Kleikamp

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

