Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbSK0BZg>; Tue, 26 Nov 2002 20:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSK0BZf>; Tue, 26 Nov 2002 20:25:35 -0500
Received: from fmr05.intel.com ([134.134.136.6]:26108 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S263321AbSK0BZe> convert rfc822-to-8bit; Tue, 26 Nov 2002 20:25:34 -0500
Message-ID: <957BD1C2BF3CD411B6C500A0C944CA2601F11699@pdsmsx32.pd.intel.com>
From: "Wang, Stanley" <stanley.wang@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'rusty@rustcorp.com.au'" <rusty@rustcorp.com.au>,
       "Zhuang, Louis" <louis.zhuang@intel.com>
Subject: RE: [BUG] [2.5.49] symbol_get doesn't work
Date: Wed, 27 Nov 2002 09:30:43 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, my last patch would cause an incompatible type warning. The following
patch could do better.

diff -Naur -X dontdiff linux-2.5.49/include/linux/module.h
linux-2.5.49-bugfix/include/linux/module.h
--- linux-2.5.49/include/linux/module.h	2002-11-27 09:23:39.000000000 +0800
+++ linux-2.5.49-bugfix/include/linux/module.h	2002-11-27
09:23:54.000000000 +0800
@@ -86,7 +86,7 @@
 /* Get/put a kernel symbol (calls must be symmetric) */
 void *__symbol_get(const char *symbol);
 void *__symbol_get_gpl(const char *symbol);
-#define symbol_get(x) ((typeof(&x))(__symbol_get(#x)))
+#define symbol_get(t,x) ((typeof(t))(__symbol_get(#x)))
 
 /* For every exported symbol, place a struct in the __ksymtab section */
 #define EXPORT_SYMBOL(sym)				\



Thanks,
Stanley

> -----Original Message-----
> From: Wang, Stanley 
> Sent: 2002Äê11ÔÂ26ÈÕ 16:14
> To: 'linux-kernel@vger.kernel.org'
> Cc: 'rusty@rustcorp.com.au'
> Subject: [BUG] [2.5.49] symbol_get doesn't work
> 
> 
> Hello,
> I found the symbol_get()/symbol_put() didn't work on my 2.5.49 build.
> I think the root cause is a wrong macro definition. The 
> following patch could 
> fix this bug.
> 
> diff -Naur -X dontdiff linux-2.5.49/include/linux/module.h 
> linux-2.5.49-bugfix/include/linux/module.h
> --- linux-2.5.49/include/linux/module.h	2002-11-26 
> 16:06:36.000000000 +0800
> +++ linux-2.5.49-bugfix/include/linux/module.h	
> 2002-11-26 16:01:52.000000000 +0800
> @@ -86,7 +86,7 @@
>  /* Get/put a kernel symbol (calls must be symmetric) */
>  void *__symbol_get(const char *symbol);
>  void *__symbol_get_gpl(const char *symbol);
> -#define symbol_get(x) ((typeof(&x))(__symbol_get(#x)))
> +#define symbol_get(x) ((typeof(&x))(__symbol_get(x)))
>  
>  /* For every exported symbol, place a struct in the 
> __ksymtab section */
>  #define EXPORT_SYMBOL(sym)				\
> @@ -166,7 +166,7 @@
>  #ifdef CONFIG_MODULE_UNLOAD
>  
>  void __symbol_put(const char *symbol);
> -#define symbol_put(x) __symbol_put(#x)
> +#define symbol_put(x) __symbol_put(x)
>  void symbol_put_addr(void *addr);
>  
>  /* We only need protection against local interrupts. */
> 
> 
> Your Sincerely,
> Stanley Wang 
> 
> SW Engineer, Intel Corporation.
> Intel China Software Lab. 
> Tel: 021-52574545 ext. 1171 
> iNet: 8-752-1171 
>  
> Opinions expressed are those of the author and do not 
> represent Intel Corporation
> 
