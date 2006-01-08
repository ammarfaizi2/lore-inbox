Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932770AbWAHUvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770AbWAHUvq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 15:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932772AbWAHUvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 15:51:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22185 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932770AbWAHUvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 15:51:45 -0500
Date: Sun, 8 Jan 2006 12:51:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernelrelase only recomputed when necessary
In-Reply-To: <20060108203749.GA7193@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0601081250441.3169@g5.osdl.org>
References: <20060108203749.GA7193@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 8 Jan 2006, Sam Ravnborg wrote:
>
> This patch goes on top of patch from hpa titled:
> Drop vmlinux dependency from "make install"

This part looks bogus:

> diff --git a/arch/x86_64/Makefile b/arch/x86_64/Makefile
> index a9cd42e..663dbdb 100644
> --- a/arch/x86_64/Makefile
> +++ b/arch/x86_64/Makefile
> @@ -80,7 +80,7 @@ bzlilo: vmlinux
>  bzdisk: vmlinux
>  	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) zdisk
>  
> -install fdimage fdimage144 fdimage288: vmlinux
> +install fdimage fdimage144 fdimage288:
>  	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) $@
>  
>  archclean:


That rule should probably be:

	fdimage fdimage144 fdimage288: vmlinux
	install:
		$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) $@

since the fdimages should still depend on vmlinux.

No?

		Linus
