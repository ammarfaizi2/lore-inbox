Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030830AbWI0U4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030830AbWI0U4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030832AbWI0U4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:56:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:37353 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030830AbWI0U4t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:56:49 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Wed, 27 Sep 2006 22:57:02 +0200
User-Agent: KMail/1.9.1
Cc: luke Yang <luke.adi@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <6.1.1.1.0.20060927121508.01ecea90@ptg1.spd.analog.com> <6.1.1.1.0.20060927130329.01ece2a0@ptg1.spd.analog.com>
In-Reply-To: <6.1.1.1.0.20060927130329.01ece2a0@ptg1.spd.analog.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609272257.02385.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wednesday 27 September 2006 19:19 schrieb Robin Getz:
> OK - I was just doing the similar thing to what already exists in
> ./asm-blackfin/system.h
>
> #define local_irq_enable() do {         \
>          __asm__ __volatile__ (          \
>                  "sti %0;"               \
>                  ::"d"(irq_flags));      \
> } while (0)
>
> which could be simplified to:
>
> #define local_irq_enable() __asm__ __volatile__ ("sti %0;"  ::"d"(irq_flags));

Actually, this one is slightly broken, because of the ';' at the end of the
macro (think of "if(x) local_irq_enable(); else somthing_else()").

What I was suggesting is to make a proper inline function, like

static inline void local_irq_enable(void)
{
	unsigned long unused_flags;
	asm volatile ("sti %0;" : : "d" (unused_flags));
}

That completely avoids all the problems you might hit with macro expansion,
while still compiling to the same code.

	Arnd <><
