Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275476AbTHJImn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 04:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272579AbTHJImn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 04:42:43 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:38554 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S275476AbTHJImk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 04:42:40 -0400
Date: Sun, 10 Aug 2003 10:42:27 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATCH: mouse and keyboard by default if not embedded
In-Reply-To: <200307272003.h6RK3ckm029604@hraefn.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0308101040220.19901-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003, Alan Cox wrote:
> (Andi Kleen)
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/input/Kconfig linux-2.6.0-test2-ac1/drivers/input/Kconfig
> --- linux-2.6.0-test2/drivers/input/Kconfig	2003-07-10 21:04:59.000000000 +0100
> +++ linux-2.6.0-test2-ac1/drivers/input/Kconfig	2003-07-16 18:39:32.000000000 +0100
> @@ -5,7 +5,7 @@
>  menu "Input device support"
>  
>  config INPUT
> -	tristate "Input devices (needed for keyboard, mouse, ...)"
> +	tristate "Input devices (needed for keyboard, mouse, ...)" if EMBEDDED
>  	default y
>  	---help---
>  	  Say Y here if you have any input device (mouse, keyboard, tablet,
> @@ -27,7 +27,7 @@
>  comment "Userland interfaces"
>  
>  config INPUT_MOUSEDEV
> -	tristate "Mouse interface"
> +	tristate "Mouse interface" if EMBEDDED
>  	default y
>  	depends on INPUT
>  	---help---
> @@ -45,7 +45,7 @@
>  	  a module, say M here and read <file:Documentation/modules.txt>.
>  
>  config INPUT_MOUSEDEV_PSAUX
> -	bool "Provide legacy /dev/psaux device"
> +	bool "Provide legacy /dev/psaux device" if EMBEDDED

Now INPUT_MOUSEDEV_PSAUX is always (on non-embedded machines) forced to true,
even on machines without PS/2 keyboard/mouse hardware. Is that OK?

So far (compiling, not running 2.6.0-test3) I didn't notice any problems,
though.

>  	default y
>  	depends on INPUT_MOUSEDEV
>  
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/input/keyboard/Kconfig linux-2.6.0-test2-ac1/drivers/input/keyboard/Kconfig
> --- linux-2.6.0-test2/drivers/input/keyboard/Kconfig	2003-07-10 21:14:55.000000000 +0100
> +++ linux-2.6.0-test2-ac1/drivers/input/keyboard/Kconfig	2003-07-16 18:39:32.000000000 +0100
> @@ -2,7 +2,7 @@
>  # Input core configuration
>  #
>  config INPUT_KEYBOARD
> -	bool "Keyboards"
> +	bool "Keyboards" if (X86 && EMBEDDED) || (!X86)
>  	default y
>  	depends on INPUT
>  	help
> @@ -12,7 +12,7 @@
>  	  If unsure, say Y.
>  
>  config KEYBOARD_ATKBD
> -	tristate "AT keyboard support"
> +	tristate "AT keyboard support" if (X86 && EMBEDDED) || (!X86) 
>  	default y
>  	depends on INPUT && INPUT_KEYBOARD && SERIO
>  	help

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

