Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVKDMmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVKDMmL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 07:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbVKDMmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 07:42:11 -0500
Received: from styx.suse.cz ([82.119.242.94]:64227 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932143AbVKDMmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 07:42:09 -0500
Date: Fri, 4 Nov 2005 13:42:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-joystick@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] drivers/input/: possible cleanups
Message-ID: <20051104124207.GA4937@ucw.cz>
References: <20051104123541.GC5587@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104123541.GC5587@stusta.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 01:35:41PM +0100, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly glbal code static

Agreed.

> - gameport/gameport: #if 0 the unused global function gameport_reconnect

That one should be an EXPORT_SYMBOL() API. If the export is missing,
then that's the bug that needs to be fixed.

> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/input/gameport/gameport.c |    2 ++
>  drivers/input/joystick/twidjoy.c  |    4 ++--
>  drivers/input/touchscreen/mk712.c |    2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.14-rc5-mm1-full/drivers/input/joystick/twidjoy.c.old	2005-11-04 11:37:38.000000000 +0100
> +++ linux-2.6.14-rc5-mm1-full/drivers/input/joystick/twidjoy.c	2005-11-04 11:38:01.000000000 +0100
> @@ -265,13 +265,13 @@
>   * The functions for inserting/removing us as a module.
>   */
>  
> -int __init twidjoy_init(void)
> +static int __init twidjoy_init(void)
>  {
>  	serio_register_driver(&twidjoy_drv);
>  	return 0;
>  }
>  
> -void __exit twidjoy_exit(void)
> +static void __exit twidjoy_exit(void)
>  {
>  	serio_unregister_driver(&twidjoy_drv);
>  }
> --- linux-2.6.14-rc5-mm1-full/drivers/input/touchscreen/mk712.c.old	2005-11-04 11:38:20.000000000 +0100
> +++ linux-2.6.14-rc5-mm1-full/drivers/input/touchscreen/mk712.c	2005-11-04 11:38:29.000000000 +0100
> @@ -154,7 +154,7 @@
>  	spin_unlock_irqrestore(&mk712_lock, flags);
>  }
>  
> -int __init mk712_init(void)
> +static int __init mk712_init(void)
>  {
>  	int err;
>  
> --- linux-2.6.14-rc5-mm1-full/drivers/input/gameport/gameport.c.old	2005-11-04 11:38:52.000000000 +0100
> +++ linux-2.6.14-rc5-mm1-full/drivers/input/gameport/gameport.c	2005-11-04 11:39:32.000000000 +0100
> @@ -637,10 +637,12 @@
>  	gameport_queue_event(gameport, NULL, GAMEPORT_RESCAN);
>  }
>  
> +#if 0
>  void gameport_reconnect(struct gameport *gameport)
>  {
>  	gameport_queue_event(gameport, NULL, GAMEPORT_RECONNECT);
>  }
> +#endif  /*  0  */
>  
>  /*
>   * Submits register request to kgameportd for subsequent execution.
> 
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
