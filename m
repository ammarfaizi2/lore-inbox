Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262671AbSJBXom>; Wed, 2 Oct 2002 19:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262678AbSJBXom>; Wed, 2 Oct 2002 19:44:42 -0400
Received: from mail-4.tiscali.it ([195.130.225.150]:39401 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S262671AbSJBXom>;
	Wed, 2 Oct 2002 19:44:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Alessandro Amici <alexamici@tiscali.it>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: 2.5.37+ i386 arch split broke external module builds
Date: Thu, 3 Oct 2002 01:49:37 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200210022209.g92M9kh02253@localhost.localdomain>
In-Reply-To: <200210022209.g92M9kh02253@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021002234937.57C711EA78@alan.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 October 2002 00:09, James Bottomley wrote:
> alexamici@tiscali.it said:
> > comments are welcome,
>
> -#include "irq_vectors.h"
> +#ifdef CONFIG_VISWS
> +#include <asm/mach-visws/irq_vectors.h>
> +#else
> +#include <asm/mach-generic/irq_vectors.h>
> +#endif
>
> I'm afraid the whole purpose of the code was to get away from this type of
> #ifdef problem.  If you do this, every new mach-type added to i386 has to
> modify a bunch of kernel headers.

as i said, that was just a rough example, it is possible to do it in a much 
cleaner way. if we can agree on this being important enough i can prepare a 
nicer patch myself.

> dwmw2@infradead.org said:
> >  make -C /lib/modules/`uname -r`/build SUBDIRS=`pwd` modules
>
> This looks like a clean solution to me, since most kernel packages install
> this module build directory.

i do agree with you and dwmw2. that one is The Right Way.

my problem is: current distributions (i know debian for sure, and suse from 
second hand experiance) are not prepared. if 2.6-3.0 will be released as it 
is _now_ and if distribution don't change policy, we will have no other 
choice than ask the users to compile and run a castom kernel, in order to use 
our driver. which means: cutting our future user base to a third (i'm 
optimistic :).

in this particular case i think a clean-enough workaround can be found, so 
i'd like to see it going in. if people agree on the general principle that 
external modules are better off using the kernel build system, thats fine 
with me. but then we need a clear statement on _what exactly_ is required for 
external module building, and distributions need to start follwing such an 
advise.

alessandro

