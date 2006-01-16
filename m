Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWAPSFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWAPSFa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 13:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWAPSF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 13:05:29 -0500
Received: from amun.rz.tu-clausthal.de ([139.174.2.12]:48320 "EHLO
	amun.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S1751026AbWAPSF3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 13:05:29 -0500
From: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Fw: two (little) problems wit 2.6.15-git7 one with build, one with acpi
Date: Mon, 16 Jan 2006 19:05:21 +0100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060112231528.025c3a0b.akpm@osdl.org> <200601152148.02445.volker.armin.hemmann@tu-clausthal.de> <20060116113942.GA3698@mars.ravnborg.org>
In-Reply-To: <20060116113942.GA3698@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601161905.22129.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 January 2006 12:39, Sam Ravnborg wrote:
> On Sun, Jan 15, 2006 at 09:48:02PM +0100, Hemmann, Volker Armin wrote:
> > The kernel-sources directory has to be 'virgin'. As soon as I build a
> > kernel in it once, it worked without any problems - even after a make
> > clean and make mrproper.
>
> This proved to be why it worked for me.
> The fix was simple. We have to evaluate MODLIB late so we have
> .kernelrelease created when evaluating MODLIB.
> Following patch fixes it:
>
> 	Sam
>
>
> diff --git a/Makefile b/Makefile
> index 22e322f..37a4b67 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -545,7 +545,7 @@ export	INSTALL_PATH ?= /boot
>  # makefile but the arguement can be passed to make if needed.
>  #
>
> -MODLIB	:= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> +MODLIB	= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
>  export MODLIB

yes, that fixed it, thank you

Glück Auf,
Volker
