Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbTILSvO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbTILStw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:49:52 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50370 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261811AbTILSsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:48:13 -0400
Date: Fri, 12 Sep 2003 20:48:01 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andi Kleen <ak@suse.de>
Cc: jgarzik@pobox.com, ebiederm@xmission.com, akpm@osdl.org,
       richard.brunner@amd.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030912184800.GL27368@fs.tum.de>
References: <20030910184414.7850be57.akpm@osdl.org> <20030911014716.GG3134@wotan.suse.de> <3F60837D.7000209@pobox.com> <20030911162634.64438c7d.ak@suse.de> <3F6087FC.7090508@pobox.com> <m1vfrxlxol.fsf@ebiederm.dsl.xmission.com> <20030912195606.24e73086.ak@suse.de> <3F62098F.9030300@pobox.com> <20030912182216.GK27368@fs.tum.de> <20030912202851.3529e7e7.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912202851.3529e7e7.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 08:28:51PM +0200, Andi Kleen wrote:
> On Fri, 12 Sep 2003 20:22:16 +0200
> Adrian Bunk <bunk@fs.tum.de> wrote:
> 
> 
> > 
> > But even CONFIG_X86_GENERIC doesn't do what you expect. A kernel 
> > compiled for Athlon wouldn't run on a Pentium 4 even with 
> > CONFIG_X86_GENERIC.
> 
> It does. Just try it.
> 
> > 
> > Quoting arch/i386/Kconfig in -test5:
> > 
> > <--  snip  -->
> > 
> > config X86_USE_3DNOW
> >         bool
> >         depends on MCYRIXIII || MK7
> >         default y
> 
> That's obsolete and could be removed. All 3dnow! code is dynamically patched depending on the CPUID.

Quoting e.g. arch/i386/lib/memcpy.c:

<--  snip  -->

void * memcpy(void * to, const void * from, size_t n)
{
#ifdef CONFIG_X86_USE_3DNOW
        return __memcpy3d(to, from, n);
#else
        return __memcpy(to, from, n);
#endif
}

<--  snip  -->

This is hardly dynamic.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

