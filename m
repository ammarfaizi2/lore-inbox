Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267422AbUHDVEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267422AbUHDVEa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUHDVE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:04:29 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:37193 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267422AbUHDVEO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:04:14 -0400
Date: Wed, 4 Aug 2004 23:05:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Can't cross compile IA32 kernels using separate build directory
Message-ID: <20040804210538.GA7275@mars.ravnborg.org>
Mail-Followup-To: Peter Chubb <peterc@gelato.unsw.edu.au>,
	sam@ravnborg.org, linux-kernel@vger.kernel.org
References: <E1BrpeA-0002QH-00@berry.gelato.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BrpeA-0002QH-00@berry.gelato.unsw.EDU.AU>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 01:07:26PM +1000, Peter Chubb wrote:
> 
> Hi Sam,
>    Trying to cross compile a kernel for IA32, on a system without an asm/boot.h
> fails (e.g., IA64)
> 
> Here's a patch to add in -Iinclude2 when building tools/build.o so that 
> asm/boot.h is picked up from the right place.

I have boot.h in /usr/include/ thats why I did not see it. Running i386 as
you already guessed.
Knowledge of include2 should be restricted to the core kbuild files though,
so I will se if I can come up with something smarter.

That would require splitting CPPFLAGS in two parts and we already have
enough variables...

	Sam

> 
> Index: linux-2.6-wip/arch/i386/boot/Makefile
> ===================================================================
> --- linux-2.6-wip.orig/arch/i386/boot/Makefile	2004-08-03 12:58:02.287223257 +1000
> +++ linux-2.6-wip/arch/i386/boot/Makefile	2004-08-03 12:59:34.661245563 +1000
> @@ -31,7 +31,7 @@
>  
>  host-progs	:= tools/build
>  
> -HOSTCFLAGS_build.o := -Iinclude
> +HOSTCFLAGS_build.o := -Iinclude -Iinclude2
>  
>  # ---------------------------------------------------------------------------
>  
