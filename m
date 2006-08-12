Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWHLOf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWHLOf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 10:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWHLOf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 10:35:27 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:29102 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932534AbWHLOf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 10:35:27 -0400
Date: Sat, 12 Aug 2006 16:34:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Alex Riesen <raa.lkml@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: powerpc: "make install" broken
Message-ID: <20060812143451.GA18642@mars.ravnborg.org>
References: <81b0412b0608120729m42b0c5b5n9f0a06b27796452c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81b0412b0608120729m42b0c5b5n9f0a06b27796452c@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 04:29:38PM +0200, Alex Riesen wrote:
> I don't know if ever worked before, just tried today on v2.6.17.
> Maybe it works, but then it is very different to i386
> where it is plain "make install".
> 
> I copied the implementation attached from i386 (modified a bit), which
> fixed it for me. Maybe the patch will motivate someone to fix it properly...

> From d3d4be5563c68b967841b17cf5557df5d7bfc4dd Mon Sep 17 00:00:00 2001
> From: Alex Riesen <raa.lkml@gmail.com>
> Date: Sat, 12 Aug 2006 15:38:42 +0200
> Subject: [PATCH] fix make install on ppc
> 
> ---
>  arch/powerpc/Makefile      |    3 +++
>  arch/powerpc/boot/Makefile |    4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index ed5b26a..d2c530d 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -156,6 +156,9 @@ boot := arch/$(ARCH)/boot
>  $(BOOT_TARGETS): vmlinux
>  	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
>  
> +install: vmlinux
> +	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) install
NACK - the install target shall not try to build the kernel - the
vmlinux dependency is long gone from i386.

	Sam
