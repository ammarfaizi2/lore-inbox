Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVCGFtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVCGFtj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 00:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVCGFtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 00:49:39 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:51161 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261634AbVCGFte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 00:49:34 -0500
Date: Mon, 7 Mar 2005 06:50:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Micheal Marineau <marineam@engr.orst.edu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] Treat ALPS mouse buttons as mouse buttons
Message-ID: <20050307055019.GA1541@ucw.cz>
References: <422BA727.1030506@engr.orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422BA727.1030506@engr.orst.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 04:58:15PM -0800, Micheal Marineau wrote:

> The following patch changes the ALPS touchpad driver to treat some mouse
> buttons as mouse buttons rather than what appears to be joystick buttons.
> This is needed for the Dell Inspiron 8500's DualPoint stick buttons. Without
> this patch only the touchpad buttons behave properly.

Thanks for the patch. I'll try to put this change into my the latest
version of the ALPS driver, which, unfortunately, has been reworked
significantly.

Can you send me the output of /proc/bus/input/devices on your machine?
I'd like to know the ID of your ALPS dualpoint.

> --- linux-2.6.11/drivers/input/mouse/alps.c     2005-03-01 23:38:13.000000000 -0800
> +++ linux-2.6.11-gentoo-r2/drivers/input/mouse/alps.c   2005-03-06 16:45:07.000000000 -0800
> @@ -97,8 +97,8 @@
> 
>                 input_report_rel(dev, REL_X, x);
>                 input_report_rel(dev, REL_Y, -y);
> -               input_report_key(dev, BTN_A, left);
> -               input_report_key(dev, BTN_B, right);
> +               input_report_key(dev, BTN_LEFT, left);
> +               input_report_key(dev, BTN_RIGHT, right);
>                 input_sync(dev);
>                 return;
>         }
> @@ -389,8 +389,6 @@
>         psmouse->dev.evbit[LONG(EV_REL)] |= BIT(EV_REL);
>         psmouse->dev.relbit[LONG(REL_X)] |= BIT(REL_X);
>         psmouse->dev.relbit[LONG(REL_Y)] |= BIT(REL_Y);
> -       psmouse->dev.keybit[LONG(BTN_A)] |= BIT(BTN_A);
> -       psmouse->dev.keybit[LONG(BTN_B)] |= BIT(BTN_B);
> 
>         psmouse->dev.evbit[LONG(EV_ABS)] |= BIT(EV_ABS);
>         input_set_abs_params(&psmouse->dev, ABS_X, 0, 1023, 0, 0);

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
