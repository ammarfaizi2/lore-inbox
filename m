Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbSKMAEv>; Tue, 12 Nov 2002 19:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267045AbSKMAEv>; Tue, 12 Nov 2002 19:04:51 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:25053 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S267039AbSKMAEu>;
	Tue, 12 Nov 2002 19:04:50 -0500
Date: Wed, 13 Nov 2002 01:10:59 +0100
From: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is ugly
Message-ID: <20021113001059.GA31147@werewolf.able.es>
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua> <200211031322.gA3DMTp28125@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200211031322.gA3DMTp28125@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Sun, Nov 03, 2002 at 19:14:26 +0100
X-Mailer: Balsa 2.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(sorry to answer to not-final-version mail, but didn't keep the last one.
This also applies, anyway...)

On 2002.11.03 Denis Vlasenko wrote:
> On 3 November 2002 14:17, Denis Vlasenko wrote:
> > It seems gcc started to de-inline large functions.
[...]

> diff -urN linux-2.5.45.orig/include/linux/compiler.h linux-2.5.45fix/include/linux/compiler.h
> --- linux-2.5.45.orig/include/linux/compiler.h	Wed Oct 30 22:43:05 2002
> +++ linux-2.5.45fix/include/linux/compiler.h	Sun Nov  3 15:19:20 2002
> @@ -20,3 +20,11 @@
>      __asm__ ("" : "=g"(__ptr) : "0"(ptr));		\
>      (typeof(ptr)) (__ptr + (off)); })
>  #endif /* __LINUX_COMPILER_H */
> +
> +/* GCC 3 (and probably earlier, I'm not sure) can be told to always inline
> +   a function. */
> +#if __GNUC__ < 3
> +#define force_inline inline
> +#else
> +#define force_inline inline __attribute__ ((always_inline))
> +#endif

This should go before the #endif /* __LINUX_COMPILER_H */, isn't it ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-rc1-jam2 (gcc 3.2 (Mandrake Linux 9.1 3.2-3mdk))
