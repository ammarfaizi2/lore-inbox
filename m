Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUJUOOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUJUOOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268734AbUJUOLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:11:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50820 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269116AbUJUOJM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:09:12 -0400
Date: Wed, 20 Oct 2004 15:59:27 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Brian Gerst <bgerst@quark.didntduck.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove last reference to LDFLAGS_BLOB
Message-ID: <20041020175927.GE14780@logos.cnet>
References: <4175C6E2.1080201@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4175C6E2.1080201@quark.didntduck.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No, do not remove that initramfs_data.S section!

People with older binutils (like me) rely on it. 

Make it obsolete on 2.7.x.

On Tue, Oct 19, 2004 at 10:01:06PM -0400, Brian Gerst wrote:
> Nothing uses LDFLAGS_BLOB anymore, now that the arm binutils are fixed.
> 
> --
> 				Brian Gerst

> diff -urN linux-2.6.9-bk/arch/m32r/Makefile linux/arch/m32r/Makefile
> --- linux-2.6.9-bk/arch/m32r/Makefile	2004-10-18 20:34:14.000000000 -0400
> +++ linux/arch/m32r/Makefile	2004-10-19 17:40:55.614157644 -0400
> @@ -5,7 +5,6 @@
>  LDFLAGS		:=
>  OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
>  LDFLAGS_vmlinux	:= -e startup_32
> -LDFLAGS_BLOB	:= --format binary --oformat elf32-m32r
>  
>  CFLAGS += -pipe -fno-schedule-insns
>  CFLAGS_KERNEL += -mmodel=medium
> diff -urN linux-2.6.9-bk/usr/initramfs_data.S linux/usr/initramfs_data.S
> --- linux-2.6.9-bk/usr/initramfs_data.S	2003-12-17 21:59:42.000000000 -0500
> +++ linux/usr/initramfs_data.S	2004-10-19 17:41:16.191659582 -0400
> @@ -1,28 +1,6 @@
>  /*
>    initramfs_data includes the compressed binary that is the
>    filesystem used for early user space.
> -  Note: Older versions of "as" (prior to binutils 2.11.90.0.23
> -  released on 2001-07-14) dit not support .incbin.
> -  If you are forced to use older binutils than that then the
> -  following trick can be applied to create the resulting binary:
> -
> -
> -  ld -m elf_i386  --format binary --oformat elf32-i386 -r \
> -  -T initramfs_data.scr initramfs_data.cpio.gz -o initramfs_data.o
> -   ld -m elf_i386  -r -o built-in.o initramfs_data.o
> -
> -  initramfs_data.scr looks like this:
> -SECTIONS
> -{
> -       .init.ramfs : { *(.data) }
> -}
> -
> -  The above example is for i386 - the parameters vary from architectures.
> -  Eventually look up LDFLAGS_BLOB in an older version of the
> -  arch/$(ARCH)/Makefile to see the flags used before .incbin was introduced.
> -
> -  Using .incbin has the advantage over ld that the correct flags are set
> -  in the ELF header, as required by certain architectures.
>  */
>  
>  .section .init.ramfs,"a"

