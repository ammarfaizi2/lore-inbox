Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbRGSRW2>; Thu, 19 Jul 2001 13:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265443AbRGSRWJ>; Thu, 19 Jul 2001 13:22:09 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:34062 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S265402AbRGSRWH>;
	Thu, 19 Jul 2001 13:22:07 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Russell King <rmk@arm.linux.org.uk>
Date: Thu, 19 Jul 2001 19:21:48 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: bitops.h ifdef __KERNEL__ cleanup.
CC: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
X-mailer: Pegasus Mail v3.40
Message-ID: <917E9842025@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 19 Jul 01 at 12:48, Russell King wrote:
> 
> I totally disagree here.  We already say "user space should not include
> kernel headers".  Why should bitops.h be any different?  Why should atomic.h
> be any different?  They contain architecture specific code, yes, which
> may not work in user space.

Maybe because of I do not know ARM assembler? If you do not want
kernel headers to be used in apps, just move them from asm and linux
into msa and xunil. Then you can simple remove all #ifdef __KERNEL__
from them...

> Oh, and thanks for pointing out ncpfs breaks - I hope the authors will
> fix up their sloppy coding before Davids patch makes it into the kernel.

It will still work. Only resulting binary will be slower. That's what
autoconf is for. If ncpfs does not compile for you, better to contact
me directly, as I'm ncpfs maintainer...
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
P.S.: Part of ncpfs's configure.ac. I do not think that it is that
hard...

  AC_CACHE_CHECK(for working asm/atomic.h,
      ncp_cv_asm_atomic_h,
    AC_TRY_LINK([#define __SMP__
#include <asm/atomic.h>],
      [atomic_t a;
       atomic_set(&a,2);
       atomic_dec(&a);
       if (atomic_read(&a)) {
         if (!atomic_dec_and_test(&a)) {
       atomic_inc(&a);
     }
       }],
      [ncp_cv_asm_atomic_h="yes"],
      [ncp_cv_asm_atomic_h="no"]
    )
  )
  if test "$ncp_cv_asm_atomic_h" = "yes"
  then
    AC_DEFINE(HAVE_ASM_ATOMIC_H, 1, [Define if we have working asm/atomic.h])
  fi
