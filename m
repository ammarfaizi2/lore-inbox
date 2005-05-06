Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVEFVpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVEFVpa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 17:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVEFVpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 17:45:30 -0400
Received: from dslsmtp.struer.net ([62.242.36.21]:34566 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S261282AbVEFVpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 17:45:21 -0400
Message-ID: <33091.80.160.117.125.1115415913.squirrel@80.160.117.125>
In-Reply-To: <cbf07e669ed84066a0bc366ca254123b@freescale.com>
References: <cbf07e669ed84066a0bc366ca254123b@freescale.com>
Date: Fri, 6 May 2005 23:45:13 +0200 (CEST)
Subject: Re: PPC uImage build not reporting correctly
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "Kumar Gala" <kumar.gala@freescale.com>
Cc: "Sam Ravnborg" <sam@ravnborg.org>,
       "linuxppc-embedded list" <linuxppc-embedded@ozlabs.org>,
       "Tom Rini" <trini@kernel.crashing.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sam,
>
> Tom pointed me at you to look at a makefile issue with
> arch/ppc/boot/images/Makefile.  When I do the following:
>
> $ make uImage
>    CHK     include/linux/version.h
> make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
>    CHK     include/linux/compile.h
>    CHK     usr/initramfs_list
>    UIMAGE  arch/ppc/boot/images/uImage
> Image Name:   Linux-2.6.12-rc3
> Created:      Fri May  6 10:19:28 2005
> Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> Data Size:    993322 Bytes = 970.04 kB = 0.95 MB
> Load Address: 0x00000000
> Entry Point:  0x00000000
>    Image: arch/ppc/boot/images/uImage not made
>
> The issue is that the file arch/ppc/boot/images/uImage does exit (the
> 'not made' is not correct).
>
> $(obj)/uImage: $(obj)/vmlinux.gz
>          $(Q)rm -f $@
>          $(call if_changed,uimage)
>          @echo '  Image: $@' $(if $(wildcard $@),'is ready','not made')
>
> It seems the $(wildcard $@) expands at the start of the rule.  Any
> ideas?

It probarly uses the build-in cache in make - and I see no easy way to
tell make not to use the cache in this case.
Could you try to replace "$(wildcard $@)" with something like:
$(shell if -f $@ echo Y; fi)

Untested - I'm not on a Linux box right now.

   Sam


