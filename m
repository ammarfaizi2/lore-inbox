Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVLNLoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVLNLoE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVLNLoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:44:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52161 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932446AbVLNLoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:44:03 -0500
Date: Mon, 12 Dec 2005 12:45:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Mouse button swapping
Message-ID: <20051212114529.GA6533@elf.ucw.cz>
References: <Pine.LNX.4.61.0512091508250.8080@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512091508250.8080@yvahk01.tjqt.qr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I produced a small patch that allows one to flip the mouse buttons at the 
> kernel level. This is useful for changing it on a per-system basis, i.e. it 
> will affect gpm, X and VMware all at once. It is changeable through
> /sys/module/mousedev/swap_buttons at runtime. Is this something mainline would
> be interested in?

Hopefully not. This should _not_ be done at kernel level. But fixing
X, gpm and vmware to load same config would be nice....
								Pavel

> diff -dpru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
> --- a/drivers/input/mousedev.c	2005-10-22 20:59:22.000000000 +0200
> +++ b/drivers/input/mousedev.c	2005-11-22 19:32:01.000000000 +0100
> @@ -40,6 +40,10 @@ MODULE_LICENSE("GPL");
>  #define CONFIG_INPUT_MOUSEDEV_SCREEN_Y	768
>  #endif
>  
> +static unsigned int swap_buttons = 0;
> +module_param(swap_buttons, uint, 0644);
> +MODULE_PARM_DESC(swap_buttons, "Swap left and right mouse buttons");
> +
>  static int xres = CONFIG_INPUT_MOUSEDEV_SCREEN_X;
>  module_param(xres, uint, 0);
>  MODULE_PARM_DESC(xres, "Horizontal screen resolution");
> @@ -191,10 +195,10 @@ static void mousedev_key_event(struct mo
>  		case BTN_TOUCH:
>  		case BTN_0:
>  		case BTN_FORWARD:
> -		case BTN_LEFT:		index = 0; break;
> +		case BTN_LEFT:		index = !!swap_buttons; break;
>  		case BTN_STYLUS:
>  		case BTN_1:
> -		case BTN_RIGHT:		index = 1; break;
> +		case BTN_RIGHT:		index = !swap_buttons; break;
>  		case BTN_2:
>  		case BTN_STYLUS2:
>  		case BTN_MIDDLE:	index = 2; break;
> # eof
> 
> 
> Jan Engelhardt

-- 
Thanks, Sharp!
