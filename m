Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317456AbSF1PYN>; Fri, 28 Jun 2002 11:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSF1PYM>; Fri, 28 Jun 2002 11:24:12 -0400
Received: from tstac.esa.lanl.gov ([128.165.46.3]:33515 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S317456AbSF1PYK>; Fri, 28 Jun 2002 11:24:10 -0400
Subject: Re: [PATCH] compile fix for 2.5 kdev_t compatibility macros
From: Steven Cole <elenstev@mesatop.com>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Stephen Lord <lord@sgi.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1025277008.1643.6.camel@tux>
References: <1025272233.1168.21.camel@n236> 
	<1025275076.27133.131.camel@spc9.esa.lanl.gov> 
	<1025277008.1643.6.camel@tux>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 28 Jun 2002 09:24:18 -0600
Message-Id: <1025277858.11726.136.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-06-28 at 09:10, Martin Josefsson wrote:
[snip]
> 
> And here's one more...
> 
> --- linux-2.4.19-rc1/include/linux/kdev_t.h.orig	Fri Jun 28 16:59:48 2002
> +++ linux-2.4.19-rc1/include/linux/kdev_t.h	Fri Jun 28 17:01:12 2002
> @@ -82,7 +82,7 @@
>  #define kdev_same(a,b)	((a) == (b))
>  #define kdev_none(d)	(!(d))
>  #define kdev_val(d)	((unsigned int)(d))
> -#define val_to_kdev(d)	((kdev_t(d))
> +#define val_to_kdev(d)	(kdev_t(d))
>  
>  /*
>  As long as device numbers in the outside world have 16 bits only,
> 
> -- 
> /Martin
> 

Hmm.  It looks like (d) should be cast to (kdev_t).
Here are both fixes (I hope).

Steven

--- linux-2.4.19-rc1/include/linux/kdev_t.h.orig	Fri Jun 28 08:31:27 2002
+++ linux-2.4.19-rc1/include/linux/kdev_t.h	Fri Jun 28 09:11:39 2002
@@ -81,8 +81,8 @@
 #define minor(d)	MINOR(d)
 #define kdev_same(a,b)	((a) == (b))
 #define kdev_none(d)	(!(d))
-#define kdev_val(d)	((unsigned int)(d)
-#define val_to_kdev(d)	((kdev_t(d))
+#define kdev_val(d)	((unsigned int)(d))
+#define val_to_kdev(d)	((kdev_t)(d))
 
 /*
 As long as device numbers in the outside world have 16 bits only,


