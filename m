Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbTEAR0v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 13:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTEAR0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 13:26:51 -0400
Received: from smtp.inet.fi ([192.89.123.192]:38342 "EHLO smtp.inet.fi")
	by vger.kernel.org with ESMTP id S261489AbTEAR0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 13:26:50 -0400
From: Kimmo Sundqvist <rabbit80@mbnet.fi>
Organization: Unorganized
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-mm3 and a simple mistake
Date: Thu, 1 May 2003 20:38:45 +0300
User-Agent: KMail/1.5.1
References: <200305011826.31389.rabbit80@mbnet.fi.suse.lists.linux.kernel> <p734r4e3ca6.fsf@oldwotan.suse.de>
In-Reply-To: <p734r4e3ca6.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305012038.45157.rabbit80@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 May 2003 18:41, Andi Kleen wrote:

> Kimmo Sundqvist <rabbit80@mbnet.fi> writes:

> > /usr/bin/make -f scripts/Makefile.clean obj=arch/i386/mach-default
> > /usr/bin/make -f scripts/Makefile.clean obj=arch/i386/mach-generic
> > scripts/Makefile.clean:10: arch/i386/mach-generic/Makefile: No such file
> > or directory
> > make[2]: *** No rule to make target `arch/i386/mach-generic/Makefile'. 
> > Stop. make[1]: *** [_clean_arch/i386/mach-generic] Error 2
> > make[1]: Leaving directory `/usr/src/linux-2.5.68'
> > make: *** [stamp-kernel-configure] Error 2

> Most likely you need to apply this patch. 

This is funny.  Patching with "patch -p0 < 2.5.68-mm3" caused all the patched 
files to appear in /usr/src/25  They also disappeared from 
/usr/src/linux-2.5.68

I did "cp -a /usr/src/25/* /usr/src/linux-2.5.68/" and there was no error at 
first, but the compile failed with:

gcc -Wp,-MD,net/core/.netfilter.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default 
-fomit-frame-pointer -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=netfilter -DKBUILD_MODNAME=netfilter -c -o 
net/core/netfilter.o net/core/netfilter.c
net/core/netfilter.c: In function `nf_reinject':
net/core/netfilter.c:559: `i' undeclared (first use in this function)
net/core/netfilter.c:559: (Each undeclared identifier is reported only once
net/core/netfilter.c:559: for each function it appears in.)
net/core/netfilter.c:559: warning: left-hand operand of comma expression has 
no effect
net/core/netfilter.c:559: warning: left-hand operand of comma expression has 
no effect
make[3]: *** [net/core/netfilter.o] Error 1
make[2]: *** [net/core] Error 2
make[1]: *** [net] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.68'
make: *** [stamp-build] Error 2

Still I can't understand what is the intended way of doing this.  I will try 
n+1 ways and stop to think now and then, but if someone has an easy way to do 
this, I haven't seen it.

-Kimmo S.
