Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267858AbTAMF0f>; Mon, 13 Jan 2003 00:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267980AbTAMFZp>; Mon, 13 Jan 2003 00:25:45 -0500
Received: from zok.SGI.COM ([204.94.215.101]:35815 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S267961AbTAMFZZ>;
	Mon, 13 Jan 2003 00:25:25 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Check compiler version, SMP and PREEMPT. 
In-reply-to: Your message of "Mon, 13 Jan 2003 16:13:19 +1100."
             <20030113051434.DC2092C09F@lists.samba.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Jan 2003 16:33:45 +1100
Message-ID: <5803.1042436025@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003 16:13:19 +1100, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>Linus, please apply if you agree.
>
>Tridge reported getting burned by gcc 3.2 compiled (Debian) XFree
>modules not working on his gcc 2.95-compiled kernel.  Interestingly,
>(as Tridge points out) modversions probably would not have caught the
>change in spinlock size, since the ioctl takes a void*, not a
>structure pointer...
>
>Simple bitmask, allows extension later, and prevents this kind of
>thing (maybe a warning is more appropriate: this refuses to load it).

Worse than that.  There is a long list of critical config options which
should :-

(a) Force a complete rebuild if any are changed and
(b) Refuse to load a module with different critical config options.

To make things more complicated, that list is arch dependent.

>From kbuild 2.5 (which handled this problem months ago)

define_string CONFIG_KBUILD_CRITICAL "CONFIG_SMP CONFIG_KBUILD_GCC_VERSION"
define_string CONFIG_KBUILD_CRITICAL_ARCH_X86 "CONFIG_M386 CONFIG_M486 \
       CONFIG_M586 CONFIG_M586TSC CONFIG_M586MMX CONFIG_M686 \
       CONFIG_MPENTIUMIII CONFIG_MPENTIUM4 \
       CONFIG_MK6 CONFIG_MK7 \
       CONFIG_MCRUSOE \
       CONFIG_MWINCHIPC6 CONFIG_MWINCHIP2 CONFIG_MWINCHIP3D \
       CONFIG_MCYRIXIII"

