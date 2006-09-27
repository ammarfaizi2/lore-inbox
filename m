Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030882AbWI0VgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030882AbWI0VgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030891AbWI0VgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:36:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:59367 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030882AbWI0VgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:36:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Wed, 27 Sep 2006 23:36:24 +0200
User-Agent: KMail/1.9.1
Cc: luke Yang <luke.adi@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <6.1.1.1.0.20060927170244.01ed18d0@ptg1.spd.analog.com>
In-Reply-To: <6.1.1.1.0.20060927170244.01ed18d0@ptg1.spd.analog.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609272336.25007.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wednesday 27 September 2006 23:22 schrieb Robin Getz:
> Systems that use static inline:
> ./asm-m32r/system.h:static inline void local_irq_enable(void)
> ./asm-sh64/system.h:static __inline__ void local_irq_enable(void)
> ./asm-sh/system.h:static __inline__ void local_irq_enable(void)
> ./asm-xtensa/system.h:static inline void local_irq_enable(void)
>
> With the "optimizations" that gcc4 is making with inline being only a
> "suggestion", I think I would prefer to stick with the macro, unless there
> is violent opposition.

Note that the architectures that do the macro are the ones that
were there first, while the four above are relatively new. They may
well have gotten the same comment ;-)

For a single statement, it doesn't really matter much
whether you're using a macro or an inline function, but the longer
the macro gets, the more reason there is to change it.

In particular, new gcc versions actually do a pretty good job
at deciding when to use an out-of-line function and it may make
your code better if you let it.

> As Mike pointed out - we are sheep - we just do what the majority (18/22)
> of other people do.

Not a bad strategy in general. An even better strategy is to do
what the better architecture implementations in linux do and
to apply common sense. "better" of course is rather subjective,
but I typically recommend looking at arch/parisc as a good example.

	Arnd <><
