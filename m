Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbRGFXKw>; Fri, 6 Jul 2001 19:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266889AbRGFXKn>; Fri, 6 Jul 2001 19:10:43 -0400
Received: from juicer03.bigpond.com ([139.134.6.79]:4338 "EHLO
	mailin6.bigpond.com") by vger.kernel.org with ESMTP
	id <S266888AbRGFXK1>; Fri, 6 Jul 2001 19:10:27 -0400
Message-Id: <m15ISwa-000CGGC@localhost>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: kaos@ocs.com.au, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: modules and 2.5 
In-Reply-To: Your message of "Tue, 03 Jul 2001 01:13:45 -0400."
             <3B415489.77425364@mandrakesoft.com> 
Date: Fri, 06 Jul 2001 20:34:40 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3B415489.77425364@mandrakesoft.com> you write:
> A couple things that would be nice for 2.5 is
> - let MOD_INC_USE_COUNT work even when module is built into kernel, and
> - let THIS_MODULE exist and be valid even when module is built into
> kernel

Hi Jeff,

What use are module use counts, if not used to prevent unloading?

> The reasoning behind this is that module use counts are useful sometimes
> even when the driver is built into the kernel.  Other facilities like
> inter_xxx are [obviously] useful when built into the kernel, so it makes

Let's be clear: inter_module_xxx is Broken as Designed.  It's a
terrible interface that has the added merit of being badly
implemented.

If you have a module B which has a soft dependency ("must use if
there") on module A, inter_xxx doesn't help without opening a can of
worms (if module B inserted after module A, oops).

The best ways out of this are:
1) Create two versions of module B: an A+B one, and a B-alone one.
2) Place infrastructure in the core kernel.
   (This is what I did for ipt_REJECT needing to know about NAT).

Also, I far prefer the simplicity of get_symbol and put_symbol.

Cheers,
Rusty.
--
Premature optmztion is rt of all evl. --DK
