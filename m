Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262362AbSI2BVm>; Sat, 28 Sep 2002 21:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262363AbSI2BVm>; Sat, 28 Sep 2002 21:21:42 -0400
Received: from h108-129-61.datawire.net ([207.61.129.108]:13776 "EHLO
	mail.datawire.net") by vger.kernel.org with ESMTP
	id <S262362AbSI2BVl> convert rfc822-to-8bit; Sat, 28 Sep 2002 21:21:41 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [PROBLEM] 2.5.39 - might_sleep() exception - ACPI/APIC, UML compile  issues on MP 2000+
Date: Sat, 28 Sep 2002 21:26:48 -0400
User-Agent: KMail/1.4.6
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@karaya.com>
References: <200209280428.23572.spstarr@sh0n.net> <3D956D06.D7370490@digeo.com>
In-Reply-To: <3D956D06.D7370490@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200209282126.48790.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't get that error anymore but UML won't compile:

Unless im doing something wrong this is how i've been building UML (in 2.4)

make menuconfig ARCH=um
make modules ARCH=um
make modules_install ARCH=um
make linux ARCH=um

Is this correct?

Shawn.

On September 28, 2002 04:49 am, Andrew Morton wrote:

> Shawn Starr wrote:
> > ...
> > 3) Compile errors with UML:
> >
> > In file included from sched.c:19:
> > /usr/src/linux-2.5.39/include/linux/mm.h:165: parse error before
> > "pte_addr_t" /usr/src/linux-2.5.39/include/linux/mm.h:165: warning: no
> > semicolon at end of struct or union
> > /usr/src/linux-2.5.39/include/linux/mm.h:165: warning: no semicolon at
> > end of struct or union /usr/src/linux-2.5.39/include/linux/mm.h:166:
> > warning: type defaults to `int' in declaration of `pte'
>
> It's strange that this ever worked.  Does this fix?
>
> --- linux-2.5.39/include/asm-um/pgtable.h	Sun Sep 15 20:53:43 2002
> +++ 25/include/asm-um/pgtable.h	Sat Sep 28 01:47:43 2002
> @@ -215,6 +215,8 @@ static inline void set_pte(pte_t *pteptr
>  	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
>  }
>
> +typedef pte_t *pte_addr_t;
> +
>  /*
>   * (pmds are folded into pgds so this doesnt get actually called,
>   * but the define is needed for a generic inline function.)

