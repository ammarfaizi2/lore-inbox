Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbTJHQGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 12:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbTJHQGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 12:06:10 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:19728 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261723AbTJHQGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 12:06:06 -0400
Date: Wed, 8 Oct 2003 18:06:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: Cross compiling using separate output directory problems
Message-ID: <20031008160601.GA11550@mars.ravnborg.org>
Mail-Followup-To: Peter Chubb <peter@chubb.wattle.id.au>,
	sam@ravnborg.org, linux-kernel@vger.kernel.org,
	linux-ia64@linuxia64.org
References: <16259.35252.163910.512212@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16259.35252.163910.512212@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 01:51:16PM +1000, Peter Chubb wrote:
> 
> Hi Sam,
>    Thanks for doing the work to make comnpilation work with a separate
> output directory.
Thanks, but Kai Germaschewski did most of the infrastructure woark, I
just made the final stuff. He deserves credits more than I do.

> I found the following changes necessary to get it to work properly
> when crosscompiling for IA64.  Otherwise include/asm-ia64 hasn't been
> created when setting up offsets.h.
> 
> There's also a minor change to tell make where to find the
> toolchain-flags and check-gas scripts.
I'm glad to see people having interest in it, I have notice several
architectures catching up on it.

A few minor comments.

>  
> -GAS_STATUS=$(shell arch/ia64/scripts/check-gas $(CC) $(OBJDUMP))
> +GAS_STATUS=$(shell $(src)/arch/ia64/scripts/check-gas $(CC) $(OBJDUMP))
I prefer the use of $(srctree), which is pointing to the root
of the kernel src tree. src works here because the file is included
from the top-level Makefile.
  
> -CPPFLAGS	+= $(shell arch/ia64/scripts/toolchain-flags $(CC) $(OBJDUMP))
> +CPPFLAGS	+= $(shell $(src)/arch/ia64/scripts/toolchain-flags $(CC) $(OBJDUMP))
Same goes here.

>  
> -CLEAN_FILES += include/asm-ia64/.offsets.h.stamp include/asm-ia64/offsets.h vmlinux.gz bootloader
> +CLEAN_FILES += include/asm-$(ARCH)/.offsets.h.stamp include/asm-$(ARCH)/offsets.h vmlinux.gz bootloader

s#$(ARCH)#ia64#g is unrelated, but OK.

I assume you will push this to David Mosberger.

	Sam
