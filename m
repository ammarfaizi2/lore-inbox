Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265143AbSK1EER>; Wed, 27 Nov 2002 23:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265154AbSK1EER>; Wed, 27 Nov 2002 23:04:17 -0500
Received: from dp.samba.org ([66.70.73.150]:1240 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265143AbSK1EEP>;
	Wed, 27 Nov 2002 23:04:15 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Wang, Stanley" <stanley.wang@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Zhuang, Louis" <louis.zhuang@intel.com>
Subject: Re: [BUG] [2.5.49] symbol_get doesn't work 
In-reply-to: Your message of "Wed, 27 Nov 2002 09:30:43 +0800."
             <957BD1C2BF3CD411B6C500A0C944CA2601F11699@pdsmsx32.pd.intel.com> 
Date: Thu, 28 Nov 2002 14:01:23 +1100
Message-Id: <20021128041136.55AB22C2C6@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <957BD1C2BF3CD411B6C500A0C944CA2601F11699@pdsmsx32.pd.intel.com> you
 write:
> Sorry, my last patch would cause an incompatible type warning. The =
> following
> patch could do better.
> 
> diff -Naur -X dontdiff linux-2.5.49/include/linux/module.h
> linux-2.5.49-bugfix/include/linux/module.h
> --- linux-2.5.49/include/linux/module.h	2002-11-27 09:23:39.000000000 =
> +0800
> +++ linux-2.5.49-bugfix/include/linux/module.h	2002-11-27
> 09:23:54.000000000 +0800
> @@ -86,7 +86,7 @@
>  /* Get/put a kernel symbol (calls must be symmetric) */
>  void *__symbol_get(const char *symbol);
>  void *__symbol_get_gpl(const char *symbol);
> -#define symbol_get(x) ((typeof(&x))(__symbol_get(#x)))
> +#define symbol_get(t,x) ((typeof(t))(__symbol_get(#x)))
> =20
>  /* For every exported symbol, place a struct in the __ksymtab section =
> */
>  #define EXPORT_SYMBOL(sym)				\

Hmm, I still don't think you are using it correctly.  You have to know
the type of the object you are grabbing, right?  Then you might as
well give it a declaration, no?  Preferably in a header somewhere.

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
