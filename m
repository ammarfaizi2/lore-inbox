Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbULHMvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbULHMvp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 07:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbULHMvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 07:51:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3343 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261199AbULHMvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 07:51:42 -0500
Date: Wed, 8 Dec 2004 13:51:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ron Murray <rjmx@rjmx.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] CS461x gameport code isn't being included in build
Message-ID: <20041208125133.GT5496@stusta.de>
References: <41B237C6.9030404@rjmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B237C6.9030404@rjmx.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2004 at 05:18:46PM -0500, Ron Murray wrote:
>    I've found a typo in drivers/input/gameport/Makefile in kernel
> 2.6.9 which effectively prevents the CS461x gameport code from
> being included. Here's the diff:
> 
> --- linux-2.6.9/drivers/input/gameport/Makefile.orig	2004-10-18 
> 17:53:06.000000000 -0400
> +++ linux-2.6.9/drivers/input/gameport/Makefile	2004-12-04 
> 16:51:12.000000000 -0500
> @@ -5,7 +5,7 @@
>  # Each configuration option enables a list of files.
> 
>  obj-$(CONFIG_GAMEPORT)		+= gameport.o
> -obj-$(CONFIG_GAMEPORT_CS461X)	+= cs461x.o
> +obj-$(CONFIG_GAMEPORT_CS461x)	+= cs461x.o
>  obj-$(CONFIG_GAMEPORT_EMU10K1)	+= emu10k1-gp.o
>  obj-$(CONFIG_GAMEPORT_FM801)	+= fm801-gp.o
>  obj-$(CONFIG_GAMEPORT_L4)	+= lightning.o
> 
>    Note: the change is to a lower-case 'x' in
> 'CONFIG_GAMEPORT_CS461x'. It's hard to see.
> 
>    Kconfig in the same directory has
> 
> >> config GAMEPORT_CS461x
> >> 	tristate "Crystal SoundFusion gameport support"
> >> 	depends on GAMEPORT
> 
>    This patch brings the Makefile into line with the spelling in
> Kconfig.
>...

Good catch.

But by convention, the names of config variables in the kernel are all 
uppercase.

I'm therefore suggesting the patch below fixing this bug the other way.

>  .....Ron


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/drivers/input/gameport/Kconfig.old	2004-12-08 13:45:53.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/input/gameport/Kconfig	2004-12-08 13:46:06.000000000 +0100
@@ -84,7 +84,7 @@
 	tristate "ForteMedia FM801 gameport support"
 	depends on GAMEPORT
 
-config GAMEPORT_CS461x
+config GAMEPORT_CS461X
 	tristate "Crystal SoundFusion gameport support"
 	depends on GAMEPORT
 

