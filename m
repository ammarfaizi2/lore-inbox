Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVCEKlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVCEKlY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 05:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVCEKlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 05:41:24 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:7443 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261569AbVCEKlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 05:41:20 -0500
Date: Sat, 5 Mar 2005 11:39:56 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, akpm@osdl.org
Subject: Re: [patch] remove the `.' in EXTRAVERSION usage
Message-ID: <20050305103956.GH30106@alpha.home.local>
References: <2cd57c90050305022211b94e86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c90050305022211b94e86@mail.gmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 06:22:45PM +0800, Coywolf Qi Hunt wrote:
> Since 2.6.9, there came along the LOCALVERSION for people to add local
> version in make menuconfig which was EXTRAVERSION originally for imho.
> Now EXTRAVERSION goes just as a kernel version number, it's reasonable
> to remove the `.' in its usage.
> 
> Signed-off-by: Coywolf Qi Hunt <coywolf@gmail.com>
> 
> diff -Nrup 2.6.11/Makefile 2.6.11-cy/Makefile
> --- 2.6.11/Makefile	2005-03-03 17:10:57.000000000 +0800
> +++ 2.6.11-cy/Makefile	2005-03-05 16:40:46.000000000 +0800
> @@ -1,7 +1,7 @@
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 11
> -EXTRAVERSION =
> +EXTRAVERSION = 1
> NAME=Woozy Numbat
> 
> # *DOCUMENTATION*
> @@ -158,7 +158,7 @@ LOCALVERSION = $(subst $(space),, \
>  	       $(shell cat /dev/null $(localver)) \
>  	       $(patsubst "%",%,$(CONFIG_LOCALVERSION)))
>  
> -KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(LOCALVERSION)
> +KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL).$(EXTRAVERSION)$(LOCALVERSION)

Please don't do that, you'll always end up with a trailing dot in 3-numbers
versions. Eg: V=2 P=6 S=11 => "2.6.11."

Willy

