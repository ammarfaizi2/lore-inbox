Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVEFV52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVEFV52 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 17:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVEFV51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 17:57:27 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:48845 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261290AbVEFV5V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 17:57:21 -0400
In-Reply-To: <33091.80.160.117.125.1115415913.squirrel@80.160.117.125>
References: <33091.80.160.117.125.1115415913.squirrel@80.160.117.125>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <4bbf50644ea82dacac17b057628f55de@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Tom Rini" <trini@kernel.crashing.org>,
       "linuxppc-embedded list" <linuxppc-embedded@ozlabs.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: PPC uImage build not reporting correctly
Date: Fri, 6 May 2005 16:57:10 -0500
To: "Sam Ravnborg" <sam@ravnborg.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 6, 2005, at 4:45 PM, Sam Ravnborg wrote:

> > Sam,
>  >
>  > Tom pointed me at you to look at a makefile issue with
>  > arch/ppc/boot/images/Makefile.  When I do the following:
>  >
>  > $ make uImage
>  >    CHK     include/linux/version.h
> > make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
>  >    CHK     include/linux/compile.h
> >    CHK     usr/initramfs_list
> >    UIMAGE  arch/ppc/boot/images/uImage
> > Image Name:   Linux-2.6.12-rc3
>  > Created:      Fri May  6 10:19:28 2005
> > Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>  > Data Size:    993322 Bytes = 970.04 kB = 0.95 MB
>  > Load Address: 0x00000000
>  > Entry Point:  0x00000000
>  >    Image: arch/ppc/boot/images/uImage not made
>  >
>  > The issue is that the file arch/ppc/boot/images/uImage does exit 
> (the
>  > 'not made' is not correct).
>  >
>  > $(obj)/uImage: $(obj)/vmlinux.gz
> >          $(Q)rm -f $@
>  >          $(call if_changed,uimage)
> >          @echo '  Image: $@' $(if $(wildcard $@),'is ready','not 
> made')
>  >
>  > It seems the $(wildcard $@) expands at the start of the rule.  Any
>  > ideas?
>
> It probarly uses the build-in cache in make - and I see no easy way to
>  tell make not to use the cache in this case.
>  Could you try to replace "$(wildcard $@)" with something like:
> $(shell if -f $@ echo Y; fi)
>
> Untested - I'm not on a Linux box right now.

I tried the following w/o success:

$(obj)/uImage: $(obj)/vmlinux.gz
         $(Q)rm -f $@
         $(call if_changed,uimage)
         @echo '  Image: $@' $(shell if [ -f $@ ]; then echo 'is ready'; 
else echo 'not made'; fi)

- kumar
