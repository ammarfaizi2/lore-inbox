Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbTIJTz5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265603AbTIJTz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:55:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5831 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265530AbTIJTzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:55:51 -0400
Date: Wed, 10 Sep 2003 21:55:44 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Message-ID: <20030910195544.GL27368@fs.tum.de>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org> <3F5DBC1F.8DF1F07A@eyal.emu.id.au> <20030910110225.GC27368@fs.tum.de> <20030910155542.GD4559@ip68-0-152-218.tc.ph.cox.net> <20030910170610.GH27368@fs.tum.de> <20030910185902.GE4559@ip68-0-152-218.tc.ph.cox.net> <20030910191038.GK27368@fs.tum.de> <20030910193158.GF4559@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910193158.GF4559@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 12:31:58PM -0700, Tom Rini wrote:
>...
> ===== drivers/input/keyboard/Kconfig 1.6 vs edited =====
> --- 1.6/drivers/input/keyboard/Kconfig	Wed Jul 16 10:39:32 2003
> +++ edited/drivers/input/keyboard/Kconfig	Fri Sep  5 14:45:36 2003
> @@ -2,8 +2,9 @@
>  # Input core configuration
>  #
>  config INPUT_KEYBOARD
> -	bool "Keyboards" if EMBEDDED || !X86
> +	bool "Keyboards"
>  	default y
> +	select KEYBOARD_ATKBD if STANDARD && X86
>  	depends on INPUT
>  	help
>  	  Say Y here, and a list of supported keyboards will be displayed.
> @@ -12,7 +13,7 @@
>  	  If unsure, say Y.
>  
>  config KEYBOARD_ATKBD
> -	tristate "AT keyboard support" if EMBEDDED || !X86 
> +	tristate "AT keyboard support"
>  	default y
>  	depends on INPUT && INPUT_KEYBOARD && SERIO
>  	help
> ===== drivers/input/serio/Kconfig 1.9 vs edited =====
> --- 1.9/drivers/input/serio/Kconfig	Wed Jul 16 10:39:32 2003
> +++ edited/drivers/input/serio/Kconfig	Fri Sep  5 14:45:36 2003
> @@ -2,7 +2,8 @@
>  # Input core configuration
>  #
>  config SERIO
> -	tristate "Serial i/o support (needed for keyboard and mouse)"
> +	tristate "Serial i/o support (needed for keyboard and mouse)" if !(STANDARD && X86)
> +	select SERIO_I8042 if STANDARD && X86
>  	default y
>  	---help---
>  	  Say Yes here if you have any input device that uses serial I/O to

This works but seems fragile since everyone touching the dependencies 
must know that the tristate dependencies of SERIO must always match the 
select dependencies in INPUT_KEYBOARD.

> @@ -19,7 +20,7 @@
>  	  as a module, say M here and read <file:Documentation/modules.txt>.
>  
>  config SERIO_I8042
> -	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
> +	tristate "i8042 PC Keyboard controller"
>  	default y
>  	depends on SERIO
>  	---help---
>...

Yes, removing the "if EMBEDDED || !X86" solves the problem...

> Tom Rini

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

