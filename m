Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030465AbWI0RTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbWI0RTp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 13:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbWI0RTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 13:19:45 -0400
Received: from nwd2mail10.analog.com ([137.71.25.55]:9282 "EHLO
	nwd2mail10.analog.com") by vger.kernel.org with ESMTP
	id S1030465AbWI0RTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 13:19:44 -0400
X-IronPort-AV: i="4.09,225,1157342400"; 
   d="scan'208"; a="12221277:sNHT21080815"
Message-Id: <6.1.1.1.0.20060927130329.01ece2a0@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Wed, 27 Sep 2006 13:19:59 -0400
To: arnd Bergmann <arnd@arndb.de>
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: luke Yang <luke.adi@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <6.1.1.1.0.20060927121508.01ecea90@ptg1.spd.analog.com>
References: <6.1.1.1.0.20060927121508.01ecea90@ptg1.spd.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd wrote:
>The irq_flags are not declared anywhere in the code you just posted,

Yeah - they are already defined, and used in other macros in system.h - 
which is why I put the macro there.

>It would also be better to convert macros like this one to inline 
>functions in general. The rule is: if you can use either a macro or an 
>inline function with the same effect, use an inline function.

OK - I was just doing the similar thing to what already exists in 
./asm-blackfin/system.h

#define local_irq_enable() do {         \
         __asm__ __volatile__ (          \
                 "sti %0;"               \
                 ::"d"(irq_flags));      \
} while (0)

which could be simplified to:

#define local_irq_enable() __asm__ __volatile__ ("sti %0;" ::"d"(irq_flags));

which is the same as what is in ./asm-i386/system.h - isn't it?

#define local_irq_disable()     __asm__ __volatile__("cli": : :"memory")
#define local_irq_enable()      __asm__ __volatile__("sti": : :"memory")

We can do it anyway that makes sense/improves readability - it all compiles 
to the same thing...

-Robin 
