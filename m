Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTHTWg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 18:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbTHTWg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 18:36:57 -0400
Received: from rivmkt61.wintek.com ([206.230.0.61]:45993 "EHLO dust")
	by vger.kernel.org with ESMTP id S262280AbTHTWgx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 18:36:53 -0400
Date: Wed, 20 Aug 2003 17:40:10 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Emilio =?ISO-8859-1?Q?Jes=FAs?= Gallego Arias 
	<egallego@telefonica.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Build Broken for 2.6.0-test3-bk8
In-Reply-To: <1061410952.568.8.camel@ellugar>
Message-ID: <Pine.LNX.4.56.0308201715150.4960@dust>
References: <1061410952.568.8.camel@ellugar>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003, Emilio [ISO-8859-1] Jesús Gallego Arias wrote:

> I got the same error, and applied this patch. Don't know if it's the way
> to go:
> 
> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or
> higher.
> # This patch includes the following deltas:
> #                  ChangeSet    1.1279  -> 1.1280
> #       arch/i386/kernel/setup.c        1.92    -> 1.93
> #       arch/i386/kernel/acpi/boot.c    1.27    -> 1.28
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 03/08/20      emilio@ellugar.(none)   1.1280
> # - Fix build error due a missing include.
> # --------------------------------------------
> #
> diff -Nru a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
> --- a/arch/i386/kernel/acpi/boot.c      Wed Aug 20 22:18:04 2003
> +++ b/arch/i386/kernel/acpi/boot.c      Wed Aug 20 22:18:04 2003
> @@ -34,6 +34,7 @@
>  #if defined (CONFIG_X86_LOCAL_APIC)
>  #include <mach_apic.h>
>  #include <mach_mpparse.h>
> +#include <asm/io_apic.h>
>  #endif
>   
>  #define PREFIX                 "ACPI: "
> diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
> --- a/arch/i386/kernel/setup.c  Wed Aug 20 22:18:04 2003
> +++ b/arch/i386/kernel/setup.c  Wed Aug 20 22:18:04 2003
> @@ -43,6 +43,7 @@
>  #include <asm/setup.h>
>  #include <asm/arch_hooks.h>
>  #include <asm/sections.h>
> +#include <asm/io_apic.h>
>  #include "setup_arch_pre.h"
>  #include "mach_resources.h"

I'd already tried this (see my second post to the other thread).  This
only works if you've got APIC enabled.  I don't feel like mucking around
in the library and moving the extern int skip_ioapic_setup out of the
proper ifdef (which is I think what's going on.  That variable gets
ifdef'd out without APIC enabled, I think).

-- 
Alex Goddard
agoddard at purdue.edu
