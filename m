Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264244AbRFSOgX>; Tue, 19 Jun 2001 10:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264260AbRFSOgN>; Tue, 19 Jun 2001 10:36:13 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:64392 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S264050AbRFSOgC>;
	Tue, 19 Jun 2001 10:36:02 -0400
Date: Tue, 19 Jun 2001 16:35:20 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Keith Owens <kaos@ocs.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac15 -- Unresolved symbols "gameport_register_port"
Message-ID: <20010619163520.A12869@suse.cz>
In-Reply-To: <Pine.LNX.4.31.0106191444410.6488-200000@neon.hh59.org> <20509.992961005@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20509.992961005@ocs3.ocs-net>; from kaos@ocs.com.au on Wed, Jun 20, 2001 at 12:30:05AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2001 at 12:30:05AM +1000, Keith Owens wrote:

> On Tue, 19 Jun 2001 14:48:09 +0200 (CEST), 
> <axel@rayfun.org> wrote:
> >something similar is happening with my kernel 2.4.5-ac15 compilation.
> >drivers/sound/sounddrivers.o: In function `es1371_probe':
> >drivers/sound/sounddrivers.o(.text.init+0xddb): undefined reference to
> >`gameport_register_port'
> 
> Gameports and joysticks should not be available unless input core
> support is selected first.  Invalid configs were slipping through.

Gameports are not input core dependent.

Only joysticks are.

> 
> Index: 5.37/drivers/char/joystick/Config.in
> --- 5.37/drivers/char/joystick/Config.in Wed, 06 Jun 2001 11:47:52 +1000 kaos (linux-2.4/Y/b/35_Config.in 1.1.1.3 644)
> +++ 5.37(w)/drivers/char/joystick/Config.in Wed, 20 Jun 2001 00:06:14 +1000 kaos (linux-2.4/Y/b/35_Config.in 1.1.1.3 644)
> @@ -5,15 +5,20 @@
>  mainmenu_option next_comment
>  comment 'Joysticks'
>  
> -tristate 'Game port support' CONFIG_INPUT_GAMEPORT
> -   dep_tristate '  Classic ISA/PnP gameports' CONFIG_INPUT_NS558 $CONFIG_INPUT_GAMEPORT
> -   dep_tristate '  PDPI Lightning 4 gamecard' CONFIG_INPUT_LIGHTNING $CONFIG_INPUT_GAMEPORT
> -   dep_tristate '  Aureal Vortex and Trident 4DWave gameports' CONFIG_INPUT_PCIGAME $CONFIG_INPUT_GAMEPORT
> -   dep_tristate '  Crystal SoundFusion gameports' CONFIG_INPUT_CS461X  $CONFIG_INPUT_GAMEPORT
> -   dep_tristate '  SoundBlaster Live! gameports' CONFIG_INPUT_EMU10K1 $CONFIG_INPUT_GAMEPORT
> -
> -tristate 'Serial port device support' CONFIG_INPUT_SERIO
> -   dep_tristate '  Serial port input line discipline' CONFIG_INPUT_SERPORT $CONFIG_INPUT_SERIO
> +if [ "$CONFIG_INPUT" != "n" ]; then
> +   tristate 'Game port support' CONFIG_INPUT_GAMEPORT
> +      dep_tristate '  Classic ISA/PnP gameports' CONFIG_INPUT_NS558 $CONFIG_INPUT_GAMEPORT
> +      dep_tristate '  PDPI Lightning 4 gamecard' CONFIG_INPUT_LIGHTNING $CONFIG_INPUT_GAMEPORT
> +      dep_tristate '  Aureal Vortex and Trident 4DWave gameports' CONFIG_INPUT_PCIGAME $CONFIG_INPUT_GAMEPORT
> +      dep_tristate '  Crystal SoundFusion gameports' CONFIG_INPUT_CS461X  $CONFIG_INPUT_GAMEPORT
> +      dep_tristate '  SoundBlaster Live! gameports' CONFIG_INPUT_EMU10K1 $CONFIG_INPUT_GAMEPORT
> +   tristate 'Serial port device support' CONFIG_INPUT_SERIO
> +      dep_tristate '  Serial port input line discipline' CONFIG_INPUT_SERPORT $CONFIG_INPUT_SERIO
> +else
> +   # Must explicitly set to n for drivers/sound/Config.in
> +   define_tristate CONFIG_INPUT_GAMEPORT n
> +   comment 'Input core support is needed for gameports'
> +fi
>  
>  if [ "$CONFIG_INPUT" != "n" ]; then
>     comment 'Joysticks'
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
