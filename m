Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTIEFhd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 01:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTIEFhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 01:37:33 -0400
Received: from nikam.ms.mff.cuni.cz ([195.113.18.106]:11920 "EHLO
	nikam.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262193AbTIEFhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 01:37:31 -0400
Date: Fri, 5 Sep 2003 07:37:30 +0200
From: Jan Hubicka <jh@suse.cz>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@osdl.org, akpm@osdl.org, rth@redhat.com,
       linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Use -fno-unit-at-a-time if gcc supports it
Message-ID: <20030905053730.GB24509@kam.mff.cuni.cz>
References: <20030905004710.GA31000@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905004710.GA31000@averell>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hallo,
> 
> gcc 3.4 current has switched to default -fno-unit-at-a-time mode for -O2. 
> The 3.3-Hammer branch compiler used in some distributions also does this.
> 
> Unfortunately the kernel doesn't compile with unit-at-a-time currently,
> it cannot tolerate the reordering of functions in relation to inline
> assembly.

How much work would be to fix kernel in this regard?
Are there some cases where this is esential?  Kernel would be nice
target to whole program optimization and GCC is not that far from it
right now.

Honza
> 
> This patch just turns it off when gcc supports the option.
> 
> I only did it for i386 for now. The problem is actually not i386 specific
> (other architectures break too), so it may make sense to move the check_gcc 
> stuff into the main Makefile and do it for everybody.
> 
> -Andi
> 
> --- linux-2.6.0test4-work/arch/i386/Makefile-o	2003-08-23 13:03:08.000000000 +0200
> +++ linux-2.6.0test4-work/arch/i386/Makefile	2003-09-05 02:14:07.000000000 +0200
> @@ -26,6 +26,10 @@
>  # prevent gcc from keeping the stack 16 byte aligned
>  CFLAGS += $(call check_gcc,-mpreferred-stack-boundary=2,)
>  
> +# gcc 3.4/3.3-hammer support -funit-at-a-time mode, but the Kernel is not ready
> +# for it yet
> +CFLAGS += $(call check_gcc,-fno-unit-at-a-time,)
> +
>  align := $(subst -functions=0,,$(call check_gcc,-falign-functions=0,-malign-functions=0))
>  
>  cflags-$(CONFIG_M386)		+= -march=i386
