Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274909AbTHPUBE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 16:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274916AbTHPUBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 16:01:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34318 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S274909AbTHPUBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 16:01:01 -0400
Date: Sat, 16 Aug 2003 21:00:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Bogus serial port ttyS02
Message-ID: <20030816210051.A9479@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
References: <Pine.GSO.4.21.0308132305210.11378-100000@vervain.sonytel.be> <Pine.GSO.4.21.0308161722030.12665-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0308161722030.12665-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Sat, Aug 16, 2003 at 05:23:20PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 05:23:20PM +0200, Geert Uytterhoeven wrote:
> This patch kills a warning if DEBUG_AUTOCONF is enabled:
> 
> --- linux-ppc-2.6.0-test3/drivers/serial/8250.c	Mon Aug 11 02:20:41 2003
> +++ linux-longtrail-2.6.0-test3/drivers/serial/8250.c	Wed Aug 13 22:31:07 2003
> @@ -557,7 +557,7 @@
>  	if (!up->port.iobase && !up->port.mapbase && !up->port.membase)
>  		return;
>  
> -	DEBUG_AUTOCONF("ttyS%d: autoconf (0x%04x, 0x%08lx): ",
> +	DEBUG_AUTOCONF("ttyS%d: autoconf (0x%04x, %p): ",
>  			up->port.line, up->port.iobase, up->port.membase);
>  
>  	/*
> This patch removes the ASYNC_SKIP_TEST flag on PPC:
> 
> --- linux-ppc-2.6.0-test3/include/asm-ppc/pc_serial.h	Mon Aug 11 02:21:00 2003
> +++ linux-longtrail-2.6.0-test3/include/asm-ppc/pc_serial.h	Wed Aug 13 23:01:50 2003
> @@ -28,10 +28,10 @@
>  
>  /* Standard COM flags (except for COM4, because of the 8514 problem) */
>  #ifdef CONFIG_SERIAL_DETECT_IRQ
> -#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ)
> +#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
>  #define STD_COM4_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
>  #else
> -#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
> +#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF)
>  #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
>  #endif
>  
> OK to apply?

Both look fine to me.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

