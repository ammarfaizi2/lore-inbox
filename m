Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267121AbSKMHLm>; Wed, 13 Nov 2002 02:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267123AbSKMHLm>; Wed, 13 Nov 2002 02:11:42 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:13843 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267121AbSKMHLl>; Wed, 13 Nov 2002 02:11:41 -0500
Message-Id: <200211130713.gAD7DBp13069@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "J.A. Magall?n" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is ugly
Date: Wed, 13 Nov 2002 10:04:32 -0200
X-Mailer: KMail [version 1.3.2]
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua> <200211031322.gA3DMTp28125@Port.imtp.ilyichevsk.odessa.ua> <20021113001059.GA31147@werewolf.able.es>
In-Reply-To: <20021113001059.GA31147@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 November 2002 22:10, J.A. Magall?n wrote:
> (sorry to answer to not-final-version mail, but didn't keep the last
> one. This also applies, anyway...)
>
> On 2002.11.03 Denis Vlasenko wrote:
> > On 3 November 2002 14:17, Denis Vlasenko wrote:
> > > It seems gcc started to de-inline large functions.
>
> [...]
>
> > diff -urN linux-2.5.45.orig/include/linux/compiler.h
> > linux-2.5.45fix/include/linux/compiler.h ---
> > linux-2.5.45.orig/include/linux/compiler.h	Wed Oct 30 22:43:05 2002
> > +++ linux-2.5.45fix/include/linux/compiler.h	Sun Nov  3 15:19:20
> > 2002 @@ -20,3 +20,11 @@
> >      __asm__ ("" : "=g"(__ptr) : "0"(ptr));		\
> >      (typeof(ptr)) (__ptr + (off)); })
> >  #endif /* __LINUX_COMPILER_H */
> > +
> > +/* GCC 3 (and probably earlier, I'm not sure) can be told to
> > always inline +   a function. */
> > +#if __GNUC__ < 3
> > +#define force_inline inline
> > +#else
> > +#define force_inline inline __attribute__ ((always_inline))
> > +#endif
>
> This should go before the #endif /* __LINUX_COMPILER_H */, isn't it ?

Oh... You are right...
--
vda
