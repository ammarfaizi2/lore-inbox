Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbTFBVnF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 17:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTFBVnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 17:43:05 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:56844 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264069AbTFBVnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 17:43:04 -0400
Date: Mon, 2 Jun 2003 23:56:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] Support for mach-xbox
Message-ID: <20030602215629.GA11407@mars.ravnborg.org>
Mail-Followup-To: Anders Gustafsson <andersg@0x63.nu>,
	linux-kernel@vger.kernel.org
References: <20030602202714.GD18786@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030602202714.GD18786@h55p111.delphi.afb.lu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 10:27:14PM +0200, Anders Gustafsson wrote:
> Hi,
> 
> Attached is a patch that adds a new subachitecture for the xbox gaming
> system. All it does outside the subarchitecture is adding posibility to
> blacklist pci-devices through an mach-hook.

A few comments.

	Sam

> diff -Nru a/arch/i386/boot/compressed/Makefile b/arch/i386/boot/compressed/Makefile
> --- a/arch/i386/boot/compressed/Makefile	Mon Jun  2 19:23:26 2003
> +++ b/arch/i386/boot/compressed/Makefile	Mon Jun  2 19:23:26 2003
> @@ -5,6 +5,9 @@
>  #
>  
>  targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
> +ifeq ($(CONFIG_X86_XBOX),y)
> +CFLAGS_misc.o   := -O0
> +endif
Add a comment why this special case is needed.

> diff -Nru a/arch/i386/mach-xbox/Makefile b/arch/i386/mach-xbox/Makefile
> --- /dev/null	Wed Dec 31 16:00:00 1969
> +++ b/arch/i386/mach-xbox/Makefile	Mon Jun  2 19:23:26 2003
> @@ -0,0 +1,7 @@
> +#
> +# Makefile for the linux kernel.
> +#
> +
> +EXTRA_CFLAGS	+= -I../kernel
Above line is not needed. Kill it.

> +static void xbox_pic_cmd(u8 command){
> +	outw_p(((XBOX_PIC_ADDRESS) << 1),XBOX_SMB_HOST_ADDRESS);
> +        outb_p(SMC_CMD_POWER, XBOX_SMB_HOST_COMMAND);
> +        outw_p(command, XBOX_SMB_HOST_DATA);
> +        outw_p(inw(XBOX_SMB_IO_BASE),XBOX_SMB_IO_BASE);
> +        outb_p(0x0a,XBOX_SMB_GLOBAL_ENABLE);
> +}
Follow coding style. See Documentation/CodingStyle
- Braces on one line
- Indent with tabs

